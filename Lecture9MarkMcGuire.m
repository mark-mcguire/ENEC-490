%Lecture9

[data text combined]  = xlsread('state_fuel_cf.xlsx');

%conditional 
state = 'NC';
fuel = 'SUN';
cf = .20;

% state probabilities
a = strcmp(state,text(:,1));
state_plants = find(a(:,1)>0);
state_prob = length(state_plants)/length(data);

%sun probability
b = strcmp(fuel,combined(:,2));
fuel_plants = find(b(:,1)>0);
fuel_prob = length(fuel_plants)/length(data);

%capacity factor prob
cf_plants = find(data(:,1) > .2);
cf_prob = length(cf_plants)/length(data);

%plant in NC amoung US solar
d=strcmp(fuel,combined(state_plants,2));
NCsun=find(d(:,1)>0);
NCsunprob= length(NCsun)/length(fuel_plants);

%plant is solar amoung NC plants
e=strcmp(state,combined(fuel_plants,1));
solarplant=find(e(:,1)>0);
plant_cond_Nc=length(solarplant)/length(state_plants);

%solar plant in NC cp>.2
f = combined(fuel_plants,:);
g = strcmp(state,f(:,1));
h = f(g,:);
fuel_state_cf_plants = 0;
for i = 1:length(h)
    if h{i,3} > cf
        fuel_state_cf_plants = fuel_state_cf_plants + 1;
    end
end
NCcp=fuel_state_cf_plants/length(data);

%>.2 condtion on having also selected NC
x = fuel_state_cf_plants/length(solarplant);
