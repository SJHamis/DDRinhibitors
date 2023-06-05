/*********************************************************
 *
 * Initiate the in silico setup.
 *
 *********************************************************/

#ifndef H_LATTICE_SETUP
#define H_LATTICE_SETUP

void InitCells();

void InitCells()
{
  int midcell = N*N/2+N/2; //mid row, mid col
  PlaceNewCell(midcell);
}


#endif
