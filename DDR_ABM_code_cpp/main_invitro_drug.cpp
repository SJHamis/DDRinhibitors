/*********************************************************
 *
 * This file contains the main file.
 * The scheduling for drugs (AZD6738) and radiotherapy are set here.
 *
 *********************************************************/

/** includes */
#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <fstream>
#include <math.h>
#include <time.h>
#include <cstdlib>
#include <ctime>
#include <chrono>
#include <string>
#include <cstring>

/* defines */
#define N 400 //100
#define NN 160000 // 10000
#define dt 0.001
#define dx 0.2
#define dy 0.2
#define hour 1000

double dtodxy = dt/(dx*dx); // Correct when dx=dy
#define invitro 1

/* include header files */
#include "h_allocate_deallocate.h"
#include "h_cell_proliferation_and_death.h"
#include "h_lattice_setup.h"
#include "h_cell_cycle_progression.h"
#include "h_oxygen.h"
#include "h_generate_output.h"
#include "h_drug.h"
#include "h_radiotherapy.h"

/** main function */
int main(int argc, char *argv[])
{
    //Calibrated: 1,24h,0.5h,75%,0.03,gamma=2,EC50=1,T_in_DD=1
    double drug_dose=1;//Drug doese (in micromole)
    double mu_in=22303;
    double sigma_in=748;
    SetInputOptions1(mu_in, sigma_in);

    double prob_Damaged_S_in=68.404;
    double T_in_Sd_in=0.037;//0.03;
    double EC50_in=0.773;
    double hc_in = 1.822;
    double T_Death_Delay_in=0.609;

    SetInputOptions2(prob_Damaged_S_in, T_in_Sd_in, hc_in, EC50_in, T_Death_Delay_in);
    
    int start_time, end_time, drug_time;// radiotherapy_time;
    start_time=0;
    end_time=500*hour; //exaggerated now
    drug_time=0;
    
    int no_cells=0;
    srand(time(0));
    /** Allocate Grid variables [h_allocate_deallocate.h] */
    Allocate();
    /** Place the first cancer cell(s) on the grid [h_lattice_setup.h] */
    InitCells();
    
    for(int n=0;n<NN;n++)
    {
        oxygen_scaled[n]=1;
    }
    
    /** Time loop */
    for(int t=0; t <= end_time; t++)
    {
        /** Progress cells in cell-cycle [h_cell_cyle.h] */
        Compute_CellCycle(t);
        if( t>(1*hour) && start_time==0 )
        {
            /**
            if(t%10000==0)
            {
             
              printf("Time: %d Cellcount %d.\n ", t, no_cells );
            }
             */
            no_cells=CountCells(t);
            if(no_cells>=720)//720
            {
                start_time=t+10*hour;
                drug_time=t+10*hour;
                end_time=start_time+72*hour; //72*hour;
                printf("Time: %d is start time.\n Time: %d is end time.\n ", start_time, end_time );
            }
        }
        
        if(start_time>0)
        {
            if(t==drug_time)
            {
                /** Apply drugs [h_drugs.h] */
                for(int n=0; n<NN; n++)
                {
                    drug[n]=drug_dose;
                }
                
            }
            
            if(t>=drug_time)
            {
                if( (t-start_time)%(1*hour)==0 )
                {
                    
                    CreateOutputScalarData(t, (int)prob_Damaged_S_in, (int)(T_in_Sd_in*100), (int)(hc_in*100), (int)(EC50_in*100), (int)(T_Death_Delay_in*100), (int)mu_in, (int)sigma_in, (int)(drug_dose*100) );
                }
            }
        }
    }//end time loop
    //CreateOutputScalarData(1000000, prob_Damaged_S_in, T_in_Sd_in, hc_in, EC50_in, T_Death_Delay_in, mu_in, sigma_in, drug_dose );
   
    Deallocate();
}
