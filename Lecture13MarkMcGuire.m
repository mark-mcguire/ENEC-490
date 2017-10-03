%Lecture13

%Read electricity demand data
data = csvread('PJM.csv',5,1);
v = mat2vec(data);

%winter
figure;
autocorr(v(1:1200));

%summer
figure;
autocorr(v(4000:5200));

%fall
figure;
autocorr(v(6000:7200));

peak=zeros(365,1);
for i=1:365
    peak(i,1)=max(data(i,:));
end

figure;
autocorr(peak,60);

difference=zeros(365,1);
for j=2:365
    difference(j,1)=peak(j)-peak(j-1);
end

figure;
plot(difference);

smoothed=zeros(335:1);
for k=16:350;
    smoothed(k-15,1)=mean(peak(k-15:k+15));
end

peak=peak(16:350,1);


figure;
plot(peak);
hold on;
plot(smoothed);

R=peak-smoothed;
figure;
plot(R);
figure;
autocorr(R);
