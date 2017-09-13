A=xlsread('coal860_data.xlsx', '2012_coal');
B=xlsread('coal860_data.xlsx', '2015_coal');

bins=zeros(91,1);

for i=1:1255;
    bins(A(i,4)-1924,1)=bins(A(i,4)-1924,1)+A(i,3);
end


C=setdiff(A,B,'rows');

bins2=zeros(91,1);
for i=1:313;
    bins2(C(i,4)-1924,1)=bins2(C(i,4)-1924,1)+C(i,3);
end


figure;
%xlabel('Year');
%ylabel('Capacity (MW)');
bar(bins,'FaceColor', [.8 .8 .8], 'EdgeColor', [.7 .7 .7], 'LineWidth', .01);
hold on;
bar(bins2);
hold off;
ax=gca;
ax.XTick=([1 11 21 31 41 51 61 71 81 91]);
ax.XTickLabel=({'1925','1935','1945','1955','1965','1975','1985','1995','2005','2010'});

set(ax,'FontSize',12)
