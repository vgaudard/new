#%IF !CPP_NO_MAIN
#include <iostream>
#%ENDIF

#%% This should not be read by the parser

#%IF !CPP_NO_NAMESPACE
using namespace std;
#%ENDIF


#%IF !CPP_NO_MAIN
int main(int argc, char** argv)
{
#%IF !CPP_NO_NAMESPACE
    cout << "Hello world !" << endl;
#%ELSE
    std::cout << "Hello world !" << std::endl;
#%ENDIF

    return 0;
}
#%ENDIF


