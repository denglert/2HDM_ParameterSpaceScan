#!/bin/awk -f
# Only print out three fields:
# field_X, field_Y and field_Z

{
  if( $0 != "" ) 
    { print $field_X, $field_Y, $field_Z}
  else
    { print };
}
