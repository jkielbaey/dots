function aws
  aws-vault exec $AWS_PROFILE -- /usr/local/bin/aws $argv
end

function sam
  aws-vault exec $AWS_PROFILE -- /usr/local/bin/sam $argv
end

set -x TF_AWS_PROFILE anb_devops

function tf
    if echo $argv | grep -q "workspace show"
        terraform workspace show
    else
        aws-vault exec $TF_AWS_PROFILE -- terraform $argv
    end
end


function tfplan --description "tfplan <workspace> <additional arguments>"
    set workspace $argv[1]
    set --erase argv[1]

    set global_config_file ../config/global.tfvars

    echo "terraform workspace select $workspace..."
    aws-vault exec $TF_AWS_PROFILE -- terraform workspace select $workspace

    echo "terraform plan $argv..."
    if test -f $global_config_file
        aws-vault exec $TF_AWS_PROFILE -- terraform plan -input=false -var-file $global_config_file -var-file ../config/$workspace.tfvars -out $workspace.tfplan $argv
    else
        aws-vault exec $TF_AWS_PROFILE -- terraform plan -input=false -var-file ../config/$workspace.tfvars -out $workspace.tfplan $argv
    end
end

function tfapply --description "tfapply <workspace>"
    set workspace $argv[1]

    echo "terraform apply $workspace.tfplan..."
    aws-vault exec $TF_AWS_PROFILE -- terraform apply $workspace.tfplan
end
