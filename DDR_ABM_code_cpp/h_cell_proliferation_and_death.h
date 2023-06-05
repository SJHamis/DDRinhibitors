/*********************************************************
 *
 * Handles multiple functionalities related to placing/removing cells on the lattice.
 *
 *********************************************************/

#ifndef H_CELL_PROLIFERATION_AND_DEATH
#define H_CELL_PROLIFERATION_AND_DEATH

/** functions*/
void SetInputOptions1(double mu_in, double sigma_in);
void PlaceNewCell(int n);
void ResetMotherCell(int n);
void KillCellByReplicationStress(int n, int t);
void ScanForCellsToRemoveFromLattice(int t);
void PutCellToSleep(int n_mother);
void CellDivision(int n_mother);
void ChooseNeighbourhood(int n_mother);
void MooreNeighbourhood(int n_mother);
int CheckMooreNbh1(int n_mother);
int CheckMooreNbh2(int n_mother);
int CheckMooreNbh3(int n_mother);
void VN_Neighbourhood(int n_mother);
int CheckVN_Nbh1(int n_mother);
int CheckVN_Nbh2(int n_mother);
int CheckVN_Nbh3(int n_mother);
int CheckLatticePoint(int n_check);
int CountCells(int t);
void CountCellsDetailed(int t);
void TryToWakeCell(int n);
void ScanForCellsToWakeUp();
double mu;
double sigma;

void SetInputOptions1(double mu_in, double sigma_in)
{
    mu=mu_in;
    sigma=sigma_in;
}

int CountCells(int t)
{
    /** Count number of cells on the lattice */
    int nocells=0;
    for(int n=0; n<NN; n++)
    {
        if(cell_cycle_phase[n]>0)// && cell_cycle_phase[n]<5 )//(cell_lives_here[n]>0)
        {
            nocells++;
        }
    }
    return nocells;
}

void CountCellsDetailed(int t)
{
     /** Count (cell-cycle detailed) number of cells on the lattice */
    double no_g1_cells=0;
    double no_s_cells=0;
    double no_sd_cells=0;
    double no_g2m_cells=0;
    double no_cells=0;
    double no_all_cells=0;
    
    for(int n=0; n<NN; n++)
    {
        if(cell_cycle_phase[n]>0)
        {
            no_all_cells++;
            
            if(cell_cycle_phase[n]==1)
            {
                no_g1_cells++;
                no_cells++;
            }
            if(cell_cycle_phase[n]==2)
            {
                no_s_cells++;
                no_cells++;
            }
            if(cell_cycle_phase[n]==3)
            {
                no_sd_cells++;
                no_cells++;
            }
            if(cell_cycle_phase[n]==4)
            {
                no_g2m_cells++;
                no_cells++;
            }
        }
    }
    //printf("At time %d, NoAllCells=%lf, Nocells = %lf. G1=%lf. S=%lf. DS=%lf. G2M=%lf.\n ",t,no_all_cells, no_cells,no_g1_cells/no_cells,no_s_cells/no_cells,no_sd_cells/no_cells,no_g2m_cells/no_cells);
}

void PlaceNewCell(int n)
{
    /** Set the initial variables for the newborn cell in lattice point n */
    cell_lives_here[n]=1;
    cell_cycle_phase[n]=1;
    cell_cycle_clock[n]=1;

    if(invitro==1)
    {
        const double pi = 3.14159265358979323846;
        double u1, u2, uu;
        //double mu = 24000;
        //double sigma = 250;//1000;//3000;
  
        u1=( (double) rand() / (RAND_MAX) );
        u2=( (double) rand() / (RAND_MAX) );
        
        if(u1==0)
            {
                uu=0;
            }
        else
            {
                uu = mu + sigma*sqrt(-2*log(u1))*cos(2*pi*u2);
            }
        
        cell_cycle_length[n]=uu;
    }
    else if(invitro==0)
    {
        const double pi = 3.14159265358979323846;
        double u1, u2, uu;
        //double mu = 24000;
        //double sigma = 3000;
        
        u1=( (double) rand() / (RAND_MAX) );
        u2=( (double) rand() / (RAND_MAX) );
        
        if(u1==0)
        {
            uu=0;
        }
        else
        {
            uu = mu + sigma*sqrt(-2*log(u1))*cos(2*pi*u2);
        }
        
        cell_cycle_length[n]=uu;
    }
    
   // printf("ccl: %d \n",cell_cycle_length[n]);
}

void ResetMotherCell(int n)
{
    /** Reset mother cell after it has divided and produced a daughter cell */
    cell_cycle_phase[n]=1;
    cell_cycle_clock[n]=1;  
}

