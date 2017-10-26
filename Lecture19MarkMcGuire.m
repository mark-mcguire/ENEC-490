% %Lecture 19

% %Markov Chain Price Spikes
data = xlsread('price_spikes.xlsx');
dap = data(:,1);
rtp = data(:,2);
jumps = rtp - dap;
histogram(jumps);
% 
% % states 
% %0;  1-20  21-50 50-100 100+
% 
bins = zeros(5,1);

for i = 1:length(jumps)-1
   if jumps(i) == 0
       bins(1) = bins(1) + 1;
   elseif jumps(i) > 0 && jumps(i) <= 20
       bins(2) = bins(2) + 1;
   elseif jumps(i) > 20 && jumps(i) <= 50
       bins(3) = bins(3) + 1;
   elseif jumps(i) > 50 && jumps(i) <= 100
       bins(4) = bins(4) + 1;
   else
       bins(5) = bins(5) + 1;
   end
end


bin1 = zeros(5,1);
bin2 = zeros(5,1);
bin3 = zeros(5,1);
bin4 = zeros(5,1);
bin5 = zeros(5,1);

for i = 1:length(jumps)-1
   if jumps(i) == 0
       if jumps(i+1) ==0
           bin1(1) = bin1(1) +1;
       elseif jumps(i+1) > 0 && jumps(i+1) <=20
       bin1(2) = bin1(2) + 1;
       elseif jumps(i+1) >20 && jumps(i+1) <=50
           bin1(3)=bin1(3)+1;
       elseif jumps(i+1) >50 && jumps(i+1) <=100
           bin1(4)=bin1(4)+1;
       else
           bin1(5)=bin1(5) +1;
       end
   elseif jumps(i) > 0 && jumps(i) <= 20
     if jumps(i+1) ==0
           bin2(1) = bin2(1) +1;
       elseif jumps(i+1) > 0 && jumps(i+1) <=20
       bin2(2) = bin2(2) + 1;
       elseif jumps(i+1) >20 && jumps(i+1) <=50
           bin2(3)=bin2(3)+1;
       elseif jumps(i+1) >50 && jumps(i+1) <=100
           bin2(4)=bin2(4)+1;
       else
           bin2(5)=bin2(5) +1;
     end
   elseif jumps(i) > 20 && jumps(i) <= 50
       if jumps(i+1) ==0
           bin3(1) = bin3(1) +1;
       elseif jumps(i+1) > 0 && jumps(i+1) <=20
       bin3(2) = bin3(2) + 1;
       elseif jumps(i+1) >20 && jumps(i+1) <=50
           bin3(3)=bin3(3)+1;
       elseif jumps(i+1) >50 && jumps(i+1) <=100
           bin3(4)=bin3(4)+1;
       else
           bin3(5)=bin3(5) +1;
       end
  elseif jumps(i) > 50 && jumps(i) <= 100
   if jumps(i+1) ==0
           bin4(1) = bin4(1) +1;
       elseif jumps(i+1) > 0 && jumps(i+1) <=20
       bin4(2) = bin4(2) + 1;
       elseif jumps(i+1) >20 && jumps(i+1) <=50
           bin4(3)=bin4(3)+1;
       elseif jumps(i+1) >50 && jumps(i+1) <=100
           bin4(4)=bin4(4)+1;
       else
           bin4(5)=bin4(5) +1;
   end
  else
    if jumps(i+1) ==0
           bin5(1) = bin5(1) +1;
       elseif jumps(i+1) > 0 && jumps(i+1) <=20
       bin5(2) = bin5(2) + 1;
       elseif jumps(i+1) >20 && jumps(i+1) <=50
           bin5(3)=bin5(3)+1;
       elseif jumps(i+1) >50 && jumps(i+1) <=100
           bin5(4)=bin5(4)+1;
       else
           bin5(5)=bin5(5) +1;
    end
   end
end

x=[bin1 bin2 bin3 bin4 bin5];
y=[1/522 0 0 0 0;
    0 1/179 0 0 0;
    0 0 1/25 0 0; 
    0 0  0 1/15 0;
    0 0 0 0 1/2];
P=y*x;

    
    %Convert
    C = zeros(5);
    C(:,1) = P(:,1);
    C(:,2) = C(:,1) + P(:,2);
    C(:,3) = C(:,2) + P(:,3);
    C(:,4) = C(:,3) + P(:,4);
    C(:,5) = C(:,4) + P(:,5);
       
    %Monte Carlo
    simulated = zeros(1000,1);
    state = 1;
    for i = 1:1000
       sample = rand(1); 
       if sample > 0 && sample <= C(state,1)
           simulated(i) = 0;
           state = 1;
       elseif sample > C(state,1) && sample <= C(state,2)
           simulated(i) = 10;
           state = 2;
       elseif sample > C(state,2) && sample <= C(state,3)
           simulated(i) = 35;
           state = 3;
       elseif sample > C(state,3) && sample <= C(state,4)
           simulated(i) = 75;
           state = 4;
       else  sample > C(state,4) && sample <= C(state,5)
           simulated(i) = 150;
           state = 5;
       end
    end
    
    plot(jumps,'r'); hold on; plot(simulated);
