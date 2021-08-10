function A_stdev = getMatrixStdDev(A, no_runs, datacol)
no_timesteps=size(A,1)/no_runs;
W=zeros(no_timesteps, no_runs);

for i=1:no_runs
    %W(:,i) = A(1 + (i-1)*73 : i*73, datacol);
    
    W(:,i) = A(1 + (i-1)*no_timesteps : i*no_timesteps, datacol);
end

A_stdev = std(W');

end