void ScanForCellsToWakeUp()
{
    /** Check if sleeping cell should wake up */
    for(int n=0; n<NN; n++)
    {
        if(cell_cycle_phase[n]==5)
        {
            TryToWakeCell(n);
        }
    }
}

void TryToWakeCell(int n)
{
    /** Check (first order) neighbourhood to wake up sleeping cell */
    bool wakeup = false;

        if(cell_lives_here[n-N-1]==0)
        {
            wakeup=true;
        }
        else if(cell_lives_here[n-N]==0)
        {
            wakeup=true;
        }
        else if(cell_lives_here[n-N+1]==0)
        {
            wakeup=true;
        }
        else if(cell_lives_here[n-1]==0)
        {
            wakeup=true;
        }
        else if(cell_lives_here[n+1]==0)
        {
            wakeup=true;
        }
        else if(cell_lives_here[n+N-1]==0)
        {
            wakeup=true;
        }
        else if(cell_lives_here[n+N]==0)
        {
            wakeup=true;
        }
        else if(cell_lives_here[n+N+1]==0)
        {
            wakeup=true;
        }
    
    if(wakeup==true)
    {
        ResetMotherCell(n);
    }
    
}
  
void KillCellByReplicationStress(int n, int t)
{
    /** Kill Cell in lattice point n. Note cell still remains on lattice */
    cell_cycle_clock[n]=1;
    cell_cycle_phase[n]=20;
    //scheduled_lattice_removal[n]=t+cell_cycle_length[n];
    //printf("Killed, death sched at %d !\n",scheduled_lattice_removal[n]);
}

void ScanForCellsToRemoveFromLattice(int t)
{
    /** Remove damaged cell from lattice point*/
    /**
    for(int n=0; n<NN; n++)
    {
        if(cell_cycle_phase[n]==20 && scheduled_lattice_removal[n]==t)
        {
            cell_lives_here[n]=0;
            cell_cycle_phase[n]=0;
            cell_cycle_clock[n]=0;
            cell_cycle_length[n]=0;
            scheduled_lattice_removal[n]=0;
            //printf("Removed!\n");
        }
    }
     */
}

void PutCellToSleep(int n_mother)
{
  cell_cycle_phase[n_mother]=5;
}

void CellDivision(int n_mother)
{
  ChooseNeighbourhood(n_mother);
}

void ChooseNeighbourhood(int n_mother)
{
   int nbh_dice = rand() %2;
   if(nbh_dice==1)
     {
         MooreNeighbourhood(n_mother);
         //VN_Neighbourhood(n_mother);
     }
   else
     {
        //MooreNeighbourhood(n_mother);
        VN_Neighbourhood(n_mother);
     }
}

void MooreNeighbourhood(int n_mother)
{
  int n_daughter=0;
  /** Check first order neighbourhood (NBH) */
  n_daughter = CheckMooreNbh1(n_mother);
  
  /** Check second order  NBH if cell not yet placed */
  if(n_daughter==0)
    {
       n_daughter = CheckMooreNbh2(n_mother);
    }

  /** Check third order NBH if cell not yet placed */
  if(n_daughter==0)
    {
       n_daughter = CheckMooreNbh3(n_mother);
    }
    
    if(invitro==1)
    {
        if(n_daughter!=0)
        {
            PlaceNewCell(n_daughter);
            ResetMotherCell(n_mother);
        }
        else     //if still not placed, randomise a direction
        {
            int direction = rand() %8;
            int position=n_mother;
            
            if(direction==0) //go up
            {
                while(cell_lives_here[position-N]==1)
                {
                    position=position-N;
                }
            }
            else if(direction==1) //go down
            {
                while(cell_lives_here[position+N]==1)
                {
                    position=position+N;
                }
            }
            else if(direction==2) //go right
            {
                while(cell_lives_here[position+1]==1)
                {
                    position=position+1;
                }
            }
            else if(direction==3) //go left
            {
                while(cell_lives_here[position-1]==1)
                {
                    position=position-1;
                }
            }
            else if(direction==4) //go left up diagonal
            {
                while(cell_lives_here[position-N-1]==1)
                {
                    position=position-N-1;
                }
            }
            else if(direction==5) //go right up diagonal
            {
                while(cell_lives_here[position-N+1]==1)
                {
                    position=position-N+1;
                }
            }
            else if(direction==6) //go right down diagonal
            {
                while(cell_lives_here[position+N-1]==1)
                {
                    position=position+N-1;
                }
            }
            else if(direction==7) //go right up diagonal
            {
                while(cell_lives_here[position+N+1]==1)
                {
                    position=position+N+1;
                }
            }
            ResetMotherCell(n_mother);
            CellDivision(position);
           // printf("%d sending %d\n",n_mother,position);
            }
    }
    else if(invitro==0)
    {
        /** Put cell to sleep if there was no space in 1st,2nd,3rd NBH */
        if(n_daughter==0)
        {
            PutCellToSleep(n_mother);
        }
        else
        {
            PlaceNewCell(n_daughter);
            ResetMotherCell(n_mother);
        }
    }
}

