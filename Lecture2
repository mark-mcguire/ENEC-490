a=xlsread('GasPrices', 'Data 1','B11:B370');

m=zeros(30,1);
counter=1;
counter2=12;
for i=1:30

    m(i)=mean(a(counter:counter2));
    counter=counter+12;
    counter2=counter2+12;

end
b=1987:1:2016;
x=horzcat(b',m);
xlswrite('monthly_average_price.xlsx', x);
