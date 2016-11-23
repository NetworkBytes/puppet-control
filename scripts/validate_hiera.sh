for FILE in $(find . -name '*.yaml'); do echo $FILE;  ruby -e "require 'yaml'; YAML.load_file('$FILE')"; done
