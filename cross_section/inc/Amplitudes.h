#ifndef AMPLITUDES_H
#define AMPLITUDES_H

#include <iostream>
#include <fstream>
#include <cmath>
#include "clooptools.h"
#include "TLorentzVector.h"
#include "TH1D.h"

#define I std::complex<double>(0.0,1.0)

   //REAL*8 FUNCTION GG_ZH_BSM(propA, CPGA, P1, P2, P3, P4, NHEL)
// Eucledian Minkowski conversion
int e2m[4] = {1, 2, 3, 0};
int m2e[4] = {3, 0, 1, 2};

// Angles
const double sin_W2 = 0.23;
const double cos_W2 = 1.0 - sin_W2;

const double sin_W = sqrt(sin_W2);
const double cos_W = sqrt(cos_W2);

// Masses
const double m_Z = 91.3621093495386;
const double m_W = m_Z*cos_W;
const double m_h = 125.0;

// Gamma
const double Gamma_Z = 2.41916;

const double m_q[3][2] = { 
		  							{ 5.0e-2,  5.00e-2}, 
		  						   {  1.4e0,  0.50e0},
									{173.0e0,  4.75e0}
		  					    };

// Quark sector
const int niSo      = 2;
const int nFamilies = 3;
const int nQuarks   = 6;



// Couplings

//      REBL*8     TMASS,      BMASS,    CMASS,    SMASS,    UMASS
//      PARAMETER (TMASS=173.D0,BMASS=4.75D0,CMASS=1.40D0,
//     &                                    SMASS=0.5D0,UMASS=5.D-2)
//      REAL*8     TWIDTH,    BWIDTH,    CWIDTH,    SWIDTH,    UWIDTH
//      PARAMETER (TWIDTH=0.D0,BWIDTH=0D0,CWIDTH=0D0,SWIDTH=0D0,
//     &                                               UWIDTH=0D0)
//      REAL*8     DMASS,    EMASS,    MUMASS,    TAUMASS
//      PARAMETER (DMASS=5.D-2,EMASS=0.D0,MUMASS=0.105D0,
//     &           TAUMASS=1.78D0)
//      REAL*8     DWIDTH,    EWIDTH,    MUWIDTH,    TAUWIDTH
//      PARAMETER (DWIDTH=0D0,EWIDTH=0D0,MUWIDTH=0D0,TAUWIDTH=0D0)

// Masses in [GeV]

class THDM
{
	public:
	THDM( double p1_[4], double p2_[4], double p3_[4], double p4[4],
			double m_A_,   double Gamma_A_, double cosBA_, double tanB_);
	THDM( double p1_[4], double p2_[4], double p3_[4], double p4[4]);

	void Calculate(int opt);
	void Set2HDMConfig(double m_A, double Gamma_A, double cosBA, double tanB);
	void SetAmpOption();
	double GetAmplitudeSqr(int opt);

	void DisplayConfig();
	void WriteDebugInfo();

	private:

	double amplitude_sqr;
	double amplitude_tri_ZA_sqr;
	double amplitude_tri_A_sqr;
	double amplitude_tri_Z_sqr;
	double amplitude_tri_ZA_interference;
	double amplitude_box_sqr;
	double amplitude_tri_box_full_sqr;

	TLorentzVector p1;
	TLorentzVector p2;
	TLorentzVector p3;
	TLorentzVector p4;

	std::complex<double> amplitude_lalblz[2][2][3];

	std::complex<double> amplitude_tri_lalblzq[2][2][3][6];
	std::complex<double> amplitude_tri_Z_lalblzq[2][2][3][6];
	std::complex<double> amplitude_tri_A_lalblzq[2][2][3][6];
	std::complex<double> amplitude_tri_ZA_lalblzq[2][2][3][6];

	std::complex<double> amplitude_tri_Z_lalblz[2][2][3];
	std::complex<double> amplitude_tri_A_lalblz[2][2][3];
	std::complex<double> amplitude_tri_ZA_lalblz[2][2][3];

	std::complex<double> amplitude_box_lalblzq[2][2][3][6];
	std::complex<double> amplitude_box_lalblz[2][2][3];

	std::complex<double> Calc_F0pp(double t_, double u_, std::complex<double> C1_, std::complex<double> C2_, std::complex<double> D1_, std::complex<double> D2_, int iQ);
	std::complex<double> Calc_F0pm(double t_, double u_, std::complex<double> C1_, std::complex<double> C2_, std::complex<double> D1_, std::complex<double> D2_, int iQ);
	std::complex<double> Calc_F1pp(double t_, double u_, double lz, std::complex<double> C1_, std::complex<double> C2_, std::complex<double> D1_, std::complex<double> D2_, int iQ);
	std::complex<double> Calc_F1pm(double t_, double u_, double lz, std::complex<double> C1_, std::complex<double> C2_, std::complex<double> D1_, std::complex<double> D2_, int iQ);

		  	
	std::complex<double> F00s[6];
	std::complex<double> F0pptu[6];
	std::complex<double> F0pmtu[6];

	std::complex<double> F0pput[6];
	std::complex<double> F0pmut[6];
//	std::complex<double> F1pputP[6];
//	std::complex<double> F1pmutM[6];

	std::complex<double> F1pptu[6][3];
	std::complex<double> F1pmtu[6][3];
	std::complex<double> F1pput[6][3];
	std::complex<double> F1pmut[6][3];

	// Loop Integrals
	std::complex<double> C00s[6];

	std::complex<double> Cz0t[6];
	std::complex<double> Cz0u[6];

	std::complex<double> Ch0t[6];
	std::complex<double> Ch0u[6];

	std::complex<double> Chzs[6];

	std::complex<double> Dh0z0tu[6];
	std::complex<double> Dh0z0ut[6];

	std::complex<double> Dhz00st[6];
	std::complex<double> Dhz00su[6];

	// -- Kinematics
	double s;
	double t;
	double u;
	double zm;
	double zk;
	double h;
	double N;
	double lambda;

	// -- 2HDM parameters
	double m_A;
	double Gamma_A;
	double cos_A;
	double sin_A;
	double cos_B;
	double sin_B;
	double cos_BA;
	double sin_BA;
	double tan_B;


	// -- Couplings
	double a_Zqq[6];
	double g_hqq[6];
	double g_Aqq[6];
	double g_hZZ   ;
	double g_hAZ   ;


	// -- Auxiliary variables
	double m_qsqr[6];
	
};


std::complex<double> Propagator (double s, double m, double Gamma);

extern "C"
{
double thdm_frontend_ ( double p1_[4], double p2_[4], double p3_[4], double p4_[4],
					          double *THDM_param );
void thdm_displayconfig_ ( double p1_[4], double p2_[4], double p3_[4], double p4_[4],
					            double *THDM_param);
	void cpp_init_ ();
	void cpp_exit_ ();
	void errormsg_ ();
	void looptools_ ();
	double ggzh_triangle_( double p1_[4], double p2_[4], double p3_[4], double p4_[4], double THDM_param[6], int option );
	double lambda_func (double a, double b, double c);
	std::complex<double> PropZ (double s);
}

void displayTLorentzVector(TLorentzVector *v);
#endif
