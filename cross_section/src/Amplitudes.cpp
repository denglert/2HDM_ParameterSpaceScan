#include "Amplitudes.h"

#define DEBUG 1



/////////////////////////////////////////////////
void cpp_init_ ()
{
	
};

/////////////////////////////////////////////////
void cpp_exit_ ()
{
};

/////////////////////////////////////////////////
void errormsg_ ()
{
	std::cerr << "Error." << std::endl;
//	ltini();
//	B0(1.1, 0.1, 0.3);
//	ltexi();
};


////////////////////////////
// ----- THDM class ----- //
////////////////////////////

/////////////////////////////////////
//double Amplitude_gg_AZ_Zh(
//		double p1_[4], double p2_[4], double p3_[4], double p4_[4],
//		double m_A_,   double Gamma_A_, double cosBA_, double tanB_)
//{
//
//	/////////////////////
//	// -- Variables -- //
//	
//	// Kinematics
//	double s;
//	double t;
//	double u;
//	double z;
//	double h;
//	double N;
//	double lambda;
//
//	// 2HDM parameters
//	double m_A;
//	double Gamma_A;
//	double cosBA;
//	double sinBA;
//	double tanB;
//
//	///////////////////////
//	// -- Calculation -- //
//
//  	TLorentzVector p1;
//  	TLorentzVector p2;
//  	TLorentzVector p3;
//  	TLorentzVector p4;
//  
//   for (int mu = 0; mu < 4; mu++)
//  	{
//  	  	p1[m2e[mu]] = p1_[mu];
//  	  	p2[m2e[mu]] = p2_[mu];
//  	  	p3[m2e[mu]] = p3_[mu];
//  	  	p4[m2e[mu]] = p4_[mu];
//  	}
//  
//  	s = (p1+p2).M2();
//  	t = (p1-p3).M2();
//  	u = (p1-p4).M2();
//  
//  	z = m_Z*m_Z;
//  	h = m_h*m_h;
//  
//  	N = t*u-z*h;
//  
//  	m_A     = m_A_;
//  	Gamma_A = Gamma_A;
//  	cosBA   = cosBA_;
//  	tanB    = tanB_;
//  
//  	lambda = lambda_func(s,z,h);
//  
//	// Quark mass squared
//  	for (int iF  = 0; iF < nFamilies; iF++)
//  	for (int iSo = 0; iSo < niSo;      iSo++)
//  	{
//  		int iQ = iF*2+iSo;
//  		m_qsqr[iQ] = m_q[iF][iSo]*m_q[iF][iSo];
//  	}
//
//	// Loop integrals
//  	for (int iF  = 0; iF < nFamilies; iF++)
//  	for (int iSo = 0; iSo < niSo;      iSo++)
//  	{
//  
//  		int iQ = iF*2+iSo;
//  		C00s[6]    = C0(0.0,0.0,s,m_qsqr[iQ],m_qsqr[iQ],m_qsqr[iQ]);
//  		Ch0t[6]    = C0(h,0.0,t,  m_qsqr[iQ],m_qsqr[iQ],m_qsqr[iQ]);
//  		Ch0u[6]    = C0(h,0.0,u,  m_qsqr[iQ],m_qsqr[iQ],m_qsqr[iQ]);
//  		Cz0t[6]    = C0(z,0.0,t,  m_qsqr[iQ],m_qsqr[iQ],m_qsqr[iQ]);
//  		Cz0u[6]    = C0(z,0.0,u,  m_qsqr[iQ],m_qsqr[iQ],m_qsqr[iQ]);
//  		Cz0u[6]    = C0(z,0.0,u,  m_qsqr[iQ],m_qsqr[iQ],m_qsqr[iQ]);
//  		Chzs[6]    = C0(z,0.0,t,  m_qsqr[iQ],m_qsqr[iQ],m_qsqr[iQ]);
//  		Dh0z0tu[6] = D0(h,0.0,z,0.0,t,u,m_qsqr[iQ],m_qsqr[iQ],m_qsqr[iQ],m_qsqr[iQ]);
//  		Dh0z0ut[6] = D0(h,0.0,z,0.0,u,t,m_qsqr[iQ],m_qsqr[iQ],m_qsqr[iQ],m_qsqr[iQ]);
//  		Dhz00st[6] = D0(h,z,0.0,0.0,s,t,m_qsqr[iQ],m_qsqr[iQ],m_qsqr[iQ],m_qsqr[iQ]);
//  		Dhz00su[6] = D0(h,z,0.0,0.0,s,u,m_qsqr[iQ],m_qsqr[iQ],m_qsqr[iQ],m_qsqr[iQ]);
//  	}
//
//
//
//
//}


////////////////////////////////////////////////////////////////////////
void thdm_displayconfig_ ( double p1_[4], double p2_[4], double p3_[4], double p4_[4], double *THDM_param)
{
	double value = 0.0;
	THDM amp(p1_,p2_,p3_,p4_,THDM_param[0],THDM_param[1],THDM_param[2],THDM_param[3]);
	amp.DisplayConfig();
}


////////////////////////////////////////////////////////////////////////
double thdm_frontend_ ( double p1_[4], double p2_[4], double p3_[4], double p4_[4], double *THDM_param)
{
	double value = 0.0;
	{
	THDM amplitude(p1_,p2_,p3_,p4_,THDM_param[0],THDM_param[1],THDM_param[2],THDM_param[3]);
	amplitude.Calculate();
	amplitude.WriteDebugInfo();
	value = amplitude.GetAmplitudeSqr(THDM_param[4]);
	}
	return value;
};


