function ME_analysis(result)
% Analyze the motion energy of result
% Eq. 11 & 12 of my own paper

%%
global analysis
result(isnan(result(:,13)),:) = [];     % eliminate the 0-gap, their motion energy is not calculated

%% Eq. 11: Regression Analysis (M=?_0+?_1 C+?_2 E+?_3 ES )

m1_1        = sum(result(:,16:27),2);   % motion energy of the 1st pulse
m2_1        = sum(result(:,31:42),2);   % motion energy of the 2nd pulse
e           = ~result(:,10);            % 1 = error response, 0 = correct response
e           = [e; e];
c1          = result(:,3);              % Coherence of the 1st pulse
c2          = result(:,4);              % Coherence of the 2nd pulse
c           = [c1; c2];
m_1         = [m1_1; m2_1];
s           = [zeros(size(c1,1),1); ones(size(c2,1),1)];    % indicates the 1st or 2nd pulse
es          = e .* s;

% Normalize the values to match the scales
[m_1_normal, mu, sigma] = zscore(m_1);
[c_normal, mu2, sigma2] = zscore(c);

dsa         = table(c_normal,e,es,m_1_normal);
ME          = fitglm(dsa,'m_1_normal~ 1 + c_normal + e + es');
analysis.me1 = ME.Coefficients;


%% Eq. 12: Logistic Regression Model for ALL coherences 
% (Logit[P_correct]= ?0+?1.C_1+?2.C2+?3(M1+M2)+?4.M2 )

response    = result(:,10);     % response of the subject
m1          = sum((result(:,16:27)),2)/100;     % motion energy of the 1st pulse
m2          = sum((result(:,31:42)),2)/100;     % motion energy of the 2nd pulse
m12         = m1 + m2;
c1          = result(:,3);      % Coherence of the 1st pulse
c2          = result(:,4);      % Coherence of the 2nd pulse
% Normalize the parameters
[m2_normal, mu2, sigma2] = zscore(m2);
[m12_normal, mu12, sigma12] = zscore(m12);
[c1_normal, mu2c, sigma2c] = zscore(c1);
[c2_normal, mu12c, sigma12c] = zscore(c2);

dsa2        = table(c1_normal, c2_normal, m12_normal, m2_normal, response);
mdl         = fitglm(dsa2,'response ~ 1 + c1_normal + c2_normal + m12_normal + m2_normal','link','logit','Distribution','binomial');
analysis.me_pool = mdl.Coefficients;

%% Logistic Regression Model for equal coherences

response2   = result((result(:,3)==(result(:,4))),10);
m1_2        = sum((result((result(:,3)==(result(:,4))),16:27)),2)/100;
m2_2        = sum((result((result(:,3)==(result(:,4))),31:42)),2)/100;
m12_2       = m1_2 + m2_2;
c           = result((result(:,3)==(result(:,4))),3);
dsa2        = table(c, m12_2, m2_2, response2);

mdl2        = fitglm(dsa2,'response2 ~ c*m12_2*m2_2-c:m12_2-c:m2_2-m12_2:m2_2-c:m12_2:m2_2','link','logit','Distribution','binomial');
analysis.me2 = mdl2.Coefficients;

%% Logistic Regression Model for unequal coherences

response3   = result((result(:,3)~=(result(:,4))),10);
m1          = sum((result((result(:,3)~=(result(:,4))),16:27)),2)/100;
m2          = sum((result((result(:,3)~=(result(:,4))),31:42)),2)/100;
m12         = m1 + m2;
c1          = result((result(:,3)~=(result(:,4))),3);
c2          = result((result(:,3)~=(result(:,4))),4);
dsa3        = table(c1, c2, m12, m2, response3);

mdl3        = fitglm(dsa3,'response3 ~ c1*c2*m12*m2-c1:c2-c1:m12-c2:m12-c1:m2-c2:m2-m12:m2-c1:c2:m12-c1:c2:m2-c1:m12:m2-c2:m12:m2-c1:c2:m12:m2','link','logit','Distribution','binomial');
analysis.me3 = mdl3.Coefficients;


end