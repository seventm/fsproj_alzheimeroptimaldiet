# fsProj_AlzheimerOptimalDiet

R code for analysis performed for paper: 
&#34;Proportions of macronutrients including specific dietary fats in anti-
Alzheimer’s and pro-longevity diet&#34;  
Marcin Studnicki, Konrad J. Dębski, Dariusz Stępkowski

# Packages in repository
Packages in */packages* directory:
- **fsParams** - package to generate matrix with params combinations
- **fsProjAlzOptimalDiet** - package with code used for analysis presented in the paper

# Analysis protocol

```
# load required packages
library(fsProjAlzOptimalDiet)

# prepare data shifts
shifts <- prepareShifts(0:20)
# Precalculated shifts matrix used in paper is stored in the package and can be obtained with:
# data(shifts)

# Calculate ... for each period:
period_1 <- makeCalculations(x = usda_nutrients, period = 1, shifts = shifts, cores = 90)
period_2 <- makeCalculations(x = usda_nutrients, period = 2, shifts = shifts, cores = 90)
period_3 <- makeCalculations(x = usda_nutrients, period = 3, shifts = shifts, cores = 90)
period_4 <- makeCalculations(x = usda_nutrients, period = 4, shifts = shifts, cores = 90)

# save results
saveRDS(period_1, 'results/results_period_1.rds')
saveRDS(period_2, 'results/results_period_2.rds')
saveRDS(period_3, 'results/results_period_3.rds')
saveRDS(period_4, 'results/results_period_4.rds')

# Calculate model params matrix
# Params configuration used in analysis are stored in package:
data(params_conf)
# configuration:
# carbs - from 300 to 600 by 5
# prot  - from  50 to 250 by 5
# satu  - from  10 to  80 by 2
# mono  - from  10 to  80 by 2
# poly  - from   2 to  50 by 2
params <- generateParams(params_conf)
# Precalculated params matrix used in paper is stored in the package and can be obtained with:
data(params)

# Model values for each period used in paper are stored in the package and can be obtained with:
data(model_configuration)


```
