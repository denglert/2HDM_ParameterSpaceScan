#!/bin/awk -f
{ if ( $field != tempval )
    { tempval = $field; printf "\n%s\n", $0}
  else
    {print};
}
