# Language Default
set -x LC_ALL en_US.UTF-8
set -x LC_CTYPE en_US.UTF-8

set -x PYTHON_VERSION (python --version 2>&1)

if echo $PYTHON_VERSION | grep -q 2.6
    set -x PYTHONPATH "/usr/local/lib/python2.6/site-packages"
else if echo $PYTHON_VERSION | grep -q 2.7
    set -x PYTHONPATH "/usr/local/lib/python2.7/site-packages"
else if echo $PYTHON_VERSION | grep -q 3.5
    set -x PYTHONPATH "/usr/local/lib/python3.5/site-packages"
end

# respect local bins
set -x PATH "./bin" $PATH

# editor
set -x EDITOR "vim"

# grep colors
setenv -x GREP_OPTIONS "--color=auto"

