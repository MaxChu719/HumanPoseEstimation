# HumanPoseEstimation
Human Pose Estimation using Convolution Net on Matconvnet

# Usage
```
setup_imdb();

% If using gpu
[net, info] = maxnet([1], 'path/to/matconvnet');

% If using cpu
[net, info] = maxnet([], 'path/to/matconvnet');

visualize_prediction(net, batch);
```