////////////////////////////////////////////////////////////////////////
THDM::THDM( double p1_[4], double p2_[4], double p3_[4], double p4_[4],
			   double m_A_,   double Gamma_A_, double cosBA_, double tanB_)
{
	
	// Kinematic varibles

  	for (int mu = 0; mu < 4; mu++)
	{
	  	p1[m2e[mu]] = p1_[mu];
	  	p2[m2e[mu]] = p2_[mu];
	  	p3[m2e[mu]] = p3_[mu];
	  	p4[m2e[mu]] = p4_[mu];
	}

	s = (p1+p2).M2();
	t = (p1-p3).M2();
	u = (p2-p3).M2();

	zm = m_Z*m_Z;
	zk = p3.M2();
	// z = m_Z*m_Z;
	// z = p3.M2();

	h = m_h*m_h;

	N = t*u-zk*h;

	lambda = lambda_func(s,zk,h);

	if ( lambda < 0)
	{
		// Debuggg 
		std::cerr << "Error!!! Lambda less than 0" << std::endl;
		std::cerr << "lambda: " << lambda << std::endl;
	}

	// 2HDM
	m_A      = m_A_;
	Gamma_A  = Gamma_A_;
	cos_BA   = cosBA_;
	tan_B    = tanB_;

	sin_BA = sqrt(1.0-cos_BA*cos_BA);

	// Couplings
	for (int iF  = 0; iF < nFamilies; iF++)
	for (int iSo = 0; iSo < niSo;      iSo++)
	{
		int iQ = iF*2+iSo;

		if ( iSo == 0 ) // up-type quarks
		{ 
			a_Zqq[iQ] = - 0.5/(2.0*cos_W);
			// (cosA)/(sinB) = sinBA + cosBA*cotB
			g_hqq[iQ] = - (m_q[iF][iSo]/(2.0*m_W))*(sin_BA + (cos_BA/tan_B));
			g_Aqq[iQ] = - m_q[iF][iSo]/(2.0*m_W*tan_B);
		}
		else if ( iSo == 1 ) // down-type quarks
		{ 
			a_Zqq[iQ] =   0.5/(2.0*cos_W);
			// (sinA)/(cosB) = cosBA * tanB - sinBA
			g_hqq[iQ] =   (m_q[iF][iSo]/(2.0*m_W))*(cos_BA*tan_B - sin_BA);
			g_Aqq[iQ] = - m_q[iF][iSo]*tan_B/(2.0*m_W);
		}

	}


	g_hZZ = m_Z*sin_BA/cos_W;    // Note that here sin(b-a) is present.
	g_hAZ = (cos_BA)/(2.0*cos_W);  // Note that here cos(b-a) is present.

	// Quark mass squared
	for (int iF  = 0; iF < nFamilies; iF++)
	for (int iSo = 0; iSo < niSo;      iSo++)
	{
		int iQ = iF*2+iSo;
		m_qsqr[iQ] = m_q[iF][iSo]*m_q[iF][iSo];
	}

	
}

////////////////////////////////////////////////////////////////////////
void THDM::DisplayConfig()
{


	printf("\n");
	printf("--- SM parameters ---\n");
	printf("m_Z      = %.4f\n", m_Z);
	printf("m_W      = %.4f\n", m_W);
	printf("sin_W2   = %.4f\n", sin_W2);
	printf("cos_W2   = %.4f\n", cos_W2);
	printf("sin_W    = %.4f\n", sin_W);
	printf("cos_W    = %.4f\n", cos_W);
		  
	printf("\n");
	printf("--- 2HDM parameters ---\n");
	printf("m_A      = %.4f\n", m_A);
	printf("Gamma_A  = %.4f\n", Gamma_A);
	printf("cos(b-a) = %.4f\n", cos_BA);
	printf("sin(b-a) = %.4f\n", sin_BA);
	printf("tan(b)   = %.4f\n", tan_B);

	printf("\n");
	std::cerr << "--- Couplings ---" << std::endl;
	for (int iQ = 0; iQ < nQuarks; iQ++)
	{
		std::cerr << "a_Zqq["  << iQ << "]: " << a_Zqq[iQ] << std::endl;
	}

	printf("\n");
	for (int iQ = 0; iQ < nQuarks; iQ++)
	{
		std::cerr << "g_hqq["  << iQ << "]: " << g_hqq[iQ] << std::endl;
	}

	printf("\n");
	for (int iQ = 0; iQ < nQuarks; iQ++)
	{
		std::cerr << "g_Aqq["  << iQ << "]: " << g_Aqq[iQ] << std::endl;
	}

	printf("\n");
	printf("g_hZZ  = %.5f", g_hZZ);
	printf("\n");
	printf("g_hAZ  = %.5f", g_hAZ);
	printf("\n");
}


