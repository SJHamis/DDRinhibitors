/*************
*
* This file includes functions to allocate and deallocate memory for data arrays.
* Data variables for lattice point-obesrvables are stored in pointers.
* Example: observable[n] denotes the value of a certain observable in lattice point n.
* This is (spatially) a 2D lattice, there are NN=N*N lattice points, (where N=100).
* Lattice point n is located on row n/N (integer division) and column n%N.
*
* Variable details:
* cell_cycle_phase[n] = 0 (no cell), 1 (G1), 2 (S), 3(G2/M), 4(G0), 5 (S-D),
* 6 (G1-IR), 7 (S-IR), 8 (G2/M-IR), 9 (G0-IR), 10 (S-D-IR)
*
*************/



#ifndef H_ALLOCATE_DEALLOCATE
#define H_ALLOCATE_DEALLOCATE

int *cell_cycle_phase, *cell_cycle_clock, *cell_cycle_length,  *cell_lives_here, *scheduled_lattice_removal;
double *oxygen, *oxygen_scaled, *drug;

void Allocate();
void Deallocate();

/** Allocate memory for data arrays */
void Allocate()
{
    cell_cycle_phase = (int*)malloc(NN*sizeof(int*));
    cell_cycle_clock = (int*)malloc(NN*sizeof(int*));
    cell_cycle_length = (int*)malloc(NN*sizeof(int*));
    cell_lives_here = (int*)malloc(NN*sizeof(int*));
    oxygen = (double*)malloc(NN*sizeof(double*));
    oxygen_scaled = (double*)malloc(NN*sizeof(double*));
    drug = (double*)malloc(NN*sizeof(double*));
    scheduled_lattice_removal = (int*)malloc(NN*sizeof(int*));
}

/** Deallocate memory for data arrays */
void Deallocate()
{
    free(cell_cycle_phase);
    free(cell_cycle_clock);
    free(cell_cycle_length);
    free(cell_lives_here);
    free(oxygen);
    free(oxygen_scaled);
    free(drug);
    free(scheduled_lattice_removal);
}

#endif
