function [result, dots, aborted] = create(subName, position, old, new)

    result  = [];
    dots    = [];
    aborted = [];
    
    % load data from part1, which doesn't have the dots position 
    if old == 1
        for i = 2 : 7   
            file_name   = sprintf('%1$s%2$s_%3$s_block_%4$d%5$s','Part1\',subName,position,i,'.mat');
            if exist(file_name, 'file') == 2
                r           = load(file_name);
                res         = r.data.result;
                nan_indx    = res(isnan(res(:,9)));
                res(nan_indx,:)     = [];
                result      = [result; res];
                aborted     = [aborted, numel(nan_indx)];
            end
        end
    end
    % load data of part2, whih includes positions of the dots
    if new == 1
        for i = 1 : 13
            file_name       = sprintf('%1$s%2$s_%3$s_block_%4$d%5$s','Part2\',subName,position,i,'.mat');
            if exist(file_name, 'file') == 2
                r           = load(file_name);
                res         = r.data.result;
                nan_indx    = res(isnan(res(:,9)));
                res(nan_indx,:)     = [];
                result  = [result; res];
                if old == 0
                    dot         = r.dot.position;
                    dot(nan_indx,:,:) = [];
                    dots        = [dots; dot];
                end
                aborted = [aborted, numel(nan_indx)];
            end
        end
    end
    result(:,1)     = [];
end