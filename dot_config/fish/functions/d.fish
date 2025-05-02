function d
    while test $PWD != /
      if test -d .git
        break
      end
      cd ..
    end
end
