#include "convolution.h"

void convolution::do_sliding_window()
 {
/************************************************************
 *  start of do_sliding_window function
 * *********************************************************/
    if(in_ready.read() == SC_LOGIC_1)
    {
        

            /* read the kernel data from the input file */
            ifstream kernelFile("kernel.txt");
                for(int i=0; i<3; i++)
                {
                    for(int j=0; j<3; j++)
                    {
                        kernelFile >> kernel[i][j];
                    }
                }
            kernelFile.close();

            /* read the pixel data from input file */
            ifstream inputFile("input.txt");
                for (int i=0; i<6; i++)
                {
                    for (int j=0; j<6; j++)
                    {
                        inputFile >> input[i][j];
                    }
                }
            inputFile.close();

            

            /* perform the sliding operation and send the data as a packet */
        for (int i = 0; i < 6; i++)
            {
            int n = i;
            int m = i + 3;
                for (int j = 0; j < 6; j++)
                {
                    int w = j;
                    int v = j + 3;
                if(start.read() == SC_LOGIC_1)
                  {
                    if (n < m && j < v)
                    {
                        sc_uint<36> data1; 
                        sc_biguint<72> data2; 
                        int f = n;

                        if (m <= 6 && v <= 6)
                        {
                        /* start kernel data is sent first */
                        for(int k=0; k<3; k++)  
                                {
                                for(int l=0; l<3; l++)
                                    {
                                        data1 = (data1 << 4) | (kernel[k][l]);       
                                    }
                                }
                        /* end kernel data */

                        /* start pixel data is sent next */
                        for(int k=f; k<m; k++)    
                            {
                            for(int l=w; l<v; l++)
                                    {
                                        data2 = (data2 << 8) | (input[k][l]);
                                    }
                            }
                        /* end pixel data */

                        }else
                            {
                                break;
                            }
                    /* start to send data */
                    sc_biguint<108> dataout1; 
                        dataout1 = (data1,data2); // 36 bit kernel data and 72 bit pixel data is appended to the 108 bit dataout1 variable
                    out_valid.write(SC_LOGIC_1);
                    dataOut.write(dataout1);
                    /* end to send data */
                
                    }else
                        {
                            break;
                        }
                  }
                out_ready.write(SC_LOGIC_1);
                }
            }
        
    } 
/************************************************************
 *  end of do_sliding_window function
 * *********************************************************/
    
/*****************************************************
 *  start reading data from output memory and writing to output file 
 * ***********************************************************/
    if (in_valid.read() == SC_LOGIC_1)
    {
        if(done.read() == SC_LOGIC_1)
            {
                ofstream outputFile("output.txt");
                    for(int i=0; i<6; i++)
                        {
                            for(int j=0; j<6; j++)
                                {
                                    outputFile << dataIn.read() << " ";
                                }
                            outputFile << endl;
                        }
                outputFile.close();
            }
    }
/************************************************************
 *  end of reading data from output memory and writing to output file 
 * *********************************************************/
}