////////////////////////////////////////////////////////////////////////
void THDM::Calculate()
{

	// -- Get 3- and 4-point functions from LoopTools
	for (int iF  = 0; iF < nFamilies; iF++)
	for (int iSo = 0; iSo < niSo;      iSo++)
	{

		int iQ = iF*2+iSo;

		C00s[iQ]    = C0(0.0,0.0,s,m_qsqr[iQ],m_qsqr[iQ],m_qsqr[iQ]);

		Cz0t[iQ]    = C0(zk,0.0,t,  m_qsqr[iQ],m_qsqr[iQ],m_qsqr[iQ]);
		Cz0u[iQ]    = C0(zk,0.0,u,  m_qsqr[iQ],m_qsqr[iQ],m_qsqr[iQ]);

		Ch0t[iQ]    = C0(h,0.0,t,   m_qsqr[iQ],m_qsqr[iQ],m_qsqr[iQ]);
		Ch0u[iQ]    = C0(h,0.0,u,   m_qsqr[iQ],m_qsqr[iQ],m_qsqr[iQ]);

		Cz0t[iQ]    = C0(zk,0.0,t,  m_qsqr[iQ],m_qsqr[iQ],m_qsqr[iQ]);
		Cz0u[iQ]    = C0(zk,0.0,u,  m_qsqr[iQ],m_qsqr[iQ],m_qsqr[iQ]);

		Chzs[iQ]    = C0(h, zk,s,  m_qsqr[iQ],m_qsqr[iQ],m_qsqr[iQ]);

		Dh0z0tu[iQ] = D0(h,0.0,zk,0.0,t,u,m_qsqr[iQ],m_qsqr[iQ],m_qsqr[iQ],m_qsqr[iQ]);
		Dh0z0ut[iQ] = D0(h,0.0,zk,0.0,u,t,m_qsqr[iQ],m_qsqr[iQ],m_qsqr[iQ],m_qsqr[iQ]);

		Dhz00st[iQ] = D0(h,zk,0.0,0.0,s,t,m_qsqr[iQ],m_qsqr[iQ],m_qsqr[iQ],m_qsqr[iQ]);
		Dhz00su[iQ] = D0(h,zk,0.0,0.0,s,u,m_qsqr[iQ],m_qsqr[iQ],m_qsqr[iQ],m_qsqr[iQ]);

	}
	

	// -- Calculate the form factors
	for (int iQ = 0; iQ < nQuarks; iQ++)
	{
		F00s[iQ]    = 4.0 * m_qsqr[iQ] * C00s[iQ];

		// F0++ = [1][1][1]
		F0pptu[iQ]  = Calc_F0pp(t,u,     Cz0t[iQ],Ch0t[iQ],Dh0z0tu[iQ],Dhz00st[iQ],iQ); 
		F0pput[iQ]  = Calc_F0pp(u,t,     Cz0u[iQ],Ch0u[iQ],Dh0z0ut[iQ],Dhz00su[iQ],iQ); 

		// F0+- = [1][0][1]
		F0pmtu[iQ]  = Calc_F0pm(t,u,     Cz0t[iQ],Ch0t[iQ],Dh0z0tu[iQ],Dhz00st[iQ],iQ);
		F0pmut[iQ]  = Calc_F0pm(u,t,     Cz0u[iQ],Ch0u[iQ],Dh0z0ut[iQ],Dhz00su[iQ],iQ);

//		F1pptuP[iQ] = Calc_F1pp(t,u, 1.0,Ch0t[iQ],Cz0u[iQ],Dh0z0tu[iQ],Dhz00st[iQ],iQ);
//		F1pmtuP[iQ] = Calc_F1pm(t,u, 1.0,Ch0t[iQ],Cz0u[iQ],Dhz00st[iQ],Dh0z0tu[iQ],iQ);

		// F1++ = [1][1][2]
		F1pptu[iQ][0] = Calc_F1pp(t,u, -1.0,Ch0t[iQ],Cz0u[iQ],Dh0z0tu[iQ],Dhz00st[iQ],iQ);
		F1pptu[iQ][2] = Calc_F1pp(t,u,  1.0,Ch0t[iQ],Cz0u[iQ],Dh0z0tu[iQ],Dhz00st[iQ],iQ);

		F1pput[iQ][0] = Calc_F1pp(u,t, -1.0,Ch0u[iQ],Cz0t[iQ],Dh0z0ut[iQ],Dhz00su[iQ],iQ);
		F1pput[iQ][2] = Calc_F1pp(u,t,  1.0,Ch0u[iQ],Cz0t[iQ],Dh0z0ut[iQ],Dhz00su[iQ],iQ);

		// F1+- = [1][0][2]
		F1pmtu[iQ][0] = Calc_F1pm(t,u, -1.0,Ch0t[iQ],Cz0u[iQ],Dhz00st[iQ],Dh0z0tu[iQ],iQ);
		F1pmtu[iQ][2] = Calc_F1pm(t,u,  1.0,Ch0t[iQ],Cz0u[iQ],Dhz00st[iQ],Dh0z0tu[iQ],iQ);

		F1pmut[iQ][0] = Calc_F1pm(u,t, -1.0,Ch0u[iQ],Cz0t[iQ],Dhz00su[iQ],Dh0z0ut[iQ],iQ);
		F1pmut[iQ][2] = Calc_F1pm(u,t,  1.0,Ch0u[iQ],Cz0t[iQ],Dhz00su[iQ],Dh0z0ut[iQ],iQ);

	}


	// -- Init amplitudes to 0.0
	for (int la  = 0; la < 2; la++)
	for (int lb  = 0; lb < 2; lb++)
	for (int lz  = 0; lz < 3; lz++)
	for (int iF  = 0; iF < nFamilies; iF++)
	for (int iSo = 0; iSo < niSo;      iSo++)
	{
		int iQ = iF*2.0+iSo;

		amplitude_tri_Z_sqr         = (0.0,0.0);
		amplitude_tri_A_sqr         = (0.0,0.0);
		amplitude_tri_ZA_sqr        = (0.0,0.0); 
		amplitude_box_sqr           = (0.0,0.0);
		amplitude_tri_box_full_sqr  = (0.0,0.0);

		amplitude_box_lalblz[la][lb][lz]      = (0.0,0.0);
		amplitude_tri_A_lalblz[la][lb][lz]    = (0.0,0.0);
		amplitude_tri_Z_lalblz[la][lb][lz]    = (0.0,0.0);
		amplitude_tri_ZA_lalblz[la][lb][lz]   = (0.0,0.0);
		amplitude_box_lalblzq[la][lb][lz][iQ] = (0.0,0.0);
		amplitude_tri_lalblzq[la][lb][lz][iQ] = (0.0,0.0);
	}

	// -- Calculate the amplitudes
	// - amplitude_[la][lb][lz][iQ]
	for (int iF  = 0; iF < nFamilies; iF++)
	for (int iSo = 0; iSo < niSo;      iSo++)
	{
		int iQ = iF*2.0+iSo;



		////////////////////
		// -- Triangle -- //
		////////////////////

		// Warning: z = zk or zm ???

		amplitude_tri_Z_lalblzq[0][0][1][iQ] =  2.0*sqrt(lambda/zm)*(1.0)*((zm-s)/zm)*a_Zqq[iQ]*g_hZZ*Propagator(s,m_Z,Gamma_Z)*(F00s[iQ] + 2.0); // Z
		amplitude_tri_A_lalblzq[0][0][1][iQ] = -2.0*sqrt(lambda/zm)*(1.0)*(s/m_q[iF][iSo])*g_Aqq[iQ]*g_hAZ*Propagator(s,m_A,Gamma_A)*F00s[iQ];  // A

		amplitude_tri_Z_lalblzq[1][1][1][iQ] = - amplitude_tri_Z_lalblzq[0][0][1][iQ]; // Z-component
		amplitude_tri_A_lalblzq[1][1][1][iQ] = - amplitude_tri_A_lalblzq[0][0][1][iQ]; // A-component

		 // Adding up A and Z components
		for (int la  = 0; la < 2; la++)
		for (int lb  = 0; lb < 2; lb++)
		for (int lz  = 0; lz < 3; lz++)
		for (int iQ  = 0; iQ < 6; iQ++)
		{
			amplitude_tri_ZA_lalblzq[la][lb][lz][iQ] = amplitude_tri_Z_lalblzq[la][lb][lz][iQ] + amplitude_tri_A_lalblzq[la][lb][lz][iQ]; 
		}

		///////////////
		// -- Box -- //
		///////////////

		// Warning: z = zk or zm ???
		
		// lz lb lz = ++0
		amplitude_box_lalblzq[1][1][1][iQ] = (8.0/sqrt(zk*lambda)) * g_hqq[iQ]*a_Zqq[iQ]*m_q[iF][iSo]*( F0pptu[iQ] + F0pput[iQ] );
		// lz lb lz = +-0
		amplitude_box_lalblzq[1][0][1][iQ] = (8.0/sqrt(zk*lambda)) * g_hqq[iQ]*a_Zqq[iQ]*m_q[iF][iSo]*( F0pmtu[iQ] - F0pmut[iQ] );

		//                     la  lb   lz                                                                              lz               lz
		// lz lb lz = ++-
		amplitude_box_lalblzq[ 1 ][ 1 ][ 0 ][iQ] = - 4.0 * sqrt((2.0*N)/s) * g_hqq[iQ]*a_Zqq[iQ]*m_q[iF][iSo]*( F1pptu[iQ][0] - F1pput[iQ][0] );
		// la lb lz = +++
		amplitude_box_lalblzq[ 1 ][ 1 ][ 2 ][iQ] = - 4.0 * sqrt((2.0*N)/s) * g_hqq[iQ]*a_Zqq[iQ]*m_q[iF][iSo]*( F1pptu[iQ][2] - F1pput[iQ][2] );

		// la lb lz = +--
		amplitude_box_lalblzq[ 1 ][ 0 ][ 0 ][iQ] = - 4.0 * sqrt((2.0*N)/s) * g_hqq[iQ]*a_Zqq[iQ]*m_q[iF][iSo]*( F1pmtu[iQ][0] + F1pmut[iQ][2] );
		// la lb lz = +-+
		amplitude_box_lalblzq[ 1 ][ 0 ][ 2 ][iQ] = - 4.0 * sqrt((2.0*N)/s) * g_hqq[iQ]*a_Zqq[iQ]*m_q[iF][iSo]*( F1pmtu[iQ][2] + F1pmut[iQ][0] );


	}

	// -- Quark sum for each helicity configuration
	for (int la  = 0; la < 2; la++)
	for (int lb  = 0; lb < 2; lb++)
	for (int lz  = 0; lz < 3; lz++)
	{
			  
		// Quark sum
		for (int iF  = 0; iF < nFamilies; iF++)
		for (int iSo = 0; iSo < niSo;      iSo++)
		{
			int iQ = iF*2.0+iSo;
		 	 amplitude_tri_Z_lalblz[la][lb][lz] +=  amplitude_tri_Z_lalblzq[la][lb][lz][iQ];
		 	 amplitude_tri_A_lalblz[la][lb][lz] +=  amplitude_tri_A_lalblzq[la][lb][lz][iQ];
		 	amplitude_tri_ZA_lalblz[la][lb][lz] += amplitude_tri_ZA_lalblzq[la][lb][lz][iQ];
			   amplitude_box_lalblz[la][lb][lz] += amplitude_box_lalblzq[la][lb][lz][iQ];
		}

	}


	// Making use of the symmetry arguments

	// lz lb lz = --0
	amplitude_box_lalblz[0][0][1] = amplitude_box_lalblz[1][1][1];
	// lz lb lz = -+0
	amplitude_box_lalblz[0][1][1] = amplitude_box_lalblz[1][0][1];

	// lz lb lz = ---
	amplitude_box_lalblz[0][0][0] = amplitude_box_lalblz[1][1][2];
	// lz lb lz = --+
	amplitude_box_lalblz[0][0][2] = amplitude_box_lalblz[1][1][0];
	// lz lb lz = -+-
	amplitude_box_lalblz[0][1][0] = amplitude_box_lalblz[1][0][2];
	// lz lb lz = -++
	amplitude_box_lalblz[0][1][2] = amplitude_box_lalblz[1][0][0];


//	std::cerr << "New code" << std::endl;
//	for (int iQ = 0; iQ < nQuarks; iQ++)
//	{
//		std::cerr << "F00s[" << iQ << "]: " << F00s[iQ] << std::endl;
//		std::cerr << "amplitude_tri_Z_lalblz[" << iQ << "]: " << amplitude_tri_Z_lalblzq[1][1][0][iQ] << std::endl;
//	}


	// Sum for helicity configurations
	for (int la  = 0; la < 2; la++)
	for (int lb  = 0; lb < 2; lb++)
	for (int lz  = 0; lz < 3; lz++)
	{
		amplitude_tri_Z_sqr        += std::abs(amplitude_tri_Z_lalblz[la][lb][lz]*std::conj(amplitude_tri_Z_lalblz[la][lb][lz]));
		amplitude_tri_A_sqr        += std::abs(amplitude_tri_A_lalblz[la][lb][lz]*std::conj(amplitude_tri_A_lalblz[la][lb][lz]));
		amplitude_tri_ZA_sqr       += std::abs(amplitude_tri_ZA_lalblz[la][lb][lz]*std::conj(amplitude_tri_ZA_lalblz[la][lb][lz]));
		amplitude_box_sqr          += std::abs(amplitude_box_lalblz[la][lb][lz]   *std::conj(amplitude_box_lalblz[la][lb][lz])  );
		amplitude_tri_box_full_sqr += std::abs( amplitude_box_lalblz[la][lb][lz]    *std::conj(amplitude_box_lalblz[la][lb][lz]) +
						  								    amplitude_tri_ZA_lalblz[la][lb][lz] *std::conj(amplitude_tri_ZA_lalblz[la][lb][lz]) );
	}


	# if DEBUG

//	for (int iQ = 0; iQ < nQuarks; iQ++)
//	{
//		std::cerr << "F00s[" << iQ << "]: " << F00s[iQ] << std::endl;
//		std::cerr << "a_Zqq["  << iQ << "]: " << a_Zqq[iQ] << std::endl;
//		std::cerr << "g_hqq["  << iQ << "]: " << g_hqq[iQ] << std::endl;
//		std::cerr << "g_Aqq["  << iQ << "]: " << g_Aqq[iQ] << std::endl;
//	}
//
//	std::cerr << "g_hZZ: " << g_hZZ << std::endl;
//	std::cerr << "g_hAZ: " << g_hAZ << std::endl;

	# endif

}

