%Lecture11

% data=xlsread('temp_demand.xlsx');
t_data = xlsread('temp_demand.xlsx','training');
v_data = xlsread('temp_demand.xlsx','validation');
t_temps = t_data(:,1);
t_demand = t_data(:,3);
v_temps = v_data(:,1);
v_demand = v_data(:,3);

t_CDD = max(t_temps - 65,0);
t_HDD = max(65 - t_temps,0);
v_CDD = max(v_temps - 65,0);
v_HDD = max(65 - v_temps,0);

X = [ones(length(t_CDD),1) t_CDD t_HDD];

[BETA,SIGMA,RESID]=mvregress(X,t_demand);

v_demand_pred=10023+388*v_CDD+121*v_HDD;

figure;
scatter(v_demand_pred,v_demand);
xlabel('Predicted Demand (MWh)');
ylabel('Actual Demand (MWh)');

SSE=zeros(1279,1);
for i=1:1279
    SSE(i)=((v_demand(i)-v_demand_pred(i))^2);
end
SSE=sum(SSE);

ybar=mean(v_demand);

SST=zeros(1279,1);
for i=1:1279
    SST(i)=((v_demand(i)-ybar)^2);
end
SST=sum(SST);

Rsqrd=1-(SSE/SST);

MSE=sqrt(SSE/1279);

RESID1=v_demand_pred-v_demand;

figure;
scatter(v_demand,RESID1);
xlabel('Actual Demand(MWh)');
ylabel('Residuals(MWh)');