int CheckMooreNbh1(int n_mother)
{
  int daughter_dice = rand() %8; //randomize 0-7
  int daughter_position = 0;
  int counter = 0;

  while(daughter_position==0 && counter<=8)
    {
      if(daughter_dice==0)
	{
	   daughter_position=CheckLatticePoint(n_mother-N-1);
	}
      else if(daughter_dice==1)
	{
	   daughter_position=CheckLatticePoint(n_mother-N);
	}
      else if(daughter_dice==2)
	{
	    daughter_position=CheckLatticePoint(n_mother-N+1);
	}
      else if(daughter_dice==3)
	{
	   daughter_position=CheckLatticePoint(n_mother-1);
	}
      else if(daughter_dice==4)
	{
	   daughter_position=CheckLatticePoint(n_mother+1);
	}
      else if(daughter_dice==5)
	{
	    daughter_position=CheckLatticePoint(n_mother+N-1);
	}
      else if(daughter_dice==6)
	{
	   daughter_position=CheckLatticePoint(n_mother+N);
	}
      else if(daughter_dice==7)
	{
	    daughter_position=CheckLatticePoint(n_mother+N+1);
	}
       daughter_dice=(daughter_dice+1)%8;
       counter++;
    }  
  return daughter_position;
}

int CheckLatticePoint(int check_n)
{
  if(cell_lives_here[check_n]==0)//if lattice point n_check is empty
    {
      return check_n;
    }
  else
    {
      return 0;
    }
}

  

int CheckMooreNbh2(int n_mother)
{
    int daughter_dice = rand() % 16;
    int daughter_position = 0;
    int counter = 0;
    
    while(daughter_position==0 && counter<=16)
    {
        if(daughter_dice==0) //start top row
        {
            daughter_position=CheckLatticePoint(n_mother-2*N-2);
        }
        else if(daughter_dice==1)
        {
            daughter_position=CheckLatticePoint(n_mother-2*N-1);
        }
        else if(daughter_dice==2)
        {
            daughter_position=CheckLatticePoint(n_mother-2*N);
        }
        else if(daughter_dice==3)
        {
            daughter_position=CheckLatticePoint(n_mother-2*N+1);
        }
        else if(daughter_dice==4)
        {
            daughter_position=CheckLatticePoint(n_mother-2*N+2);
        } //end top row
        else if(daughter_dice==5) //start bot row
        {
            daughter_position=CheckLatticePoint(n_mother+2*N-2);
        }
        else if(daughter_dice==6)
        {
            daughter_position=CheckLatticePoint(n_mother+2*N-1);
        }
        else if(daughter_dice==7)
        {
            daughter_position=CheckLatticePoint(n_mother+2*N);
        }
        else if(daughter_dice==8)
        {
            daughter_position=CheckLatticePoint(n_mother+2*N+1);
        }
        else if(daughter_dice==9)
        {
            daughter_position=CheckLatticePoint(n_mother+2*N+2);
        } //end bot row
        else if(daughter_dice==10) //start left
        {
            daughter_position=CheckLatticePoint(n_mother-N-2);
        }
        else if(daughter_dice==11)
        {
            daughter_position=CheckLatticePoint(n_mother-2);
        }
        else if(daughter_dice==12)
        {
            daughter_position=CheckLatticePoint(n_mother+N-2); //end left
        }
        else if(daughter_dice==13) //start right
        {
            daughter_position=CheckLatticePoint(n_mother-N+2);
        }
        else if(daughter_dice==14)
        {
            daughter_position=CheckLatticePoint(n_mother+2);
        }
        else if(daughter_dice==15)
        {
            daughter_position=CheckLatticePoint(n_mother+N+2);
        }

        daughter_dice=(daughter_dice+1)%16;
        counter++;
    }
    return daughter_position;
}

