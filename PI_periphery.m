function p_e = PI_periphery( r1, r2, same )
% Calculate the perfect integrator in the peripheral locations

global analysis;

% r1 = first pulse, r2 = second pulse
r           = [r1; r2];
% find the estimated values for the accuracy of single pulses, shown in TOP
B_t         = Analysis_single(r1);
p_32_t      = glmval(B_t, 0.032, 'logit'); 
p_64_t      = glmval(B_t, 0.064, 'logit'); 
p_128_t     = glmval(B_t, 0.128, 'logit');
p_t         = [p_32_t, p_64_t, p_128_t];
% find the estimated values for the accuracy of single pulses, shown in BOTTOM
B_b         = Analysis_single(r2);
p_32_b      = glmval(B_b, 0.032, 'logit'); 
p_64_b      = glmval(B_b, 0.064, 'logit'); 
p_128_b     = glmval(B_b, 0.128, 'logit');
p_b         = [p_32_b, p_64_b, p_128_b];
% Compute number of single pulses in each stimulus
num_1       = sum(r1(r1(:,2)==0));
num_2       = sum(r2(r2(:,2)==0));

% if location = SAME
if same==1
    p_e_1 = perfect_integrator(r1, p_t, p_t); % find the expected accuracy for top-top 
    p_e_2 = perfect_integrator(r2, p_b, p_b);
% if location = DIFFERENT
else
    p_e_1 = perfect_integrator(r1, p_t, p_b); % find the expected accuracy for top-bottom
    p_e_2 = perfect_integrator(r2, p_t, p_b);  
end
% Compute expected accuracy as the weighted average of p_e in each pulse
p_e        = (p_e_1 * num_1 + p_e_2 * num_2)/(num_1+num_2); % Compute the total expected accuracy

% Calculate size of each coherence pair in double pulses
size_p      = [sum((r(:,3)==0.032) & (r(:,4)==0.032));
                sum((r(:,3)==0.064) & (r(:,4)==0.064));
                sum((r(:,3)==0.128) & (r(:,4)==0.128));
                sum((r(:,3)==0.032) & (r(:,4)==0.064)) + sum((r(:,3)==0.064) & (r(:,4)==0.032));
                sum((r(:,3)==0.032) & (r(:,4)==0.128)) + sum((r(:,3)==0.128) & (r(:,4)==0.032));
                sum((r(:,3)==0.064) & (r(:,4)==0.128)) + sum((r(:,3)==0.128) & (r(:,4)==0.064))];
% performance of each coherence pair in double pulses
n_crct      = [sum((r(:,3)==0.032) & (r(:,4)==0.032) & r(:,10));
                sum((r(:,3)==0.064) & (r(:,4)==0.064) & r(:,10));
                sum((r(:,3)==0.128) & (r(:,4)==0.128) & r(:,10));
                sum((r(:,3)==0.032) & (r(:,4)==0.064) & r(:,10)) + sum((r(:,3)==0.064) & (r(:,4)==0.032) & r(:,10));
                sum((r(:,3)==0.032) & (r(:,4)==0.128) & r(:,10)) + sum((r(:,3)==0.128) & (r(:,4)==0.032) & r(:,10));
                sum((r(:,3)==0.064) & (r(:,4)==0.128) & r(:,10)) + sum((r(:,3)==0.128) & (r(:,4)==0.064) & r(:,10))];
 
n_crct      = [n_crct; sum(n_crct(1:3)); sum(n_crct(4:6))];
size_p      = [size_p; sum(size_p(1:3)); sum(size_p(4:6))];
p_crct      = n_crct ./size_p;

%BOOTSTRAP
n   = 10000;
for h = 1 : 8 
    size        = size_p(h);  
    beta(h) = log(p_crct(h)/(1 - p_crct(h))) - log(p_e(h)/(1 - p_e(h)));
    
    for i = 1 : n       
        aa          = rand(size,1);
        bb          = (aa <= p_e(h));
        p_e_(i)    = sum(bb)/size;
        
        b(h,i)          = log(p_crct(h)/(1 - p_crct(h))) - log(p_e_(i)/(1 - p_e_(i)));
    end
    if mean(b,2)>0
        amghezi(h)      = sum(b(h,:)>0) / n;
    else
        amghezi(h)      = sum(b(h,:)<0) / n;
    end
end

analysis.B_mean    = mean(b,2);
analysis.B_p       = 1-amghezi;    % p_value
analysis.B_std     = std(b,[],2);

end

