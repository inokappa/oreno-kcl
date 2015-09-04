#!/bin/sh

cd /app/
cat oreno.properties.template | while read line; do eval "echo `echo $line`"; done > oreno.properties
rake run
