clc
close all;

%setting constant values ...
m = 8;
n = 0;
minVal = -2^m;
maxVal = 2^m-2^-n;


%opening file to be written to
fileID = fopen('temp.txt','w');

    for i=0:63
        %fprintf(fileID,'stim_IN_X[%d],\n',i);
        fprintf(fileID,'y[%d] <= x[%d];\n',i,i);
        %fprintf(fileID,'%%d ');
    end
    for i=0:63
        %fprintf(fileID,'gold_OUT_Y[%d],\n ',i);
        %fprintf(fileID,'%%d ');
    end
    fprintf(fileID,'\n');

 
%closing file to be written to
fclose(fileID);
