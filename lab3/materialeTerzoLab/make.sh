#!/bin/bash

yacc='../../../bin/yacc.exe'
jflex='../../../bin/jflex-1.8.2/bin/jflex.bat'
yaccFile="$1.y"
jflexFile="$1.l"

$jflex $jflexFile && \
$yacc -J $yaccFile && \
 javac *.java && \
 java Parser < $2 > compilato.txt && \
 ./stackMachine.exe compilato.txt