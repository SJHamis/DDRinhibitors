/*********************************************************
 *
 *  Create output. Scalar data (text/csv files) and cell/field maps (vtk).
 *
 *********************************************************/

#ifndef H_GENERATE_OUTPUT
#define H_GENERATE_OUTPUT
using namespace std;

/** Functions */
void CreateOutputCellMaps(int n_caption); //vtk file for cells
void CreateOutputScalarFieldMaps(int n_caption); //vtk file for fields (oxygen/drug)
                                  
void CreateOutputScalarFieldMaps2(int n_caption); //vtk file for fields (oxygen/drug)   
//void CreateOutputScalarData(int t); //plain text files with scalar-over-time type data (cellcount etc)
void CreateOutputScalarData(int t, int prob_Damaged_S_in, int T_in_Sd_in, int hc_in, int EC50_in, int T_Death_Delay_in, int mu_in, int sigma_in, int drug_dose );

void CreateOutputScalarData_LHC(int t, int prob_Damaged_S_in, int T_in_Sd_in, int hc_in, int EC50_in, int T_Death_Delay_in, int mu_in, int sigma_in, int drug_dose, int LHC_sample );

//FILE *scalardata;
//FILE *scalardata;

void CreateOutputCellMaps(int n_caption)
{
  char fullname[256]="invivo_cellmap_3_"; //Choose file name
  sprintf(fullname, "invivo_cellmap_3_%d.vtk",n_caption); //Choose file name
  FILE *tempVTKfile;
  tempVTKfile = fopen(fullname,"w");

  /**Header, required format*/
  fprintf(tempVTKfile, "# vtk DataFile Version 2.0 \nTumourTREAT \nASCII \nDATASET POLYDATA \n");

  /**count how many cells exist */
  int nocells=0;
  for(int n = 0; n<NN; n++)
    {
      if(cell_cycle_phase[n]>0)
      {
          nocells++;
      }
    }
  
  /**Header, required format*/
  fprintf(tempVTKfile, "POINTS %d float \n", nocells);

  /**Write coordinate data*/
  int x_pos = 0;
  int y_pos = 0;
  for(int n=0; n<NN; n++)
    {
      if(cell_cycle_phase[n]>0)
	{
            x_pos=n/N;
            y_pos=n%N;
            fprintf(tempVTKfile, "%d %d %d \n",x_pos,y_pos,0);
	}
    }

  /** Header, required format*/
  fprintf(tempVTKfile, "POINT_DATA %d \nSCALARS sample_scalars float 1 \nLOOKUP_TABLE my_table \n", nocells);

  double temp=0;
  /** Write cell state data */
  for(int n=0; n<NN; n++)
    {
      if(cell_cycle_phase[n]>0)
	{
	  temp = cell_cycle_phase[n];
	  fprintf(tempVTKfile, "%lf \n", temp);
	}
    }
  fclose(tempVTKfile);
}


void CreateOutputScalarFieldMaps(int n_caption)
{
    char fullname[256]="invivo3_oxy_";//Choose file name
    sprintf(fullname, "invivo3_oxy_%d.vtk",n_caption);//Choose file name
    FILE *tempVTKfile;
    tempVTKfile = fopen(fullname,"w");
    
    /**Header, required format*/
    fprintf(tempVTKfile, "# vtk DataFile Version 2.0 \nTumourTREAT \nASCII \nDATASET POLYDATA \n");
    
    /**count how many cells exist */
    int nolatticepoints=0;

    //   int nocells=0;
    for(int n = 0; n<NN; n++)
      {
	if(cell_cycle_phase[n]>0)
	  {
	    nolatticepoints++;
	    //	    nocells++;
	  }
      }
    
    /**Header, required format*/
    fprintf(tempVTKfile, "POINTS %d float \n", nolatticepoints);
    
    /**Write coordinate data*/
    int x_pos = 0;
    int y_pos = 0;
    for(int n=0; n<NN; n++)
    {
      if(cell_cycle_phase[n]>0){
            x_pos=n/N;
            y_pos=n%N;
            fprintf(tempVTKfile, "%d %d %d \n",x_pos,y_pos,0);
      }
    }
    
    /** Header, required format*/
    fprintf(tempVTKfile, "POINT_DATA %d \nSCALARS sample_scalars float 1 \nLOOKUP_TABLE my_table \n", nolatticepoints);
    
    double temp=0;
    /** Write cell state data */
    for(int n=0; n<NN; n++)
    {
      if(cell_cycle_phase[n]>0){
            temp = oxygen_scaled[n];
            fprintf(tempVTKfile, "%lf \n", temp);
      }
    }
    fclose(tempVTKfile);
}

