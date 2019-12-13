# NODDI-pipeline
## Setting up NODDI on your PC
This pipeline is implemented on the basis of the following [tutorial](http://mig.cs.ucl.ac.uk/index.php?n=Tutorial.NODDImatlab).
For that you need to have Matlab with optimization toolbox and cloned current directory:

`git clone git@github.com:aidanamv/NODDI-pipeline.git` 

Once you set up everything, you can start preparing your data. 

## Data Preparation
First of all, you have to convert your bruker data to nifti. For that you can use [library](https://github.com/SebastianoF/bruker2nifti), which is based on python. You have to change the path of the data in bruker2nifti.py file with your data path along with output file name. Once you have done that save it and run from your terminal:

`python bruker2nifti.py` 

If you are not Linux user, you can just use any python IDE or jupyter notebook.

This will convert your Bruker data to nifti files. In the generated folder, find a folder containing DWI data. This is the heaviest normally and it contains zipped DWI data in nifti format and b values and b vectors in text files. Make sure to unzip zipped DWI data. Another pain in the ass is that you have to create the mask of the brain for NODDI pipeline. I did that using [ITK-Snap software](http://www.itksnap.org/pmwiki/pmwiki.php). 
