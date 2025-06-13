function PI_plot(r, p_e, p_single, equal)

intervals    = [0, 0.48, 1.08];

%% double pulse_Equal Coherences

coh_32_1     = ((r(:,3)==0.032) & (r(:,4)==0.032) & (r(:,5)==0));
coh_32_2     = ((r(:,3)==0.032) & (r(:,4)==0.032) & (r(:,5)==0.48));
coh_32_3     = ((r(:,3)==0.032) & (r(:,4)==0.032) & (r(:,5)==1.08));

coh_64_1     = ((r(:,3)==0.064) & (r(:,4)==0.064) & (r(:,5)==0));
coh_64_2     = ((r(:,3)==0.064) & (r(:,4)==0.064) & (r(:,5)==0.48));
coh_64_3     = ((r(:,3)==0.064) & (r(:,4)==0.064) & (r(:,5)==1.08));

coh_128_1    = ((r(:,3)==0.128) & (r(:,4)==0.128) & (r(:,5)==0));
coh_128_2    = ((r(:,3)==0.128) & (r(:,4)==0.128) & (r(:,5)==0.48));
coh_128_3    = ((r(:,3)==0.128) & (r(:,4)==0.128) & (r(:,5)==1.08));


acc_same_32  = [sum(coh_32_1 & r(:,10))/sum(coh_32_1),...
                sum(coh_32_2 & r(:,10))/sum(coh_32_2),...
                sum(coh_32_3 & r(:,10))/sum(coh_32_3)];
sem_same_32  = sqrt((acc_same_32 .* (1-acc_same_32)) ./ [sum(coh_32_1) sum(coh_32_2) sum(coh_32_3)]); 
acc_same_64  = [sum(coh_64_1 & r(:,10))/sum(coh_64_1),...
                sum(coh_64_2 & r(:,10))/sum(coh_64_2),...
                sum(coh_64_3 & r(:,10))/sum(coh_64_3)];
sem_same_64  = sqrt((acc_same_64 .* (1-acc_same_64)) ./ [sum(coh_64_1) sum(coh_64_2) sum(coh_64_3)]);
acc_same_128 = [sum(coh_128_1 & r(:,10))/sum(coh_128_1),...
                sum(coh_128_2 & r(:,10))/sum(coh_128_2),...
                sum(coh_128_3 & r(:,10))/sum(coh_128_3)];
sem_same_128 = sqrt((acc_same_128 .* (1-acc_same_128)) ./ [sum(coh_128_1) sum(coh_128_2) sum(coh_128_3)]);
                      

%% double pulse_Unequal coherences

coh_32_64   = [((r(:,3)==0.032) & (r(:,4)==0.064) & (r(:,5)==0)),...
               ((r(:,3)==0.032) & (r(:,4)==0.064) & (r(:,5)==0.48)),...
               ((r(:,3)==0.032) & (r(:,4)==0.064) & (r(:,5)==1.08))];
coh_64_32   = [((r(:,3)==0.064) & (r(:,4)==0.032) & (r(:,5)==0)),...
               ((r(:,3)==0.064) & (r(:,4)==0.032) & (r(:,5)==0.48)),...
               ((r(:,3)==0.064) & (r(:,4)==0.032) & (r(:,5)==1.08))];

coh_32_128  = [((r(:,3)==0.032) & (r(:,4)==0.128) & (r(:,5)==0)),...
               ((r(:,3)==0.032) & (r(:,4)==0.128) & (r(:,5)==0.48)),...
               ((r(:,3)==0.032) & (r(:,4)==0.128) & (r(:,5)==1.08))];
coh_128_32  = [((r(:,3)==0.128) & (r(:,4)==0.032) & (r(:,5)==0)),...
               ((r(:,3)==0.128) & (r(:,4)==0.032) & (r(:,5)==0.48)),...
               ((r(:,3)==0.128) & (r(:,4)==0.032) & (r(:,5)==1.08))];

coh_64_128  = [((r(:,3)==0.064) & (r(:,4)==0.128) & (r(:,5)==0)),...
               ((r(:,3)==0.064) & (r(:,4)==0.128) & (r(:,5)==0.48)),...
               ((r(:,3)==0.064) & (r(:,4)==0.128) & (r(:,5)==1.08))];
