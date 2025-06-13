function B1 = Analysis_single(result)
% This function includes the analyses on the single pulse trials
% Using fitglm models, we fit regression models to 
% solve the Equaions: 1, 2 (Equation numbers in the paper)

global analysis;

result1     = result(result(:,2)==1,:);     % Extract the single pulse trials

%% Eq 1: Logit[P] = ?0 + ?1C

% Eliminate 0 coherences and fit the logit function
response    = result1(result1(:,3)~=0,10);  % response of the subject
c           = result1(result1(:,3)~=0,3);   % coherence of the single pulse
dsa         = table(c, response);
mdl1        = fitglm(dsa,'response ~ c','link','logit','Distribution','binomial');
B1          = mdl1.Coefficients.Estimate;   
analysis.B1 = mdl1.Coefficients;


%% Eq 2: Fit logit to check for bias to any direction

c           = result1(result1(:,3)~=0,:);   % response of the subject
c(c(:,8)==1,3)    = c(c(:,8)==1,3) * -1;    % direction of the stimulus
cc          = c(:,3);                       % coherence of the single pulse
right       = ~c(:,9);
dsa         = table(cc, right);
mdl2        = fitglm(dsa,'right ~ cc','link','logit','Distribution','binomial');
analysis.B2 = mdl2.Coefficients;

end

