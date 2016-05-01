#include "Amplitudes.h"

#define DEBUG 1

void errormsg_ ()
{
	std::cerr << "Error." << std::endl;
//	ltini();
//	B0(1.1, 0.1, 0.3);
//	ltexi();
};


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


//	printf("sinw2: %.3f\n", sin_W2 );

	# if DEBUG

	printf("########################\n");
	printf("### ----- CPP ------ ###\n");
	printf("########################\n");
	printf("p1.M(): %.3f\n", p1.M() );
	printf("p2.M(): %.3f\n", p2.M() );
	printf("p3.M(): %.3f\n", p3.M() );
	printf("p4.M(): %.3f\n", p4.M() );
	printf("s:      %.3f\n", s );
	printf("z:      %.3f\n", z );
	printf("h:      %.3f\n", h );

	#endif

	std::complex<double> amplitude;
	std::complex<double> amplitude_quark_sum;
	std::complex<double> amplitude_sqr;
	amplitude_quark_sum = 0.0;

	for (int iF  = 0; iF < nFamilies; iF ++ )
	for (int iSo = 0; iSo < niSo; iSo ++ )
	{
      double mqsqr = m_q[iF][iSo]*m_q[iF][iSo];
		amplitude_quark_sum = amplitude_quark_sum + ((z-s)/z) * g_Zqq[iSo] * g_hZZ * PropZ(s)  * ( 4.0 * mqsqr * C0(0.0,0.0,s,mqsqr,mqsqr,mqsqr)  + 2.0 );

		# if DEBUG
//		std::cerr << "iF: " << iF << " iSo: " << iSo << " C0: " << C0(0.0,0.0,s,mqsqr,mqsqr,mqsqr) << std::endl;
//		std::cerr << "iF: " << iF << " iSo: " << iSo << " 4*m2*C0: " << 4.0*mqsqr*C0(0.0,0.0,s,mqsqr,mqsqr,mqsqr) << std::endl;
		std::cerr << "(z-s)/z :" << ((z-s)/z) << std::endl;
		std::cerr << "g_Zqq: " << g_Zqq[iSo] << std::endl;
		std::cerr << "g_hZZ: " << g_hZZ << std::endl;
		std::cerr << "PropZ(s): " << PropZ(s) << std::endl;
		std::cerr << "iF: " << iF << " iSo: " << iSo << " quark : " << ((z-s)/z) * g_Zqq[iSo] * g_hZZ * PropZ(s)  * ( 4.0 * mqsqr * C0(0.0,0.0,s,mqsqr,mqsqr,mqsqr)  + 2.0 ) << std::endl;
		# endif
	}
  
	std::cerr << "g_hZZ: " << g_hZZ << std::endl;
	std::cerr << "g_Zqq: " << g_Zqq[0] << std::endl;
	std::cerr << "g_Zqq: " << g_Zqq[1] << std::endl;
	printf("lambda: %.4e\n", lambda_func(s,z,h));
	amplitude     = -2*sqrt(lambda_func(s,z,h)/z) * amplitude_quark_sum;
	std::cerr << "amplitude: " << amplitude << std::endl;
	amplitude_sqr = amplitude*std::conj(amplitude);

	double result =  std::abs(amplitude_sqr);

	return result;	
}


double lambda_func (double a, double b, double c)
{
	double lambda;
	lambda = a*a + b*b + c*c - 2*( a*b + b*c + a*c);
	return lambda;
}


std::complex<double> PropZ (double s)
{
	return 1.0;
}
//double lambda_func (double a, double b, double c)
