function xSQI = xSQI_calc(data, annot1, window1, window2)
    % Code calculates xSQI of signal by channels
    % xSQI is power ratio of surrounding of annot 
    % +/- window1 and wider surrounding +/- window2
    borders = border(annot1, window1, length(data));
    borders_mQRS = border(annot1, window2, length(data));
    
    %% xSQI calcultion

    temp1 = data.*borders;
    temp2 = data.*borders_mQRS - temp1;
    xSQI  = sum(temp1.^2)/sum(temp2.^2);

end
