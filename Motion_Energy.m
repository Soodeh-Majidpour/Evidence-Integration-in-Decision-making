% Do all analyses related to the Motion Energy

%% Calculate Motion Energy of each pulse

ME_result_c     = Create_ME(dots_c, result_c);          % CENTER
ME_result_same  = Create_ME(dots_same, result_same);    % SAME location
ME_result_diff  = Create_ME(dots_diff, result_diff);    % DIFFERENT location

%% Do analysis on ME, Equations 11, 12

ME_analysis(ME_result_c);       % CENTER
ME_analysis(ME_result_same);    % SAME location
ME_analysis(ME_result_diff);    % DIFFERENT location

%% Plot all MEs

figure();
set(gcf,'position',[0,0,1500,1000]);

% Plot figures for center
ME_plot(ME_result_c,0)

% Write coherences on top of each column
text(120,1.12,'3.2%        3.2%','fontsize',12)
text(-580,1.12,'6.4%        6.4%','fontsize',12)
text(-1290,1.12,'12.8%        12.8%','fontsize',12)

% Write the letter related to each figure
text(10,0.92,'C','fontweight','bold', 'fontsize',15)
text(-690,0.92,'B','fontweight','bold', 'fontsize',15)
text(-1390,0.92,'A','fontweight','bold', 'fontsize',15)
text(-1810,0.4,'Center','fontweight','bold', 'fontsize',13) % Write location of dots (condition) on the rightmost position
set(gca,'xlabel',[])


% Plot figures for Same location
ME_plot(ME_result_same,1)
text(10,0.92,'F','fontweight','bold', 'fontsize',15)
text(-690,0.92,'E','fontweight','bold', 'fontsize',15)
text(-1390,0.92,'D','fontweight','bold', 'fontsize',15)
text(-1820,0.4,'Same','fontweight','bold', 'fontsize',13)
text(-1840,0.25,'location','fontweight','bold', 'fontsize',13)
set(gca,'xlabel',[])


% Plot figures for Different location
ME_plot(ME_result_diff,2)
text(10,0.92,'I','fontweight','bold', 'fontsize',15)
text(-690,0.92,'H','fontweight','bold', 'fontsize',15)
text(-1390,0.92,'G','fontweight','bold', 'fontsize',15)
text(-1850,0.4,'Different','fontweight','bold', 'fontsize',13)
text(-1840,0.25,'location','fontweight','bold', 'fontsize',13)




