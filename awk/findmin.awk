#!/bin/awk -f
# Finds the minimum of field <field> and then prints out the line containing the
# minimum value

BEGIN{ min=9999.0; }
{ 
	if ( ($0 != "") && ($field < min) )
	{min = $field; line = $0};
}
END{ print line }
