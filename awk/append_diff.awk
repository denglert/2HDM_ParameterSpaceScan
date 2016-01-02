#!/bin/awk -f
{
  if( $0 != "" ) 
    { print $0, $field-val}
  else
    { print };
}
