# HumanPoseEstimation
Human Pose Estimation using Convolution Net on Matconvnet

# Usage
```
setup_imdb();

% If using gpu
[net, info] = maxnet([1], 'path/to/matconvnet');

% If using cpu
[net, info] = maxnet([], 'path/to/matconvnet');

% batch of index you want to visualize the output
batch = [1, 10, 100]
visualize_prediction(net, batch);

% Visual the first feature map
visualize_feature(net);
```
