# NODDI-pipeline
## Setting up NODDI on your PC
This pipeline is implemented on the basis of the following [tutorial](http://mig.cs.ucl.ac.uk/index.php?n=Tutorial.NODDImatlab).
For that you need to have Matlab with optimization toolbox and cloned current directory:

`git clone git@github.com:aidanamv/NODDI-pipeline.git` 

Once you set up everything, you can start preparing your data. 

## Data Preparation
First of all, you have to convert your bruker data to nifti. For that you can use [library](https://github.com/SebastianoF/bruker2nifti), which is based on python. 

`python bruker2nifti.py` 
