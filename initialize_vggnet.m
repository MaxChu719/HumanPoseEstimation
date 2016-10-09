function net = initialize_vggnet()

%net.meta.inputSize = [220, 220, 3, 1] ;
net.meta.normalization.imageSize = [220, 220, 3] ;
net.layers = { } ;

id = 0;

% -------------------------------------------------------------------------
id = id + 1;
net.layers{end+1} = struct(...
    'name', sprintf('conv%d', id), ...
    'type', 'conv', ...
    'weights', {xavier(3, 3, 3, 64)}, ...
    'stride', 1, ...
    'pad', 1, ...
    'learningRate', [1 2], ...
    'weightDecay', [1 0]) ;
net.layers{end+1} = struct(...
    'type', 'bnorm', 'name', sprintf('bn%d',id), ...
    'weights', {{ones(64, 1, 'single'), zeros(64, 1, 'single'), zeros(64, 2, 'single')}}, ...
    'epsilon', 1e-4, ...
    'learningRate', [2 1 0.1], ...
    'weightDecay', [0 0]) ;
net.layers{end+1} = struct('type', 'relu', 'name', sprintf('relu%d',id)) ;

id = id + 1;
net.layers{end+1} = struct(...
    'name', sprintf('conv%d', id), ...
    'type', 'conv', ...
    'weights', {xavier( 3, 3, 64, 64)}, ...
    'stride', 1, ...
    'pad', 1, ...
    'learningRate', [1 2], ...
    'weightDecay', [1 0]) ;
net.layers{end+1} = struct(...
    'type', 'bnorm', 'name', sprintf('bn%d',id), ...
    'weights', {{ones(64, 1, 'single'), zeros(64, 1, 'single'), zeros(64, 2, 'single')}}, ...
    'epsilon', 1e-4, ...
    'learningRate', [2 1 0.1], ...
    'weightDecay', [0 0]) ;
net.layers{end+1} = struct('type', 'relu', 'name', sprintf('relu%d',id)) ;

net.layers{end+1} = struct(...
    'name', sprintf('pool%d', id), ...
    'type', 'pool', ...
    'method', 'max', ...
    'pool', [2 2], ...
    'stride', 2, ...
    'pad', 0) ;

% -------------------------------------------------------------------------
id = id + 1;
net.layers{end+1} = struct(...
    'name', sprintf('conv%d', id), ...
    'type', 'conv', ...
    'weights', {xavier(3, 3, 64, 128)}, ...
    'stride', 1, ...
    'pad', 1, ...
    'learningRate', [1 2], ...
    'weightDecay', [1 0]) ;
net.layers{end+1} = struct(...
    'type', 'bnorm', 'name', sprintf('bn%d',id), ...
    'weights', {{ones(128, 1, 'single'), zeros(128, 1, 'single'), zeros(128, 2, 'single')}}, ...
    'epsilon', 1e-4, ...
    'learningRate', [2 1 0.1], ...
    'weightDecay', [0 0]) ;
net.layers{end+1} = struct('type', 'relu', 'name', sprintf('relu%d',id)) ;

id = id + 1;
net.layers{end+1} = struct(...
    'name', sprintf('conv%d', id), ...
    'type', 'conv', ...
    'weights', {xavier(3, 3, 128, 128)}, ...
    'stride', 1, ...
    'pad', 1, ...
    'learningRate', [1 2], ...
    'weightDecay', [1 0]) ;
net.layers{end+1} = struct(...
    'type', 'bnorm', 'name', sprintf('bn%d',id), ...
    'weights', {{ones(128, 1, 'single'), zeros(128, 1, 'single'), zeros(128, 2, 'single')}}, ...
    'epsilon', 1e-4, ...
    'learningRate', [2 1 0.1], ...
    'weightDecay', [0 0]) ;
net.layers{end+1} = struct('type', 'relu', 'name', sprintf('relu%d',id)) ;

net.layers{end+1} = struct(...
    'name', sprintf('pool%d', id), ...
    'type', 'pool', ...
    'method', 'max', ...
    'pool', [2 2], ...
    'stride', 2, ...
    'pad', 0) ;

% -------------------------------------------------------------------------
id = id + 1;
net.layers{end+1} = struct(...
    'name', sprintf('conv%d', id), ...
    'type', 'conv', ...
    'weights', {xavier(3, 3, 128, 256)}, ...
    'stride', 1, ...
    'pad', 1, ...
    'learningRate', [1 2], ...
    'weightDecay', [1 0]) ;
net.layers{end+1} = struct(...
    'type', 'bnorm', 'name', sprintf('bn%d',id), ...
    'weights', {{ones(256, 1, 'single'), zeros(256, 1, 'single'), zeros(256, 2, 'single')}}, ...
    'epsilon', 1e-4, ...
    'learningRate', [2 1 0.1], ...
    'weightDecay', [0 0]) ;
net.layers{end+1} = struct('type', 'relu', 'name', sprintf('relu%d',id)) ;

