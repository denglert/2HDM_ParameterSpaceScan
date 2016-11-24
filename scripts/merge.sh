#!/bin/sh

jobtag=$1

awk 'FNR > 1' *formated_allowed.dat > output_allowed_combined.dat
