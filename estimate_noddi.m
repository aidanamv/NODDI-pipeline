function[]=estimate_noddi(patient_struct)
%structure should include following parameters. You can create struct by
%modifying create_struct.m. Just update the values with the correspondence
%to your data.
%toolbox path='/home/ni/Documents/Aidana/NODDI_pipeline/NODDI-pipeline'
%data_dir='/home/ni/Documents/Aidana/NODDI_8month/transgenic/6885/6885_3'
%bval='6885_3_DwEffBval.txt'
%bvec='6885_3_DwGradVec.txt'
%DWI_data='6885_3.nii'
%brainmask_nii='brainmask.nii'
%brainmask_hdr='6885.hdr'
%% adding toolboxes
NODDI_toolbox_dir=fullfile(patient_struct.toolbox_path, 'NODDI_toolbox_v1.01');
if ~exist(NODDI_toolbox_dir, 'dir')
    error('Could not find NODDI toolbox folder.');
end
niftimatlib_dir=fullfile(patient_struct.toolbox_path, 'niftimatlib-1.2');
if ~exist(niftimatlib_dir, 'dir')
    error('Could not find niftimatlib.');
end
addpath(genpath(NODDI_toolbox_dir));
addpath(genpath(niftimatlib_dir));
disp('Toolboxes was added successfully.');

%% selecting bvec file
bvec_dir=fullfile(patient_struct.data_dir,patient_struct.bvec);
fileID_bvec=fopen(bvec_dir,'r');
formatSpec = '%f %f %f';
sizeA = [3 inf];
bvec=fscanf(fileID_bvec, formatSpec, sizeA);
fclose(fileID_bvec);
fid = fopen('bvec.txt','wt');
for ii = 1:size(bvec,1)
    fprintf(fid,'%g\t',bvec(ii,:));
    fprintf(fid,'\n' );
end
fclose(fid);
%% selecting bval file
bval_dir=fullfile(patient_struct.data_dir,patient_struct.bval);
fileID_bval=fopen(bval_dir);
formatSpec = '%f ';
sizeA = [1 inf];
bval=fscanf(fileID_bval, formatSpec, sizeA);
fclose(fileID_bval);
fid = fopen('bval.txt','wt');
for ii = 1:size(bval,1)
    fprintf(fid,'%g\t',bval(ii,:)*0.33);
    fprintf(fid,'\n');
end
fclose(fid);
%% converting the raw DWI volume into the required format
CreateROI(patient_struct.DWI_data, patient_struct.brainmask_nii, 'wholebrain.mat');
%% converting the FSL bval/bvec files into the required format
protocol = FSL2Protocol('bval.txt', 'bvec.txt');
%% create NODDI model structure 
noddi = MakeModel('WatsonSHStickTortIsoV_B0');
%% run the NODDI fitting
load wholebrain.mat;
batch_fitting(roi,'wholebrain.mat', protocol, noddi, 'FittedParams1.mat', 20);
SaveParamsAsNIfTI('FittedParams1.mat', 'wholebrain.mat', patient_struct.brainmask_hdr, 'noddi')
end
