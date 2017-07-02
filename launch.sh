#!/bin/sh

while true; do
    composer update
    /usr/bin/env php madeline.php
    sleep 5
done
