/******************************************************************************

                            Online C Compiler.
                Code, Compile, Run and Debug C program online.
Write your code in this editor and press "Run" button to compile and execute it.

*******************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include<stdint.h>


void fastDCT4(int * x, int * y);
void fastDCT8(int *x, int * y);

int main ()
{
    
    FILE *fp_out;
    fp_out = fopen( "stimV2.txt", "w" );

    FILE *intermediate;
    intermediate = fopen( "stimV2_intermediate.txt", "w" );
    
    fprintf(fp_out,"//");

    for (int i=0;i<64;i++)
    {
        fprintf(fp_out,"X%d ",i);
    }
    for (int i=0;i<64;i++)
    {
        fprintf(fp_out,"Y%d ",i);
    }

    fprintf(fp_out,"\n");

    srand(time(NULL));   // Initialization, should only be called once.

    for( int numTests=0; numTests<100;numTests++)
    { 
    
        //calculating max and min values
        int m = 8;
        int n = 0;
        int minVal = -(1<<(m+n));
        int maxVal = ( (1<<m)-(1>>n) ) << n;//-1>>n)<<n;
        
        int x[8][8];
        int y[8][8];
        int temp[8][8];

        //randomizing each element of input signal X
        for(int i=0; i<8;i++)
        {
            for(int j=0; j<8;j++)
            {
                x[i][j] = (rand()%(maxVal-minVal))+minVal;      // Returns a pseudo-random integer between max and min.
            }
        }

        int rowX[8];
        int rowY[8];
    
        for(int i = 0; i<8; i++)
        {
            for(int j=0;j<8;j++)
            {
                rowX[j] = x[i][j];
            }
            fastDCT8(rowX,rowY);
            for(int j=0;j<8;j++)
            {
                temp[i][j] = rowY[j];
            }
        }

        //printing intermediate values
        for(int i = 0; i<8; i++)
        {
            for(int j=0;j<8;j++)
            {
                fprintf(intermediate,"%d ",temp[i][j]);
            }
            fprintf(intermediate,"\n");
        }

        int columnX[8];
        int columnY[8];

        for(int i = 0; i<8; i++)
        {
            for(int j=0;j<8;j++)
            {
                columnX[j] = temp[j][i];
            }
            fastDCT8(columnX,columnY);
            for(int j=0;j<8;j++)
            {
                y[j][i] = columnY[j];
            }
        }

        //printing X values
        for(int i = 0; i<8; i++)
        {
            for(int j=0;j<8;j++)
            {
                fprintf(fp_out,"%d ",x[i][j]);
            }
        }
        
        //printing Y values
        for(int i = 0; i<8; i++)
        {
            for(int j=0;j<8;j++)
            {
                fprintf(fp_out,"%d ",y[i][j]);
            }
        }
        fprintf(fp_out,"\n");
    }

  return 0;
}


void fastDCT4(int * x, int * y)
{
  int a[2];
  int b[2];
  int t36[2];
  int t83[2];

  a[0] = x[0] + x[3];
  a[1] = x[1] + x[2];

  b[0] = x[0] - x[3];
  b[1] = x[1] - x[2];

  t36[0] = (((b[0] << 3) + b[0]) << 1) << 1;
  t83[0] = (((b[0] << 3) + b[0]) << 1) + b[0] + (b[0] << 6);

  t36[1] = (((b[1] << 3) + b[1]) << 1) << 1;
  t83[1] = (((b[1] << 3) + b[1]) << 1) + b[1] + (b[1] << 6);

  y[0] = (a[0]   + a[1]) << 6;
  y[1] =  t83[0] + t36[1];
  y[2] = (a[0]   - a[1]) << 6;
  y[3] =  t36[0] - t83[1];
}

void fastDCT8(int *x, int * y)
{
  int a[4];
  int b[4];
  int t18[4];
  int t50[4];
  int t75[4];
  int t89[4];
  int DCT4_OUTPUT[4];

  a[0] = x[0] + (x[7]);
  a[1] = x[1] + (x[6]);
  a[2] = (x[2]) + (x[5]);
  a[3] = (x[3]) + (x[4]);

  b[0] = (x[0]) - (x[7]);
  b[1] = (x[1]) - (x[6]);
  b[2] = (x[2]) - (x[5]);
  b[3] = (x[3]) - (x[4]);

  t18[0] = (((b[0]) << 3) + (b[0])) << 1;
  t50[0] = (((b[0]) << 4) + ((t18[0]) >> 1)) << 1;
  t75[0] = (t50[0]) + ((t50[0]) >> 1);
  t89[0] = (((b[0]) << 6) + ((t50[0]) >> 1));

  t18[1] = (((b[1]) << 3) + (b[1])) << 1;
  t50[1] = (((b[1]) << 4) + ((t18[1]) >> 1)) << 1;
  t75[1] = (t50[1]) + ((t50[1]) >> 1);
  t89[1] = (((b[1]) << 6) + ((t50[1]) >> 1));

  t18[2] = (((b[2]) << 3) + (b[2])) << 1;
  t50[2] = (((b[2]) << 4) + ((t18[2]) >> 1)) << 1;
  t75[2] = (t50[2]) + ((t50[2]) >> 1);
  t89[2] = (((b[2]) << 6) + ((t50[2]) >> 1));

  t18[3] = (((b[3]) << 3) + (b[3])) << 1;
  t50[3] = (((b[3]) << 4) + ((t18[3]) >> 1)) << 1;
  t75[3] = (t50[3]) + ((t50[3]) >> 1);
  t89[3] = (((b[3]) << 6) + ((t50[3]) >> 1));

  fastDCT4(a, DCT4_OUTPUT);

  y[0] = DCT4_OUTPUT[0];
  y[1] = ((t89[0]) + (t75[1]) + (t50[2]) + (t18[3]));
  y[2] = DCT4_OUTPUT[1];
  y[3] = ((t75[0]) - (t18[1]) - (t89[2]) - (t50[3]));
  y[4] = DCT4_OUTPUT[2];
  y[5] = ((t50[0]) - (t89[1]) + (t18[2]) + (t75[3]));
  y[6] = DCT4_OUTPUT[3];
  y[7] = ((t18[0]) - (t50[1]) + (t75[2]) - (t89[3]));  
}