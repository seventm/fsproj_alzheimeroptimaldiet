# fsProj_AlzheimerOptimalDiet
R code for analysis performed for paper: 

*"Proportions of macronutrients including specific dietary fats in anti-Alzheimer’s and pro-longevity diet"*

*Marcin Studnicki, Konrad J. Dębski, Dariusz Stępkowski*

# Packages in repository
Packages in */packages* directory:

- **fsParams** - package to generate matrix with params combinations
- **fsProjAlzOptimalDiet** - package with code used for analysis presented in the paper

# Analysis protocol

```
# load required packages
library(fsProjAlzOptimalDiet)
########
#Global optimization procedure (Flow chart 2)
########
# prepare data set for all five nutrients with availabilities taken with a shift from 0 to -20 years
shifts <- prepareShifts(0:20)
# Precalculated shifts matrix used in paper is stored in the package and can be obtained with:
# data(shifts)

# Calculate Roptimal for each combinations of different sets of precedence periods for one period of life.
# Model GAM used in analysis see fsProjAlzOptimalDiet/makeCalcultions.R
period_1 <- makeCalculations(x = usda_nutrients, period = 1, shifts = shifts, cores = 6)
period_2 <- makeCalculations(x = usda_nutrients, period = 2, shifts = shifts, cores = 6)
period_3 <- makeCalculations(x = usda_nutrients, period = 3, shifts = shifts, cores = 6)
period_4 <- makeCalculations(x = usda_nutrients, period = 4, shifts = shifts, cores = 6)

# save results for Roptimal and GAM model parameters
saveRDS(period_1, 'results/results_period_1.rds')
saveRDS(period_2, 'results/results_period_2.rds')
saveRDS(period_3, 'results/results_period_3.rds')
saveRDS(period_4, 'results/results_period_4.rds')
#chosen set of precedence periods based on maximum Roptimal criterion


########
#Procedure of calculation of optimal diet in regard to macronutrients proportions(Flow chart 3)
########
# Calculate model params matrix
# Params configuration used in analysis are stored in package:
# data(params_conf)
# configuration:
# carbs - from 300 to 600 by 5
# prot  - from  50 to 250 by 5
# satu  - from  10 to  80 by 2
# mono  - from  10 to  80 by 2
# poly  - from   2 to  50 by 2
params <- generateParams(params_conf)
# Precalculated params matrix used in paper is stored in the package and can be obtained with:
# data(params)

# Model values for each period used in paper are stored in the package and can be obtained with:
data(model_configuration)

model.period.1 <- calculateParams(params.matrix = params,
                                  model.conf = model_configuration$period_1,
                                  range= c(-0.1, 0))

model.period.2 <- calculateParams(params.matrix = params,
                                  model.conf = model_configuration$period_2,
                                  range= c(-0.1, 0))

model.period.3 <- calculateParams(params.matrix = params,
                                  model.conf = model_configuration$period_3,
                                  range= c(-0.1, 0))

model.period.4 <- calculateParams(params.matrix = params,
                                  model.conf = model_configuration$period_4,
                                  range= c(-0.1, 0))
								  
# save results
saveRDS(model.period.1, 'model_period_1.rds')
saveRDS(model.period.2, 'model_period_2.rds')
saveRDS(model.period.3, 'model_period_3.rds')
saveRDS(model.period.4, 'model_period_4.rds')
```

# Session info:
```
> sessionInfo()
R version 3.2.3 (2015-12-10)
Platform: x86_64-pc-linux-gnu (64-bit)
Running under: Ubuntu 16.04 LTS

locale:
 [1] LC_CTYPE=en_US.UTF-8    LC_NUMERIC=C            LC_TIME=C              
 [4] LC_COLLATE=en_US.UTF-8  LC_MONETARY=C           LC_MESSAGES=en_US.UTF-8
 [7] LC_PAPER=C              LC_NAME=C               LC_ADDRESS=C           
[10] LC_TELEPHONE=C          LC_MEASUREMENT=C        LC_IDENTIFICATION=C    

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
[1] fsProjAlzOptimalDiet_0.0.1.2 fsParams_0.0.0.1            

loaded via a namespace (and not attached):
[1] Matrix_1.2-3    snow_0.4-3      parallel_3.2.3  mgcv_1.8-27    
[5] nlme_3.1-124    grid_3.2.3      lattice_0.20-33
```

# Brief description:
Calculations were performed with R version 3.2.3 using packages snow version 0.4-3, 
mgcv version 1.8-27, nlme 3.1-124 and fsParams version 0.0.0.1 and fsProjAlzOptimalDiet version 0.0.1.2. 
Packages fsParams and fsProjAlzOptimalDiet designed by Fork Systems company for this analysis 
are available in public repository
(https://bitbucket.org/seventm/fsproj_alzheimeroptimaldiet).
Formula used for mgcv::gam() function is R~carbs+prot+satu+mono+poly.
