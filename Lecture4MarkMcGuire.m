x=xlsread('monthly_demandNC.xlsx');
d=annual_profile(x);
[months,years]=size(d);
differences = zeros(months,years-1);

for i = 1:12
    for j = 1:years-1
        differences (i,j)= (d(i,j+1) - d(i,j))/d(i,j);
    end
end

figure;
hold on;

for i=1:12
    plot(differences(i,:)*100, 'color', rand(1,3));
end

totals = sum(d);
monthly_fractions = zeros(months,years);
for i = 1:years
    monthly_fractions(:,i) = d(:,i)/totals(i);
end


figure; 
hold on;


for i  = 1:12
    plot(monthly_fractions(i,:)*100,'color',rand(1,3));
end



num_years = 10;
bootstrap_sample = zeros(12*num_years,1);
for i = 1:num_years
    for j = 1:12
    s = ceil(num_years*rand(1));
    bootstrap_sample((i-1)*12+j) = d(j,s);
    end
end

figure;

subplot(2,2,1);
plot(bootstrap_sample);

subplot(2,2,2);
autocorr(bootstrap_sample);

montecarlo=zeros(12*num_years,1);
for i = 1:num_years
    for j = 1:12
    s = randn(num_years*rand(1));
    montecarlo((i-1)*12+j) = d(j,s);
    end
end