coh_128_64  = [((r(:,3)==0.128) & (r(:,4)==0.064) & (r(:,5)==0)),...
               ((r(:,3)==0.128) & (r(:,4)==0.064) & (r(:,5)==0.48)),...
               ((r(:,3)==0.128) & (r(:,4)==0.064) & (r(:,5)==1.08))];
        
acc_32_64   = [length(r(coh_32_64(:,1) & r(:,10)))/sum(coh_32_64(:,1)),...
               length(r(coh_32_64(:,2) & r(:,10)))/sum(coh_32_64(:,2)),...
               length(r(coh_32_64(:,3) & r(:,10)))/sum(coh_32_64(:,3))];

acc_64_32   = [length(r(coh_64_32(:,1) & r(:,10)))/sum(coh_64_32(:,1)),...
               length(r(coh_64_32(:,2) & r(:,10)))/sum(coh_64_32(:,2)),...
               length(r(coh_64_32(:,3) & r(:,10)))/sum(coh_64_32(:,3))];

%the number of 
N_32_64_mix   = [length(r(coh_32_64(:,1))) + length(r(coh_64_32(:,1))),...
                 length(r(coh_32_64(:,2))) + length(r(coh_64_32(:,2))),...
                 length(r(coh_32_64(:,3))) + length(r(coh_64_32(:,3)))];

acc_32_64_mix = [acc_32_64;acc_64_32]; % 3 columns -> interval 0,0.48,1.08
acc_32_64_mix = [mean(acc_32_64_mix(:,1)),mean(acc_32_64_mix(:,2)),mean(acc_32_64_mix(:,3))];
sem_32_64_mix = sqrt((acc_32_64_mix .* (1-acc_32_64_mix)) ./ N_32_64_mix);

acc_32_128   = [length(r(coh_32_128(:,1) & r(:,10)))/sum(coh_32_128(:,1)),...
                length(r(coh_32_128(:,2) & r(:,10)))/sum(coh_32_128(:,2)),...
                length(r(coh_32_128(:,3) & r(:,10)))/sum(coh_32_128(:,3))];

acc_128_32   = [length(r(coh_128_32(:,1) & r(:,10)))/sum(coh_128_32(:,1)),...
                length(r(coh_128_32(:,2) & r(:,10)))/sum(coh_128_32(:,2)),...
                length(r(coh_128_32(:,3) & r(:,10)))/sum(coh_128_32(:,3))];
        
N_32_128_mix   = [length(r(coh_32_128(:,1))) + length(r(coh_128_32(:,1))),...
                 length(r(coh_32_128(:,2))) + length(r(coh_128_32(:,2))),...
                 length(r(coh_32_128(:,3))) + length(r(coh_128_32(:,3)))];
            
acc_32_128_mix = [acc_32_128;acc_128_32]; % 3 columns -> interval 0,0.48,1.08
acc_32_128_mix = [mean(acc_32_128_mix(:,1)),mean(acc_32_128_mix(:,2)),mean(acc_32_128_mix(:,3))];
sem_32_128_mix = sqrt((acc_32_128_mix .* (1-acc_32_128_mix)) ./ N_32_128_mix);

acc_64_128   = [length(r(coh_64_128(:,1) & r(:,10)))/sum(coh_64_128(:,1)),...
                length(r(coh_64_128(:,2) & r(:,10)))/sum(coh_64_128(:,2)),...
                length(r(coh_64_128(:,3) & r(:,10)))/sum(coh_64_128(:,3))];

acc_128_64   = [length(r(coh_128_64(:,1) & r(:,10)))/sum(coh_128_64(:,1)),...
                length(r(coh_128_64(:,2) & r(:,10)))/sum(coh_128_64(:,2)),...
                length(r(coh_128_64(:,3) & r(:,10)))/sum(coh_128_64(:,3))];

