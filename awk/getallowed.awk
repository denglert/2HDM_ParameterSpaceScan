#!/bin/awk -f
# Get lines which satisfy the criteria

BEGIN{
	sigma1=2.30; 
	sigma2=6.18;
	sigma3=11.83;
	stability=1
	unitarity=1
	perturbativity=1
	hobs=1
	  }
{ 
	if ( ($0 != "") && ($26 < sigma3) && ($9 < hobs) && ($11 == unitarity) && ($12 == perturbativity) )
	print $0
}



# Original script:
#BEGIN{
#	sigma1=2.30; 
#	sigma2=6.18;
#	sigma3=11.83;
#	stability=1
#	unitarity=1
#	perturbativity=1
#	hobs=1
#	  }
#{ 
#	if ( ($0 != "") && ($26 < sigma3) && ($9 < hobs) && ($10 == stability) && ($11 == unitarity) && ($12 == perturbativity) )
#	print $0
#}