////////////////////////////////////
double THDM::GetAmplitudeSqr(int opt)
{
	switch (opt) 
	{
		case 0: amplitude_sqr = amplitude_tri_Z_sqr;        break;
		case 1: amplitude_sqr = amplitude_tri_A_sqr;        break;
		case 2: amplitude_sqr = amplitude_tri_ZA_sqr;       break;
		case 3: amplitude_sqr = amplitude_box_sqr;          break;
		case 4: amplitude_sqr = amplitude_tri_box_full_sqr; break;
	}

	return amplitude_sqr;
}


//////////////////////////////////////
//void THDM::WriteComparison()
//{
//   std::ofstream dbgfile;
//	dbgfile.open("debug_THDM_2", std::ios_base::app);
//}

////////////////////////////////////
void THDM::WriteDebugInfo()
{
   std::ofstream dbgfile;
	dbgfile.open("debug_THDM", std::ios_base::app);


	dbgfile << std::endl;
	dbgfile << "########################" << std::endl;
	dbgfile << "### ----- CPP ------ ###" << std::endl;
	dbgfile << "########################" << std::endl;

	dbgfile << std::endl;

	dbgfile << "p1" << Form("(E,px,py,pz): (%13.8f, %13.8f, %13.8f, %13.8f)\n", p1.E(), p1.Px(), p1.Py(), p1.Pz() );
	dbgfile << "p2" << Form("(E,px,py,pz): (%13.8f, %13.8f, %13.8f, %13.8f)\n", p2.E(), p2.Px(), p2.Py(), p2.Pz() );
	dbgfile << "p3" << Form("(E,px,py,pz): (%13.8f, %13.8f, %13.8f, %13.8f)\n", p3.E(), p3.Px(), p3.Py(), p3.Pz() );
	dbgfile << "p4" << Form("(E,px,py,pz): (%13.8f, %13.8f, %13.8f, %13.8f)\n", p4.E(), p4.Px(), p4.Py(), p4.Pz() );

	dbgfile << "p1.M(): " << p1.M() << std::endl;
	dbgfile << "p2.M(): " << p2.M() << std::endl;
	dbgfile << "p3.M(): " << p3.M() << std::endl;
	dbgfile << "p4.M(): " << p4.M() << std::endl;
	dbgfile << "(p1+p2).M(): " << (p1+p2).M() << std::endl;
	dbgfile << std::endl;
	dbgfile << "s:      " << s << std::endl;
	dbgfile << "t:      " << t << std::endl;
	dbgfile << "u:      " << u << std::endl;
	dbgfile << std::endl;
	dbgfile << "zk:      " << zk << std::endl;
	dbgfile << "zm:      " << zm << std::endl;
	dbgfile << "h:      " << h << std::endl;
	dbgfile << std::endl;
	dbgfile << "N:      " << N << std::endl;

	// 2HDM
  	dbgfile << "### - 2HDM space - ###" << std::endl;
	dbgfile << std::endl;
  	dbgfile << "cos_AB:    " << cos_BA << std::endl;
  	dbgfile << "sin_AB:    " << sin_BA << std::endl;
  	dbgfile << "tan_B:     " << tan_B << std::endl;
  	dbgfile << "m_A:       " << m_A << std::endl;
  	dbgfile << "Gamma_A:   " << Gamma_A << std::endl;

	// Couplings
  	dbgfile << "### - Couplings/angles/masses - ###" << std::endl;
  	dbgfile << "cos_W:    " << cos_W << std::endl;
  	dbgfile << "m_Z:      " << m_Z << std::endl;
  	dbgfile << "g_hZZ:    " << g_hZZ << std::endl;
	dbgfile << std::endl;

	for (int iQ = 0; iQ < 6; iQ++)
	{
		dbgfile << "g_hqq[" << iQ << "]: " << g_hqq[iQ]  << std::endl;
	}

	// Kinematic factors
  	dbgfile << "### - Kinematic factors - ###" << std::endl;
  	dbgfile << "lambda:           " << lambda_func(s,zk,h)           << std::endl;
  	dbgfile << "sqrt(lambda/z):   " << sqrt((lambda_func(s,zk,h)/zm)) << std::endl;
  	dbgfile << "(z-s)/s:   " << (zm-s)/zm << std::endl;

	dbgfile << "--- Triangle contribution ---" << std::endl;
	dbgfile << std::endl;
	dbgfile << "amplitude_tri_Z_sqr: " << amplitude_tri_Z_sqr << std::endl;
	dbgfile << "amplitude_tri_Z_lalblz[0][0][1]_sqr: " << amplitude_tri_Z_lalblz[0][0][1]*std::conj(amplitude_tri_Z_lalblz[0][0][1]) << std::endl;

	for (int la  = 0; la < 2; la++)
	for (int lb  = 0; lb < 2; lb++)
	for (int lz  = 0; lz < 3; lz++)
	{
		dbgfile << "[" << la << "][" << lb << "][" << lz << "]: " << amplitude_tri_Z_lalblz[la][lb][lz] << std::endl;
	}

	dbgfile << "--- Triangle contribution ---" << std::endl;
	dbgfile << "[0][0][1][iQ]" << std::endl;

	for (int iQ = 0; iQ < 6; iQ++)
	{
		dbgfile << "[" << iQ << "]: " << amplitude_tri_Z_lalblzq[0][0][1][iQ] << std::endl;
	}


	dbgfile << "--- 3- and 4- point functions ---" << std::endl;
	dbgfile << std::endl;

	dbgfile << "Cz0t:" << std::endl;
	for (int iQ = 0; iQ < 6; iQ++)
	{
		dbgfile << "[" << iQ << "] " << Cz0t[iQ] << std::endl;
	}

	dbgfile << std::endl;
	dbgfile << "Cz0u:" << std::endl;
	for (int iQ = 0; iQ < 6; iQ++)
	{
		dbgfile << "[" << iQ << "] " << Cz0u[iQ] << std::endl;
	}

	dbgfile << std::endl;
	dbgfile << "Ch0t:" << std::endl;
	for (int iQ = 0; iQ < 6; iQ++)
	{
		dbgfile << "[" << iQ << "] " << Ch0t[iQ] << std::endl;
	}

	dbgfile << std::endl;
	dbgfile << "Ch0u:" << std::endl;
	for (int iQ = 0; iQ < 6; iQ++)
	{
		dbgfile << "[" << iQ << "] " << Ch0u[iQ] << std::endl;
	}

	dbgfile << std::endl;
	dbgfile << "Dh0z0tu:" << std::endl;
	for (int iQ = 0; iQ < 6; iQ++)
	{
		dbgfile << "[" << iQ << "] " << Dh0z0tu[iQ] << std::endl;
	}

	dbgfile << std::endl;
	dbgfile << "Dh0z0ut:" << std::endl;
	for (int iQ = 0; iQ < 6; iQ++)
	{
		dbgfile << "[" << iQ << "] " << Dh0z0ut[iQ] << std::endl;
	}

	dbgfile << std::endl;
	dbgfile << "Dhz00st:" << std::endl;
	for (int iQ = 0; iQ < 6; iQ++)
	{
		dbgfile << "[" << iQ << "] " << Dhz00st[iQ] << std::endl;
	}

	dbgfile << std::endl;
	dbgfile << "Dhz00su:" << std::endl;
	for (int iQ = 0; iQ < 6; iQ++)
	{
		dbgfile << "[" << iQ << "] " << Dhz00su[iQ] << std::endl;
	}

	dbgfile << "--- Form factors ---" << std::endl;
	dbgfile << std::endl;
	
	dbgfile << "F00s:" << std::endl;
	for (int iQ = 0; iQ < 6; iQ++)
	{
		dbgfile << "[" << iQ << "] " << F00s[iQ] << std::endl;
	}

	dbgfile << "F0pptu:" << std::endl;
	for (int iQ = 0; iQ < 6; iQ++)
	{
		dbgfile << "[" << iQ << "] " << F0pptu[iQ] << std::endl;
	}

	dbgfile << "F0pmtu:" << std::endl;
	for (int iQ = 0; iQ < 6; iQ++)
	{
		dbgfile << "[" << iQ << "] " << F0pmtu[iQ] << std::endl;
	}

	dbgfile << "F0pput:" << std::endl;
	for (int iQ = 0; iQ < 6; iQ++)
	{
		dbgfile << "[" << iQ << "] " << F0pput[iQ] << std::endl;
	}


	dbgfile << "F0pmut:" << std::endl;
	for (int iQ = 0; iQ < 6; iQ++)
	{
		dbgfile << "[" << iQ << "] " << F0pmut[iQ] << std::endl; 
	}

	dbgfile << "F1pput[0]:" << std::endl;
	dbgfile << "F1pput[2]:" << std::endl;
	for (int iQ = 0; iQ < 6; iQ++)
	{
		dbgfile << "[" << iQ << "] " << F1pptu[iQ][0] << std::endl;
		dbgfile << "[" << iQ << "] " << F1pptu[iQ][2] << std::endl;
	}

	dbgfile << "F0pput[0]:" << std::endl;
	dbgfile << "F0pput[2]:" << std::endl;
	for (int iQ = 0; iQ < 6; iQ++)
	{
		dbgfile << "[" << iQ << "] " << F1pput[iQ][0] << std::endl;
		dbgfile << "[" << iQ << "] " << F1pput[iQ][2] << std::endl;
	}

	dbgfile << "F1pmtu[0]:" << std::endl;
	dbgfile << "F1pmtu[2]:" << std::endl;
	for (int iQ = 0; iQ < 6; iQ++)
	{
		dbgfile << "[" << iQ << "] " << F1pmtu[iQ][0] << std::endl;
		dbgfile << "[" << iQ << "] " << F1pmtu[iQ][2] << std::endl;
	}

	dbgfile << "F1pmut[0]:" << std::endl;
	dbgfile << "F1pmut[2]:" << std::endl;
	for (int iQ = 0; iQ < 6; iQ++)
	{
		dbgfile << "[" << iQ << "] " << F1pmut[iQ][0] << std::endl;
		dbgfile << "[" << iQ << "] " << F1pmut[iQ][2] << std::endl;
	}

	dbgfile << std::endl;
	dbgfile << "--- Box contribution ---" << std::endl;
	dbgfile << std::endl;

	dbgfile << "[1][1][1][iQ]:" << std::endl;
	for (int iF  = 0; iF < nFamilies; iF++)
	for (int iSo = 0; iSo < niSo;      iSo++)
	{
		int iQ = iF*2+iSo;
		dbgfile << "[" << iQ <<	"]: " <<  amplitude_box_lalblzq[1][1][1][iQ] << std::endl;
//		dbgfile << "8.0/sqrt(zk*lambda) " <<  (8.0/sqrt(zk*lambda)) << std::endl;
//		dbgfile << " g_hqq[iQ] " << g_hqq[iQ]  << std::endl;
//		dbgfile << " a_Zqq[iQ] " << a_Zqq[iQ]  << std::endl;
//		dbgfile << " m_q[iF][iSo] " << m_q[iF][iSo]  << std::endl;
//		dbgfile << " (F0pptu[iQ] + F0pput[iQ])" <<  (F0pptu[iQ] + F0pput[iQ]) << std::endl;
	}

	dbgfile << "[1][0][1][iQ]:" << std::endl;
	for (int iQ = 0; iQ < 6; iQ++)
	{
		dbgfile << "[" << iQ <<	"]: " << amplitude_box_lalblzq[1][0][1][iQ] << std::endl;
	}
	
	dbgfile << "[1][1][0][iQ]:" << std::endl;
	for (int iQ = 0; iQ < 6; iQ++)
	{
		dbgfile << "[" << iQ <<	"]: " << amplitude_box_lalblzq[1][1][0][iQ] << std::endl;
	}

	dbgfile << "[1][1][2][iQ]:" << std::endl;
	for (int iQ = 0; iQ < 6; iQ++)
	{
		dbgfile << "[" << iQ <<	"]: " << amplitude_box_lalblzq[1][1][2][iQ] << std::endl;
	}

	dbgfile << "[1][0][0][iQ]:" << std::endl;
	for (int iQ = 0; iQ < 6; iQ++)
	{
		dbgfile << "[" << iQ <<	"]: " << amplitude_box_lalblzq[1][0][0][iQ] << std::endl;
	}

	dbgfile << "[1][0][2][iQ]:" << std::endl;
	for (int iQ = 0; iQ < 6; iQ++)
	{
		dbgfile << "[" << iQ <<	"]: " << amplitude_box_lalblzq[1][0][2][iQ] << std::endl;
	}


	for (int la  = 0; la < 2; la++)
	for (int lb  = 0; lb < 2; lb++)
	for (int lz  = 0; lz < 3; lz++)
	{
		dbgfile << "[" << la << "][" << lb << "][" << lz << "]: " << amplitude_box_lalblz[la][lb][lz] << std::endl;
	}


	dbgfile << std::endl;
	dbgfile << "Total square + triangle amplitude squared:" << amplitude_tri_box_full_sqr << std::endl;

//	for (int iQ = 0; iQ < 6; iQ++)
//	{
//	}


}

