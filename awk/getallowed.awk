#!/bin/awk -f
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
	if ( ($0 != "") && ($16 < sigma3) && ($9 < hobs) && ($10 == stability) && ($11 == unitarity) && ($12 == perturbativity) )
	print $0
}