int CheckMooreNbh3(int n_mother)
{
    int daughter_dice = rand() % 24;
    int daughter_position = 0;
    int counter = 0;
    
    while(daughter_position==0 && counter<=24)
    {
        if(daughter_dice==0) //start top row
        {
            daughter_position=CheckLatticePoint(n_mother-3*N-3);
        }
        else if(daughter_dice==1)
        {
            daughter_position=CheckLatticePoint(n_mother-3*N-2);
        }
        else if(daughter_dice==2)
        {
            daughter_position=CheckLatticePoint(n_mother-3*N-1);
        }
        else if(daughter_dice==3)
        {
            daughter_position=CheckLatticePoint(n_mother-3*N);
        }
        else if(daughter_dice==4)
        {
            daughter_position=CheckLatticePoint(n_mother-3*N+1);
        }
        else if(daughter_dice==5)
        {
            daughter_position=CheckLatticePoint(n_mother-3*N+2);
        }
        else if(daughter_dice==6)
        {
            daughter_position=CheckLatticePoint(n_mother-3*N+3);
        } //end top row
        else if(daughter_dice==7) //start bot row
        {
            daughter_position=CheckLatticePoint(n_mother+3*N-3);
        }
        else if(daughter_dice==8)
        {
            daughter_position=CheckLatticePoint(n_mother+3*N-2);
        }
        else if(daughter_dice==9)
        {
            daughter_position=CheckLatticePoint(n_mother+3*N-1);
        }
        else if(daughter_dice==10)
        {
            daughter_position=CheckLatticePoint(n_mother+3*N);
        }
        else if(daughter_dice==11)
        {
            daughter_position=CheckLatticePoint(n_mother+3*N+1);
        }
        else if(daughter_dice==12)
        {
            daughter_position=CheckLatticePoint(n_mother+3*N+2);
        }
        else if(daughter_dice==13)
        {
            daughter_position=CheckLatticePoint(n_mother+3*N+3);
        } //end bot row
        else if(daughter_dice==14) //start left
        {
            daughter_position=CheckLatticePoint(n_mother-2*N-3);
        }
        else if(daughter_dice==15)
        {
            daughter_position=CheckLatticePoint(n_mother-N-3);
        }
        else if(daughter_dice==16)
        {
            daughter_position=CheckLatticePoint(n_mother-3);
        }
        else if(daughter_dice==17)
        {
            daughter_position=CheckLatticePoint(n_mother+N-3);
        }
        else if(daughter_dice==18)
        {
            daughter_position=CheckLatticePoint(n_mother+2*N-3); //end left
        }
        else if(daughter_dice==19) //start right
        {
            daughter_position=CheckLatticePoint(n_mother-2*N+3);
        }
        else if(daughter_dice==20)
        {
            daughter_position=CheckLatticePoint(n_mother-N+3);
        }
        else if(daughter_dice==21)
        {
            daughter_position=CheckLatticePoint(n_mother+3);
        }
        else if(daughter_dice==22)
        {
            daughter_position=CheckLatticePoint(n_mother+N+3);
        }
        else if(daughter_dice==23)
        {
            daughter_position=CheckLatticePoint(n_mother+2*N+3); //end left
        }
 
        daughter_dice=(daughter_dice+1)%24;
        counter++;
    }
    return daughter_position;
}

void VN_Neighbourhood(int n_mother)
{
    int n_daughter=0;
    /** Check first order neighbourhood (NBH) */
    n_daughter = CheckVN_Nbh1(n_mother);
    /** Check second order  NBH if cell not yet placed */
    if(n_daughter==0)
    {
        n_daughter = CheckVN_Nbh2(n_mother);
    }
    /** Check third order NBH if cell not yet placed */
    if(n_daughter==0)
    {
        n_daughter = CheckVN_Nbh3(n_mother);
    }
    //if still not placed, randomise a direction
    if(n_daughter!=0)
    {
        PlaceNewCell(n_daughter);
        ResetMotherCell(n_mother);
    }
    else
    {
        //if still not placed, randomise a direction
        int direction = rand() %8;
        int position=n_mother;
        
        if(direction==0) //go up
        {
            while(cell_lives_here[position-N]==1)
            {
                position=position-N;
            }
        }
        else if(direction==1) //go down
        {
            while(cell_lives_here[position+N]==1)
            {
                position=position+N;
            }
        }
        else if(direction==2) //go right
        {
            while(cell_lives_here[position+1]==1)
            {
                position=position+1;
            }
        }
        else if(direction==3) //go left
        {
            while(cell_lives_here[position-1]==1)
            {
                position=position-1;
            }
        }
        else if(direction==4) //go left up diagonal
        {
            while(cell_lives_here[position-N-1]==1)
            {
                position=position-N-1;
            }
        }
        else if(direction==5) //go right up diagonal
        {
            while(cell_lives_here[position-N+1]==1)
            {
                position=position-N+1;
            }
        }
        else if(direction==6) //go right down diagonal
        {
            while(cell_lives_here[position+N-1]==1)
            {
                position=position+N-1;
            }
        }
        else if(direction==7) //go right up diagonal
        {
            while(cell_lives_here[position+N+1]==1)
            {
                position=position+N+1;
            }
        }
        ResetMotherCell(n_mother);
        CellDivision(position);
    }
    /** Put cell to sleep if there was no space in 1st,2nd,3rd NBH */
    /**
    if(n_daughter==0)
    {
        PutCellToSleep(n_mother);
    }
    else
    {
        PlaceNewCell(n_daughter);
        ResetMotherCell(n_mother);
    }
     */

}

