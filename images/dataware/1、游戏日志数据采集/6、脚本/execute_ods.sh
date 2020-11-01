#!/bin/bash

odsshell=`ls ods*`

#echo "$odsshell"


for m in $odsshell
do
 echo $m
 /usr/bin/sh $m


done
