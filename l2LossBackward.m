function dx = l2LossBackward(x,r,p)
dx = 2 * p * (x - r) ;

for idx = 1:numel(r)
    if r(idx) < 0
        dx(idx) = 0;
    end
end
