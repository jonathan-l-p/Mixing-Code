% save workspace of various cases for Pr, SR, and UR

SavePathWS = '/Users/jonathan/Documents/DataDump/MATLAB_test_cases/';

if ConstantKappaAtInf
    ConstantKappaAtInf = 'true';
else
     ConstantKappaAtInf = 'false';
end

save([SavePathWS,'Pr_',strrep(num2str(Pr),'.','d'),...
    '_SR_',strrep(num2str(strain_ratio),'.','d'),...
    '_UR_',strrep(num2str(FSR_U),'.','d'),...
    '_ConsKap@inf_', ConstantKappaAtInf]);

fprintf('Workspace save complete!\n\n')