#!/bin/bash

if pidof -x conky > /dev/null
then
	killall conky
else
	conky
fi
