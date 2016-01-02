#!/bin/awk -f
BEGIN{ min=9999.0; }
{ 
	if ( ($0 != "") && ($field < min) )
	{min = $field; line = $0};
}
END{ print line }
