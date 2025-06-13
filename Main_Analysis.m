%% Main Analysis

% Specify the DataFolder, where 2 parts of the data are stored
DataFolder = 'C:\Users\SoodeH\Documents\DARSI\Thesis\my paper\Psychological Science\Data';
addpath(strcat(DataFolder, '\Part1'));
addpath(strcat(DataFolder, '\Part2'));

close all; clear; clc;
sub_Name    = {'One', 'Two', 'Three', 'Four', 'Five', 'Six', 'Seven'};
old         = 1;   new          = 1;    % Old refers to the part1, new refers to the part2
result_c    = [];   result_t_t  = [];  result_b_b   = []; result_t_b        = [];  result_b_t   = [];
dots_c      = [];   dots_t_t    = [];  dots_b_b     = []; dots_t_b          = [];  dots_b_t     = [];
intervals   = [0, 0.48, 1.08];
position    = {'center', '2t', '2b', 't_b', 'b_t'};
sub_list    = 1:7;

% Pool subjects' data for each condition separately
for f = 1 : size(sub_list,2)
    
    subName = sub_Name{sub_list(f)};    % Read the name of the subject
    [r1, d1, aborted1]  = create(subName, position{1}, old, new);   
    r1      = [repmat(sub_list(f), size(r1,1),1), r1];
    [r2, d2, aborted2]  = create(subName, position{2}, old, new);
    r2      = [repmat(sub_list(f), size(r2,1),1), r2];
    [r3, d3, aborted3]  = create(subName, position{3}, old, new);
    r3      = [repmat(sub_list(f), size(r3,1),1), r3];
    [r4, d4, aborted4]  = create(subName, position{4}, old, new);
    r4      = [repmat(sub_list(f), size(r4,1),1), r4];
    [r5, d5, aborted5]  = create(subName, position{5}, old, new);
    r5      = [repmat(sub_list(f), size(r5,1),1), r5];
    
    % Create matrix of the result in each condition
    result_c    = [result_c; r1];       % center
    result_t_t  = [result_t_t; r2];     % Top_Top
    result_b_b  = [result_b_b; r3];     % Bottom_Bottom
    result_t_b  = [result_t_b; r4];     % Top_Bottom
    result_b_t  = [result_b_t; r5];     % Bottom_Top
    
    % Create matrix of position of dots in each condition, used for Motion
    % Energy calculation
    if old == 0
        dots_c      = [dots_c; d1];     % center
        dots_t_t    = [dots_t_t; d2];   % Top_Top
        dots_b_b    = [dots_b_b; d3];   % Bottom_Bottom
        dots_t_b    = [dots_t_b; d4];   % Top_Bottom
        dots_b_t    = [dots_b_t; d5];   % Bottom_Top
    end
 
end

result_same     = [result_t_t; result_b_b];
result_diff     = [result_t_b; result_b_t];
dots_same       = [dots_t_t; dots_b_b];
dots_diff       = [dots_t_b; dots_b_t];
result          = [result_same; result_diff; result_c];
dots            = [dots_same; dots_diff; dots_c];

total_acc_same  = sum(result_same(:,10))/size(result_same,1);
total_acc_diff  = sum(result_diff(:,10))/size(result_diff,1);
total_acc_c     = sum(result_c(:,10))/size(result_c,1);

%% Analyses of the single pulses (Equation 1 & 2)

% Eq. 1 & 2; Returns the logit regression coefficients to use later
B_c = Analysis_single(result_c);
B_s = Analysis_single(result_same);
B_d = Analysis_single(result_diff);

%% Figure 2: Plot the single pulses

Plot_all_singles(result_c, result_t_t, result_b_b, result_t_b, result_b_t);

%% Calculate Performance of Single Pulses

acc_sngl_same = sum(result_same(result_same(:,2)==1,10))/size(result_same(result_same(:,2)==1,:),1);
acc_sngl_diff = sum(result_diff(result_diff(:,2)==1,10))/size(result_diff(result_diff(:,2)==1,:),1);

%% Repeated Measures ANOVA on single pulse trials

anova_single_table = rmANOVA_single(result_c, result_same, result_diff);

%% PI (Perfect Integrator), Location = CENTER

