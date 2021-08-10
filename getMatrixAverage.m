function A_avg = getMatrixAverage(A, no_runs)
no_timesteps=size(A,1)/no_runs;
A_avg=zeros(no_timesteps, size(A,2));

%sum the data 
for row=1:length(A)
    n = mod(row, no_timesteps);
    if(n==0)
        n=no_timesteps;
    end
    %v1,20
    A_avg(n,:) = A_avg(n,:) + A(row,:);
end

A_avg=A_avg./no_runs;
end