#ifndef H_CELL_CYCLE
#define H_CELL_CYCLE

void Compute_CellCycle(int t);
void EvaluateDrugs();
void SetInputOptions2(double prob_Damaged_S_in, double T_in_Sd_in, double hc_in, double EC50_in, double T_Death_Delay_in);


int dice_G1_fate, dice_DS_fate;
int protect_dice, attack_drugeffect;


double prob_Damaged_S;// = 75; //45; //The probability (in %) that cell enters DS instead of S
double T_in_Sd;//=0.03;                   //min 0.01, mid 0.16 maximum 0.32
double hc; //Hill coefficient
double EC50;// = 1;
double T_Death_Delay;


int GetDrugAttack(int option, int n);

/** Constants used in GetG1ArrestFactor */
double a1=0.9209;
double a2=0.8200;
double a3=-0.2398;
double GetG1ArrestFactor(double oxygen_value);


/** Set input options to global variables */
void SetInputOptions2(double prob_Damaged_S_in, double T_in_Sd_in, double hc_in, double EC50_in, double T_Death_Delay_in)
{
    prob_Damaged_S = prob_Damaged_S_in;
    T_in_Sd = T_in_Sd_in;
    hc = hc_in; //Hill coefficient
    EC50 = EC50_in;
    T_Death_Delay = T_Death_Delay_in;
    
}

/** Progress cell-cycle by time steps */
void Compute_CellCycle(int t)
{
    int length_cc;
    double DS_repair_probability;
    int option=1;
    for(int n=0; n<NN; n++)
      {
          length_cc=cell_cycle_length[n];
          /** Handle replication damaged cell */
          if(cell_cycle_phase[n]==20)
          {
              if(cell_cycle_clock[n]>=T_Death_Delay*cell_cycle_length[n])
              {
                  cell_cycle_phase[n]=0;
                  if(invitro==0)
                  {
                  cell_lives_here[n]=0;
                  cell_cycle_clock[n]=0;
                  cell_cycle_length[n]=0;
                  }
              }
              cell_cycle_clock[n]++;
          }
          
          /** Handle cycling cell */
          if(cell_cycle_phase[n]>0 && cell_cycle_phase[n]<5)
          {
              /** adjust length of cell cycle according to oxygen status od cell */

              
              /** increment cell cyle clock +1 */
              cell_cycle_clock[n]++;

              if(cell_cycle_phase[n]==1) //If cell is in G1
              {
                  if(cell_cycle_clock[n]>0.46*length_cc) //If cell has reached end of G1
                  {
                      /** Roll a dice to see if cell should enter S or D-S state */
                      dice_G1_fate = rand() % 101;
                      if(dice_G1_fate < prob_Damaged_S)
                      {
                          cell_cycle_phase[n]=3; //Go to DS
                      }
                      else
                      {
                          cell_cycle_phase[n]=2;//Go to S
                      }
                  }
              }
              else if(cell_cycle_phase[n]==2) //If cell is in S
              {
                  if(cell_cycle_clock[n]>0.79*length_cc) //If cell has reached end of S
                  {
                      cell_cycle_phase[n]=4; //Go to G2/M
                  }
              }
              else if(cell_cycle_phase[n]==3) //If cell is in D-S
              {
                  //If cell has reached end of D-S state: Try to go to S. Otherwise Die.
                  if( cell_cycle_clock[n]>(0.46+T_in_Sd)*length_cc )
                  {
                      protect_dice = rand() % 101;
                      attack_drugeffect = GetDrugAttack(option, n);

                      if(protect_dice>=attack_drugeffect)
                      {
                          /** Cell repairs */
                          cell_cycle_phase[n]=2; //Go to S
                      }
                      else
                      {
                          /** Cell dies */
                          KillCellByReplicationStress(n,t);
                      }
                  }
              }
              else if(cell_cycle_phase[n]==4) //If cell in G2/M
              {
                  if(cell_cycle_clock[n] >= length_cc)
                  {
                      CellDivision(n);
                  }
              }
          }
      }
}

int GetDrugAttack(int option, int n)
{
    double attack_E=0;
    
    if(invitro==1)
    {
        //double hc = 2; //Hill coefficient
        //double EC50 = 1;
        attack_E=100*pow(drug[n],hc)/( pow(EC50,hc) + pow(drug[n],hc) );
    }
    if(invitro==0)
    {
        //double hc = 2.5; //Hill coefficient
        //double EC50 = 3;
        attack_E=100*pow(drug[n],hc)/( pow(EC50,hc) + pow(drug[n],hc) );
    }
    
    return (int)attack_E;
    
}


double GetG1ArrestFactor(double oxygen_value)
{
    double g1_arrest_factor;
    if(oxygen_value<1)
    {
        g1_arrest_factor=2;
    }
    else if(oxygen_value<=10)
    {
        g1_arrest_factor=a1+a2/(a3+oxygen_value);
    }
    else
    {
        g1_arrest_factor=1;
    }
    g1_arrest_factor=(int)(g1_arrest_factor*100+0.5);
    
    return (float)g1_arrest_factor/100;
}

void EvaluateDrugs()
{
    double maxdrug =0;
    double mindrug =10000;
    double totaldrug =0;
    double nocells =0;
    
    for(int n=0; n<NN; n++)
    {
        if(cell_cycle_phase[n]>0 && cell_cycle_phase[n]<6)
        {
            nocells++;
            totaldrug=totaldrug+drug[n];
            if(drug[n]>maxdrug)
            {
                maxdrug=drug[n];
            }
            if(drug[n]<mindrug)
            {
                mindrug=drug[n];
            }
            
        }

    }
    printf("MAX: %lf, MIN: %lf, AVG: %lf, TOT:%lf, nocells:%lf \n", maxdrug, mindrug, totaldrug/nocells, totaldrug, nocells);
}

#endif
