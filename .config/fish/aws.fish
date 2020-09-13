# All AWS related aliases, functions, etc...

set -x AWS_ASSUME_ROLE_TTL 1h
set -x AWS_SESSION_TTL 1h
set -x AWS_DEFAULT_REGION eu-west-1

# Enable auto-completion aws cli.
complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'

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

    echo "CMD: aws-vault exec $TF_AWS_PROFILE -- terraform plan -input=false -var-file ../config/$workspace.tfvars -out $workspace.tfplan -parallelism=30"
    aws-vault exec $TF_AWS_PROFILE -- terraform plan -input=false -var-file ../config/$workspace.tfvars -out $workspace.tfplan -parallelism=30
end

function tfapply --description "tfapply"
    echo "CMD: aws-vault exec $TF_AWS_PROFILE -- terraform apply -parallelism=30 $workspace.tfplan"
    aws-vault exec $TF_AWS_PROFILE -- terraform apply -parallelism=30 $workspace.tfplan
end

function tfsl
    echo "CMD: aws-vault exec $TF_AWS_PROFILE -- terraform state list"
    aws-vault exec $TF_AWS_PROFILE -- terraform state list
end

function tfss --description "tfss <resource>"
    echo "CMD: aws-vault exec $TF_AWS_PROFILE -- terraform state show $argv"
    aws-vault exec $TF_AWS_PROFILE -- terraform state show $argv
end
