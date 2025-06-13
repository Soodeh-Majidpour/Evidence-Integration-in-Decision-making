function ME_plot(result, plot_i)

% Plot Motion Energy of each coherence set in the condition of the result

%% Separate the motion energy for correct and wrong responses for each equal coherence set
result(isnan(result(:,13)),:) = [];     

% Extract the motion energy columns out of the result
% coh = 3.2%
% first pulse
c_32_1      = result((result(:,3)== 0.032) & (result(:,4)==0.032) & (result(:,10)==1) & (result(:,5)~=0), 13:27);
w_32_1      = result((result(:,3)== 0.032) & (result(:,4)==0.032) & (result(:,10)==0) & (result(:,5)~=0), 13:27);
% second pulse
c_32_2      = result((result(:,3)== 0.032) & (result(:,4)==0.032) & (result(:,10)==1) & (result(:,5)~=0), 28:42);
w_32_2      = result((result(:,3)== 0.032) & (result(:,4)==0.032) & (result(:,10)==0) & (result(:,5)~=0), 28:42);
% coh = 6.4%
% first pulse
c_64_1      = result((result(:,3)== 0.064) & (result(:,4)==0.064) & (result(:,10)==1) & (result(:,5)~=0), 13:27);
w_64_1      = result((result(:,3)== 0.064) & (result(:,4)==0.064) & (result(:,10)==0) & (result(:,5)~=0), 13:27);
% second pulse
c_64_2      = result((result(:,3)== 0.064) & (result(:,4)==0.064) & (result(:,10)==1) & (result(:,5)~=0), 28:42);
w_64_2      = result((result(:,3)== 0.064) & (result(:,4)==0.064) & (result(:,10)==0) & (result(:,5)~=0), 28:42);
% coh = 12.8%
% first pulse
c_128_1     = result((result(:,3)== 0.128) & (result(:,4)==0.128) & (result(:,10)==1) & (result(:,5)~=0), 13:27);
w_128_1     = result((result(:,3)== 0.128) & (result(:,4)==0.128) & (result(:,10)==0) & (result(:,5)~=0), 13:27);
% second pulse
c_128_2     = result((result(:,3)== 0.128) & (result(:,4)==0.128) & (result(:,10)==1) & (result(:,5)~=0), 28:42);
w_128_2     = result((result(:,3)== 0.128) & (result(:,4)==0.128) & (result(:,10)==0) & (result(:,5)~=0), 28:42);

%% Plot the figure for motion energy, Coh = 3.2%

Max     = max([mean(c_128_1), mean(w_128_1), mean(c_128_2), mean(w_128_2)]);
Max  	= 1.3 * Max;
Min     = -0.25;

% x = [10, 500, 1000];
y = [0.69, 0.4, 0.11];

ind = plot_i*3+1;
h(ind) = subplot(3,3,ind);
set(h(ind),'position',[0.2,y(plot_i+1),0.12,0.26]);

shadedErrorBar([0:14]*16.7,mean(w_128_1)/Max,(std(w_128_1)/sqrt(size(w_128_1,1))/Max),'lineProps',{'-b', 'LineWidth', 2.5},'transparent',1)
hold on
shadedErrorBar([0:14]*16.7,mean(c_128_1)/Max,(std(c_128_1)/sqrt(size(c_128_1,1))/Max),'lineProps',{'-r', 'LineWidth', 2.5},'transparent',1)
hold on 
shadedErrorBar([16:30]*16.7,mean(w_128_2)/Max,(std(w_128_2)/sqrt(size(w_128_2,1))/Max),'lineProps',{'-b', 'LineWidth', 2.5},'transparent',1)
hold on
shadedErrorBar([16:30]*16.7,mean(c_128_2)/Max,(std(c_128_2)/sqrt(size(c_128_2,1))/Max),'lineProps',{'-r', 'LineWidth', 2.5},'transparent',1)
hold on
plot([-10, 550],[-0.2, -0.2], 'k');
set(gca,'XTick',[0, 100],'fontsize',7)
set(gca,'xticklabel',({'0','100'}))
set(gca,'YTick',[0, 0.25, 0.5, 0.75, 1],'fontsize',11)
set(gca,'yticklabel',({'0','','0.5','','1'}))
ylim([Min, 1]);
xlim([-10, 550]);
text(230,-0.2,'//','fontsize',10);
ylabel('Motion Energy (a. u.)','FontSize',12);
if plot_i==2
    xlabel('Time (ms)','FontSize',13);
