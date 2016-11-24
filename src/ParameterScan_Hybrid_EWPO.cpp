#include "2HDMC/THDM.h"
#include "2HDMC/SM.h"
#include "2HDMC/HBHS.h"
#include "2HDMC/Constraints.h"
#include "2HDMC/DecayTable.h"
#include <iostream>
#include <string>
#include <TROOT.h>
#include <fstream>
#include <cmath>

//#define VERBOSE

using namespace std;

int main(int argc, char* argv[]) 
{

  if ( argc != 11)
  {
	 printf("ParameterScan_Hybrid_General usage:\n");
	 printf("ParameterScan_Hybrid_General <label> <BitWriteLHA> <mh> <mH> <cba> <tanb> <Z4> <Z5> <Z7> <yukawa-type>");
  }


  std::string label = argv[1];
  bool BitWriteLHA  = (int)atoi(argv[2]); 
  double mh_in      = (double)atof(argv[3]);
  double mH_in      = (double)atof(argv[4]);
  double cba_in     = (double)atof(argv[5]);
  double tanb_in    = (double)atof(argv[6]);
  double Z4_in      = (double)atof(argv[7]);
  double Z5_in      = (double)atof(argv[8]);
  double Z7_in      = (double)atof(argv[9]);
  int yt_in         = (int)atoi(argv[10]);


  // Reference SM Higgs mass for EW precision observables
  double mh_ref = 125.;
  
  // Create SM and set parameters
  SM sm;
  sm.set_qmass_pole(6, 172.5);		
  sm.set_qmass_pole(5, 4.75);		
  sm.set_qmass_pole(4, 1.42);	
  sm.set_lmass_pole(3, 1.77684);	
  sm.set_alpha(1./127.934);
  sm.set_alpha0(1./137.0359997);
  sm.set_alpha_s(0.119);
  sm.set_MZ(91.15349);
  sm.set_MW(80.36951);
  sm.set_gamma_Z(2.49581);
  sm.set_gamma_W(2.08856);
  sm.set_GF(1.16637E-5);

  // Create 2HDM and set SM parameters
  THDM model;
  model.set_SM(sm);

  // Parameter set validation check
  bool pset = model.set_param_hybrid(mh_in,mH_in,cba_in,Z4_in,Z5_in,Z7_in,tanb_in);
  
  if (!pset)
  {
    cerr << "The specified parameters are not valid\n";
    return -1;
  }

  // Set Yukawa couplings
  model.set_yukawas_type(yt_in);

  // Print the parameters in different parametrizations to stdout
  
  ////////////////////////////////////
  /// 									  ///
  /// --- Checking constraints --- ///
  /// 									  ///
  ////////////////////////////////////
  // -   !!! Important note !!!   - //
  // You need to call HB&HS initialization before constr(mode)!

  // Prepare to calculate observables
  Constraints constr(model);

  double S,T,U,V,W,X;   

  //printf("start\n", cba_in);
  constr.oblique_param(mh_ref,S,T,U,V,W,X);

  //printf("cba: %.3f\n", cba_in*cba_in);
  //printf("sba: %.3f\n", (1.0-cba_in*cba_in));
  //printf("stop\n", cba_in);

  bool BitAllowedStability      = constr.check_stability();
  bool BitAllowedUnitarity      = constr.check_unitarity();
  bool BitAllowedPerturbativity = constr.check_perturbativity(8.0*M_PI);

  double delta_rho = constr.delta_rho(mh_ref);
  double delta_amu = constr.delta_amu();

  double mh,mH,mA,mHc,sinba,l6,l7,m12_2,tb;
  double l1,l2,l3,l4,l5;
  
  model.get_param_gen(l1,l2,l3,l4,l5,l6,l7,m12_2,tb);
  model.get_param_phys(mh,mH,mA,mHc,sinba,l6,l7,m12_2,tb);
  // Please note that here sin(b-a) comes from the physical basis so it can be
  // negative too!

  # ifdef VERBOSE
  printf("Inside ParameterScan_Hybrid_General.cpp\n");
  printf("mh_in:       %8.4f\n", mh_in);
  printf("mH_in:       %8.4f\n", mH_in);
  printf("mh:          %8.4f\n", mh);
  printf("mA:          %8.4f\n", mA);
  printf("mH:          %8.4f\n", mH);
  printf("mHc:         %8.4f\n", mHc);
  printf("cos(b-a)_in: %8.4f\n", cba_in);
  printf("tan(b)_in:   %8.4f\n", tanb_in);
  printf("Z4_in:       %8.4f\n", Z4_in);
  printf("Z5_in:       %8.4f\n", Z5_in);
  printf("Z7_in:       %8.4f\n", Z7_in);
  printf("S:           %8.4f\n", S);
  printf("T:           %8.4f\n", T);
  printf("U:           %8.4f\n", U);
  printf("delta_rho:   %8.4f\n", delta_rho);
  printf("\nConstraints:\n");
  printf("  Potential stability: %s\n", 
	 (constr.check_stability() ? "OK" : "Not OK"));
  printf(" Tree-level unitarity: %s\n", 
	 (constr.check_unitarity() ? "OK" : "Not OK"));
  printf("       Perturbativity: %s\n", 
	 (constr.check_perturbativity() ? "OK" : "Not OK"));
  # endif

  ///////////////////
  // Write to file //
  ///////////////////

  // Write output to LesHouches file
  if ( BitWriteLHA )
  {
  std::string filename_LHA = Form("./LHA/mh_%.4f_mH_%.4f_mHc_%.4f_mA_%.4f_cba_%.4f_tb_%.4f_Z4_%.4f_Z5_%.4f_Z7_%.4f.lha", mh_in, mH_in, mHc, mA, cba_in, tanb_in, Z4_in, Z5_in, Z7_in);

  model.write_LesHouches(filename_LHA.c_str(), 1, 0, 1, 1);
  }


  ///////////////////////////////
  // Write parameters and chi2 //
  ///////////////////////////////
  
  std::string fout_path = Form("./param_pts_processed_%s.dat", label.c_str());

  std::ofstream fout;
  fout.open( fout_path.c_str(), std::ios_base::app);

	// Write to file
	fout                                    
	
	// 2HDM params (mostly Hybrid)
	<< cba_in << " "                        			//  01 - input parameter
	<< sinba << " "                        			//  02
	<< tanb_in << " "                       			//  03 - input parameter
	<< Z4_in << " "                         			//  04 - input parameter
	<< Z5_in << " "                         			//  05 - input parameter
	<< Z7_in << " "                         			//  06 - input parameter
	<< m12_2 << " "                         			//  07

	// Lambdas
	<< l1 << " "                            			//  08                 
	<< l2 << " "                            			//  09                 
	<< l3 << " "                            			//  10                 
	<< l4 << " "                            			//  11                 
	<< l5 << " "                            			//  12                
	<< l6 << " "                            			//  13                
	<< l7 << " "                            			//  14                
	
	// Masses
	<< mh_in << " "                         			//  15 - input parameter
	<< mH_in << " "                         			//  16 - input parameter
	<< mHc   << " "                         			//  17            
	<< mA    << " "                         			//  18           
	
	// Theoretical test - allowed/excluded 
	<< BitAllowedStability << " "                   //  19
	<< BitAllowedUnitarity << " "                   //  20                                  
	<< BitAllowedPerturbativity << " "              //  21
	
	// Oblique
	<< S << " "                             			//  22
	<< T << " "                             			//  23
	<< U << " "                             			//  24
	<< V << " "                             			//  25
	<< W << " "                             			//  26
	<< X << " "                             			//  27
	<< delta_rho << " "                             //  28

	// a_mu
	<< delta_amu << " "                             //  29                                  

	<< std::endl;

}
