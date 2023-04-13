function snr = SNR_time_domain(data1,annot1,window)
    % Code for caluclating SNR of desired window around annot
    % vs less desired part 
    
    borders = border(annot1,window,length(data1));

    %% SNR estimate
    ref = ones(length(data1),1);
    fQRS_pow = data1.*borders;
    fQRS_pow = rms(fQRS_pow(fQRS_pow~=0));

    noise = ref - borders;
    noise(noise < 0) = 0;
    noise_pow = data1.*noise;
    noise_pow = rms(noise_pow(noise_pow~=0));
    
    snr = 10*log10(fQRS_pow.^2./noise_pow.^2);

end
