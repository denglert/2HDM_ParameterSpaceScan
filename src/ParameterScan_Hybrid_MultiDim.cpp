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

using namespace std;

int main(int argc, char* argv[]) {

  if ( argc != 11)
  {
	 printf("ParameterScan_Hybrid_MultiDim usage:\n");
	 printf("ParameterScan_Hybrid_MultiDim <tag> <BitWriteLHA> <mh> <mH> <cba> <tanb> <Z4> <Z5> <Z7> <yukawa-type>");
  }

  std::string tag  = argv[1];
  bool BitWriteLHA = (int)atoi(argv[2]); 
  double mh_in     = (double)atof(argv[3]);
  double mH_in     = (double)atof(argv[4]);
  double cba_in    = (double)atof(argv[5]);
  double tanb_in   = (double)atof(argv[6]);
  double Z4_in     = (double)atof(argv[7]);
  double Z5_in     = (double)atof(argv[8]);
  double Z7_in     = (double)atof(argv[9]);
  int yt_in        = (int)atoi(argv[10]);

  printf("Inside ParameterScan_Hybrid_MultiDim\n");
  printf("mh:       %8.4f\n", mh_in);
  printf("mH:       %8.4f\n", mH_in);
  printf("cos(b-a): %8.4f\n", cba_in);
  printf("tan(b):   %8.4f\n", tanb_in);
  printf("Z4:       %8.4f\n", Z4_in);
  printf("Z5:       %8.4f\n", Z5_in);
  printf("Z7:       %8.4f\n", Z7_in);

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


  HB_init();
  HS_init();

  // Set Yukawa couplings
  model.set_yukawas_type(yt_in);

  // Print the parameters in different parametrizations to stdout
//  model.print_param_phys();
//  model.print_param_gen();
//  model.print_param_higgs();
//  model.print_param_hybrid();

  ////////////////////////////////////
  /// 									  ///
  /// --- Checking constraints --- ///
  /// 									  ///
  ////////////////////////////////////

  // Prepare to calculate observables
  Constraints constr(model);

  double S,T,U,V,W,X;   

  constr.oblique_param(mh_ref,S,T,U,V,W,X);

  bool BitAllowedStability      = constr.check_stability();
  bool BitAllowedUnitarity      = constr.check_unitarity();
  bool BitAllowedPerturbaticity = constr.check_perturbativity();

// constr.print_all(mh_ref);
  
//  printf("\nConstraints:\n");
//  printf("  Potential stability: %s\n", 
//	 (constr.check_stability() ? "OK" : "Not OK"));
//  printf(" Tree-level unitarity: %s\n", 
//	 (constr.check_unitarity() ? "OK" : "Not OK"));
//  printf("       Perturbativity: %s\n", 
//	 (constr.check_perturbativity() ? "OK" : "Not OK"));
//
//  printf("\n");
//  printf(" Oblique S: %12.5e\n", S);  
//  printf(" Oblique T: %12.5e\n", T);
//  printf(" Oblique U: %12.5e\n", U);  
//  printf(" Oblique V: %12.5e\n", V);
//  printf(" Oblique W: %12.5e\n", W);  
//  printf(" Oblique X: %12.5e\n", X);
//  printf(" Delta_rho: %12.5e\n", constr.delta_rho(mh_ref));
//  printf("\n");
//  printf(" Delta_amu: %12.5e\n\n", constr.delta_amu());

  //////////////////////////////////
  // - HiggsBounds/HiggsSignals - //
  //////////////////////////////////

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
  printf("\nHiggsBounds results (full):\n");
  printf("  Higgs  res  chan       ratio        ncomb\n");
  for (int i=1;i<=4;i++) {
    printf("%5d %5d %6d %16.8E %5d   %s\n", i, hbres[i],hbchan[i],hbobs[i],hbcomb[i],hbobs[i]<1 ? "Allowed" : "Excluded");
  }
  printf("------------------------------------------------------------\n");
  printf("  TOT %5d %6d %16.8E %5d   %s\n", hbres[0],hbchan[0],hbobs[0],hbcomb[0],hbobs[0]<1 ? "ALLOWED" : "EXCLUDED");

  double tot_hbobs = hbobs[0];

  double csqmu;
  double csqmh;
  double csqtot;
  int nobs;
  double pval;
  
  double dMh[3]={0., 0., 0.,};
  HS_set_mass_uncertainties(dMh);
 
  HS_run(&csqmu, &csqmh, &csqtot, &nobs, &pval);

  printf("\nHiggsSignals results:\n");
  printf(" Chi^2 from rates: %16.8E\n", csqmu);
  printf("  Chi^2 from mass: %16.8E\n", csqmh);
  printf("      Total chi^2: %16.8E\n", csqtot);
  printf("    # observables: %16d\n\n", nobs);


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

  // table.print_decays(1);
  // table.print_decays(2);
  // table.print_decays(3);
  // table.print_decays(4);

  double Hvev_2 = sm.get_v2();
//  double mA = sqrt(mH_in*mH_in*(1-cba_in*cba_in) + mh_in*mh_in*cba_in*cba_in-Z5_in*Hvev_2);

  // From 2HDMC:
  //  const char *hnames[6] = {" ","h ", "H ", "A ", "H+", "H-"};
  double Gamma_h = table.get_gammatot_h(1);
  double Gamma_A = table.get_gammatot_h(3);

  // Debuggg 
  // double mh,mH,mA,mHp,sba,lambda6,lambda7,tan_beta,m12_2;
  // model.get_param_phys(mh,mH,mA,mHp,sba,lambda6,lambda7,m12_2,tan_beta);
  // printf("mA(manual): %15.8f\n", mA_man);
  // printf("mA(2HDMC):  %15.8f\n", mA);

  ///////////////////
  // Write to file //
  ///////////////////

  // mh mH cba tb, Z4, Z5, Z7, chisq, tot_hbobs, stability, unitarity,
  // perturbativity, mA, GammaA, Gammah 

  // Write output to LesHouches file
  if ( BitWriteLHA )
  {
  std::string filename_LHA = Form("./output/%s/LHA/mh_%.4f_mH_%.4f_cba_%.4f_tb_%.4f_Z4_%.4f_Z5_%.4f_Z7_%.4f.lha", tag.c_str(), mh_in, mH_in, cba_in, tanb_in, Z4_in, Z5_in, Z7_in);

  model.write_LesHouches(filename_LHA.c_str(), 1, 0, 1, 1);
  }

   double mh,mH,mA,mHp,sinba,l6,l7,m12_2,tb;
	model.get_param_phys(mh,mH,mA,mHp,sinba,l6,l7,m12_2,tb);


  printf("Hvev:       %8.4f\n", sqrt(Hvev_2));
  printf("mA:       %8.4f\n", mA);

  ///////////////////////////////
  // Write parameters and chi2 //
  ///////////////////////////////
  
  std::string filename_param_chisq = Form("./output/%s/chisquare_table.dat", tag.c_str());

  std::ofstream file_param_chisq;
  file_param_chisq.open(filename_param_chisq.c_str(), std::ios_base::app);
  std::string line = Form("%.6f %.6f %.6f %.6f %.6f %.6f %.6f %.6f %.6e %d %d %d %.6f %.6e %.6e %.6e %.6e %.6e %.6e %.6e %.6e %.6e %.6e %.6e %.6e\n", mh_in, mH_in, cba_in, tanb_in, Z4_in, Z5_in, Z7_in, csqtot, tot_hbobs, BitAllowedStability, BitAllowedUnitarity, BitAllowedPerturbaticity, mA, Gamma_h, Gamma_A, mHp, l6, l7, m12_2, S, T, U, V, W, X );
  file_param_chisq << line.c_str();

  HB_finish();
  HS_finish();

}