///////////////////////////////////////////////////
//void THDM::CalcLoopIntegrals()
//{
//
//
//}


//////////////////////////
// --- Form factors --- //
//////////////////////////

std::complex<double> THDM::Calc_F0pp(double t_, double u_,
					 							 std::complex<double> C1_, std::complex<double> C2_,
					 							 std::complex<double> D1_, std::complex<double> D2_,
												 int iQ)
{
	std::complex<double> value;

//   std::ofstream dbgfile;
//	dbgfile.open("debug_THDM", std::ios_base::app);
//	dbgfile << "!!!!!!!!!!!!" << std::endl;
//	dbgfile << "Hey! I am a worm inside Calc_F0pp!" << std::endl;
//	
//	dbgfile << "F0ppt" << (2.0 * s * (t_ + u_) * C00s[iQ]) << std::endl;
//	dbgfile << "F0pp1" <<  << std::endl;

	value =
			  2.0 * s * (t_ + u_) * C00s[iQ] + 2.0 * (t_ + u_ + lambda/s) * ( (t_ - zk) * C1_ + (t_ - h) * C2_ )
			  - ( N * ( t_ + u_ + lambda/s) + 2.0*m_qsqr[iQ]*lambda ) * D1_ - 4.0 * (s*zk*h + m_qsqr[iQ] * lambda)*D2_; 

	return value;
}



