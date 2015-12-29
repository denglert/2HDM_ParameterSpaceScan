#!/bin/awk -f
{ if ( $1 != tempval )
    { tempval = $1; printf "\n%s\n", $0}
  else
    {print};
}
