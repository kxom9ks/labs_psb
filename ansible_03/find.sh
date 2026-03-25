#!/bin/bash

c=0

for (( i = 1; i <= $#; i++ ))
do

    if [[ -f "$path" ]]; then

        if [[ $(grep -x "TMOUT=900" ${!i}) != "" && $(grep -x "readonly TMOUT" ${!i}) != "" ]]; then
            ((c++))
        else
            ((c))
        fi

    else

        if [[ $(grep -xrl "TMOUT=900" ${!i} | xargs grep -x "readonly TMOUT") != "" ]]; then
            ((c++))
        else
            ((c))
        fi

    fi
done

if (( c <= 0 )); then
    echo "Нужно добавить параметры TMOUT"
    c=0
else
    echo "Параметры добавлены"
    c=0
fi