/////////////////////////////////////////////////
std::complex<double> THDM::Calc_F0pm(double t_, double u_,
						 						 std::complex<double> C1_, std::complex<double> C2_, 
					 							 std::complex<double> D1_, std::complex<double> D2_,
					 	                   int iQ)
{
	std::complex<double> value;
	value =
		((h - zk - s)/N) * (t_ - u_) * ( s*(t_ + u_)*C00s[iQ] - lambda*Chzs[iQ] - 2.0*m_qsqr[iQ]*N*D1_ )
	 + 2.0 * (t_ + u_)*(t_ - zk)*(1.0 + (t_*(t_ - u_)*(h-zk-s))/(N*(t_ + u_)) )*C1_
	 + 2.0 * ((t_ - h)/N) * (zk*(u_*u_ - t_*t_ - lambda) + (t_ + u_)*(t_*t_ - zk*h))*C2_
    - (h - zk - s) * ( 2*s*t_*(( t_*t_ - zk*h)/N) + 4.0 * m_qsqr[iQ] * (t_ - u_))*D2_;

	return value;
}


/////////////////////////////////////////////////
std::complex<double> THDM::Calc_F1pp(double t_, double u_, double lz,
						 						 std::complex<double> C1_, std::complex<double> C2_, 
					 							 std::complex<double> D1_, std::complex<double> D2_,
					 	                   int iQ)
{
	std::complex<double> value;
	value =
		(t_ - u_) * ((zk-h-s)/(sqrt(lambda)) - lz) * ( (s*C00s[iQ]/N) - (D1_/2.0) - (s/N)*(t_ + (2.0*N)/(t_ - u_))*D2_)
	 + (2.0*(h - u_)/(sqrt(lambda)*N)) * (lz*sqrt(lambda) + t_ - u_ + (2.0*N)/(h - u_)) * ((h - t_)*C1_ + (zk - u_)*C2_);

	return value;
}


