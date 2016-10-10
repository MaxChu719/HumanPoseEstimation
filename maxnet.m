function [net, info] = maxnet(gpus, matconvnet_path)
run(fullfile(fileparts(mfilename('fullpath')), matconvnet_path, 'matlab', 'vl_setupnn.m'));

% Load a database of blurred images to train from
imdb = load('imdb_lsp.mat') ;

% Initialize the net
net = initialize_alexnet() ;

% Train
lr = logspace(-1, -4, 100);

trainOpts.expDir = 'output' ;
trainOpts.gpus = gpus ;
trainOpts.batchSize = 64 ;
trainOpts.learningRate = lr ;
trainOpts.weightDecay = 0.0005;
trainOpts.momentum = 0.9 ;
trainOpts.nesterovUpdate = true;
trainOpts.numEpochs = numel(lr) ;
trainOpts.plotDiagnostics = false ;
trainOpts.errorFunction = 'none' ;

[net, info] = cnn_train(net, imdb, @getBatch, trainOpts) ;

% Deploy: remove loss
net.layers(end) = [] ;