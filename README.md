# Fetal-Heart-Rate-Detection
This repository contains Matlab and R programming codes that reproduce results for the paper titled "A new algorithm for fetal heart rate detection: Fractional order calculus approach" authored by Ilija Tanasković (ORCiD: [0000-0002-6488-4074](https://orcid.org/0000-0002-6488-4074)) and Nadica Miljković (ORCiD: [0000-0002-3933-6076](https://orcid.org/0000-0002-3933-6076)).

## GitHub Repository Contents
This repository contains the MATLAB and R software and data used in our research paper "A new algorithm for fetal heart rate detection: Fractional order calculus approach". We propose the novel modified Pan-Tompkins algorithm for detection of fetal QRS complexes.

### Code
This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program. If not, see [https://www.gnu.org/licenses/](https://www.gnu.org/licenses/).

Please, report any bugs to the Authors listed in the Contacts.

The repository contains the following code:
1) [SNR_time_domain.m](https://github.com/NadicaSm/Fetal-Heart-Rate-Detection/blob/main/SNR_time_domain.m) - Matlab software code that estimates signal to noise ratio (SNR) in time domain
2) [xSQI_calc.m](https://github.com/NadicaSm/Fetal-Heart-Rate-Detection/blob/main/xSQI_calc.m) - Matlab software code that estimates extravagance of fetal QRS peak (parameter used for signal quality assessment)
3) [optimal segment selection.m](https://github.com/NadicaSm/Fetal-Heart-Rate-Detection/blob/main/optimal%20segment%20selection.m) - Matlab software code that selects optimal segments based on defined criteria for signal quality assessment
4) [fQRS detection.m](https://github.com/NadicaSm/Fetal-Heart-Rate-Detection/blob/main/fQRS%20detection.m) - Matlab software code that lods optimal segments from [optimal segment selection.m](https://github.com/NadicaSm/Fetal-Heart-Rate-Detection/blob/main/optimal%20segment%20selection.m) function and applies new proposed modified Pan-Tompkins algorithm (mPT) on data
5) [statistical analysis.R](https://github.com/NadicaSm/Fetal-Heart-Rate-Detection/blob/main/statistical%20analysis.R) - R programming code that performs statistical tests on signal quality parameters to statistically compare parameters before and after maternal QRS cancellation. This code should be used with data provided in [signal quality parameters for statistical test.csv](https://github.com/NadicaSm/Fetal-Heart-Rate-Detection/blob/main/signal%20quality%20parameters%20for%20statistical%20test.csv).

### Data
1) [signal quality parameters for statistical test.csv](https://github.com/NadicaSm/Fetal-Heart-Rate-Detection/blob/main/signal%20quality%20parameters%20for%20statistical%20test.csv) - table with signal quality parameters before and after maternal QRS cancellation<br>
    1.1. snr_pre is signal to noise ratio calculated using [SNR_time_domain.m](https://github.com/NadicaSm/Fetal-Heart-Rate-Detection/blob/main/SNR_time_domain.m) before maternal QRS cancellation.<br>
    1.2. snr_post is signal to noise ratio calculated using [SNR_time_domain.m](https://github.com/NadicaSm/Fetal-Heart-Rate-Detection/blob/main/SNR_time_domain.m) after maternal QRS cancellation.<br>
    1.3. xSQI_pre is extravagane of fetal QRS complex calculated using [xSQI_calc.m](https://github.com/NadicaSm/Fetal-Heart-Rate-Detection/blob/main/xSQI_calc.m) - Matlab software code that estimates extravagance of fetal QRS peak (parameter used for signal quality assessment) before maternal QRS cancellation.<br>
    1.4. xSQI_post is extravagane of fetal QRS complex calculated using [xSQI_calc.m](https://github.com/NadicaSm/Fetal-Heart-Rate-Detection/blob/main/xSQI_calc.m) - Matlab software code that estimates extravagance of fetal QRS peak (parameter used for signal quality assessment) after maternal QRS cancellation.<br>
    1.5. fQRS_to_mQRS_pre is the mean amplitude ratio between fetal QRS complexes and maternal QRS complexes before mQRS cancellation.<br>
    1.6. fQRS_to_mQRS_post is the mean amplitude ratio between fetal QRS complexes and maternal QRS complexes after mQRS cancellation.<br>
2) [maternal QRS annotations](https://github.com/NadicaSm/Fetal-Heart-Rate-Detection/tree/main/maternal%20QRS%20annotations) - folder with .csv tables with annotations of maternal QRS complexes performed on signals saved in files a01, a02, ..., a25 from the initial Set A from [PhysioNet](https://physionet.org/) database "Noninvasive Fetal ECG: The PhysioNet/Computing in Cardiology Challenge 2013" ([CinC](https://physionet.org/content/challenge-2013/1.0.0/)). The annotations are saved in form of samples with sampling frequency 1000 Hz. References for this database are:<br>
    2.1. Goldberger, A. L., Amaral, L. A., Glass, L., Hausdorff, J. M., Ivanov, P. C., Mark, R. G., ... & Stanley, H. E. (2000). PhysioBank, PhysioToolkit, and PhysioNet: components of a new research resource for complex physiologic signals. circulation, 101(23), e215-e220. [https://doi.org/10.1161/01.CIR.101.23.e215](https://doi.org/10.1161/01.CIR.101.23.e215)<br>
    2.2. Silva, I., Behar, J., Sameni, R., Zhu, T., Oster, J., Clifford, G. D., & Moody, G. B. (2013, September). Noninvasive fetal ECG: the PhysioNet/computing in cardiology challenge 2013. In Computing in cardiology 2013 (pp. 149-152). IEEE.

## Contacts
Ilija Tanasković ([ilijatanaskovic97@hotmail.com](mailto:ilijatanaskovic97@hotmail.com)) or Nadica Miljković (e-mail: [nadica.miljkovic@etf.bg.ac.rs](mailto:nadica.miljkovic@etf.bg.ac.rs)).

## Funding
Nadica Miljković acknowledges the support from Grant No. 451-03-47/2023-01/200103 funded by the Ministry of Science,Technological Development and Innovation of the Republic of Serbia.

## How to cite this repository?
If you find provided code and signals useful for your own research and teaching class, please cite the following references:
1) 
