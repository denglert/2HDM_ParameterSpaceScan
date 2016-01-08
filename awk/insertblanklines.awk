#!/bin/awk -f
# Insert a blank line when the field value changes otherwise just print out the line

{ if ( $field != tempval )
    { tempval = $field; printf "\n%s\n", $0}
  else
    {print};
}
