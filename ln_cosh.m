function y = ln_cosh(x, c, dzdy)
assert(numel(x) == numel(c));
assert(all(size(x) == size(c)));

delta = x - c ;
if nargin == 2 || isempty(dzdy)
    total_size = numel(c);
    for idx = 1:total_size
        if c(idx) < 0
            delta(idx) = 0;
        end
    end
    
    y = sum(log(cosh(delta)));
elseif nargin == 3 && ~isempty(dzdy)
    y =  dzdy * tanh(delta) ;
    
    total_size = numel(c);
    for idx = 1:total_size
        if c(idx) < 0
            y(idx) = 0;
        end
    end
end