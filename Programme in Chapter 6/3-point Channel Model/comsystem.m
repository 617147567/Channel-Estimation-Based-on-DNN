function y=comsystem(s,L,h,SNR)
N=length(s);   % N = signal length
X=zeros(N+L-1,L); % L = channel taps number

%for  l=1:L
%X(l:N,l)=s(1:(N-l+1));

for  n=1:L
X(n:N+n-1,n)=s(1:N);   %this is convolution matrix,

end
w=X*h;  % this denotes s and h do convolution operations
y=awgn(w,SNR); %add noise
end