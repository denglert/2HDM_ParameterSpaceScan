#ifndef AMPLITUDES_H
#define AMPLITUDES_H

#include <iostream>
#include <cmath>
#include "clooptools.h"
#include "TLorentzVector.h"


   //REAL*8 FUNCTION GG_ZH_BSM(propA, CPGA, P1, P2, P3, P4, NHEL)
// Eucledian Minkowski conversion
int e2m[4] = {1, 2, 3, 0};
int m2e[4] = {3, 0, 1, 2};

// Masses
const double m_W = 80.23;
const double m_Z = 91.19;
const double m_H = 125.0;

const double m_q[3][2] = { 
		  							{ 5.0e-2,  5.00e-2}, 
		  						   {  1.4e0,  0.50e0},
									{173.0e0,  4.75e0}
		  					    };

// Quark sector
const int niSo      = 2;
const int nFamilies = 3;

// Angles
const double cos_W = m_W/m_Z;
const double sin_W = sqrt(1-(cos_W*cos_W));

const double cos_W2 = cos_W*cos_W;
const double sin_W2 = sin_W*sin_W;

// Couplings
const double g_Zqq[2] = { (-0.5/(2.0*cos_W)), (+0.5/(2.0*cos_W))};
const double g_hZZ    = - m_Z/cos_W; // Warning sin(alpha-beta) missing!

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

extern "C"
{
	void errormsg_ ();
	double ggzh_triangle_( int la, int lb, double Aparam[2], double THDM_param[4], double p1[4], double p2[4], double p3[4], double p4[4] );
	double lambda_func (double a, double b, double c);
	std::complex<double> PropZ (double s);
}

#endif
