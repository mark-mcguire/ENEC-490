s=xlsread('HenryHub.xls','Data 1', 'B136:B243');

x=monthly_stats(s);

jan = x(1,2)*randn(1000,1) + x(1,1);
april = x(4,2)*randn(1000,1)+x(4,1);

figure;
edges = -5:.5:30;
histogram(april,edges);
hold on;
histogram(jan,edges);
xlabel('Natural Gas Price ($/MMBtu)');
ylabel('Frequency');
legend('April','January');
