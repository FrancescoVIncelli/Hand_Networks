function [LHM_data, LHI_data, RHM_data, RHI_data, hdr] = dataset_load()
% disp("------------------Loading Dataset-------------------");

% [hdr, data] = edfread("S004R07.edf");
% [data, header] = ReadEDF("S004R07.edf");
[data1,header1] =  lab_read_edf(fullfile('..','data','S001R03.edf'));
[data2,header2] =  lab_read_edf(fullfile('..','data','S001R04.edf'));
[data3,header3] =  lab_read_edf(fullfile('..','data','S001R07.edf'));
[data4,header4] =  lab_read_edf(fullfile('..','data','S001R08.edf'));
[data5,header5] =  lab_read_edf(fullfile('..','data','S001R11.edf'));
[data6,header6] =  lab_read_edf(fullfile('..','data','S001R12.edf'));

hdr = header1;

[LHM_data, RHM_data, LHI_data, RHI_data] = Merge(data1,data2,data3,data4,data5,data6,header1,header2,header3,header4,header5,header6);

function [LHM, RHM, LHI, RHI] = Merge(data1,data2,data3,data4,data5,data6,header1,header2,header3,header4,header5,header6)
    [LHM3, RHM3] = split_data(data1,header1);
    [LHM7, RHM7] = split_data(data3,header3);
    [LHM11, RHM11] = split_data(data5,header5);

    [LHI4, RHI4] = split_data(data2,header2);
    [LHI8, RHI8] = split_data(data4,header4);
    [LHI12, RHI12] = split_data(data6,header6);

    LHM = transpose([LHM3, LHM7, LHM11]);
    RHM = transpose([RHM3, RHM7, RHM11]);
    LHI = transpose([LHI4, LHI8, LHI12]);
    RHI = transpose([RHI4, RHI8, RHI12]);
end

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

end

