function bar_subplot(r, label)

%% Bar Plot

a   = r(r(:,3)==0.032 & r(:,4)==0.064,10);
b   = r(r(:,3)==0.064 & r(:,4)==0.032,10);
c   = r(r(:,3)==0.032 & r(:,4)==0.128,10);
d   = r(r(:,3)==0.128 & r(:,4)==0.032,10);
e   = r(r(:,3)==0.064 & r(:,4)==0.128,10);
f   = r(r(:,3)==0.128 & r(:,4)==0.064,10);
[p1,h1, stats] = ranksum(a,b);
[p2,h2] = ranksum(c,d);
[p3,h3] = ranksum(e,f);


aa = sum(r(:,3)==0.032 & r(:,4)==0.064 & r(:,10)==1)/sum(r(:,3)==0.032 & r(:,4)==0.064);
bb = sum(r(:,3)==0.064 & r(:,4)==0.032 & r(:,10)==1)/sum(r(:,3)==0.064 & r(:,4)==0.032);
cc = sum(r(:,3)==0.032 & r(:,4)==0.128 & r(:,10)==1)/sum(r(:,3)==0.032 & r(:,4)==0.128);
dd = sum(r(:,3)==0.128 & r(:,4)==0.032 & r(:,10)==1)/sum(r(:,3)==0.128 & r(:,4)==0.032);
ee = sum(r(:,3)==0.064 & r(:,4)==0.128 & r(:,10)==1)/sum(r(:,3)==0.064 & r(:,4)==0.128);
ff = sum(r(:,3)==0.128 & r(:,4)==0.064 & r(:,10)==1)/sum(r(:,3)==0.128 & r(:,4)==0.064);
bar_coh = [aa, bb; cc, dd; ee, ff];

sem_bar = sqrt((bar_coh .* (1-bar_coh)) ./[sum(r(:,3)==0.032 & r(:,4)==0.064), sum(r(:,3)==0.064 & r(:,4)==0.032);...
                sum(r(:,3)==0.032 & r(:,4)==0.128) sum(r(:,3)==0.128 & r(:,4)==0.032);...
                sum(r(:,3)==0.064 & r(:,4)==0.128) sum(r(:,3)==0.128 & r(:,4)==0.064)]);

accs = [1,2,3];
if(sum(sum(bar_coh>=0.5))==6 && sum(sum(bar_coh<=0.9))==6)
    h = bar(accs, bar_coh-0.5, 'BarWidth', 1);
    set(gca,'YTick',[0,0.1,0.2,0.3,0.4],'fontsize',11)
    set(gca,'yticklabel',{'0.5','0.6','0.7','0.8','0.9'})
    ylim([0 0.4])
else
    h = bar(accs, bar_coh, 'BarWidth', 1);
end
if sum(sum(bar_coh>=0.5))<6
    ylim([0.4 0.9])
end
if sum(sum(bar_coh<=0.9))<6
    ylim([0.5 1])
end
set(h,{'FaceColor'},{[1,1,1],[0.5,0.5,0.5]}')
hold on 
set(gca,'xtick',[],'xlabel',[])
xLab = [{'3.2%,6.4%'},{'6.4%,3.2%'},{'3.2%,12.8%','12.8%,3.2%','6.4%,12.8%','12.8%,6.4%'}];
ngroups     = 3;
nbars       = 2;
x1          = [];
% Calculate the width for each bar group
groupwidth  = min(0.8, nbars/(nbars + 1.5));
for i = 1:nbars
    x = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
    if(sum(sum(bar_coh>=0.5))==6 && sum(sum(bar_coh<=0.9))==6)
        errorbar(x, bar_coh(:,i)-0.5, sem_bar(:,i), '.k');
    else
        errorbar(x, bar_coh(:,i), sem_bar(:,i), '.k');
    end
    x1 = [x1, x];
end
set(gca, 'box', 'off')  % eliminate lines around each figure
% In the lowest part of the overall figure, set the label to the coherence pairs
if label == 1
    set(gca,'XTick',[x1(1),x1(4),x1(2),x1(5),x1(3),x1(6)],'fontsize',12,'XTickLabel', xLab)
    set(gca,'XTickLabelRotation',45)
end
hold on
ylabel('Probability Correct','fontsize',14)

end