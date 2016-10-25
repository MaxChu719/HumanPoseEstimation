function y = l2Loss(x, c, dzdy)
assert(numel(x) == numel(c));
assert(all(size(x) == size(c)));

if nargin == 2 || isempty(dzdy)
    delta = x - c ;
    
    total_size = numel(c);
    for idx = 1:total_size
        if c(idx) < 0
            delta(idx) = 0;
        end
    end
    
    y = sum(delta(:).^2);
elseif nargin == 3 && ~isempty(dzdy)
    y = 2 * dzdy * (x - c) ;
    
    total_size = numel(c);
    for idx = 1:total_size
        if c(idx) < 0
            y(idx) = 0;
        end
    end
end