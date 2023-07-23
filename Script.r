reqPkg = c("data.table", "Matrix", "hdf5r", "reticulate", "ggplot2", 
           "gridExtra", "glue", "readr", "RColorBrewer", "R.utils", "Seurat", "languageserver", "httpgd", "radian")
newPkg = reqPkg[!(reqPkg %in% installed.packages()[,"Package"])]
if(length(newPkg)){install.packages(newPkg)}


reqPkg = c("shiny", "shinyhelper", "data.table", "Matrix", "DT", "hdf5r", 
           "reticulate", "ggplot2", "gridExtra", "magrittr", "ggdendro", "devtools") 
newPkg = reqPkg[!(reqPkg %in% installed.packages()[,"Package"])]
if(length(newPkg)){install.packages(newPkg)}
install.packages('rsconnect')
library(rsconnect)
    rsconnect::deployApp('shinyApp')
devtools::install_github("SGDDNB/ShinyCell")
devtools::install_github('satijalab/seurat-data')
library(SeuratData)
InstallData("pbmc3k")
data("pbmc3k")
pbmc3k
library(Seurat)
library(ShinyCell)
all.genes <- rownames(pbmc3k)
pbmc3k <- ScaleData(pbmc3k, features = all.genes)
pbmc3k <- FindVariableFeatures(object = pbmc3k)
pbmc3k <- RunPCA(pbmc3k, features = VariableFeatures(object = pbmc3k) )
pbmc3k <- RunUMAP(pbmc3k, dims = 1:10)

scConf = createConfig(pbmc3k)
makeShinyApp(pbmc3k, scConf, gene.mapping = TRUE,
             shiny.title = "ShinyCell Quick Start") 
