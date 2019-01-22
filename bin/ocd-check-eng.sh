#!/bin/bash
PROJECT=your-eng
APP=realworld
awk 'FNR==NR{a[$1]=$2 FS $3;next}{ print $0, a[$2]}' roles-eng.tsv user-roles-eng.tsv \
    | awk '{split($3,v,","); for (x in v){ print $1 " " v[x] " " $4; } }' > /tmp/template.$$
envsubst < /tmp/template.$$ \
    | awk '{print "oc policy who-can " $2 " " $3 " | grep " $1 " ; if [ $? -ne 0 ]; then echo MISSING! " $1  " " $2 " " $3 "; fi " }' \
    > /tmp/script.$$.sh
chmod +x /tmp/script.$$.sh
/tmp/script.$$.sh
