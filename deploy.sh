remote=go@instructions.peachyprinter.com:/var/www/instructions/
 for i in `find . -mtime -1 -type f -print | sed '/\.git/d'`
 do
   echo "Copying $i"
   scp $i ${remote}$(echo $i | sed 's:^\.*/::')
 done

