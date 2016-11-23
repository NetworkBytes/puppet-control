MODULES=modules
ENVIRONMENT=$(basename $PWD)
PUPPET_MODULES=$(puppet module list --environment=$ENVIRONMENT --color false)
echo -e "# Generated by $(basename $0)    $(date)\n\n"
echo -e "\nmod 'profiles', :local => true\n"

for MOD_PATH in $MODULES/*; do
  MOD=$(basename $MOD_PATH)
  #echo "#  $MOD"
  if [ -d "$MOD_PATH/.git" ]; then
    echo "mod '$MOD',"
    git --git-dir=$MOD_PATH/.git --work-tree=$MOD_PATH fetch > /dev/null
    #git --git-dir=$MOD_PATH/.git --work-tree=$MOD_PATH log -n 1 FETCH_HEAD| grep -e '^commit'|awk '{ printf "  :%s => '\''%s'\'',\n",  $1, $2 }'
    git --git-dir=$MOD_PATH/.git --work-tree=$MOD_PATH log -n 1 origin/master| grep -e '^commit'|awk '{ printf "  :%s => '\''%s'\'',\n",  $1, $2 }'
    git --git-dir=$MOD_PATH/.git --work-tree=$MOD_PATH remote -v  |grep 'origin'|head -n 1|awk '{printf "  :git    => '\''%s'\'',\n", $2 }'
    echo "  :branch => 'master'"

  else
    # external module
    echo "$PUPPET_MODULES" |\
        grep -e "-$MOD " \
      | cut -d' ' -f2 \
      | tr '-' '/' \
      | awk '{printf "mod '\''%s'\'',\n", $0}'

    # version
    echo "$PUPPET_MODULES" |\
        grep -e "-$MOD " \
      | cut -d' ' -f3 \
      | tr -d '()v' \
      | awk '{printf "  '\''%s'\''\n", $0}'
  fi

  echo -e "\n"
done
