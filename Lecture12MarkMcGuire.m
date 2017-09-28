
%Lecture12

data=xlsread('peak_forecasting.xlsx','RegressionData');
insample = data(1:9,:);
outsample = data(10:end,:);

Y = insample(:,2);
X = [ones(length(Y),1) insample(:,3:end)];
coeff = mvregress(X,Y);


% predicted
predicted = coeff(1) + coeff(2)*outsample(:,3) + coeff(3)*outsample(:,4) + coeff(4)*outsample(:,5) + coeff(5)*outsample(:,6);

% actual
actual = outsample(:,2);

% scatterplot
scatter(actual,predicted);

% RMSE
sq_errors = (predicted - actual).^2;  % Squared Errors
RMSE = sqrt(mean((sq_errors)));   % Root Mean Squared Error

data2=xlsread('peak_forecasting.xlsx','HistoricalTemps');
data2=data2(:,2);
years = floor(length(data2)/365);
annual_peak = zeros(years,1);


for i = 1:years
    annual = data2((i-1) * 365 +1: (i-1)*365+365);
    annual_peak(i) = max(annual);
end


mu = mean(annual_peak);
sd = std(annual_peak);
sample = (randn(1000,1)*sd)+ mu ;
%sample_final = (sample);

percapita = 0.87;
econindex = 1.80;
pop = 5.32;

% predicted

predicted = coeff(1) + coeff(2)*econindex + coeff(3)*pop + coeff(4)*percapita + coeff(5)*(sample);

figure;

hist(predicted);

a=zeros(1000,1);
b=25000+a;

reserve_margin=(b-predicted)/25000*100;
figure;
hist(reserve_margin);
xlabel('Resrve Margin %');
ylabel('Frequency out of 1000');
