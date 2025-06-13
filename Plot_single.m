function hax = Plot_single(result, color)

result1     = result(result(:,2)==1,:); % extract the single pulse trials

coh0        = (result1(:,3) == 0);
coh32       = (result1(:,3) == 0.032);
coh64       = (result1(:,3) == 0.064);
coh128      = (result1(:,3) == 0.128);
coh256      = (result1(:,3) == 0.256);
coh512      = (result1(:,3) == 0.512);

accuracy0   = length(result1(coh0 & result1(:,10)))/sum(coh0);
accuracy1   = length(result1(coh32 & result1(:,10)))/sum(coh32);
accuracy2   = length(result1(coh64 & result1(:,10)))/sum(coh64);
accuracy3   = length(result1(coh128 & result1(:,10)))/sum(coh128);
accuracy4   = length(result1(coh256 & result1(:,10)))/sum(coh256);
accuracy5   = length(result1(coh512 & result1(:,10)))/sum(coh512);
accuracies  = [accuracy0,accuracy1,accuracy2,accuracy3,accuracy4,accuracy5];

Beta        = Analysis_single(result);


% Psychometric Function 
N       = [sum(coh32) sum(coh64) sum(coh128) sum(coh256) sum(coh512)];       
p       = accuracies;
SEM     = sqrt((p .* (1-p)) ./ [sum(coh0) N]);
x       = 0.012:0.005:0.62;
y       = glmval(Beta, x, 'logit');
xx      = 100 * x;

hold on
hax = plot(xx,y,color,'LineWidth',2.5);
set(get(hax,'Parent'),'XScale','log')
plot(100*[0.032, 0.064, 0.128, 0.256, 0.512], accuracies(2:6), 'o', 'MarkerFaceColor', color, 'MarkerEdgeColor', color, 'MarkerSize',10);
errorbar(100*[0.032, 0.064, 0.128, 0.256, 0.512], accuracies(2:6), SEM(2:6), 'LineStyle','none', 'Color', color,'linewidth', 1.1)
hold on

set(gca,'XLim',[2 62]);

xlabel('Motion strength (%coh)','fontsize',17); ylabel('Probability correct','fontsize',17);
xh      = get(gca,'xlabel'); % handle to the label object
p       = get(xh,'position'); % get the current position property
p(2)    = -0.001 + p(2) ;       % double the distance, % negative values put the label below the axis
set(xh,'position',p)   % set the new position

yh      = get(gca,'ylabel') % handle to the label object
p       = get(yh,'position') % get the current position property
p(1)    = -0.02 + p(1) ;       % double the distance, % negative values put the label below the axis
set(yh,'position',p)   % set the new position
hold on

end