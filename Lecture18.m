%Lecture18

%Define state vector
% 1 - sunny; 2 - rainy

x = [0 1];
P = [.9 .1; .5 .5];

% Probability of weather 10 days from now
x_n = zeros(10,2);
for i = 1:10
    x_n(i,:) = x*P^i;
end

% Steady state probability

% q (P - I) = 0

P_I = P - [1 0;0 1];

% Solve system of equations 
% -.1(q1) + .1(q2) = 0
%  .5(q1) - .5(q2) = 0
%   q1 + q2 = 1

% -.1(q1) + .1(1-q1) = 0; -->
% .5(q1)-.5(q2)=0


q1 = .5/.6;
q2 = 1-q1;
[q1 q2];


sunny = q1*365;
rainy = q2*365;

% 1-pro 2-skilled 3-unskilled

Prob=[.8 .1 .1; .6 .2 .2; .5 .25 .25];
a=[0 0 1];

b=a*(Prob^2);
prob_pro=b(1,1);

Prob_I=Prob-[1 0 0; 0 1 0; 0 0 1];


syms x y z
eqn1 = -.2*(x) + .6*y +.5*z==0;
eqn2 = .1*(x) -.8*y +.25*z==0;
eqn3 = .1*(x) + .2*y -.75*z==0;
eqn4 = x + y+z==1;

[A, B] = equationsToMatrix([eqn1, eqn2, eqn3, eqn4], [x y z]);
X=linsolve(A,B);
