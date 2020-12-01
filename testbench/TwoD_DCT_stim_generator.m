clc
clear all
close all

%setting constant values ...
m = 8;
n = 0;
minVal = -2^m;
maxVal = 2^m-2^-n;


%opening file to be written to
fileID = fopen('stimV1.txt','w');
 
%Adding heading Of Table
    fprintf(fileID,'//\t');

    for i=0:63
        fprintf(fileID,'X%d ',i);
    end
    for i=0:63
        fprintf(fileID,'Y%d ',i);
    end
    fprintf(fileID,'\n');

%writing X values
    X = zeros(8,8);
    for i=0:63
        xVal = floor(i/8)+1;
        yVal = mod(i,8)+1;
        fprintf(fileID,'%d ', X(xVal,yVal) );
    end
   
%writing Y values
    Y = dct(X);
    for i=0:63
        xVal = floor(i/8)+1;
        yVal = mod(i,8)+1;
        fprintf(fileID,'%d ', Y(xVal,yVal) );
    end

%closing file to be written to
fclose(fileID);