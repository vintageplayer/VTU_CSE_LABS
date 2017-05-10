#define _POSIX_SOURCE
#define _POSIX_C_SOURCE 199309L

#include<iostream>
#include<unistd.h>

using namespace std;

int main()
{
	#ifdef _POSIX_JOB_CONTROL
		cout<<"Job control is supported by the system."<<endl;
	#else
		cout<<"Job control is not supported by the system."<<endl;
	#endif
	
	#ifdef _POSIX_NO_TRUNC
		cout<<"Auto-Truncation is restricted by the system."<<endl;
	#else
		cout<<"Auto-Truncation is allowed by the system."<<endl;
	#endif
	
	#ifdef _POSIX_CHOWN_RESTRICTED
		cout<<"CHOWN Restricted option is set."<<endl;
	#else
		cout<<"CHOWN Restricted option is not set."<<endl;
	#endif
	
	#ifdef _POSIX_SAVED_IDS
		cout<<"System supports saving of UIDs and GIDs."<<endl;
	#else
		cout<<"System does not define support for saving UIDs and GIDs."<<endl;
	#endif
	
	#ifdef _POSIX_VDISABLE
		cout<<"Terminal special characters disable is : "<<_POSIX_VDISABLE<<endl;
	#else
		cout<<"System does not define a disabling character for terminal special characters."<<endl;
	#endif
	
	
	return 0;
}
