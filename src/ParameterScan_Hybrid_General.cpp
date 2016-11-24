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

int main(int argc, char* argv[]) {

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
  
  if (!pset) {
    cerr << "The specified parameters are not valid\n";
    return -1;
  }

  // Set Yukawa couplings
  model.set_yukawas_type(yt_in);

  // Print the parameters in different parametrizations to stdout
  //model.print_param_phys();
  //model.print_param_gen();
  //model.print_param_higgs();
  //model.print_param_hybrid();

  
  ////////////////////////////////////
  /// 									  ///
  /// --- Checking constraints --- ///
  /// 									  ///
  ////////////////////////////////////
  // -   !!! Important note !!!   - //
  // You need to call HB&HS initialization before constr(mode)!

  // Call HB & HS initialization
  HB_init();
  HS_init();
  // Prepare to calculate observables
  Constraints constr(model);

  double S,T,U,V,W,X;   

  constr.oblique_param(mh_ref,S,T,U,V,W,X);

  bool BitAllowedStability      = constr.check_stability();
  bool BitAllowedUnitarity      = constr.check_unitarity();
//bool BitAllowedPerturbativity = constr.check_perturbativity(); // the default is 4.0*M_PI
  bool BitAllowedPerturbativity = constr.check_perturbativity(8.0*M_PI);

 
  //////////////////////////////////
  // - HiggsBounds/HiggsSignals - //
  //////////////////////////////////
  // - !!! Important note !!!  -  //
  // It seems that if you call constr.delta_amu() before
  // HB/HS then HB/HS won't work properly!

// See HiggsSignals manual for more information
  int mass_pdf = 2;
  HS_set_pdf(mass_pdf);
  HS_setup_assignment_range_massobservables(2.);
  HS_set_output_level(0);

// Share couplings of 2HDM model with HiggsBounds/HiggsSignals
  HB_set_input_effC(model);
  
  int hbres[6];
  int hbchan[6];
  double hbobs[6];
  int hbcomb[6];  

// Run HiggsBounds 'full', i.e. with each Higgs result separately  
  HB_run_full(hbres, hbchan, hbobs, hbcomb);
//  printf("\nHiggsBounds results (full):\n");
//  printf("  Higgs  res  chan       ratio        ncomb\n");
//  for (int i=1;i<=4;i++) {
//    printf("%5d %5d %6d %16.8E %5d   %s\n", i, hbres[i],hbchan[i],hbobs[i],hbcomb[i],hbobs[i]<1 ? "Allowed" : "Excluded");
//  }
//  printf("------------------------------------------------------------\n");
//  printf("  TOT %5d %6d %16.8E %5d   %s\n", hbres[0],hbchan[0],hbobs[0],hbcomb[0],hbobs[0]<1 ? "ALLOWED" : "EXCLUDED");

  double tot_hbobs = hbobs[0];
  double mostsensitivech = hbchan[0];

  double csqmu;
  double csqmh;
  double csqtot;
  int nobs;
  double pval;
  
  double dMh[3]={0., 0., 0.,};
  HS_set_mass_uncertainties(dMh);
 
  HS_run(&csqmu, &csqmh, &csqtot, &nobs, &pval);

  //printf("\nHiggsSignals results:\n");
  //printf(" Chi^2 from rates: %16.8E\n", csqmu);
  //printf("  Chi^2 from mass: %16.8E\n", csqmh);
  //printf("      Total chi^2: %16.8E\n", csqtot);
  //printf("    # observables: %16d\n\n", nobs);


//	std::complex <double> cs;
//	std::complex <double> cp;

//	model.get_coupling_vvh(2,2,1,coupling);
//  	model.get_coupling_hdd(1,3,3,cs,cp);

//  printf("Hvev:       %8.4f\n", sqrt(Hvev_2));
//  printf("mA:       %8.4f\n", mA);


  // Warning: Beware with these ones as they seem to destroy some HB/HS
  // functionality!!!
  double delta_rho = constr.delta_rho(mh_ref);
  double delta_amu = constr.delta_amu();

// constr.print_all(mh_ref);

  //////////////////////
  // - Gamma widths - //
  //////////////////////

  // Prepare to calculate decay widths
  DecayTable table(model);

  // Print to stdout total widths of Higgs bosons
  // table.print_width(1);
  // table.print_width(2);
  // table.print_width(3);
  // table.print_width(4);	

  struct BR brf;
  table.geth_BR(3,brf); // 3 - stands for the pseudoscalar A

  double br_A_tt     = brf.bruu[3][3];
  double br_A_bb     = brf.brdd[3][3];
  double br_A_gg     = brf.brhgg;
  double br_A_tautau = brf.brll[3][3];
  double br_A_zh     = brf.brvh[2][1];

//  printf("br tt:      %.3e\n", br_A_tt    );
//  printf("br bb:      %.3e\n", br_A_bb    );
//  printf("br gg:      %.3e\n", br_A_gg    );
//  printf("br tau tau: %.3e\n", br_A_tautau);
//  printf("br zh:      %.3e\n", br_A_zh    );

  // You can cross-check the branching fractions here with the full table
  // printf("br tt:      %.3e\n", brf.bruu[3][3]);
  // printf("br bb:      %.3e\n", brf.brdd[3][3]);
  // printf("br gg:      %.3e\n", brf.brhgg);
  // printf("br tau tau: %.3e\n", brf.brll[3][3]);
  // printf("br zh:      %.3e\n", brf.brvh[2][1]);
  // table.print_decays(3);

  // table.print_decays(1);
  // table.print_decays(2);
  // table.print_decays(3);
  // table.print_decays(4);



  double Hvev_2 = sm.get_v2();

  // From 2HDMC:
  //  const char *hnames[6] = {" ","h ", "H ", "A ", "H+", "H-"};
  double Gamma_h  = table.get_gammatot_h(1);
  double Gamma_H  = table.get_gammatot_h(2);
  double Gamma_A  = table.get_gammatot_h(3);
  double Gamma_Hc = table.get_gammatot_h(4);

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
  printf("Gamma_A:     %8.4f\n", Gamma_A);
  printf("cos(b-a)_in: %8.4f\n", cba_in);
  printf("tan(b)_in:   %8.4f\n", tanb_in);
  printf("Z4_in:       %8.4f\n", Z4_in);
  printf("Z5_in:       %8.4f\n", Z5_in);
  printf("Z7_in:       %8.4f\n", Z7_in);
  printf("S:           %8.4f\n", S);
  printf("T:           %8.4f\n", T);
  printf("U:           %8.4f\n", U);
  printf("delta_rho:   %8.4f\n", delta_rho);
  printf("csqtot:      %8.4f\n", csqtot);
  printf("tot_hbobs:   %8.4f\n", tot_hbobs);
  printf("\nConstraints:\n");
  printf("  Potential stability: %s\n", 
	 (constr.check_stability() ? "OK" : "Not OK"));
  printf(" Tree-level unitarity: %s\n", 
	 (constr.check_unitarity() ? "OK" : "Not OK"));
  printf("       Perturbativity: %s\n", 
	 (constr.check_perturbativity() ? "OK" : "Not OK"));
//  printf("sba - cba*tb:%8.4f\n", (sinba-cba_in*tanb_in));
//  printf("cs/(sba - cba*tb):%8.4f\n", std::abs(cs/(sinba-cba_in*tanb_in))/(sqrt(2.0)*4.75/246.0) );
//  std::cout << "vvh:     " << coupling << std::endl;
//  std::cout << "hdd cs:     " << cs << std::endl;
//  std::cout << "hdd cp:     " << cp << std::endl;
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
	
	// Widths
	<< Gamma_h  << " "                      			//  19                      
	<< Gamma_H  << " "                      			//  20                      
	<< Gamma_Hc << " "                      			//  21                      
	<< Gamma_A  << " "                      			//  22                      

   // A -> sg sg. branching fractions
	<<  br_A_tt     << " "                      		//  23
	<<  br_A_bb     << " "                      		//  24
	<<  br_A_gg     << " "                      		//  25
	<<  br_A_tautau << " "                      		//  26
	<<  br_A_zh     << " "                      		//  27

	// Theoretical test - allowed/excluded 
	<< BitAllowedStability << " "                   //  28
	<< BitAllowedUnitarity << " "                   //  29                                  
	<< BitAllowedPerturbativity << " "              //  30
	
	// Oblique
	<< S << " "                             			//  31
	<< T << " "                             			//  32
	<< U << " "                             			//  33
	<< V << " "                             			//  34
	<< W << " "                             			//  35
	<< X << " "                             			//  36
	<< delta_rho << " "                             //  37

	// a_mu
	<< delta_amu << " "                             //  38                                  

	// Experimental test - statistics
	<< tot_hbobs << " "                             //  39
   << mostsensitivech << " "                       //  40
	<< csqtot << " "                                //  41
	
	<< std::endl;

  HB_finish();
  HS_finish();

}