/////////////////////////////////////////////////
std::complex<double> THDM::Calc_F1pm(double t_, double u_, double lz,
						 						 std::complex<double> C1_, std::complex<double> C2_, 
					 							 std::complex<double> D1_, std::complex<double> D2_,
					 	                   int iQ)
{
	std::complex<double> value;
	value = 
	(s/N)* ( (4.0*s*(t_ + u_)/(sqrt(lambda))) + sqrt(lambda) - lz*(t_ - u_)) * C00s[iQ] - ((2.0*s)/N)*(sqrt(lambda) + lz*(t_ - u_))*Chzs[iQ]
 - 2.0*((t_ - h)/(sqrt(lambda)*N))*(-s*(u_ + 3.0*t_) - 2.0*N + (u_ - t_)*(t_ - zk) + lz*(t_ - s - zk)*sqrt(lambda) )*C1_
 + 2.0*((u_ - zk)/(sqrt(lambda)*N))*(3.0*u_ * (s-zk) + t_*h - 2.0*zk*(h - 2.0*u_) - lz* (h - u_)*sqrt(lambda))*C2_
 + (s/(sqrt(lambda)*N))*(t_ * (lambda + 8.0*zk*h - 4.0*t_*s - 2.0*(t_ + u_)*(zk+h) +
 + lz*(-2.0*h + 3.0*t_ + u_ - 2.0*zk)*sqrt(lambda) ) - 16.0*m_qsqr[iQ]*N)*D1_
 + 0.5*(-sqrt(lambda) - (16.0*m_qsqr[iQ]*s/sqrt(lambda)) + lz*(t_ - u_) )*D2_;
	return value;
}


//////////////////////////////////////
//// ---- END OF THDM CLASS ----- ////
//////////////////////////////////////


