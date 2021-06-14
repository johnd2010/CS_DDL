%% Copyright(c) Naushad Ansari, 2017.
% %% Please feel free to use this open-source code for research purposes only. 
% %%
% %% contact at naushadansari09797@gmail.com in case of any query.
% %%
% %%
% %% This function calculates the psnr of a signal with reference to original 
% signal. PSNR can be calculated for 1-D/2-D/3-D signals.
%%-----------------------------------------------------------------------%%
%%-----------------------------------------------------------------------%%
% %% output: psnr-> psnr in dB
%            
% %% input:  orgSig-> original 1-D/2-D/3-D signal (or reference signal)
%            recSig-> reconstructed signal/ signal obtained from the
%            experiment/ signal, of which psnr is to be calculated with
%            reference to original signal.
%            boun-> boun is the boundary left at the corners for the 
%            psnr calculation. default value = 0
%%-----------------------------------------------------------------------%%
%%-----------------------------------------------------------------------%%
function psnr = calPSNR(orgSig,recSig,varargin)

if isempty(varargin)
    boun = 0;
else boun = varargin{1};
end
if size(orgSig,2)==1       % if signal is 1-D
    orgSig = orgSig(boun+1:end-boun,:);
    recSig = recSig(boun+1:end-boun,:);
else                       % if signal is 2-D or 3-D
    orgSig = orgSig(boun+1:end-boun,boun+1:end-boun,:);
    recSig = recSig(boun+1:end-boun,boun+1:end-boun,:);
end

mse = norm((orgSig(:)-recSig(:)))^2/length(orgSig(:));
% mse=sum(abs((img(:)-recImg(:)).^2))/length(img(:));
maxval = max(abs(orgSig(:)));
psnr = 10*log10((maxval^2)/mse);