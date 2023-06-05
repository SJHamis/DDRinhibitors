/*********************************************************
 *
 * Computes oxygen using FDM and no-flux boundary conditions.
 * Scales oxygen between 0 and 1
 *
 *********************************************************/

#ifndef H_OXYGEN
#define H_OXYGEN

/** PDE constants */
double d0 = 1; //diffusion coefficient
double gamma_n = 1; //production
double phi = 1; //consumption of oxygen by cells

/** variables */
double max_oxygen;

/** functions*/
void ComputeOxygen();
void ScaleOxygen();

//double d;// c;// p; //diffusion, cell binary
double d, dxp, dxm, dyp, dym;

void ComputeOxygen()
{
    /** Produce oxygen on (one in from) boundaries */
    /**
    for(int n=1; n<N-1; n++)
    {
        //oxygen[n+N]=oxygen[n+N]+dt*gamma_n; //top row
        //oxygen[NN-2*N+n]=oxygen[NN-2*N+n]+dt*gamma_n; //bot row
        //oxygen[1+N*n]=oxygen[1+N*n]+dt*gamma_n; //left col
        //oxygen[N*(n+1)-1]=oxygen[N*(n+1)-1]+dt*gamma_n; //right col
        //printf("%d, %lf \n",n, oxygen_scaled[n]);
        //oxygen[N*(n+1)-1]=oxygen[N*(n+1)-1]+dt*gamma_n;
    }
    */
    
    /** Produce oxygen on all no-cell lattice points */
    for(int n=0; n<NN; n++) //top row, bot row excluded
    {
        if(cell_lives_here[n]==0)
        {
            oxygen[n]=oxygen[n]+dt*gamma_n;
        }
    }
    
    /** Compute Oxygen using FDM on all (non-boundary) lattice points */
    for(int n=N; n<NN-N; n++) //top row, bot row excluded
    {
        if(n%N!=0 && n%N!=N-1) //left col, right col excluded
        {          
                d = d0/(1 + 0.5*cell_lives_here[n]);
                dxp = d0/(1+0.5*cell_lives_here[n+1]);
                dxm = d0/(1+0.5*cell_lives_here[n-1]);
                dyp = d0/(1+0.5*cell_lives_here[n+N]);
                dym = d0/(1+0.5*cell_lives_here[n-N]);
                
                oxygen[n]=oxygen[n]+dtodxy*(
                                               (d+dyp)/2*(oxygen[n+N]-oxygen[n])-(d+dym)/2*(oxygen[n]-oxygen[n-N])+
                                               (d+dxp)/2*(oxygen[n+1]-oxygen[n])-(d+dxm)/2*(oxygen[n]-oxygen[n-1])
                                            )-dt*(phi*cell_lives_here[n]*oxygen[n]);
                                        //+dt*(p-phi*c*oxygen[n]);
            if(oxygen[n]>0.01)
            {
                //printf("%d, %lf \n",n, oxygen[n]);
            }
        }
    }

    /** Set No-Flux Boundary Conditions */
    for(int n=0; n<N; n++)
    {
        oxygen[n]=oxygen[n+N]; //top row
        oxygen[NN-N+n]=oxygen[NN-2*N+n]; //bot row
        oxygen[N*n]=oxygen[N*n+1]; //left col
        oxygen[N*(n+1)-1]=oxygen[N*(n+1)-2]; //right col
    }
}

void ScaleOxygen()
{
    max_oxygen = 0;
    for(int n=0; n<NN; n++)
    {
        if(oxygen[n]>max_oxygen)
        {
                max_oxygen = oxygen[n];
        }
    }
    
    for(int n=0; n<NN; n++)
    {
        oxygen_scaled[n]=oxygen[n]/max_oxygen;
    }
}

#endif

