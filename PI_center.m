function p_e = PI_center(r, p_32, p_64, p_128)
% Calculate the expected accuracy for the center location

global analysis;
% number of each coherence pair
size_p  = [sum(r(:,3)==0.032 & r(:,4)==0.032);...
           sum(r(:,3)==0.064 & r(:,4)==0.064);...
           sum(r(:,3)==0.128 & r(:,4)==0.128);...
           sum(r(:,3)==0.032 & r(:,4)==0.064)+...
           sum(r(:,3)==0.064 & r(:,4)==0.032);...
           sum(r(:,3)==0.032 & r(:,4)==0.128)+...
           sum(r(:,3)==0.128 & r(:,4)==0.032);...
           sum(r(:,3)==0.064 & r(:,4)==0.128)+...
           sum(r(:,3)==0.128 & r(:,4)==0.064)];

% Probability Correct in double pulse trials
n_crct  = [sum((r(:,3)==0.032) & (r(:,4)==0.032) & (r(:,10)==1));...
           sum((r(:,3)==0.064) & (r(:,4)==0.064) & (r(:,10)==1));...
           sum((r(:,3)==0.128) & (r(:,4)==0.128) & (r(:,10)==1));...
           (sum((r(:,3)==0.032) & (r(:,4)==0.064) & (r(:,10)==1))+sum((r(:,3)==0.064) & (r(:,4)==0.032) & (r(:,10)==1)));...
           (sum((r(:,3)==0.032) & (r(:,4)==0.128) & (r(:,10)==1))+sum((r(:,3)==0.128) & (r(:,4)==0.032) & (r(:,10)==1)));...
           (sum((r(:,3)==0.064) & (r(:,4)==0.128) & (r(:,10)==1))+sum((r(:,3)==0.128) & (r(:,4)==0.064) & (r(:,10)==1)))];
       
% add the equal and unequal coherences
n_crct	= [n_crct; sum(n_crct(1:3)); sum(n_crct(4:6))];
size_p	= [size_p; sum(size_p(1:3)); sum(size_p(4:6))];
p_crct  = n_crct ./size_p;
n       = 10000;   %number of bootstrap runs

%% Bootstrap the double pulses
% Compute the evidence values
e_32    = icdf('Normal',p_32,0,1);
e_64    = icdf('Normal',p_64,0,1);
e_128   = icdf('Normal',p_128,0,1);

% Expected performance of the subject in 6 conditions
p_e     = [1 - normcdf(0,(e_32 + e_32), sqrt(2));...
           1 - normcdf(0,(e_64 + e_64), sqrt(2));...
           1 - normcdf(0,(e_128 + e_128), sqrt(2));...
           1 - normcdf(0,(e_32 + e_64), sqrt(2));...
           1 - normcdf(0,(e_32 + e_128), sqrt(2));...
           1 - normcdf(0,(e_64 + e_128), sqrt(2))];
                
p_e_eq      = mean(p_e(1:3));   % p_e in equal coherences, overall
p_e_uneq    = mean(p_e(4:6));   % p_e in unequal coherences, overall
p_e         = [p_e; p_e_eq; p_e_uneq];

for h = 1 : 8  
    size        = size_p(h);  
    beta(h) = log(p_crct(h)/(1 - p_crct(h))) - log(p_e(h)/(1 - p_e(h)));
    % Bootstrap
    for i = 1 : n       
        aa          = rand(size,1);
        bb          = (aa <= p_e(h));
        p_e_1(i)    = sum(bb)/size;
        
        b6(h,i)          = log(p_crct(h)/(1 - p_crct(h))) - log(p_e_1(i)/(1 - p_e_1(i)));
    end
    if mean(b6,2)>0
        amghezi(h)      = sum(b6(h,:)>0) / n;
    else
        amghezi(h)      = sum(b6(h,:)<0) / n;
    end
end
analysis.B6_mean    = mean(b6,2);
analysis.B6_std     = std(b6,[],2);
analysis.B6_p       = 1-amghezi;    % p_value

end
