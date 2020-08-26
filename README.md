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

This will convert your Bruker data to nifti files. In the generated folder, find a folder containing DWI data. This is the heaviest normally and it contains zipped DWI data in nifti format and b values and b vectors in text files. Make sure to unzip zipped DWI data. Another pain is that you have to create the mask of the brain for NODDI pipeline. I did that using [ITK-Snap software](http://www.itksnap.org/pmwiki/pmwiki.php). This is pretty cool software, since you can do it quickly owing to its ability to interpolate manually drawn segments. Once you have segmented the whole brain, save your segmentation as both nifti and hdr files. 

Now, you are supposed to be ready to feed your data!

## Creating Matlab Structure

I have added here create_struct.m file, which allows you to create the structure of data including mainly paths and names of files. Before running it from matlab command, you have to change the variables inside of it. I added comments by giving definitions to the variables. Make sure to modify it in compliance with your data. This script creates structure called patient. 

## Running NODDI

Finally, you are ready to launch NODDI. First, make sure that you are in your data folder (in Matlab environment). If you have less than 20 cores on your PC, you are better to change 20 in this line in estimate_noddi.m file to the number of cores of your machine:

`batch_fitting(roi,'wholebrain.mat', protocol, noddi, 'FittedParams.mat', 20);
` 

From the command line of Matlab, run the following function with patient data.

`estimate_noddi(patient)` 

Now, it should start running. It will take some hours depending on how many cores you have. For me with 20 cores, it took about 6-8 hours.

Good Luck!

