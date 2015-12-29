#!/bin/awk -f
{
  if( $0 != "" ) 
    { print $field_X, $field_Y, ($field_Z-min)}
  else
    { print };
}
