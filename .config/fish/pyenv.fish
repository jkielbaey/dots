set pyenv_temp_file (mktemp)
pyenv init - > $pyenv_temp_file
. $pyenv_temp_file
rm $pyenv_temp_file