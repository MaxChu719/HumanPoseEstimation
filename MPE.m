function mpe = MPE(opts, labels, res)
if opts.batchSize > 1
    predictions = gather(res(end-1).x) ;
else
    predictions = res(end).x;
end

delta = predictions - labels;
total_size = numel(labels);
non_valid_count = 0;
for idx = 1:total_size
    if labels(idx) < 0
        delta(idx) = 0;
        non_valid_count = non_valid_count + 1;
    end
end

mpe = 0;
batchSize = size(labels, 4);
for b = 1:batchSize
    for i = 0:13
        mpe = mpe + sqrt(delta(1,1,2*i + 1,b)^2 + delta(1,1,2*i + 2,b)^2);
    end
end
mpe = mpe * total_size / (total_size - non_valid_count);
end