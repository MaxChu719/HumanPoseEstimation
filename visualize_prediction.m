function visualize_prediction(net, imdb, batch)
[im, label] = getBatch(imdb, batch);

im_size = size(im, 1);
batch_size = numel(batch);

for b = 1:batch_size
    % Apply the CNN to the larger image
    res = vl_simplenn(net, im(:, :, :, b)) ;
    
    test_image = uint8(im(:, :, :, b)*128 + 128);
    input_joint = ones(14*3, 1);
    for i = 0:13
        input_joint(i*3 + 1) = res(end).x(:, :, i*2 + 1)*im_size;
        input_joint(i*3 + 2) = res(end).x(:, :, i*2 + 2)*im_size;
        if input_joint(i*3 + 1) < 0 || input_joint(i*3 + 2) < 0
            input_joint(i*3 + 3) = 0;
        end
    end
    draw_joints(test_image, input_joint);
    waitforbuttonpress;
end