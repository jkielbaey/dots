# All AWS related aliases, functions, etc...

set -x AWS_ASSUME_ROLE_TTL 1h
set -x AWS_SESSION_TTL 1h
set -x AWS_DEFAULT_REGION eu-west-1
set -x TF_AWS_PROFILE anb_devops

# Enable auto-completion aws cli.
complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'

function aws
  aws-vault exec $AWS_PROFILE -- /usr/local/bin/aws $argv
end

function sam
  aws-vault exec $AWS_PROFILE -- /usr/local/bin/sam $argv
end

function tf
    if echo $argv | grep -q "workspace show"
        terraform workspace show
    else
        aws-vault exec $TF_AWS_PROFILE -- terraform $argv
    end
end


function tfplan --description "tfplan <workspace>"
    if test (count $argv) -ne 0
        set workspace $argv[1]
        set curworkspace (terraform workspace show)
        if test "$workspace" != "$curworkspace"
            echo "terraform workspace select $workspace..."
            aws-vault exec $TF_AWS_PROFILE -- terraform workspace select $workspace
        end
    else
        set workspace (terraform workspace show)
    end

    set global_config_file ../config/global.tfvars

    if test -f $global_config_file
        echo "terraform plan -input=false -var-file $global_config_file -var-file ../config/$workspace.tfvars -out $workspace.tfplan"
        aws-vault exec $TF_AWS_PROFILE -- terraform plan -input=false -var-file $global_config_file -var-file ../config/$workspace.tfvars -out $workspace.tfplan
    else
        echo "terraform plan -input=false -var-file ../config/$workspace.tfvars -out $workspace.tfplan"
        aws-vault exec $TF_AWS_PROFILE -- terraform plan -input=false -var-file ../config/$workspace.tfvars -out $workspace.tfplan
    end
end

function tfapply --description "tfapply <workspace>"
    if test (count $argv) -ne 0
        set workspace $argv[1]
        echo "terraform workspace select $workspace..."
        aws-vault exec $TF_AWS_PROFILE -- terraform workspace select $workspace
    else
        set workspace (terraform workspace show)
    end

    echo "terraform apply $workspace.tfplan..."
    aws-vault exec $TF_AWS_PROFILE -- terraform apply $workspace.tfplan
end

