function result = Create_ME(dots, result)
% Create Motion Energy Profile for each pulse

num_trial       = size(dots,1);
radius          = 2.5;          % radius of the stimulus in degrees
ppd             = 40.3;         % display spatial resolution (pixels per degree)
radius_pix      = round(ppd * radius);
stim_1          = zeros(radius_pix*2,radius_pix*2,15);  %Initialize matrices for first pulse of stimulus
stim_2          = zeros(radius_pix*2,radius_pix*2,15);  %Initialize matrices for second pulse of stimulus
energy_1        = NaN(num_trial,15);
energy_2        = NaN(num_trial,15);

%% Load filters

f1_0_9  = load('f1_0_9.mat'); 
f1_0    = f1_0_9.data;
f2_0_9  = load('f2_0_9.mat'); 
f2_0    = f2_0_9.data;
f3_0_9  = load('f3_0_9.mat'); 
f3_0    = f3_0_9.data;
f4_0_9  = load('f4_0_9.mat'); 
f4_0    = f4_0_9.data;

filters_r = {f1_0, f2_0, f3_0, f4_0};        % filters for rightward motion

%% Apply motion energy on pulses with gap duration bigger than zero

for i = 1 : num_trial
    % Choose double pulse trials with gap duration bigger than zero
    if (result(i,5) == 0 && result(i,2) == 0)
        disp(i)
        % for all 9 frames of motion create the aperture matrix, where
        % there is a dot, assign 1, otherwise 0
        for f = 1 : 9
            % first pulse
            a1  = cell2mat(dots(i,1,f));
            b1  = a1 + radius_pix + 1;               
            for h = 1:size(b1,2)
                x = b1(1,h)-1 : b1(1,h)+1;
                y = b1(2,h)-1 : b1(2,h)+1;
                x((x<1) | (x>radius_pix*2))  = [];
                y((y<1) | (y>radius_pix*2))  = [];
                stim_1(x,y,f) = 1;
            end
            % second pulse
            a2  = cell2mat(dots(i,2,f));
            b2  = a2 + radius_pix + 1;
            for h = 1:size(b2,2)
                x = b2(1,h)-1 : b2(1,h)+1;
                y = b2(2,h)-1 : b2(2,h)+1;
                x((x<1) | (x>radius_pix*2))  = [];
                y((y<1) | (y>radius_pix*2))  = [];
                stim_2(x,y,f) = 1;
            end           
        end
        % if the preferred direction is right
        temp1       = sum(sum(apply_motion_energy_filters(stim_1, filters_r),1));
        temp2       = sum(sum(apply_motion_energy_filters(stim_2, filters_r),1));
        if (result(i,8) == 1)    % if the preferred direction is left
            temp1   = temp1 * -1;
            temp2   = temp2 * -1;
        end
        energy_1(i,:) = temp1(:,:);     % Motion Energy of first pulse
        energy_2(i,:) = temp2(:,:);     % Motion Energy of second pulse
        % Reset the matrices
        stim_1 = 0 * stim_1;    
        stim_2 = 0 * stim_2;
    end
end


%% Add the calulated motion energy to the result
result      = [result(:,(1:12)), energy_1, energy_2];

end