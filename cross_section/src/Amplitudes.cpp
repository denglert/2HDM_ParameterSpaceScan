#include "Amplitudes.h"

#define DEBUG 1

/////////////////////////////////////////////////
void errormsg_ ()
{
	std::cerr << "Error." << std::endl;
//	ltini();
//	B0(1.1, 0.1, 0.3);
//	ltexi();
};


/////////////////////////////////////////////////
double ggzh_triangle_( int la, int lb, double Aparam[2], double THDM_param[4], double p1_[4], double p2_[4], double p3_[4], double p4_[4] )
{

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

	double z = p3.M2();
	double h = p4.M2();

	std::complex<double> amplitude;
	std::complex<double> amplitude_C0[6];
	std::complex<double> amplitude_Ftri[6];
	std::complex<double> amplitude_quark[6];
	std::complex<double> amplitude_quark_sum;
	std::complex<double> amplitude_sqr;
	amplitude_quark_sum = 0.0;
	double mqsqr[6];

	for (int iF  = 0; iF < nFamilies; iF ++ )
	for (int iSo = 0; iSo < niSo; iSo ++ )
	{

			int iQ = iF*2+iSo;
      	mqsqr[iQ] = m_q[iF][iSo]*m_q[iF][iSo];
			amplitude_C0[iQ] = C0(0.0,0.0,s,mqsqr[iQ],mqsqr[iQ],mqsqr[iQ]);
			amplitude_Ftri[iQ] = 4.0 * mqsqr[iQ] * amplitude_C0[iQ];
			//amplitude_C0[iQ] = C0(0.0,0.0,s*1.0e6,mqsqr[iQ]*1.0e6,mqsqr[iQ]*1.0e6,mqsqr[iQ]*1.0e6);
			amplitude_quark[iQ] = ((z-s)/z) * g_Zqq[iSo] * g_hZZ * PropZ(s)  * ( 4.0 * mqsqr[iQ] * amplitude_C0[iQ]  + 2.0 );
			amplitude_quark_sum = amplitude_quark_sum + amplitude_quark[iQ]; 


		# if DEBUG
//		std::cerr << "iF: " << iF << " iSo: " << iSo << " C0: " << C0(0.0,0.0,s,mqsqr,mqsqr,mqsqr) << std::endl;
//		std::cerr << "iF: " << iF << " iSo: " << iSo << " 4*m2*C0: " << 4.0*mqsqr*C0(0.0,0.0,s,mqsqr,mqsqr,mqsqr) << std::endl;
//		std::cerr << "(z-s)/z :" << ((z-s)/z) << std::endl;
//		std::cerr << "g_Zqq: " << g_Zqq[iSo] << std::endl;
//		std::cerr << "g_hZZ: " << g_hZZ << std::endl;
//		std::cerr << "PropZ(s): " << PropZ(s) << std::endl;
//		std::cerr << "iF: " << iF << " iSo: " << iSo << " quark : " << ((z-s)/z) * g_Zqq[iSo] * g_hZZ * PropZ(s)  * ( 4.0 * mqsqr * C0(0.0,0.0,s,mqsqr,mqsqr,mqsqr)  + 2.0 ) << std::endl;
		# endif
	}
  

	amplitude     = -2.0*sqrt(lambda_func(s,z,h)/z) * amplitude_quark_sum;
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
std::complex<double> PropZ (double s)
{
	std::complex<double> prop = 1.0/( s - (m_Z*m_Z) + I*m_Z*Gamma_Z);
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
