library(MadingleyR)

# download and load 0.5 degree inputs
source("https://raw.githubusercontent.com/SHoeks/MadingleyR_0.5degree_inputs/master/DownloadLoadHalfDegreeInputs.R")
envDIR = "/Users/osx/Desktop/dir"
sp_inputs = DownloadLoadHalfDegreeInputs(envDIR) # downloads and loads the 0.5 degree inputs from the zip in the wd

# load other default params
chrt_def = madingley_inputs("cohort definition")
stck_def = madingley_inputs("stock definition")
mdl_prms = madingley_inputs("model parameters") # useful later for running the model

# spatial model domain = c(min_long, max_long, min_lat, max_lat)
spatial_window = c(31, 35, -5, -1)

# initialise model the model using the pre-loaded inputs
mdata = madingley_init(spatial_window = spatial_window,
                       cohort_def = chrt_def,
                       stock_def = stck_def,
                       spatial_inputs = sp_inputs,
                       max_cohort = 100)
