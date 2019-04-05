function y=comsystem(s,L,h,SNR)

% s=[0,0,1,2,0,1,2,1,0,2,0,0,2,0,1,1,0,1,1,1,-1,1,0,-1,-1,1,1,0,0,1,0,1,1,1,2,1,2,0,1,2,1,0,0,1,1,1,0,-2,1,-1,-1,0,-1,2,0,-1,-1,1,1,0,0,0,1,2];
% L=30;
% h=wgn(L,1000,0,'complex'); 
% SNR=5;

N=length(s);   % N = signal length
X=zeros(N+L-1,L); % L = channel taps number

for  n=1:L
X(n:N+n-1,n)=s(1:N);
end
w=X*h;


 y=awgn(w,SNR,'measured'); %add noise
end