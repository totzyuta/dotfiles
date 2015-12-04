#################
#   functions   #
#################

# Cat image
cam() {
  ORG=$1

  if [[ ${ORG##*.} =~ '(JPG|jpg|JPEG|jpeg|GIF|gif|PNG|png)' ]]; then

    CATWIDTH=128

    SRC=/tmp/termtmp.png
    convert -resize $(( $CATWIDTH / 2 ))x "$ORG" "$SRC"

    INF=`identify "$SRC" | sed -e 's/^.* \([0-9]*x[0-9]*\) .*$/\1/g'`
    W=`echo "$INF" | cut -d'x' -f1`

    INF=`convert "$SRC" -crop 1x1+$W txt:- 2>&/dev/null`
    INF=`echo $INF | sed -e 's/^.*(\(.*\)[,)].*$/\1/g' | sed -e 's/,/ /g' | sed -e '1,1d'`

    I=0

    RGB2COL()
    {
      I=$(( $I + 1 ))
      _R=$(( $1 * 5 / 255 * 36 ))
      _G=$(( $2 * 5 / 255 * 6 ))
      _B=$(( $3 * 5 / 255 ))
      echo -n "\x1b[48;5;$(( 16 + $_R + $_G + $_B ))m  \x1b[0m"
      [[ 0 -eq $(( $I % $W )) ]] && echo -n '\n'
    }

    I=0

    echo $INF | while read line
    do
      RGB2COL `echo $line`
    done

  else
    cat $@
  fi
}

# git
# open a remote by browser
openremote() {
  if [ $# -eq 0 ]
  then
    git remote show "origin" | grep Fetch | cut -d ":" -f2 -f3 | cut -d "." -f1 -f2 | xargs python -mwebbrowser
  else
    git remote show ${1} | grep Fetch | cut -d ":" -f2 -f3 | cut -d "." -f1 -f2 | xargs python -mwebbrowser
  fi
}

200check() {
  while true
  do
    RESULT=`curl --head ${1} | grep HTTP`
    echo $RESULT
    if [[ $RESULT =~ "200" ]]; then
      osascript -e 'display notification "🍻" with title "200"'
    fi
    sleep 5
  done
}
