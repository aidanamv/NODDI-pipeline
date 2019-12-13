% toolbox_path is the folder where your NODDI toolbox and niftimatlib are
% located
patient.toolbox_path='/home/ni/Documents/Aidana/NODDI_pipeline/NODDI-pipeline';
%data_dir is the directory with your DWI data
patient.data_dir='/home/ni/Documents/Aidana/NODDI_8month/transgenic/6885/6885_3';
%bval is just the name of you bval text file. Usually it goes like
%6885_3_DWEffBval.txt, where the initial numbers are varying in
%correspondence with the study number. Same applies to bvec.
patient.bval='6885_3_DwEffBval.txt';
patient.bvec='6885_3_DwGradVec.txt';
% this is the name of nifti file of DWI data. If it is zipped (.gz),then
% make sure to unzip it or gunzip it from matlab command line
patient.DWI_data='6885_3.nii';
%brain mask in nifti format, here you enter just the name of it
patient.brainmask_nii='brainmask.nii';
%same brain mask, but in hdr format. I don't know the reason why do we need
%to feed it with hdr as well here.
patient.brainmask_hdr='6885.hdr';