function [E tempprot] = RemoveNegMeas(Epn, protocol)
% Removes negative or zero measurements from a set and returns a protocol
% with the corresponding elements removed to exclude the negative
% measurements from the fitting.
%
% Epn is the full set of measurements; E is that with the negative ones
% removed.
%
% protocol is the full protocol; tempprot is that with the entries
% corresponding to negative measurements removed.
%
% author: Daniel C Alexander (d.alexander@ucl.ac.uk)
%         Gary Hui Zhang (gary.zhang@ucl.ac.uk)
%

tempprot = protocol;
E = Epn;
if(min(Epn)<=0)
    posonly = find(Epn>0);
    E = Epn(posonly);
    nonposonly = setdiff([1:size(Epn,1)], posonly);
    tempprot.totalmeas = length(posonly);
    
    if (isfield(tempprot, 'b0_Indices'))
        tempprot.b0_Indices = [];
    end
    if (isfield(tempprot, 'dti_subset'))
        tempprot.dti_subset = [];
    end
    
    for i=1:tempprot.totalmeas
        if(isfield(tempprot, 'b0_Indices'))
            if ismember(posonly(i), protocol.b0_Indices)
                tempprot.b0_Indices = [tempprot.b0_Indices i];
            end
        end
        if(isfield(tempprot, 'dti_subset'))
            if ismember(posonly(i), protocol.dti_subset)
                tempprot.dti_subset = [tempprot.dti_subset i];
            end
        end
    end
    if(isfield(tempprot, 'b0_Indices'))
        tempprot.numZeros = length(tempprot.b0_Indices);
        if length(tempprot.b0_Indices) == 0
            error('All b=0 measurements are negative');
        end
    end
    
    if tempprot.totalmeas - length(tempprot.b0_Indices) < 6
        error('Not enough DWI measurements');
    end
    
    if(isfield(tempprot, 'dti_subset'))
        if length(tempprot.dti_subset) - length(tempprot.b0_Indices) < 6
            error('Not enough DWI measurements');
        end
    end
    
    if(strcmp(tempprot.pulseseq, 'PGSE') || strcmp(tempprot.pulseseq, 'STEAM'))
        tempprot.G = tempprot.G(posonly);
        tempprot.delta = tempprot.delta(posonly);
        tempprot.smalldel = tempprot.smalldel(posonly);
        tempprot.grad_dirs = tempprot.grad_dirs(posonly, :);
        if(strcmp(tempprot.pulseseq, 'STEAM'))
            tempprot.TM = tempprot.TM(posonly);
            tempprot.TR = tempprot.TR(posonly);
            tempprot.TE = tempprot.TE(posonly);
        end
        if(isfield(tempprot, 'TE'))
            tempprot.TE = tempprot.TE(posonly);
        end
    else
        error('Need to adapt for other pulse sequences.');
    end
end


