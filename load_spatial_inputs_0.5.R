load_spatial_inputs_0.5 = function(wd) 
{

  cat('Downloading zip from github repository')
  download.file(url = "https://github.com/SHoeks/MadingleyR_0.5degree_inputs/archive/master.zip", destfile = "0.5degree.zip"); 
  cat('Extracting zip')
  unzip(zipfile = "0.5degree.zip")
  cat('Reading rasters')
  rasters_path = paste0(wd,"/MadingleyR_0.5degree_inputs-master")
  
  if (!"rgdal" %in% installed.packages()[, "Package"]) {
    stop("Package 'rgdal' not installed")
  }
  else {
    require(rgdal)
  }
  if (!"raster" %in% installed.packages()[, "Package"]) {
    stop("Package 'raster' not installed")
  }
  else {
    require(raster)
  }
  input = list()

  spatial_path = paste0(rasters_path)
  file_names = list.files(spatial_path, full.names = T, recursive = T)
  list_names = gsub("\\..*", "", list.files(spatial_path, full.names = F, recursive = T))
  FILES_sp = c("realm_classification", "land_mask", "hanpp", 
               "available_water_capacity") #, "Ecto_max", "Endo_C_max", "Endo_H_max", "Endo_O_max")
  FILES_sp_temp = c("terrestrial_net_primary_productivity", 
                    "near-surface_temperature", "precipitation", "ground_frost_frequency", 
                    "diurnal_temperature_range")
  for (i in FILES_sp) {
    if (length(grep(i, file_names, value = T)) != 1) {
      stop("Could not find raster: ", i, ".tif \n")
    }
  }
  for (i in FILES_sp_temp) {
    if (length(grep(i, file_names, value = T)) != 12) {
      stop("Could not find raster all 12 monthly rasters containing data on: ", 
           i, "\n")
    }
  }
  cat("Reading default input rasters from: ", spatial_path)
  for (i in FILES_sp) {
    file_name = grep(i, file_names, value = T)
    cat(".")
    input[[i]] = raster(file_name)
  }
  for (i in FILES_sp_temp) {
    file_name = grep(i, file_names, value = T)
    if (length(grep("_1.tif", file_name, value = T)) == 
        0) {
      file_name_sort = file_name
    }
    else {
      if (substr(spatial_path, nchar(spatial_path), 
                 nchar(spatial_path)) == "/") {
        file_name_sort = paste0(spatial_path, i, "_", 
                                1:12)
      }
      else {
        file_name_sort = paste0(spatial_path, "/", 
                                i, "_", 1:12, ".tif")
      }
    }
    if (length(file_name_sort) == 12) {
      input[[i]] = brick(lapply(file_name_sort, raster))
    }
    cat(".")
  }
  cat("\n")
  return(input)

}
