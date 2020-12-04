clc
close all;

%setting constant values ...
m = 8;
n = 0;
minVal = -2^m;
maxVal = 2^m-2^-n;


%opening file to be written to
fileID = fopen('stimTest_forJoshOnly.txt','w');
 
%Adding heading Of Table
    fprintf(fileID,'//\t');

    for i=0:63
        fprintf(fileID,'X%d ',i);
    end
    for i=0:63
        fprintf(fileID,'Y%d ',i);
    end
    fprintf(fileID,'\n');

 for j=1:1000
    %writing X values
        X = round( minVal + (maxVal-minVal)*rand(8,8) );
        for i=0:63
            xVal = floor(i/8)+1;
            yVal = mod(i,8)+1;
            fprintf(fileID,'%s ', dec2hex( X(xVal,yVal)*2^n,3) );
        end

    %writing Y values
        Y = round( dct(X) );
        
        
        %printing Y values in document
        for i=0:63
            xVal = floor(i/8)+1;
            yVal = mod(i,8)+1;
            %saturating
            if( Y(xVal,yVal) > maxVal)
                Y(xVal,yVal) = maxVal;
            end
            if( Y(xVal,yVal) < minVal)
                Y(xVal,yVal) = minVal;
            end
            fprintf(fileID,'%s ', dec2hex( Y(xVal,yVal)*2^n,3 ) );
        end        
    %printing new line for next x and y 
    fprintf(fileID,'\n');
 end
 
%closing file to be written to
fclose(fileID);
