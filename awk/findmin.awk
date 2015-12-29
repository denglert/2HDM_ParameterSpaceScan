#!/bin/awk -f
BEGIN{min=9999.0;}
{if ((NF >= 8) && ($8 < min)) {min = $8; line = $0};}
END{print line}