% Find accuracy in cohs 0.032, 0.064, 0.128, based on fitted logit parameters (B)
p_32_c    = glmval(B_c, 0.032, 'logit'); 
p_64_c    = glmval(B_c, 0.064, 'logit'); 
p_128_c   = glmval(B_c, 0.128, 'logit');
p_single_c  = [p_32_c, p_64_c, p_128_c];
p_e_center  = PI_center(result_c, p_32_c, p_64_c, p_128_c);

%% PI (Perfect Integrator), Location = SAME

p_32_s      = glmval(B_s, 0.032, 'logit'); 
p_64_s      = glmval(B_s, 0.064, 'logit'); 
p_128_s     = glmval(B_s, 0.128, 'logit');
p_single_s  = [p_32_s, p_64_s, p_128_s];
p_e_same    = PI_periphery(result_t_t, result_b_b, 1);    % Find expected performance for the same location

%% PI (Perfect Integrator), Location = DIFFERENT

p_32_d      = glmval(B_d, 0.032, 'logit'); 
p_64_d      = glmval(B_d, 0.064, 'logit'); 
p_128_d     = glmval(B_d, 0.128, 'logit');
p_single_d  = [p_32_d, p_64_d, p_128_d];
p_e_diff    = PI_periphery(result_t_b, result_b_t, 0);    % Find expected performance for different location

%% Plot the PI for all conditions

figure()
set(gcf,'position',[0,50,1800,700])

% Plot equal coherences
h1 = subplot(2,3,1);
PI_plot(result_c, p_e_center, p_single_c, 1);
set(gca,'xlabel',[])
set(h1, 'Units', 'normalized');
set(h1, 'Position', [0.12, 0.55, 0.25, 0.4]);
text(0.02,0.94,'A','fontweight','bold', 'fontsize',15)
text(0.5,0.97,'Center','fontweight','bold','fontsize',14)
text(-0.57,0.7,'Equal','fontweight','bold','fontsize',16)
text(-0.62,0.65,'coherence','fontweight','bold','fontsize',16)
% Add the legends
set(h1, 'Clipping', 'off')
rectangle('Position',[-0.64, 0.93, 0.034, 0.017],'Curvature',[1,1],'FaceColor','m','edgecolor','m');
text(-0.55,0.94,'3.2%-3.2%','fontsize',11)
rectangle('Position',[-0.64, 0.9, 0.034, 0.017],'Curvature',[1,1],'FaceColor','b','edgecolor','b');
text(-0.55,0.91,'6.4%-6.4%','fontsize',11)
rectangle('Position',[-0.64, 0.87, 0.034, 0.017],'Curvature',[1,1],'FaceColor','c','edgecolor','c');
text(-0.55,0.88,'12.8%-12.8%','fontsize',11)

h2 = subplot(2,3,2);
PI_plot(result_same, p_e_same, p_single_s, 1);
set(gca,'xlabel',[], 'ylabel',[])
set(h2, 'Units', 'normalized');
set(h2, 'Position', [0.42, 0.55, 0.25, 0.4]);
text(0.02,0.94,'B','fontweight','bold', 'fontsize',15)
text(0.45,0.97,'Same location','fontweight','bold','fontsize',14)

h3 = subplot(2,3,3);
PI_plot(result_diff, p_e_diff, p_single_d, 1);
set(gca,'xlabel',[], 'ylabel',[])
set(h3, 'Units', 'normalized');
set(h3, 'Position', [0.72, 0.55, 0.25, 0.4]);
text(0.02,0.94,'C','fontweight','bold', 'fontsize',15)
text(0.45,0.97,'Different location','fontweight','bold','fontsize',14)

% Plot unequal coherences
h4 = subplot(2,3,4);
PI_plot(result_c, p_e_center, p_single_c, 0);
set(h4, 'Units', 'normalized');
set(h4, 'Position', [0.12, 0.08, 0.25, 0.4]);
text(0.02,0.94,'D','fontweight','bold', 'fontsize',15)
text(-0.57,0.7,'Unqual','fontweight','bold','fontsize',16)
text(-0.62,0.65,'coherence','fontweight','bold','fontsize',16)
% Add the legends
set(h4, 'Clipping', 'off')
rectangle('Position',[-0.64, 0.93, 0.034, 0.017],'Curvature',[1,1],'FaceColor','m','edgecolor','m');
text(-0.55,0.94,'3.2%-6.4%','fontsize',11)
rectangle('Position',[-0.64, 0.9, 0.034, 0.017],'Curvature',[1,1],'FaceColor','b','edgecolor','b');
text(-0.55,0.91,'3.2%-12.8%','fontsize',11)
rectangle('Position',[-0.64, 0.87, 0.034, 0.017],'Curvature',[1,1],'FaceColor','c','edgecolor','c');
text(-0.55,0.88,'6.4%-12.8%','fontsize',11)

