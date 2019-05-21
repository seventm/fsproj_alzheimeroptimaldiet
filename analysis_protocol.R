# load packages
library(fsProjAlzOptimalDiet)
########
#Global optimization procedure (Flow chart 2)
########
# load data from fsProjAlzOptimalDiet)
data(usda_nutrients)

# prepare data shifts
shifts <- prepareShifts(0:20)
# data(shifts) # precalculated shifts for 0:20

period_1 <- makeCalculations(x = usda_nutrients, period = 1, shifts = shifts, cores = 6)
period_2 <- makeCalculations(x = usda_nutrients, period = 2, shifts = shifts, cores = 6)
period_3 <- makeCalculations(x = usda_nutrients, period = 3, shifts = shifts, cores = 6)
period_4 <- makeCalculations(x = usda_nutrients, period = 4, shifts = shifts, cores = 6)

# save results
saveRDS(period_1, 'results_period_1.rds')
saveRDS(period_2, 'results_period_2.rds')
saveRDS(period_3, 'results_period_3.rds')
saveRDS(period_4, 'results_period_4.rds')
########
#Procedure of calculation of optimal diet in regard to macronutrients proportions(Flow chart 3)
########
# calculate model params
# Param config
# carbs - from 300 to 600 by 5
# prot  - from  50 to 250 by 5
# satu  - from  10 to  80 by 2
# mono  - from  10 to  80 by 2
# poly  - from   2 to  50 by 2
data(params_conf)
params <- generateParams(params_conf)
# data(params) # precalculated params
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


saveRDS(model.period.1, 'model_period_1.rds')
saveRDS(model.period.2, 'model_period_2.rds')
saveRDS(model.period.3, 'model_period_3.rds')
saveRDS(model.period.4, 'model_period_4.rds')
