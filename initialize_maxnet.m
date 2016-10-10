function net = initialize_maxnet()
%net.meta.inputSize = [220, 220, 3, 1] ;
net.meta.normalization.imageSize = [220, 220, 3] ;
net.layers = { } ;

id = 0;

id = id + 1;
net = add_block(net, id, 7, 7, 3, 64, 3, 3) ;
net.layers{end+1} = struct('type', 'pool', 'name', sprintf('pool%d', id), ...
                           'method', 'max', ...
                           'pool', [2 2], ...
                           'stride', 2, ...
                           'pad', 0) ;

id = id + 1;
net = add_block(net, id, 3, 3, 64, 128, 1, 1) ;
net.layers{end+1} = struct('type', 'pool', 'name', sprintf('pool%d', id), ...
                           'method', 'max', ...
                           'pool', [2 2], ...
                           'stride', 2, ...
                           'pad', 0) ;

id = id + 1;
net = add_block(net, id, 3, 3, 128, 256, 1, 1) ;
id = id + 1;
net = add_block(net, id, 3, 3, 256, 512, 1, 1) ;
net.layers{end+1} = struct('type', 'pool', 'name', sprintf('pool%d', id), ...
                           'method', 'max', ...
                           'pool', [2 2], ...
                           'stride', 2, ...
                           'pad', 0) ;
                       
id = id + 1;                       
net = add_block(net, id, 3, 3, 512, 512, 1, 1) ;
id = id + 1;
net = add_block(net, id, 3, 3, 512, 1024, 1, 1) ;
net.layers{end+1} = struct('type', 'pool', 'name', sprintf('pool%d', id), ...
                           'method', 'max', ...
                           'pool', [2 2], ...
                           'stride', 2, ...
                           'pad', 0) ;
                       
id = id + 1;
net = add_block(net, id, 4, 4, 1024, 4096, 1, 0) ;
id = id + 1;
net = add_block(net, id, 1, 1, 4096, 4096, 1, 0) ;
id = id + 1;
net = add_block(net, id, 1, 1, 4096, 28, 1, 0) ;
net.layers(end) = [] ;
net.layers{end+1} = struct('type', 'sigmoid', 'name', sprintf('sigmoid%d',id)) ;

% Add a loss (using a custom layer)
net = addCustomLossLayer(net, @l2LossForward, @l2LossBackward) ;

% Consolidate the network, fixing any missing option
% in the specification above.

net = vl_simplenn_tidy(net) ;
end

% --------------------------------------------------------------------
function net = add_block(net, id, h, w, in, out, stride, pad)
% --------------------------------------------------------------------

id = id + 1;
info = vl_simplenn_display(net) ;
fc = (h == info.dataSize(1,end) && w == info.dataSize(2,end)) ;
if fc
    name = 'fc' ;
else
    name = 'conv' ;
end
convOpts = {'CudnnWorkspaceLimit', 1024*1024*1204} ;
net.layers{end+1} = struct('type', 'conv', 'name', sprintf('%s%d', name, id), ...
    'weights', {xavier(h, w, in, out)}, ...
    'stride', stride, ...
    'pad', pad, ...
    'dilate', 1, ...
    'learningRate', [1 2], ...
    'weightDecay', [1 0], ...
    'opts', {convOpts}) ;
net.layers{end+1} = struct('type', 'bnorm', 'name', sprintf('bn%s',id), ...
    'weights', {{ones(out, 1, 'single'), zeros(out, 1, 'single'), zeros(out, 2, 'single')}}, ...
    'epsilon', 1e-4, ...
    'learningRate', [2 1 0.1], ...
    'weightDecay', [0 0]) ;
net.layers{end+1} = struct('type', 'relu', 'name', sprintf('relu%s',id)) ;
end

% -------------------------------------------------------------------------
function weights = xavier(h, w, in, out)
sc = sqrt(2/(h*w*in)) ;
filters = randn(h, w, in, out, 'single')*sc ;
biases = zeros(out, 1, 'single');
weights = {filters, biases};
end