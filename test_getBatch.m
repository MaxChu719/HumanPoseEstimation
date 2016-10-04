function test_getBatch(imdb, batch)
[im, label] = getBatch(imdb, batch);

im_size = size(im, 1);
batch_size = numel(batch);

for b = 1:batch_size
    test_image = uint8(im(:, :, :, b)*128 + 128);
    input_joint = ones(14*3, 1);
    for i = 0:13
        input_joint(i*3 + 1) = label(:, :, i*2 + 1, b)*im_size;
        input_joint(i*3 + 2) = label(:, :, i*2 + 2, b)*im_size;
        if input_joint(i*3 + 1) < 0 || input_joint(i*3 + 2) < 0
            input_joint(i*3 + 3) = 0;
        end
    end
    draw_joints(test_image, input_joint);
    waitforbuttonpress;
end