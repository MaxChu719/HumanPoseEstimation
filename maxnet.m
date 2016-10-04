function [net, info] = maxnet(gpus, matconvnet_path)
run(fullfile(fileparts(mfilename('fullpath')), matconvnet_path, 'matlab', 'vl_setupnn.m'));

% Load a database of blurred images to train from
imdb = load('imdb_lsp.mat') ;

% Initialize the net
net = initialize_maxnet() ;

% Add a loss (using a custom layer)
net = addCustomLossLayer(net, @l2LossForward, @l2LossBackward) ;

% Train
trainOpts.expDir = 'output' ;
trainOpts.gpus = gpus ;
trainOpts.batchSize = 128 ;
trainOpts.learningRate = 0.00025 ;
trainOpts.weightDecay = 0.0005 ;
trainOpts.momentum = 0.9 ;
trainOpts.numEpochs = 20 ;
trainOpts.plotDiagnostics = true ;
trainOpts.errorFunction = 'none' ;

[net, info] = cnn_train(net, imdb, @getBatch, trainOpts) ;

% Deploy: remove loss
net.layers(end) = [] ;