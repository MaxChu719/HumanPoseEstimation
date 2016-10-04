function visualize_feature(net)
figure(2) ; clf ; colormap gray ;
vl_imarraysc(squeeze(net.layers{1}.weights{1}),'spacing',2)
axis equal ;
title('filters in the first layer') ;