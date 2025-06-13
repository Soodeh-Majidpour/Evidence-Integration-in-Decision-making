function tabl = rmANOVA_single(result_c, result_same, result_diff)

% Run Repeated Measures Anova on the single pulse trials, in different
% coherences and positions

%%

for i=1:7
    % Location = CENTER
    % Compute accuracies of the single pulses for each subject (i) and for each coherence 
    acc1(i)     = length(result_c(result_c(:,1) == i & result_c(:,2) == 1 & result_c(:,3) == 0.032 & result_c(:,10)))/sum(result_c(:,1) == i & result_c(:,2) == 1 & result_c(:,3) == 0.032);
    acc2(i)     = length(result_c(result_c(:,1) == i & result_c(:,2) == 1 & result_c(:,3) == 0.064 & result_c(:,10)))/sum(result_c(:,1) == i & result_c(:,2) == 1 & result_c(:,3) == 0.064);
    acc3(i)   	= length(result_c(result_c(:,1) == i & result_c(:,2) == 1 & result_c(:,3) == 0.128 & result_c(:,10)))/sum(result_c(:,1) == i & result_c(:,2) == 1 & result_c(:,3) == 0.128);
    acc4(i)   	= length(result_c(result_c(:,1) == i & result_c(:,2) == 1 & result_c(:,3) == 0.256 & result_c(:,10)))/sum(result_c(:,1) == i & result_c(:,2) == 1 & result_c(:,3) == 0.256);
    acc5(i)   	= length(result_c(result_c(:,1) == i & result_c(:,2) == 1 & result_c(:,3) == 0.512 & result_c(:,10)))/sum(result_c(:,1) == i & result_c(:,2) == 1 & result_c(:,3) == 0.512);
     
    % Location = SAME
    acc1_s(i)   = length(result_same(result_same(:,1) == i & result_same(:,2) == 1 & result_same(:,3) == 0.032 & result_same(:,10)))/sum(result_same(:,1) == i & result_same(:,2) == 1 & result_same(:,3) == 0.032);
    acc2_s(i)   = length(result_same(result_same(:,1) == i & result_same(:,2) == 1 & result_same(:,3) == 0.064 & result_same(:,10)))/sum(result_same(:,1) == i & result_same(:,2) == 1 & result_same(:,3) == 0.064);
    acc3_s(i)   = length(result_same(result_same(:,1) == i & result_same(:,2) == 1 & result_same(:,3) == 0.128 & result_same(:,10)))/sum(result_same(:,1) == i & result_same(:,2) == 1 & result_same(:,3) == 0.128);
    acc4_s(i)   = length(result_same(result_same(:,1) == i & result_same(:,2) == 1 & result_same(:,3) == 0.256 & result_same(:,10)))/sum(result_same(:,1) == i & result_same(:,2) == 1 & result_same(:,3) == 0.256);
    acc5_s(i)   = length(result_same(result_same(:,1) == i & result_same(:,2) == 1 & result_same(:,3) == 0.512 & result_same(:,10)))/sum(result_same(:,1) == i & result_same(:,2) == 1 & result_same(:,3) == 0.512);
    
    % Location = DIFFERENT
    acc1_d(i)   = length(result_diff(result_diff(:,1) == i & result_diff(:,2) == 1 & result_diff(:,3) == 0.032 & result_diff(:,10)))/sum(result_diff(:,1) == i & result_diff(:,2) == 1 & result_diff(:,3) == 0.032);
    acc2_d(i)   = length(result_diff(result_diff(:,1) == i & result_diff(:,2) == 1 & result_diff(:,3) == 0.064 & result_diff(:,10)))/sum(result_diff(:,1) == i & result_diff(:,2) == 1 & result_diff(:,3) == 0.064);
    acc3_d(i)   = length(result_diff(result_diff(:,1) == i & result_diff(:,2) == 1 & result_diff(:,3) == 0.128 & result_diff(:,10)))/sum(result_diff(:,1) == i & result_diff(:,2) == 1 & result_diff(:,3) == 0.128);    
    acc4_d(i)   = length(result_diff(result_diff(:,1) == i & result_diff(:,2) == 1 & result_diff(:,3) == 0.256 & result_diff(:,10)))/sum(result_diff(:,1) == i & result_diff(:,2) == 1 & result_diff(:,3) == 0.256);    
    acc5_d(i)   = length(result_diff(result_diff(:,1) == i & result_diff(:,2) == 1 & result_diff(:,3) == 0.512 & result_diff(:,10)))/sum(result_diff(:,1) == i & result_diff(:,2) == 1 & result_diff(:,3) == 0.512);    

end


%% Run RM ANOVA on the accuracies of the subjects (all coherences included)

factorNames = {'Pos', 'Coh'};
Pos         = [repmat('c',5,1);repmat('s',5,1);repmat('d',5,1)];
Coh         = repmat([0.032;0.064;0.128;0.256;0.512],3,1);
% Create the within table
within      = table(Pos, Coh, 'VariableNames', factorNames);
accs        = [acc1; acc2; acc3; acc4; acc5;...
                acc1_s; acc2_s; acc3_s; acc4_s; acc5_s;...
                acc1_d; acc2_d; acc3_d; acc4_d; acc5_d]';
varNames = cell(3*5,1);
for i = 1 : 3*5
    vv = strcat('V',num2str(i));
    varNames{i,1} = vv;
end
taccs       = array2table(accs, 'VariableNames', varNames);

% fit the repeated measures model
rm      = fitrm(taccs,'V1-V15~1','WithinDesign',within);
[tabl]  = ranova(rm, 'WithinModel','Pos*Coh');


end

