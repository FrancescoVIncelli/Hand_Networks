clear all
% [hdr, data] = edfread("S004R07.edf");
% [data, header] = ReadEDF("S004R07.edf");
[data1,header1] =  lab_read_edf("Dataset/S001R03.edf");
[data2,header2] =  lab_read_edf("Dataset/S001R04.edf");

% record = data(1:64,:);
% y =transpose(record);

[LHM, RHM] = split_data(data1,header1);
[LHI, RHI] = split_data(data2,header2);

function [left_records, right_records] = split_data(data,header)
    pos_list = header.events.POS;
    typ_list = header.events.TYP;
    left_records = [];
    right_records = [];
    prev_idx = 1;

    for i = 1:30
       if i <= 29
           next_idx = pos_list(:,i+1)-1;
       end
       if strcmp(typ_list(:,i), 'T1')       % 'T1': left fist
           for r_idx = prev_idx:next_idx
               left_records = [left_records,data(:,r_idx)];
           end
       elseif strcmp(typ_list(:,i), 'T2')   % 'T2': right fist
           for r_idx = prev_idx:next_idx
               right_records = [right_records,data(:,r_idx)];
           end
       end
       prev_idx = next_idx+1;
    end
end