end
rectangle('position',[0 -0.2 150 0.04],'FaceColor','k')
rectangle('position',[251 -0.2 150 0.04],'FaceColor','k')
if plot_i==0
    l = legend('Correct', 'Error');
    set(l, 'position',[0.125 0.9 0.01 0.01], 'box', 'off', 'fontsize',12)
end


%% Coh = 6.4%

ind = plot_i*3+2;
h(ind) = subplot(3,3,ind);
set(h(ind),'position',[0.35,y(plot_i+1),0.12,0.26]);

shadedErrorBar([0:14]*16.7,mean(w_64_1)/Max,(std(w_64_1)/sqrt(size(w_64_1,1))/Max),'lineProps',{'-b', 'LineWidth', 2.5},'transparent',1)
hold on
shadedErrorBar([0:14]*16.7,mean(c_64_1)/Max,(std(c_64_1)/sqrt(size(c_64_1,1))/Max),'lineProps',{'-r', 'LineWidth', 2.5},'transparent',1)
hold on 
shadedErrorBar([16:30]*16.7,mean(w_64_2)/Max,(std(w_64_2)/sqrt(size(w_64_2,1))/Max),'lineProps',{'-b', 'LineWidth', 2.5},'transparent',1)
hold on
shadedErrorBar([16:30]*16.7,mean(c_64_2)/Max,(std(c_64_2)/sqrt(size(c_64_2,1))/Max),'lineProps',{'-r', 'LineWidth', 2.5},'transparent',1)
hold on
plot([-10, 550],[-0.2, -0.2], 'k');
set(gca,'XTick',[0, 100],'fontsize',6)
set(gca,'xticklabel',({'0','100'}))
set(gca,'YTick',[0, 0.25, 0.5, 0.75, 1],'fontsize',11)
set(gca,'yticklabel',({'0','','0.5','','1'}))
ylim([Min, 1]);
xlim([-10, 550]);
text(230,-0.2,'//','fontsize',10);
% ylabel('Motion Energy (a. u.)','FontSize',17);
if plot_i==2
    xlabel('Time (ms)','FontSize',13);
end
rectangle('position',[0 -0.2 150 0.04],'FaceColor','k')
rectangle('position',[251 -0.2 150 0.04],'FaceColor','k')
% title('6.4%                                  6.4%','FontSize',11);

%% Coh = 12.8%

ind = plot_i*3+3;
h(ind) = subplot(3,3,ind);
set(h(ind),'position',[0.5,y(plot_i+1),0.12,0.26]);

shadedErrorBar([0:14]*16.7,mean(w_32_1)/Max,(std(w_32_1)/sqrt(size(w_32_1,1))/Max),'lineProps',{'-b', 'LineWidth', 2.5},'transparent',1)
hold on
shadedErrorBar([0:14]*16.7,mean(c_32_1)/Max,(std(c_32_1)/sqrt(size(c_32_1,1))/Max),'lineProps',{'-r', 'LineWidth', 2.5},'transparent',1)
hold on 
shadedErrorBar([16:30]*16.7,mean(w_32_2)/Max,(std(w_32_2)/sqrt(size(w_32_2,1))/Max),'lineProps',{'-b', 'LineWidth', 2.5},'transparent',1)
hold on
shadedErrorBar([16:30]*16.7,mean(c_32_2)/Max,(std(c_32_2)/sqrt(size(c_32_2,1))/Max),'lineProps',{'-r', 'LineWidth', 2.5},'transparent',1)
hold on
plot([-10, 550],[-0.2, -0.2], 'k');
set(gca,'XTick',[0, 100],'fontsize',6)
set(gca,'xticklabel',({'0','100'}))
set(gca,'YTick',[0, 0.25, 0.5, 0.75, 1],'fontsize',11)
set(gca,'yticklabel',({'0','','0.5','','1'}))
ylim([Min, 1]);
xlim([-10, 550]);
text(230,-0.2,'//','fontsize',10);
% ylabel('Motion Energy (a. u.)','FontSize',10);
if plot_i==2
    xlabel('Time (ms)','FontSize',13);
end
rectangle('position',[0 -0.2 150 0.04],'FaceColor','k')
rectangle('position',[251 -0.2 150 0.04],'FaceColor','k')

end