net.layers{end+1} = struct(...
    'name', sprintf('conv%d', id), ...
    'type', 'conv', ...
    'weights', {xavier(3, 3, 256, 256)}, ...
    'stride', 1, ...
    'pad', 1, ...
    'learningRate', [1 2], ...
    'weightDecay', [1 0]) ;
net.layers{end+1} = struct(...
    'type', 'bnorm', 'name', sprintf('bn%d',id), ...
    'weights', {{ones(256, 1, 'single'), zeros(256, 1, 'single'), zeros(256, 2, 'single')}}, ...
    'epsilon', 1e-4, ...
    'learningRate', [2 1 0.1], ...
    'weightDecay', [0 0]) ;
net.layers{end+1} = struct('type', 'relu', 'name', sprintf('relu%d',id)) ;

net.layers{end+1} = struct(...
    'name', sprintf('conv%d', id), ...
    'type', 'conv', ...
    'weights', {xavier(3, 3, 256, 256)}, ...
    'stride', 1, ...
    'pad', 1, ...
    'learningRate', [1 2], ...
    'weightDecay', [1 0]) ;
net.layers{end+1} = struct(...
    'type', 'bnorm', 'name', sprintf('bn%d',id), ...
    'weights', {{ones(256, 1, 'single'), zeros(256, 1, 'single'), zeros(256, 2, 'single')}}, ...
    'epsilon', 1e-4, ...
    'learningRate', [2 1 0.1], ...
    'weightDecay', [0 0]) ;
net.layers{end+1} = struct('type', 'relu', 'name', sprintf('relu%d',id)) ;

net.layers{end+1} = struct(...
    'name', sprintf('pool%d', id), ...
    'type', 'pool', ...
    'method', 'max', ...
    'pool', [2 2], ...
    'stride', 2, ...
    'pad', 0) ;

% -------------------------------------------------------------------------
id = id + 1;
net.layers{end+1} = struct(...
    'name', sprintf('conv%d', id), ...
    'type', 'conv', ...
    'weights', {xavier(3, 3, 256, 512)}, ...
    'stride', 1, ...
    'pad', 1, ...
    'learningRate', [1 2], ...
    'weightDecay', [1 0]) ;
net.layers{end+1} = struct(...
    'type', 'bnorm', 'name', sprintf('bn%d',id), ...
    'weights', {{ones(512, 1, 'single'), zeros(512, 1, 'single'), zeros(512, 2, 'single')}}, ...
    'epsilon', 1e-4, ...
    'learningRate', [2 1 0.1], ...
    'weightDecay', [0 0]) ;
net.layers{end+1} = struct('type', 'relu', 'name', sprintf('relu%d',id)) ;

net.layers{end+1} = struct(...
    'name', sprintf('conv%d', id), ...
    'type', 'conv', ...
    'weights', {xavier(3, 3, 512, 512)}, ...
    'stride', 1, ...
    'pad', 1, ...
    'learningRate', [1 2], ...
    'weightDecay', [1 0]) ;
net.layers{end+1} = struct(...
    'type', 'bnorm', 'name', sprintf('bn%d',id), ...
    'weights', {{ones(512, 1, 'single'), zeros(512, 1, 'single'), zeros(512, 2, 'single')}}, ...
    'epsilon', 1e-4, ...
    'learningRate', [2 1 0.1], ...
    'weightDecay', [0 0]) ;
net.layers{end+1} = struct('type', 'relu', 'name', sprintf('relu%d',id)) ;

net.layers{end+1} = struct(...
    'name', sprintf('conv%d', id), ...
    'type', 'conv', ...
    'weights', {xavier(3, 3, 512, 512)}, ...
    'stride', 1, ...
    'pad', 1, ...
    'learningRate', [1 2], ...
    'weightDecay', [1 0]) ;
net.layers{end+1} = struct(...
    'type', 'bnorm', 'name', sprintf('bn%d',id), ...
    'weights', {{ones(512, 1, 'single'), zeros(512, 1, 'single'), zeros(512, 2, 'single')}}, ...
    'epsilon', 1e-4, ...
    'learningRate', [2 1 0.1], ...
    'weightDecay', [0 0]) ;
net.layers{end+1} = struct('type', 'relu', 'name', sprintf('relu%d',id)) ;

net.layers{end+1} = struct(...
    'name', sprintf('pool%d', id), ...
    'type', 'pool', ...
    'method', 'max', ...
    'pool', [2 2], ...
    'stride', 2, ...
    'pad', 0) ;

% -------------------------------------------------------------------------
id = id + 1;
net.layers{end+1} = struct(...
    'name', sprintf('conv%d', id), ...
    'type', 'conv', ...
    'weights', {xavier(3, 3, 512, 512)}, ...
    'stride', 1, ...
    'pad', 1, ...
    'learningRate', [1 2], ...
    'weightDecay', [1 0]) ;