N_64_128_mix   = [length(r(coh_64_128(:,1))) + length(r(coh_128_64(:,1))),...
                 length(r(coh_64_128(:,2))) + length(r(coh_128_64(:,2))),...
                 length(r(coh_64_128(:,3))) + length(r(coh_128_64(:,3)))];
                     
acc_64_128_mix = [acc_64_128;acc_128_64]; % 3 columns -> interval 0,0.48,1.08
acc_64_128_mix = [mean(acc_64_128_mix(:,1)),mean(acc_64_128_mix(:,2)),mean(acc_64_128_mix(:,3))];
sem_64_128_mix = sqrt((acc_64_128_mix .* (1-acc_64_128_mix)) ./ N_64_128_mix);

if (equal == 1)
%% Plot equal Coherences

    errorbar(intervals, acc_same_32, sem_same_32, 'om', 'MarkerFaceColor', 'm','MarkerSize',9)
    hold on
    errorbar(intervals, acc_same_64, sem_same_64, 'ob', 'MarkerFaceColor', 'b','MarkerSize',9)
    hold on
    errorbar(intervals, acc_same_128, sem_same_128, 'oc', 'MarkerFaceColor', 'c','MarkerSize',9)
    hold on
    plot(intervals, [p_e(1), p_e(1), p_e(1)], '-m', 'LineWidth', 3.5)
    hold on 
    plot(intervals, [p_e(2), p_e(2), p_e(2)], '-b', 'LineWidth', 3.5)
    hold on
    plot(intervals, [p_e(3), p_e(3), p_e(3)], '-c', 'LineWidth', 3.5)
    xlim([-0.05 1.25])
    ylim([0.5 0.93])
    set(gca,'XTick',intervals,'fontsize',10)
    set(gca,'xticklabel',({'0','480','1080'}))
    set(gca,'YTick',[0.5,0.6,0.7,0.8,0.9],'fontsize',13)
    set(gca, 'box', 'off')

    h1 = annotation('arrow','Color','m','LineWidth', 0.75);  % store the arrow information in ha
    h1.Parent = gca;           % associate the arrow to the current axes
    h1.X = [1.23 1.13];          % the location in data units
    h1.Y = [p_single(1) p_single(1)];
    h2 = annotation('arrow','Color','b','LineWidth', 0.75);  % store the arrow information in ha
    h2.Parent = gca;           % associate the arrow to the current axes
    h2.X = [1.23 1.13];          % the location in data units
    h2.Y = [p_single(2) p_single(2)];
    h3 = annotation('arrow','Color','c','LineWidth', 0.75);  % store the arrow information in ha
    h3.Parent = gca;           % associate the arrow to the current axes
    h3.X = [1.23 1.13];          % the location in data units
    h3.Y = [p_single(3) p_single(3)];

    xlabel('Inter-pulse interval (ms)')
    ylabel('Probability Correct')

else

%% Plot unequal Coherences

    errorbar(intervals, acc_32_64_mix, sem_32_64_mix, 'om', 'MarkerFaceColor', 'm','MarkerSize',9)
    hold on  
    errorbar(intervals, acc_32_128_mix, sem_32_128_mix, 'ob', 'MarkerFaceColor', 'b','MarkerSize',9)
    hold on
    errorbar(intervals, acc_64_128_mix, sem_64_128_mix, 'oc', 'MarkerFaceColor', 'c','MarkerSize',9)
    hold on
    plot(intervals, [p_e(4), p_e(4), p_e(4)], '-m', 'LineWidth', 3.5)
    hold on 
    plot(intervals, [p_e(5), p_e(5), p_e(5)], '-b', 'LineWidth', 3.5)
    hold on 
    plot(intervals, [p_e(6), p_e(6), p_e(6)], '-c', 'LineWidth', 3.5)
    xlim([-0.05 1.25])
    ylim([0.5 0.93])

    set(gca, 'box', 'off')
    set(gca,'XTick',intervals,'fontsize',10)
    set(gca,'xticklabel',({'0','480','1080'}))
    set(gca,'YTick',[0.5,0.6,0.7,0.8,0.9],'fontsize',13)
    xlabel('Inter-pulse interval (ms)')
    ylabel('Probability Correct')
end
hold on

end

