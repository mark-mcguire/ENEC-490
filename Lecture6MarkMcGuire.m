%Lecture 6

temps=csvread('tempdata.csv');
temps=temps(:,2);
%Read electricity demand data
data_2014 = csvread('hourly-day-ahead-bid-data-2014.csv',5,1);
vector = mat2vec(data_2014);
peak = zeros(365,1);

for i=1:365
    peak(i) = max(data_2014(i,:));
end

peak=peak/1000;

% forms 2-column matrix
combined = [temps peak];

% clusters for each row
IDX = kmeans(combined,3);

% forms 3-column matrix
clustered_data = [combined IDX];

% sorts 
sorted_data = sortrows(clustered_data,3);

% find indices of cluster 1
ONE = clustered_data(clustered_data(:,3)==1,1:2);

% find indices of cluster 2
TWO = clustered_data(clustered_data(:,3)==2,1:2);

% find indices of cluster 3
THREE = clustered_data(clustered_data(:,3)==3,1:2);

figure; 
hold on;
scatter(ONE(:,1),ONE(:,2),'r'); 
scatter(TWO(:,1),TWO(:,2) ,'b');
scatter(THREE(:,1),THREE(:,2) ,'g');
xlabel('Average Temperature (degrees F)','FontSize',14);
ylabel('Peak Electricity Demand (MWh)','FontSize',14);
legend('Cluster 1', 'Cluster 2', 'Cluster 3');
hold off;

hourlydemand_jan=zeros(24,1);

for i=1:24
    hourlydemand_jan(i)=mean(data_2014(1:31,i));
end

hourlydemand_june=zeros(24,1);

for i=1:24
    hourlydemand_june(i)=mean(data_2014(182:212,i));
end

figure;
hold on;
plot(hourlydemand_jan);
plot(hourlydemand_june);
xlabel('Hour of Day', 'FontSize', 14);
ylabel('Average Demand (MWh)','FontSize',14);
legend('January','June');
hold off;

vec=1:1:7;

x = [repmat(vec(1:7),52,1)];
year=mat2vec(x);
onerow=[1];
weekdays=horzcat(year',onerow);
weekdays=weekdays';
a=[weekdays peak];

p=sortrows(a,1);

ONE = p(1:53,2);
TWO = p(54:105,2);
% ...

% will have to shorten ONE because it's longer
ONE = ONE(1:52);

% put them in a matrix
X = [ONE TWO THREE FOUR FIVE SIX SEVEN];

figure;
% might have to change labels depending on what day numbers 1-7 correspond to in 2014
boxplot(X,'Labels',{'SUN','MON','TUE','WED','THU','FRI','SAT'});