int CheckVN_Nbh1(int n_mother)
{
    int daughter_dice = rand() %4;
    int daughter_position = 0;
    int counter = 0;
    
    while(daughter_position==0 && counter<=4)
    {
        if(daughter_dice==0)
        {
            daughter_position=CheckLatticePoint(n_mother-N);
        }
        else if(daughter_dice==1)
        {
            daughter_position=CheckLatticePoint(n_mother+N);
        }
        else if(daughter_dice==2)
        {
            daughter_position=CheckLatticePoint(n_mother-1);
        }
        else if(daughter_dice==3)
        {
            daughter_position=CheckLatticePoint(n_mother+1);
        }
        daughter_dice=(daughter_dice+1)%3;
        counter++;
    }
    return daughter_position;
}

int CheckVN_Nbh2(int n_mother)
{
    int daughter_dice = rand() %8;
    int daughter_position = 0;
    int counter = 0;
    
    while(daughter_position==0 && counter<=8)
    {
        if(daughter_dice==0)//start outer points
        {
            daughter_position=CheckLatticePoint(n_mother-2*N);
        }
        else if(daughter_dice==1)
        {
            daughter_position=CheckLatticePoint(n_mother+2*N);
        }
        else if(daughter_dice==2)
        {
            daughter_position=CheckLatticePoint(n_mother-2);
        }
        else if(daughter_dice==3)
        {
            daughter_position=CheckLatticePoint(n_mother+2);
        }//end outer points
        else if(daughter_dice==4)
        {
            daughter_position=CheckLatticePoint(n_mother-N-1);
        }
        else if(daughter_dice==5)
        {
            daughter_position=CheckLatticePoint(n_mother-N+1);
        }
        else if(daughter_dice==6)
        {
            daughter_position=CheckLatticePoint(n_mother+N-1);
        }
        else if(daughter_dice==7)
        {
            daughter_position=CheckLatticePoint(n_mother+N+1);
        }
        
        daughter_dice=(daughter_dice+1)%8;
        counter++;
    }
    return daughter_position;
}

int CheckVN_Nbh3(int n_mother)
{
    int daughter_dice = rand() %12;
    int daughter_position = 0;
    int counter = 0;
    
    while(daughter_position==0 && counter<=12)
    {
        if(daughter_dice==0)
        {
            daughter_position=CheckLatticePoint(n_mother-3*N);
        }
        else if(daughter_dice==1)
        {
            daughter_position=CheckLatticePoint(n_mother+3*N);
        }
        else if(daughter_dice==2)
        {
            daughter_position=CheckLatticePoint(n_mother-3);
        }
        else if(daughter_dice==3)
        {
            daughter_position=CheckLatticePoint(n_mother+3); //end edges
        }
        else if(daughter_dice==4)
        {
            daughter_position=CheckLatticePoint(n_mother-2*N-1);
        }
        else if(daughter_dice==5)
        {
            daughter_position=CheckLatticePoint(n_mother-2*N+1);
        }
        else if(daughter_dice==6)
        {
            daughter_position=CheckLatticePoint(n_mother+2*N-1);
        }
        else if(daughter_dice==7)
        {
            daughter_position=CheckLatticePoint(n_mother+2*N+1); //end 2*N separations
        }
        else if(daughter_dice==8)
        {
            daughter_position=CheckLatticePoint(n_mother-N-2);
        }
        else if(daughter_dice==9)
        {
            daughter_position=CheckLatticePoint(n_mother-N+2);
        }
        else if(daughter_dice==10)
        {
            daughter_position=CheckLatticePoint(n_mother+N-1);
        }
        else if(daughter_dice==11)
        {
            daughter_position=CheckLatticePoint(n_mother+N+1);
        }
        else if(daughter_dice==12)
        {
            daughter_position=CheckLatticePoint(n_mother+1);
        }
        
        daughter_dice=(daughter_dice+1)%12;
        counter++;
    }
    return daughter_position;
}





#endif