/////////////////////////////////////////////////
double ggzh_triangle_( double p1_[4], double p2_[4], double p3_[4], double p4_[4], double THDM_param[6], int option )
{

	double g_Zqq[2] = { (-0.5/(2.0*cos_W)), (+0.5/(2.0*cos_W))};
	double g_hZZ    = - m_Z/cos_W; // Warning sin(alpha-beta) missing!

	TLorentzVector p1;
	TLorentzVector p2;
	TLorentzVector p3;
	TLorentzVector p4;

  	for (int mu = 0; mu < 4; mu++)
	{
	  	p1[m2e[mu]] = p1_[mu];
	  	p2[m2e[mu]] = p2_[mu];
	  	p3[m2e[mu]] = p3_[mu];
	  	p4[m2e[mu]] = p4_[mu];
	}

  	for (int mu = 0; mu < 4; mu++)
	{
	//	printf("p1[%d]: %.3f\n", mu, p1[mu] );
	}

	double s = (p1+p2).M2();
	double t = (p1-p3).M2();
	double u = (p1-p4).M2();


//	double z = p3.M2();
	double z = m_Z*m_Z;
//	double z = p3.M2();
	double z2 = p3.M2();
//	double z2 = m_Z*m_Z;
	double z1 = m_Z*m_Z;
	double h = p4.M2();

	std::complex<double> amplitude;
	std::complex<double> amplitude_C0[6];
	std::complex<double> amplitude_Ftri[6];
	std::complex<double> amplitude_quark[6];
	std::complex<double> amplitude_quark_sum;
	std::complex<double> amplitude_sqr;
	amplitude_quark_sum = 0.0;
	double mqsqr[6];

//	std::cerr << "Old code:" << std::endl;
	for (int iF  = 0; iF < nFamilies; iF ++ )
	for (int iSo = 0; iSo < niSo; iSo ++ )
	{

			int iQ = iF*2+iSo;
      	mqsqr[iQ] = m_q[iF][iSo]*m_q[iF][iSo];
			amplitude_C0[iQ] = C0(0.0,0.0,s,mqsqr[iQ],mqsqr[iQ],mqsqr[iQ]);
			amplitude_Ftri[iQ] = 4.0 * mqsqr[iQ] * amplitude_C0[iQ];
			//amplitude_C0[iQ] = C0(0.0,0.0,s*1.0e6,mqsqr[iQ]*1.0e6,mqsqr[iQ]*1.0e6,mqsqr[iQ]*1.0e6);
			amplitude_quark[iQ] = -2.0*sqrt(lambda_func(s,z2,h)/z) * ((z1-s)/z1) * g_Zqq[iSo] * g_hZZ * Propagator(s,m_Z,Gamma_Z)  * ( 4.0 * mqsqr[iQ] * amplitude_C0[iQ]  + 2.0 );
			amplitude_quark_sum = amplitude_quark_sum + amplitude_quark[iQ]; 


		# if DEBUG
//		std::cerr << "amplitude_Ftri[" << iQ << "]: " << amplitude_Ftri[iQ] << std::endl;
//		std::cerr << "amplitude_quark[" << iQ << "]: " << amplitude_quark[iQ] << std::endl;
//		std::cerr << "iF: " << iF << " iSo: " << iSo << " C0: " << C0(0.0,0.0,s,mqsqr,mqsqr,mqsqr) << std::endl;
//		std::cerr << "iF: " << iF << " iSo: " << iSo << " 4*m2*C0: " << 4.0*mqsqr*C0(0.0,0.0,s,mqsqr,mqsqr,mqsqr) << std::endl;
//		std::cerr << "(z-s)/z :" << ((z-s)/z) << std::endl;
//		std::cerr << "g_Zqq: " << g_Zqq[iSo] << std::endl;
//		std::cerr << "g_hZZ: " << g_hZZ << std::endl;
//		std::cerr << "PropZ(s): " << PropZ(s) << std::endl;
//		std::cerr << "iF: " << iF << " iSo: " << iSo << " quark : " << ((z-s)/z) * g_Zqq[iSo] * g_hZZ * PropZ(s)  * ( 4.0 * mqsqr * C0(0.0,0.0,s,mqsqr,mqsqr,mqsqr)  + 2.0 ) << std::endl;
		# endif
	}
  

	amplitude     = amplitude_quark_sum;
	amplitude_sqr = amplitude*std::conj(amplitude);

	# if DEBUG

	std::ofstream dbgfile;
	dbgfile.open("debug_cpp", std::ios_base::app);

	dbgfile << std::endl;
	dbgfile << "########################" << std::endl;
	dbgfile << "### ----- CPP ------ ###" << std::endl;
	dbgfile << "########################" << std::endl;

	dbgfile << std::endl;

	dbgfile << "p1" << Form("(E,px,py,pz): (%13.8f, %13.8f, %13.8f, %13.8f)\n", p1.E(), p1.Px(), p1.Py(), p1.Pz() );
	dbgfile << "p2" << Form("(E,px,py,pz): (%13.8f, %13.8f, %13.8f, %13.8f)\n", p2.E(), p2.Px(), p2.Py(), p2.Pz() );
	dbgfile << "p3" << Form("(E,px,py,pz): (%13.8f, %13.8f, %13.8f, %13.8f)\n", p3.E(), p3.Px(), p3.Py(), p3.Pz() );
	dbgfile << "p4" << Form("(E,px,py,pz): (%13.8f, %13.8f, %13.8f, %13.8f)\n", p4.E(), p4.Px(), p4.Py(), p4.Pz() );

	dbgfile << "p1.M(): " << p1.M() << std::endl;
	dbgfile << "p2.M(): " << p2.M() << std::endl;
	dbgfile << "p3.M(): " << p3.M() << std::endl;
	dbgfile << "p4.M(): " << p4.M() << std::endl;
	dbgfile << "(p1+p2).M(): " << (p1+p2).M() << std::endl;
	dbgfile << std::endl;
	dbgfile << "s:      " << s << std::endl;
	dbgfile << "t:      " << t << std::endl;
	dbgfile << "u:      " << u << std::endl;
	dbgfile << std::endl;
	dbgfile << "z:      " << z << std::endl;
	dbgfile << "h:      " << h << std::endl;
	dbgfile << std::endl;

	dbgfile << std::endl;
  	dbgfile << "### - Formula - ###" << std::endl;
  	dbgfile << "-2*sqrt(lambda/z)*(la+lb)*sum_{q} [((z-s)/z) * aZqq * ghZZ * PZ(s) * (Ftri(s,mq**2) + 2.0)]" << std::endl;
	dbgfile << std::endl;

	// Couplings
  	dbgfile << "### - Couplings/angles/masses - ###" << std::endl;
  	dbgfile << "cos_W:    " << cos_W << std::endl;
  	dbgfile << "m_Z:      " << m_Z << std::endl;
  	dbgfile << "g_hZZ:    " << g_hZZ << std::endl;
  	dbgfile << "g_Zqq[0]: " << g_Zqq[0] << std::endl;
  	dbgfile << "g_Zqq[1]: " << g_Zqq[1] << std::endl;
	dbgfile << std::endl;

	// Kinematic factors
  	dbgfile << "### - Kinematic factors - ###" << std::endl;
  	dbgfile << "lambda:           " << lambda_func(s,z,h)           << std::endl;
  	dbgfile << "sqrt(lambda/z):   " << sqrt((lambda_func(s,z,h)/z)) << std::endl;
  	dbgfile << "(z-s)/s:   " << (z-s)/z << std::endl;

  	dbgfile << std::endl;
  	dbgfile << "### - Quark contributions to the quark sum - ###" << std::endl;

	for (int iQ = 0; iQ < 6; iQ++)
	{
		dbgfile << "C0["              << iQ << "]               " <<  amplitude_C0[iQ]   << "  |abs| = " << std::abs(amplitude_C0[iQ]) << std::endl;
	}
	for (int iQ = 0; iQ < 6; iQ++)
	{
		dbgfile << "Ftri["            << iQ << "]             " <<  amplitude_Ftri[iQ] << "  |abs| = " << std::abs(amplitude_Ftri[iQ]) << std::endl;
	}
	for (int iQ = 0; iQ < 6; iQ++)
	{
		dbgfile << "Ftri["            << iQ << "] + 2.0        " <<  (amplitude_Ftri[iQ]+2.0) << "  |abs| = " << std::abs(amplitude_Ftri[iQ]+2.0) << std::endl;
	}
	for (int iQ = 0; iQ < 6; iQ++)
	{
		dbgfile << "((z-s)/z) * aZqq * ghZZ * PZ(s) * (Ftri + 2.0)[" << iQ << "]  " << amplitude_quark[iQ]  << "  |abs| = " << std::abs(amplitude_quark[iQ]) << std::endl;
	}


  	dbgfile << std::endl;
  	dbgfile << "### - Quark sum - ###" << std::endl;
	dbgfile << "quark_sum: "   << amplitude_quark_sum << std::endl;
	dbgfile << "|quark_sum|: " << std::abs(amplitude_quark_sum) << std::endl;
  	dbgfile << std::endl;

  	dbgfile << "### - Final amplitude - ###" << std::endl;
	dbgfile << "amp:     " << amplitude << std::endl;
	dbgfile << "|amp|:   " << std::abs(amplitude) << std::endl;
	dbgfile << "|amp|^2: " << amplitude*std::conj(amplitude) << std::endl;
	# endif

	double result =  std::abs(amplitude_sqr);

	return result;	
}


/////////////////////////////////////////////////
double lambda_func (double a, double b, double c)
{
	double lambda;
	lambda = a*a + b*b + c*c - 2*( a*b + b*c + a*c);
	return lambda;
}


/////////////////////////////////////////////////
std::complex<double> Propagator (double s, double m, double Gamma)
{
	std::complex<double> prop = 1.0/( s - (m*m) + I*m*Gamma);
	return prop;
}


/////////////////////////////////////////////////
void looptools_ ()
{
	ltini();
	printf("LoopTools settings:\n");
	printf("delta: %.4f\n", getdelta() );
	printf("mudim: %.4f\n", getmudim() );
	printf("lambda: %.4f\n", getlambda() );
	printf("minmass: %.4f\n", getminmass() );
}

///////////////////////////////////////////////
void displayTLorentzVector(TLorentzVector *v)
{
	std::cout << Form("(E,px,py,pz): (%13.8f, %13.8f, %13.8f, %13.8f)\n", v->E(), v->Px(), v->Py(), v->Pz() );
};
