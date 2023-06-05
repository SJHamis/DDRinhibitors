/*********************************************************
 *
 * Computes drug (AZD6738) concentration using FDM and no-flux boundary conditions.
 *
 *********************************************************/

#ifndef H_DRUG
#define H_DRUG

/** PDE constants */
double microMol = NN; //1 Mol is chosen to equate to n.o. lattice points
double d0_AZD = 0.27851; //diffusion coefficient, matched to weight 412g/M compared to O2 (16g/M)
double gamma_n_AZD; // = 1*Mol/388; //production per source point (we have 388 source points)
double mu_AZD = 0.12; //decay rate, matched to half-life time 6 hours (in vivo)
double d_AZD, dxp_AZD, dxm_AZD, dyp_AZD, dym_AZD;

/** functions */
void ProduceDrug(double drug_dose);
void ComputeDrug();

void ProduceDrug(double drug_dose)
{
    /** Produce drug on unoccupied lattice points */
    double dose=drug_dose*microMol;
    int no_empty_lattice_points=0;
    for(int n=0; n<NN; n++)
    {
        if(cell_cycle_phase[n]==0) //if lattice point not occupied
        {
            no_empty_lattice_points++;
        }
    }
    double dose_per_lattice_point=dose/no_empty_lattice_points;
   //  printf("drug_per_lattice_point=%lf. no_empty=%d\n",dose_per_lattice_point,no_empty_lattice_points);
    for(int n=0; n<NN; n++)
    {
        if(cell_cycle_phase[n]==0) //if lattice point not occupied
        {
            drug[n]=drug[n]+dose_per_lattice_point;
        }
    }
    
}

void ComputeDrug()
{
    /** Compute Oxygen using FDM on all (non-boundary) lattice points */
    for(int n=N; n<NN-N; n++) //top row, bot row excluded
    {
        if(n%N!=0 && n%N!=N-1) //left col, right col excluded
        {
            d_AZD = d0_AZD;     //d0_AZD/(1 + 0.5*cell_lives_here[n]);
            dxp_AZD = d0_AZD;   //d0_AZD/(1+0.5*cell_lives_here[n+1]);
            dxm_AZD = d0_AZD;   //d0_AZD/(1+0.5*cell_lives_here[n-1]);
            dyp_AZD = d0_AZD;   //d0_AZD/(1+0.5*cell_lives_here[n+N]);
            dym_AZD =d0_AZD;    // d0_AZD/(1+0.5*cell_lives_here[n-N]);
                
                drug[n]=drug[n]+dtodxy*(
                                (d_AZD+dyp_AZD)/2*(drug[n+N]-drug[n])-(d_AZD+dym_AZD)/2*(drug[n]-drug[n-N])+
                                (d_AZD+dxp_AZD)/2*(drug[n+1]-drug[n])-(d_AZD+dxm_AZD)/2*(drug[n]-drug[n-1])
                                        )- dt*drug[n]*mu_AZD;
    
        }
    }
        /** Set No-Flux Boundary Conditions */
        /** Right and left column */
        for(int n=0; n<N; n++)
        {
            drug[n*N]=drug[n*N+1];
            drug[n*N+N-1]=drug[n*N+N-2];
        }
        /** Top and bottom row (excluding corners) */
        for(int n=1; n<N-1; n++)
        {
            drug[n]=drug[n+N];
            drug[NN-N+n]=drug[NN-2*N+n];
        }
}

void CountDrug()
{
    /**Check amount of drug, for example to verify decay */
    double drug_tot=0;
    for(int n=0; n<NN; n++)
    {
        drug_tot=drug_tot+drug[n];
    }
 //   printf("Drug: %lf\n",drug_tot);
}
#endif
