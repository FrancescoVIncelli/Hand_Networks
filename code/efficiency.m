%% AIM 2.2 - Compute binary global (Global and Local Efficiency) graph indices in the four conditions. (LHM, RHM, LHI, RHI)
   %%% Written by : Francesco Peracchia
	
%%
function [distance_matrix, global_efficiency, local_efficiency_avg, local_efficiency_all] = efficiency(PDC_Bin)
    %%  Compute distance matrices
    distance_matrix = distances(digraph(PDC_Bin));

    %%  Compute binary Global Efficiency values
    global_efficiency = Global_Efficiency(distance_matrix);

	%%  Compute binary Local Efficiency values
    [local_efficiency_avg, local_efficiency_all] = Local_Efficiency(PDC_Bin);
end


%%  function for binary Global Efficiency

function [value] = Global_Efficiency(M)
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

%%  function Subnetwork for Local Efficiency

function [Average,values]  = Local_Efficiency(M)
%     disp("_____________Computing Subnet & Local Efficiency_____________");
    [rows, cols] = size(M); 
    N=rows;
    values=[];
	for i=1:rows
%         disp("SINGLE NODE " +i );   
        C=M;
        A=[];
        for j=1:cols
            if M(i,j)==0 && M(j,i)==0   && i ~= j      
                %disp("_node " +j+ " is not directly connected with node " +i );     
                A=[A j];                     
            end
        end
        C(i,:)=[];
        C(:,i)=[];
        %disp(C);
       
       
        for k=1:length(A)
            if i<A(k)
                A(k)=A(k)-1;
            end
            %disp(A(k));           
        end

        for t=1:length(A)
            %disp("removing this nodes: "+A(t)); 
            C(A(t),:)=[];
            C(:,A(t))=[];
            for d=1:length(A)
                if A(t)<A(d)
                    A(d)=A(d)-1;
                end
            end  
        end

        C=distances(digraph(C));
%         disp("Distances Matrix");
%         disp(C);
        T=Global_Efficiency(C);        
        if isnan(T)
            T=0;
        end        
        values=[values T];
	end
       
    Sum=0;
    for a=1:length(values)
        Sum=Sum+values(a); 
    end
    Average=Sum/N;
end

           
      
           