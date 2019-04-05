function h_est=ls(y,s,L)
N=length(s);
X=zeros(N+L-1,L);
%for l=1:L
%H(l:N,l)=s(1:(N-l+1));

for  n=1:L
X(n:N+n-1,n)=s(1:N);
end
%h_est=(X'*X)\(X'*y);
h_est=(X.'*X)\(X.'*y);
end