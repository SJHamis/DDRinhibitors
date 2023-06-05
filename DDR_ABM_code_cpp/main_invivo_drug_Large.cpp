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
#define N 1000//400 //400 //100
#define NN 1000000 // 10000
#define dt 0.001
#define dx 0.2
#define dy 0.2
#define hour 1000
#define invitro 0 //invitro=false, invivo=true

double dtodxy = dt/(dx*dx); // Correct when dx=dy/Users/sara/Desktop/DDR inhibitor/h_generate_output.h

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
    double drug_dose=24;//19;//50*0.33;//12.5;//Drug doese (in micromole)
    double mu_in=24007;//24000;//24000;
    double sigma_in=500;//2500;
    SetInputOptions1(mu_in, sigma_in);
    
    double prob_Damaged_S_in=75;
    double T_in_Sd_in=0.03;
    double hc_in=2;
    double EC50_in=1;
    double T_Death_Delay_in=1;
    SetInputOptions2(prob_Damaged_S_in, T_in_Sd_in, hc_in, EC50_in, T_Death_Delay_in);
    
    int start_time, end_time, drug_time, radiotherapy_time, drug_clear_time;
    //int n_caption=0; //Variable to progress the cell map captions
    //int n_field_caption=0; //Progress the scalar field (oxygen or drug) maps
    
    /** Set therapy and end times */
    start_time=0;
    end_time=50000*hour;
    drug_time=0;
    drug_clear_time=0;
    int no_cells;
    int washout_time=0;
    
    srand(time(0));
    /** Allocate Grid variables [h_allocate_deallocate.h] */
    Allocate();
    /** Place the first cancer cell(s) on the grid [h_lattice_setup.h] */
    InitCells();
    int midcell = N*N/2+N/2;
    int k=0;
    
    /**
    while(oxygen_scaled[midcell]<0.2)
    {
        ComputeOxygen();
        ScaleOxygen();
        k++;
        if(k%10000==0)
        {
                    printf("hour %d = %lf, %lf \n",k/10000,oxygen[midcell],oxygen_scaled[midcell]);
        }
 
    }
     */
    for(int n=0; n <= NN; n++)
    {
        oxygen_scaled[n]=100;
    }
    printf("done oxygenating\n");
    /** Time loop */
    for(int t=0; t <= end_time; t++)
    {
        /** Compute oxygen distribution across lattice [h_oxygen.h] */
        //ComputeOxygen();
        /** Scale oxygen [h_oxygen.h] */
        //ScaleOxygen();
        /** Progress cells in cell-cycle [h_cell_cyle.h] */
        Compute_CellCycle(t);
        
        if(t%(24*hour)==0)
        {
            no_cells=CountCells(t);
            printf("In loop. Time: %d. No Cells: %d.\n",t,no_cells);
        }
        
        /** When population size is 1000 cells, treatments (drugs/IR) are scheduled */
        if(start_time==0)
        {
            no_cells=CountCells(t);
            
            if(no_cells>=40000)//126000)
            {
                start_time=t;
                drug_time=t;
                drug_clear_time=t+12*hour;
                end_time=t+14*24*hour; //t+5*24*hour;
                printf("Time: %d is start time.\n Time: %d is end time.\n ", start_time, end_time );
            }
        }
        
        if(start_time>0)
        {
            /**
            if(t==start_time)//+10*24000)
            {
                for(int n=0; n <= NN; n++)
                {
                    oxygen_scaled[n]=0;
                }
                printf("done un-oxygenating\n");
            }
            */
            
            if(t==drug_time)
            {
                /** Apply drugs [h_drugs.h] */
                ProduceDrug(drug_dose);
                drug_time=t+24*hour;
            }
            if(t==drug_clear_time)
            {
                /** Apply drugs [h_drugs.h] */
                for(int i=i; i<NN; i++)
                {
                    drug[i]=0;
                }
                drug_clear_time=t+24*hour;
            }
            
            /** Compute drugs [h_drugs.h] */
            ComputeDrug();
            /** Test if sleeping cells should wake up [h_cell_proliferation_and_death.h]*/
            //ScanForCellsToWakeUp();
            /** Test if damgaed cells should be removed from lattice [h_cell_proliferation_and_death.h]*/
            //ScanForCellsToRemoveFromLattice(t);
            
            /** Print output to file */
            if( (t-start_time)%(1*hour)==0 )
                {
                    //printf("DATA! %d ",(t-start_time)/1000);
                    //CountDrug();
                    //CreateOutputScalarData((t-start_time)/hour);
                    CreateOutputScalarData(t, (int)prob_Damaged_S_in, (int)(T_in_Sd_in*100), (int)(hc_in*100), (int)(EC50_in*100), (int)(T_Death_Delay_in*100), (int)mu_in, (int)sigma_in, (int)(drug_dose*100) );
                    
                }
            if( (t-start_time)%(24*hour)==0 )
            {
                printf("Time is %d \n ",(t-start_time)/1000);
            }
            /**
	    if( (t-start_time)%(1*hour)==0 )
	      {
              //CreateOutputScalarFieldMaps(n_field_caption);
              //CreateOutputCellMaps(n_caption);
              //n_caption++;
              //n_field_caption++;
	      } */
        }
    }//end time loop
}