h5 = subplot(2,3,5);
PI_plot(result_same, p_e_same, p_single_s, 0);
set(gca,'ylabel',[])
set(h5, 'Units', 'normalized');
set(h5, 'Position', [0.42, 0.08, 0.25, 0.4]);
text(0.02,0.94,'E','fontweight','bold', 'fontsize',15)

h6 = subplot(2,3,6);
PI_plot(result_diff, p_e_diff, p_single_d, 0);
set(gca,'ylabel',[])
set(h6, 'Units', 'normalized');
set(h6, 'Position', [0.72, 0.08, 0.25, 0.4]);
text(0.02,0.94,'F','fontweight','bold', 'fontsize',15)


%% Figure 4: sequential effect

figure()
set(gcf,'position',[10,100,1800,480])

subplot(1,3,1);
bar_subplot(result_c,1);
text(0.6,0.41,'A','fontweight','bold', 'fontsize',15)
title('center')
subplot(1,3,2);
bar_subplot(result_same,1);
text(0.6,0.41,'B','fontweight','bold', 'fontsize',15)
text(1,0.36,'*','fontweight','bold', 'fontsize',16) % significance star
text(2,0.36,'*','fontweight','bold', 'fontsize',16) % significance star
text(3,0.36,'*','fontweight','bold', 'fontsize',16) % significance star
title('same location')
subplot(1,3,3);
bar_subplot(result_diff,1);
text(0.6,0.41,'C','fontweight','bold', 'fontsize',15)

title('different location')

%% Figure 6: Sequential effect for all gaps

figure()
set(gcf,'position',[0,0,1800,2200])

h1 = subplot(3,3,1);
bar_subplot(result_c(result_c(:,5)==0,:),0);
text(0.6,0.43,'A','fontweight','bold', 'fontsize',15)
text(2,0.375,'**','fontweight','bold', 'fontsize',16) % significance star
text(1.5,0.49,'center', 'fontsize',15)

h2 = subplot(3,3,2);
bar_subplot(result_same(result_same(:,5)==0,:),0);
text(0.6,0.43,'B','fontweight','bold', 'fontsize',15)
text(2,0.375,'**','fontweight','bold', 'fontsize',16)   % significance star
text(3,0.375,'*','fontweight','bold', 'fontsize',16)    % significance star
text(1.5,0.49,'same location','fontsize',15)
ylabel('')

h3 = subplot(3,3,3);
bar_subplot(result_diff(result_diff(:,5)==0,:),0);
text(0.6,0.43,'C','fontweight','bold', 'fontsize',15)
text(1.5,0.49,'different location','fontsize',15)
ylabel('')

h4 = subplot(3,3,4);
bar_subplot(result_c(result_c(:,5)==0.48,:),0);
text(0.6,0.43,'D','fontweight','bold', 'fontsize',15)

h5 = subplot(3,3,5);
bar_subplot(result_same(result_same(:,5)==0.48,:),0);
text(0.6,0.43,'E','fontweight','bold', 'fontsize',15)
ylabel('')

h6 = subplot(3,3,6);
bar_subplot(result_diff(result_diff(:,5)==0.48,:),0);
text(0.6,0.43,'F','fontweight','bold', 'fontsize',15)
ylabel('')

h7 = subplot(3,3,7);
bar_subplot(result_c(result_c(:,5)==1.08,:),1);
text(0.6,0.43,'G','fontweight','bold', 'fontsize',15)
text(1,0.375,'**','fontweight','bold', 'fontsize',16) % significance star

h8 = subplot(3,3,8);
bar_subplot(result_same(result_same(:,5)==1.08,:),1);
text(0.6,0.43,'H','fontweight','bold', 'fontsize',15)
ylabel('')

h9 = subplot(3,3,9);
bar_subplot(result_diff(result_diff(:,5)==1.08,:),1);
text(0.6,0.43,'I','fontweight','bold', 'fontsize',15)
ylabel('')
