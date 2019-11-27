%% adding toolboxes
addpath(genpath('/BigHDD/Aidana/NODDI_pipeline/NODDI_toolbox_v1.01'));
addpath(genpath('/BigHDD/Aidana/NODDI_pipeline/niftimatlib-1.2'));
%% converting the raw DWI volume into the required format
CreateROI('my_study_2_11.nii', 'roi.nii', 'NODDI_roi.mat');

%% converting the FSL bval/bvec files into the required format
protocol = FSL2Protocol('my_study_2_11_DwEffBval.txt', 'my_study_2_11_DwGradVec.txt');

%% create NODDI model structure 
noddi = MakeModel('WatsonSHStickTortIsoV_B0');
%% run the NODDI fitting
batch_fitting('NODDI_roi.mat', protocol, noddi, 'FittedParams.mat', 2);
SaveParamsAsNIfTI('FittedParams.mat', 'NODDI_roi.mat', 'brain_mask.hdr', 'workbitch')
