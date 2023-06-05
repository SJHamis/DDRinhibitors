/*********************************************************
 *
 * Radiotherapy (IR).
 * Apply a dose of radiotherapy.
 * Compute which cells will die/survive from radiotherapy.
 * Label the IR damaged cells as "dying". 
 *
 *********************************************************/

#ifndef H_RADIOTHERAPY
#define H_RADIOTHERAPY

/** Functions */
void ApplyRadiotherapy();
int ComputeRadioSensitivity(int n);
void SetRadiotherapyDamage(int n);

/** Set the alpha, beta values for the LQ radiotherapy model */
/** Index order is G1, S, D-S, G2/M, G0 */
double alpha_vals[5] = {0.351, 0.1235, 0.1235, 0.793, 0.234}; //last index is 0.351/1.5
double beta_vals[5] = {0.04, 0.0285, 0.0285, 0.0, 0.018}; //last index is 0.351/(1.5^2)
double radio_dose = 2; //units in Gy

int radiotherapy_defence, radiotherapy_dice_attack;
/** Progress cell-cycle by time steps */
void ApplyRadiotherapy()
{
    for(int n=0; n<NN; n++)
    {
        /** Radiotherapy attacks all viable cells that are not marked as damaged by radiotherapy */
        if(cell_cycle_phase[n]>=1 && cell_cycle_phase[n]<=5)
        {
            /** Compute radiotherapy survival probability (defence) in [0,100] for cell */
            radiotherapy_defence=ComputeRadioSensitivity(n);
        
            /** Roll dice to see if cell gets DNA damage by radiotherapy attack */
            radiotherapy_dice_attack= rand() % 101;
            //printf("%d, %d \n", radiotherapy_dice_attack, radiotherapy_defence);
            if(radiotherapy_dice_attack>radiotherapy_defence)
            {
                /** DNA damage by radiotherapy */
                SetRadiotherapyDamage(n);
            }
        }
    }
}

int ComputeRadioSensitivity(int n)
{
    double temp_oxygen_value = 100*oxygen_scaled[n];
    double omf = 0.33*( (3*temp_oxygen_value+3)/(temp_oxygen_value+3) );
    double alpha = alpha_vals[cell_cycle_phase[n]-1]; //minus 1 since array index goes 0,1,2...
    double beta = beta_vals[cell_cycle_phase[n]-1];
    /** Return defence, i.e. probability that cell in point n survives current radiotherapy attack */
    return 100*(exp(-( omf*alpha*radio_dose + omf*omf*beta*radio_dose*radio_dose ) ) );
}
    
void SetRadiotherapyDamage(int n)
{
    /** Mark cell as radiotherapy damaged. */
    cell_cycle_phase[n]=20;
}

#endif
