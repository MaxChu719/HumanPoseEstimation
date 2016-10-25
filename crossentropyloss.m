function Y = crossentropyloss(x, c, dzdy)
assert(numel(x) == numel(c));
assert(all(size(x) == size(c)));

total_size = numel(x);
if nargin == 2 || isempty(dzdy)
    log_x = log(x);
    log_1_minus_x = log(1 - x);
    delta_y = -(c.*log_x + (1-c).*log_1_minus_x);
    for idx = 1:total_size
        if c(idx) < 0
            delta_y(idx) = 0;
        end
    end
    
    Y = sum(delta_y);
elseif nargin == 3 && ~isempty(dzdy)
    
    assert(numel(dzdy) == 1);
 
    Y = dzdy * (x - c);  
    
    for idx = 1:total_size
        if c(idx) < 0
            Y(idx) = 0;
        end
    end
end