net.layers{end+1} = struct(...
    'type', 'bnorm', 'name', sprintf('bn%d',id), ...
    'weights', {{ones(512, 1, 'single'), zeros(512, 1, 'single'), zeros(512, 2, 'single')}}, ...
    'epsilon', 1e-4, ...
    'learningRate', [2 1 0.1], ...
    'weightDecay', [0 0]) ;
net.layers{end+1} = struct('type', 'relu', 'name', sprintf('relu%d',id)) ;

net.layers{end+1} = struct(...
    'name', sprintf('conv%d', id), ...
    'type', 'conv', ...
    'weights', {xavier(3, 3, 512, 512)}, ...
    'stride', 1, ...
    'pad', 1, ...
    'learningRate', [1 2], ...
    'weightDecay', [1 0]) ;
net.layers{end+1} = struct(...
    'type', 'bnorm', 'name', sprintf('bn%d',id), ...
    'weights', {{ones(512, 1, 'single'), zeros(512, 1, 'single'), zeros(512, 2, 'single')}}, ...
    'epsilon', 1e-4, ...
    'learningRate', [2 1 0.1], ...
    'weightDecay', [0 0]) ;
net.layers{end+1} = struct('type', 'relu', 'name', sprintf('relu%d',id)) ;

net.layers{end+1} = struct(...
    'name', sprintf('conv%d', id), ...
    'type', 'conv', ...
    'weights', {xavier(3, 3, 512, 512)}, ...
    'stride', 1, ...
    'pad', 1, ...
    'learningRate', [1 2], ...
    'weightDecay', [1 0]) ;
net.layers{end+1} = struct(...
    'type', 'bnorm', 'name', sprintf('bn%d',id), ...
    'weights', {{ones(512, 1, 'single'), zeros(512, 1, 'single'), zeros(512, 2, 'single')}}, ...
    'epsilon', 1e-4, ...
    'learningRate', [2 1 0.1], ...
    'weightDecay', [0 0]) ;
net.layers{end+1} = struct('type', 'relu', 'name', sprintf('relu%d',id)) ;

net.layers{end+1} = struct(...
    'name', sprintf('pool%d', id), ...
    'type', 'pool', ...
    'method', 'max', ...
    'pool', [2 2], ...
    'stride', 2, ...
    'pad', 0) ;

% -------------------------------------------------------------------------
id = id + 1;
net.layers{end+1} = struct(...
    'name', sprintf('fc%d', id), ...
    'type', 'conv', ...
    'weights', {xavier(6, 6, 512, 4096)}, ...
    'stride', 1, ...
    'pad', 0, ...
    'learningRate', [1 2], ...
    'weightDecay', [1 0]) ;
net.layers{end+1} = struct(...
    'type', 'bnorm', 'name', sprintf('bn%d',id), ...
    'weights', {{ones(4096, 1, 'single'), zeros(4096, 1, 'single'), zeros(4096, 2, 'single')}}, ...
    'epsilon', 1e-4, ...
    'learningRate', [2 1 0.1], ...
    'weightDecay', [0 0]) ;
net.layers{end+1} = struct('type', 'relu', 'name', sprintf('relu%d',id)) ;

%net.layers{end+1} = struct(...
%    'type', 'dropout', ...
%    'name', sprintf('dropout%d', id), ...
%    'rate', 0.6) ;

id = id + 1;
net.layers{end+1} = struct(...
    'name', sprintf('fc%d', id), ...
    'type', 'conv', ...
    'weights', {xavier(1, 1, 4096, 4096)}, ...
    'stride', 1, ...
    'pad', 0, ...
    'learningRate', [1 2], ...
    'weightDecay', [1 0]) ;
net.layers{end+1} = struct(...
    'type', 'bnorm', 'name', sprintf('bn%d',id), ...
    'weights', {{ones(4096, 1, 'single'), zeros(4096, 1, 'single'), zeros(4096, 2, 'single')}}, ...
    'epsilon', 1e-4, ...
    'learningRate', [2 1 0.1], ...
    'weightDecay', [0 0]) ;
net.layers{end+1} = struct('type', 'relu', 'name', sprintf('relu%d',id)) ;

%net.layers{end+1} = struct(...
%    'type', 'dropout', ...
%    'name', sprintf('dropout%d', id), ...
%    'rate', 0.6) ;

net.layers{end+1} = struct(...
    'name', 'prediction', ...
    'type', 'conv', ...
    'weights', {xavier(1, 1, 4096, 28)}, ...
    'stride', 1, ...
    'pad', 0, ...
    'learningRate', [1 2], ...
    'weightDecay', [1 0]) ;

% Add a loss (using a custom layer)
net = addCustomLossLayer(net, @l2LossForward, @l2LossBackward) ;

% Consolidate the network, fixing any missing option
% in the specification above.

net = vl_simplenn_tidy(net) ;
end

% -------------------------------------------------------------------------
function weights = xavier(h, w, in, out)
sc = sqrt(2/(h*w*in)) ;
filters = randn(h, w, in, out, 'single')*sc ;
biases = zeros(out, 1, 'single');
weights = {filters, biases};
end