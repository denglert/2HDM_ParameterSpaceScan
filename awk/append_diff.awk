#!/bin/awk -f
# Adds a new field to the lines which is <fieldvalue> - <val>
# Input variables:
#  - <field>: The number of the field from which you would like to subtract
#  -   <val>: subtract this number

{
  if( $0 != "" ) 
    { print $0, $field-val}
  else
    { print };
}
