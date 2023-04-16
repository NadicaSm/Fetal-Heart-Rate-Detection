close all; clear all; clc;

fs = 1000; % sampling frequency
opt_F1 = zeros(1,25);
opt_FO = -ones(1,25);
opt_MA = -ones(1,25);

res = zeros(25,10);

val_SNR = load('val_SNR.mat');
val_SNR = val_SNR.val_SNR;

handpicked = load('handpicked.mat');
handpicked = handpicked.handpicked;

val_xSQI = load('val_xSQI.mat');
val_xSQI = val_xSQI.val_xSQI;

val_fQRS_to_mQRS = load('val_fQRS_to_mQRS.mat');
val_fQRS_to_mQRS = val_fQRS_to_mQRS.val_fQRS_to_mQRS;

nm_num = 1;
for nm = 1:25

if(nm < 10)
    name = ['a0',num2str(nm)]
else
    name = ['a',num2str(nm)]
end

% Here different options can be chosen: val_xSQI, 
% val_SNR, val_fQRS_to_mQRS, or handpicked.
% The code currently performs for val_xSQI.
calc = val_xSQI;
limit1 = calc(1,nm)*fs+1;
limit2 = limit1 + 9999;

% for the following code a string path should be
% chosen as directory on a local computer
ch = calc(2, nm);
loc = [path, name, '.csv'];
data = readmatrix(loc);

annot = load([path, name, '.fqrs.txt']);
annot = annot(annot > limit1);
annot = annot(annot < limit2);
annot1 = annot - (limit1 - 1);
data = data(limit1:limit2, :);
t = data(:, 1);
fQRS_to_mQRS = [];
t = t - (limit1 - 1)/fs;

data1 = data(:, ch + 1);
data1(isnan(data1)) = 0;

%% fQRS Borders

borders = border(annot1, 25, length(data1));

%% mQRS Borders

mQRS_annot = load([path, name, '_ch1.mat']);
mQRS = mQRS_annot.locs1;
mQRS = mQRS(mQRS > limit1);
mQRS = mQRS(mQRS < limit2);
mQRS = mQRS - (limit1 - 1);
mQRS_border = border(mQRS, 40, length(data1));
data = data1.*not(mQRS_border);

%% Preprocessing 

[b1,a1] = iirnotch(50/fs, 50/fs/35);
data_filt = filtfilt(b1, a1, data);
[b,a] = butter(3, 3/(fs/2), 'low');

baseline = filtfilt(b, a, data_filt);
data = data_filt - baseline;
data1 = data;

clear baseline;

%% 2nd filtering

[b4,a4] = butter(2, 20/(fs/2), 'high');
[b5,a5] = butter(2, 50/(fs/2), 'low');

data1 = filtfilt(b5, a5, filtfilt(b4, a4, data1));

%% Fractional derivative 

for alpha = 0:0.1:3.0
% For the analysis presented in the paper, we used copyrighted gldiff function:
% Tomas Skovranek (2023). FracApp: numerical differ-integrals of fractional order 
% (https://www.mathworks.com/matlabcentral/fileexchange/73815-fracapp-numerical-differ-integrals-of-fractional-order)
% MATLAB Central File Exchange. Retrieved April 13, 2023. 
% For the realization of this code, any other function could be used (we placed fracdif() function to
% emphasize this and to be able to share it under GNU GPL-3.0 license)
    data_filt1 = fracdif(data1, t, alpha)';

    %% Square
    
    data_kv = data_filt1.^2;

    %% MA filter
        
    for width = 10:10:100      
        data_filt = movmean(data_kv, width);
        data_filt(data_filt < mean(data_filt)) = 0; % data1 or data_filt
       
        [pks1,locs1] = findpeaks(data_filt, 'MinPeakDistance', 325); 

        locs = zeros(length(data), 1);

        locs(locs1) = 1;
            
        TP = sum(locs.*borders);
        res1 = locs - locs.*borders;
        FP = sum(locs) - TP;
        if(length(annot) - sum(locs) > 0)
            FN = length(annot) - sum(locs);
        else
            FN = 0;
        end
        
        FN;
        Se = TP/(TP + FN);
        pP = TP/(TP + FP);
        FD = (FP + FN)/(FP + FN + TP);
        F1 = 2*TP/(2*TP + FN + FP);
        
        if opt_F1(1, nm) < F1
            opt_F1(1, nm) = F1;
            opt_FO(1, nm) = alpha;
            opt_MA(1, nm) = width;
            res(nm, 1) = TP;
            res(nm, 2) = FN;
            res(nm, 3) = FP;
            res(nm, 4) = FD;
            res(nm, 5) = Se;
            res(nm, 6) = pP;
            res(nm, 7) = TP/(TP + FN + FP);
            res(nm, 8) = length(locs1)*6;
            res(nm, 9) = length(annot)*6;
            res(nm, 10) = abs(length(annot) - length(locs1))/length(annot)*100;  
        end
    end
end
end

% save('variables_handpicked.mat','opt_F1','opt_FO','opt_MA','res');
