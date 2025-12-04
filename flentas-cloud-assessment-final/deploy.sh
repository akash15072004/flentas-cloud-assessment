#!/bin/bash
set -euo pipefail

# Safer deploy script for flentas-cloud-assessment
# - Prompts before applying each module
# - Supports flags:
#     --auto    -> run non-interactively (apply without prompts)
#     --destroy -> run terraform destroy instead of apply for each module
# Usage:
#   ./deploy.sh            (interactive apply)
#   ./deploy.sh --auto     (non-interactive apply)
#   ./deploy.sh --destroy  (interactive destroy)
#
# WARNING: Running this will create AWS resources that may incur charges.
# Make sure AWS credentials are configured (AWS_ACCESS_KEY_ID / AWS_SECRET_ACCESS_KEY or AWS CLI configured).

MODE="apply"
AUTO="false"
for arg in "$@"; do
  case "$arg" in
    --auto) AUTO="true" ;;
    --destroy) MODE="destroy" ;;
    *) echo "Unknown argument: $arg"; exit 1 ;;
  esac
done

MODULES=(
  "task-01-vpc"
  "task-02-ec2-asg-elb"
  "task-03-rds"
  "task-04-s3-static-site"
  "task-05-iam-ec2-s3"
  "task-06-lambda-apigw"
  "task-07-cloudwatch-sns"
  "task-08-backend-destroy"
)

echo "Mode: $MODE"
if [ "$AUTO" = "true" ]; then
  echo "Auto mode enabled: will run without prompts."
fi
echo "Make sure you've reviewed terraform.tfvars in each module."
read -p "Proceed? (type YES to continue) " CONFIRM
if [ "$CONFIRM" != "YES" ]; then
  echo "Aborted by user."
  exit 0
fi

for mod in "${MODULES[@]}"; do
  if [ ! -d "$mod" ]; then
    echo "Skipping missing module: $mod"
    continue
  fi
  echo "======================================"
  echo "Module: $mod"
  pushd "$mod" > /dev/null

  echo "Initializing Terraform in $mod..."
  terraform init -input=false

  if [ "$MODE" = "apply" ]; then
    echo "Planning..."
    terraform plan -out=tfplan -input=false
    if [ "$AUTO" = "true" ]; then
      echo "Applying tfplan..."
      terraform apply -input=false -auto-approve tfplan
    else
      read -p "Apply this module? (yes/no) " APPLY_CONFIRM
      if [ "$APPLY_CONFIRM" = "yes" ]; then
        terraform apply -input=false -auto-approve tfplan
      else
        echo "Skipping apply for $mod"
      fi
    fi
  else
    echo "Planning destroy..."
    terraform plan -destroy -out=tfplan_destroy -input=false
    if [ "$AUTO" = "true" ]; then
      terraform apply -input=false -auto-approve tfplan_destroy
    else
      read -p "Destroy resources in this module? (yes/no) " DESTROY_CONFIRM
      if [ "$DESTROY_CONFIRM" = "yes" ]; then
        terraform apply -input=false -auto-approve tfplan_destroy
      else
        echo "Skipping destroy for $mod"
      fi
    fi
  fi

  echo "Cleaning up local plan files..."
  rm -f tfplan tfplan_destroy

  popd > /dev/null
done

echo "All modules processed. Reminder: check AWS Console to verify resources and billing."
