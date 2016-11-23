for DIR in $(find modules -type d -maxdepth 1); do echo $DIR; [ -d "$DIR/.git" ] && git --git-dir=$DIR/.git --work-tree=$DIR log  HEAD..FETCH_HEAD && echo -e "\n"; done

