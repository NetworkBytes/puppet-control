 for DIR in $(find modules -type d -maxdepth 1); do echo $DIR; [ -d "$DIR/.git" ] && git --git-dir=$DIR/.git --work-tree=$DIR status && echo -e "\n"; done

