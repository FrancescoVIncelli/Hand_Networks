%% AIM 2.2 - Compute binary global (Global and Local Efficiency) graph indices in the four conditions. (LHM, RHM, LHI, RHI)


function [distance_matrix, global_efficiency] = efficiency(PDC_Bin)
    %%  Compute distance matrices
    distance_matrix = distances(digraph(PDC_Bin));


    %%  Compute binary Global Efficiency values
    global_efficiency = Global_Efficency(distance_matrix);

end


%%  function for binary Global Efficiency

function [value] = Global_Efficency(M)
[rows, cols] = size(M); 
N=rows;
    sum=0;
    for i =1:rows
        for j = 1:cols
            if i ~= j 
                if(M(i,j)~=0)
                sum=sum+(1/M(i,j));
                end
                
            end
        end
    end
    
    value=sum/(N*(N-1));
%     disp("Efficiency:Value")
%     disp(value) 
end