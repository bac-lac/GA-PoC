#!/bin/sh

CLASS=$(echo /opt/saxon/lib/*.jar | tr ' ' ':')
CLASSPATH="$CLASSPATH:$CLASS"
export CLASSPATH