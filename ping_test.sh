#!/bin/bash

ping $1 > /var/tmp/ping.from.`hostname`.to.$1
