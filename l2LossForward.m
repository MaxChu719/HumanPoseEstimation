function y = l2LossForward(x,r)
delta = x - r ;

for idx = 1:numel(r)
    if r(idx) < 0
        delta(idx) = 0;
    end
end

y = sum(delta(:).^2) ;