void CreateOutputScalarFieldMaps2(int n_caption)
{
  char fullname[256]="invivo3_drug_";//Choose file name
  sprintf(fullname, "invivo3_drug_%d.vtk",n_caption);//Choose file name
  FILE *tempVTKfile;
  tempVTKfile = fopen(fullname,"w");

  /**Header, required format*/
  fprintf(tempVTKfile, "# vtk DataFile Version 2.0 \nTumourTREAT \nASCII \nDATASET POLYDATA \n");

  /**count how many cells exist */
  // int nolatticepoints=NN;


  int nolatticepoints=0;

  //   int nocells=0;                                                                                                                                                              
  for(int n = 0; n<NN; n++)
    {
      if(cell_cycle_phase[n]>0)
	{
	  nolatticepoints++;
	  //      nocells++;                                                                                                                                                       
	}
    }



  /**Header, required format*/
  fprintf(tempVTKfile, "POINTS %d float \n", nolatticepoints);

  /**Write coordinate data*/
  int x_pos = 0;
  int y_pos = 0;
  for(int n=0; n<NN; n++)
    {
      if(cell_cycle_phase[n]>0)
        {
      x_pos=n/N;
      y_pos=n%N;
      fprintf(tempVTKfile, "%d %d %d \n",x_pos,y_pos,0);
	}
    }

  /** Header, required format*/
  fprintf(tempVTKfile, "POINT_DATA %d \nSCALARS sample_scalars float 1 \nLOOKUP_TABLE my_table \n", nolatticepoints);

  double temp=0;
  /** Write cell state data */
  for(int n=0; n<NN; n++)
    {
      if(cell_cycle_phase[n]>0)
        {
      temp = drug[n];
      fprintf(tempVTKfile, "%lf \n", temp);
	}
    }
  fclose(tempVTKfile);
}




void CreateOutputScalarData(int t, int prob_Damaged_S_in, int T_in_Sd_in, int hc_in, int EC50_in, int T_Death_Delay_in, int mu_in, int sigma_in, int drug_dose )
{
    FILE *scalardata_file;

        string filename ="sept_B" ;// /Users/sara/Desktop/DDRinhibitor/SensitivityAnalysisDataInVivo_2/invivo3_vtk_";
       //string filename ="/Users/sara/Desktop/DDRinhibitor/SensitivityAnalysisDataInVivo/cluster_4_short_invivo";
    
    
    filename+="_mu"+std::to_string(mu_in);
    filename+="_sigma"+std::to_string(sigma_in);
    filename+="_DSprob"+std::to_string(prob_Damaged_S_in);
    filename+="_DStime"+std::to_string(T_in_Sd_in);
    filename+="_EC"+std::to_string(EC50_in);
    filename+="_gamma"+std::to_string(hc_in);
    filename+="_Tdeath"+std::to_string(T_Death_Delay_in);
    filename+="_Dose"+std::to_string(drug_dose);
    
    scalardata_file=fopen(filename.c_str(),"a");
    //printf("%s \n",filename.c_str());
    
    
    double g1cells=0;
    double scells=0;
    double sdcells=0;
    double g2mcells=0;
    double terminalcells=0;
    double g0cells=0;
    double allcyclingcells=0;
    double allhealthycells = 0;
    double allhealthycells_wg0 = 0;
    double allcells=0;
    double op1=0;
    double op2=0;
    
    for(int n=0; n<NN; n++)
        {
            if(cell_lives_here[n]>0)
            {
                if(cell_cycle_phase[n]==1)
                {
                    g1cells++;
                }
                else if(cell_cycle_phase[n]==2)
                {
                    scells++;
                }
                else if(cell_cycle_phase[n]==3)
                {
                    sdcells++;
                }
                else if(cell_cycle_phase[n]==4)
                {
                    g2mcells++;
                }
                else if(cell_cycle_phase[n]==20)
                {
                    terminalcells++;
                }
                else if(cell_cycle_phase[n]==5)
                {
                    g0cells++;
                }
            }
        }
        allcyclingcells=g1cells+scells+sdcells+g2mcells+terminalcells;
        allhealthycells=g1cells+scells+sdcells+g2mcells;
        allhealthycells_wg0=g1cells+scells+sdcells+g2mcells+g0cells;
        
        allcells=g1cells+scells+sdcells+g2mcells+terminalcells+g0cells;
        
        op1= 100*(terminalcells+sdcells)/allcyclingcells;
        op2= 100*(terminalcells+sdcells)/allcells;
    
        fprintf(scalardata_file, "%d %lf %lf %lf %lf %lf %lf %lf %lf %lf %lf %lf\n",t, op1, op2, allhealthycells, allhealthycells_wg0, allcells, g1cells, scells, sdcells, g2mcells, g0cells, terminalcells);
    
    fclose(scalardata_file);
}

