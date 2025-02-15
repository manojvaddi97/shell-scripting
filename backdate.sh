#!/bin/bash

#This script creates backdate logs for testing purpose##

for ((i=1; i<=20; i++))
do
    touch -d "2024-01-10" "shipping_$i.log"
done
