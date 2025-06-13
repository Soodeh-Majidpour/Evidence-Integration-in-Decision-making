function Plot_all_singles(r_c, r_2t, r_2b, r_tb, r_bt)
% Plot single pulses for all of the conditions

r_s     = [r_2t; r_2b]; % same
r_d     = [r_tb; r_bt]; % different

% Plot the 3 conditions: center, same, different locations
figure()
set(gcf,'position',[150,150,750,650])
set(gca,'XTick',[2.5 5 10 20 40],'fontsize',15)
set(gca,'xticklabel',({'2.5', '5', '10', '20', '40'})) 
ylim([0.5 1]);
set(gca,'YTick',(0:(0.1):1));
hold all

h1      = Plot_single(r_c,'b');
h2      = Plot_single(r_s,'c');
h3      = Plot_single(r_d,'m');

legend([h1 h2 h3],'center', 'same location', 'different location', 'fontsize',12, 'location', 'southeast')



end