void CreateOutputScalarData_LHC(int t, int prob_Damaged_S_in, int T_in_Sd_in, int hc_in, int EC50_in, int T_Death_Delay_in, int mu_in, int sigma_in, int drug_dose, int LHC_sample )
{
    FILE *scalardata_file;

        //string filename ="/Users/sara/Desktop/DDRinhibitor/SensitivityAnalysisData/invitro";
       string filename ="/Users/sara/Desktop/DDRinhibitor/SensitivityAnalysisDataLHC/lhc_";
    
    
    //filename+="_mu"+std::to_string(mu_in);
    //filename+="_sigma"+std::to_string(sigma_in);
    //filename+="_DSprob"+std::to_string(prob_Damaged_S_in);
    //filename+="_DStime"+std::to_string(T_in_Sd_in);
    //filename+="_EC"+std::to_string(EC50_in);
    //filename+="_gamma"+std::to_string(hc_in);
    //filename+="_Tdeath"+std::to_string(T_Death_Delay_in);
    //filename+="_Dose"+std::to_string(drug_dose);
    filename+="_sample_"+std::to_string(LHC_sample);
    
    scalardata_file=fopen(filename.c_str(),"a");
    //printf("%s \n",filename.c_str());
    
    
    double g1cells=0;
    double scells=0;
    double sdcells=0;
    double g2mcells=0;
    double terminalcells=0;
    double g0cells=0;
    double allcyclingcells=0;
    double allhealthycells = 0;
    double allhealthycells_wg0 = 0;
    double allcells=0;
    double op1=0;
    double op2=0;
    
    for(int n=0; n<NN; n++)
        {
            if(cell_lives_here[n]>0)
            {
                if(cell_cycle_phase[n]==1)
                {
                    g1cells++;
                }
                else if(cell_cycle_phase[n]==2)
                {
                    scells++;
                }
                else if(cell_cycle_phase[n]==3)
                {
                    sdcells++;
                }
                else if(cell_cycle_phase[n]==4)
                {
                    g2mcells++;
                }
                else if(cell_cycle_phase[n]==20)
                {
                    terminalcells++;
                }
                else if(cell_cycle_phase[n]==5)
                {
                    g0cells++;
                }
            }
        }
        allcyclingcells=g1cells+scells+sdcells+g2mcells+terminalcells;
        allhealthycells=g1cells+scells+sdcells+g2mcells;
        allhealthycells_wg0=g1cells+scells+sdcells+g2mcells+g0cells;
        
        allcells=g1cells+scells+sdcells+g2mcells+terminalcells+g0cells;
        
        op1= 100*(terminalcells+sdcells)/allcyclingcells;
        op2= 100*(terminalcells+sdcells)/allcells;
    
        fprintf(scalardata_file, "%d %lf %lf %lf %lf %lf %lf %lf %lf %lf %lf %lf\n",t, op1, op2, allhealthycells, allhealthycells_wg0, allcells, g1cells, scells, sdcells, g2mcells, g0cells, terminalcells);
    
    fclose(scalardata_file);
}

#endif
