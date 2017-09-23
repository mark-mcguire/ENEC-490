%Lecture10

data=xlsread('catawba_data.xlsx');

temps = data(:,4);
flows = data(:,5);

days=length(temps);

W = zeros(days,1); 
losses = zeros(days,1);

for i = 1:days
    
    W(i) = (33.3/(1+exp(.15*(16.9-temps(i)))) + 127/flows(i));
    
    
    if W(i) > 37 && W(i) <= 40
    losses(i) = .25*2000*24;
    elseif W(i) > 40 && W(i) <= 42
    losses(i) = .50*2000*24;
    elseif W(i) > 42
    losses(i) = 2000*24;
    end
        
end
%convert losses to thousands 1000s
losses_dollars = (losses*100)/1000;

annual_losses = zeros(41,1);

for i = 1:41
    annual_losses(i) = sum(losses_dollars((i-1)*365+1:(i-1)*365+365));
end

sorted_losses = sort(annual_losses);
idx = round(.95*41);
CVar = sorted_losses(idx);


GWtemps=temps+2;

x=log(flows);
y=mean(x);
z=std(x);
a=(x-y)/z;
b=.9*y+1.2*z*a;
GWflows=exp(b);


GWW = zeros(days,1); 
GWlosses = zeros(days,1);

for i = 1:days
    
    GWW(i) = (33.3/(1+exp(.15*(16.9-GWtemps(i)))) + 127/GWflows(i));
    
    
    if GWW(i) > 37 && GWW(i) <= 40
    GWlosses(i) = .25*2000*24;
    elseif GWW(i) > 40 && GWW(i) <= 42
    GWlosses(i) = .50*2000*24;
    elseif GWW(i) > 42
    GWlosses(i) = 2000*24;
    end
        
end

GWlosses_dollars = (GWlosses*100)/1000;

GWannual_losses = zeros(41,1);

for i = 1:41
    GWannual_losses(i) = sum(GWlosses_dollars((i-1)*365+1:(i-1)*365+365));
end

GWsorted_losses = sort(GWannual_losses);
GWidx = round(.95*41);
GWCVar = GWsorted_losses(GWidx);


c=ceil(max(GWannual_losses)/100000)*100000;
edges =[0:10000:c];
figure;
histogram(annual_losses,edges)
hold on
histogram(GWannual_losses,edges)
ylabel('Frequency')
xlabel('Losses $1000s')
legend('1970-2010','Climate Change');
