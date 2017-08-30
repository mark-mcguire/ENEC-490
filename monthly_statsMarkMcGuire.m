function [ m ] = monthly_stats( vector )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
m=zeros(12,2);

for i=1:12
    m(i,1)=mean(sum(vector(i:12:end,:)));
    m(i,2)=std((vector(i:12:end,:)));
end

end
