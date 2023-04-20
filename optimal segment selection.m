close all; clear all; clc;

% Sampling frequency
fs = 1000;

% Initializing matrices which will contaian values of xSQI 
% Dimensions of matrices are 25*4*11 where 25 stands for number of signals,
% 4 stands for number of channels inside each signal, and 11 stands for 
% number of 10 s long segments with 5 s overlapping
snr_parts = zeros(25, 4, 11);
% xSQI_parts = zeros(25, 4, 11);
% fQRS_to_mQRS = zeros(25, 4, 11);

for nm = 1:25
    
    if(nm < 10)
        name = ['a0', num2str(nm)]
    else
        name = ['a', num2str(nm)]
    end
    
    % Loading signals and mQRS annotation defined by the authors
    % path should be defined as string containing local directory
    loc = [path, name, '.csv'];
    data = readmatrix(loc);
    mQRS_annot = load([path, name, '_ch1.mat']);
    mQRS_annot1 = mQRS_annot.locs1;
    nm_limit = 1;
    
% each 10 s of signal is assessed with 5 s window overlap
    for limit1 = (1:5000:55000) 
        
        limit2 = limit1 + 9999;
        annot = load([path, name, '.fqrs.txt']);
        annot = annot(annot > limit1);
        annot = annot(annot < limit2);
        annot = annot - (limit1 - 1);

        data_cropped = data(limit1:limit2, :);
        t = data_cropped(:, 1);
        t = t - (limit1 - 1)/fs;

        data1 = data_cropped(:, 2:5);
        data1(isnan(data1)) = 0;

        %% fQRS borders
        
        % borders = border(annot1, 25, length(data1));

        %% mQRS borders
        
        mQRS = mQRS_annot1;
        mQRS = mQRS(mQRS > limit1);
        mQRS = mQRS(mQRS < limit2);
        mQRS = mQRS - (limit1 - 1);
        mQRS_border = border(mQRS, 40, length(data1(:, 1)));
        data1 = data1.*not(mQRS_border);

        %% Preprocessing 

        [b1, a1] = iirnotch(50/fs, 50/fs/35);

        data_filt = filtfilt(b1, a1, data1);

        [b, a] = butter(3, 3/(fs/2), 'low');

        baseline = filtfilt(b, a, data_filt);
        data_filt2 = data_filt - baseline;
        data1 = data_filt2;

        clear baseline;
        %% 2nd filtering

        [b4, a4] = butter(2, 20/(fs/2), 'high');
        [b5, a5] = butter(2, 50/(fs/2), 'low');

        data1 = filtfilt(b5, a5, filtfilt(b4, a4, data1));
        
        for ch = 1:4
            snr_parts(nm, ch, nm_limit) = SNR_time_domain(data1(:, ch), annot, 25);
            xSQI_parts(nm, ch, nm_limit) = xSQI_calc(data1(:, ch), annot, 25, 125);
            fQRS_to_mQRS(nm, ch, nm_limit) = mean(abs(data1(annot, ch)))/mean(abs(data1(mQRS, ch)));
        end
        nm_limit = nm_limit + 1;
    end
    nm_num = nm_num + 1;
end

%% Creating (time, channel) matrix

val_xSQI = zeros(2, 25);
val_SNR = zeros(2, 25);
val_fQRS_to_mQRS = zeros(2, 25);

for ix = 1:25
    [~,i1] = max(reshape(xSQI_parts(ix, :, :), 4, 11)');
    [~,i2] = max(max(reshape(xSQI_parts(ix, :, :), 4, 11)'));
    val_xSQI(2, ix) = i2;
    val_xSQI(1, ix) = i1(i2);
    [~, i1] = max(reshape(snr_parts(ix, :, :), 4, 11)');
    [~, i2] = max(max(reshape(snr_parts(ix, :, :), 4, 11)'));
    val_SNR(2, ix) = i2;
    val_SNR(1, ix) = i1(i2);    
    [~, i1] = max(reshape(fQRS_to_mQRS(ix, :, :), 4, 11)');
    [~, i2] = max(max(reshape(fQRS_to_mQRS(ix, :, :), 4, 11)'));
    val_fQRS_to_mQRS(2, ix) = i2;
    val_fQRS_to_mQRS(1, ix) = i1(i2); 
end

val_xSQI(1, :) = (val_xSQI(1, :) - 1)*5;
val_SNR(1, :) = (val_SNR(1, :) - 1)*5;
val_fQRS_to_mQRS(1, :) = (val_fQRS_to_mQRS(1, :) - 1)*5;

save('val_xSQI.mat', 'val_xSQI');
save('val_SNR.mat', 'val_SNR');
save('val_fQRS_to_mQRS.mat', 'val_fQRS_to_mQRS');
