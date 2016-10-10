function visualize_prediction(net, batch)
imdb = load('imdb_lsp.mat');
im_name = imdb.images.name(:,batch);
im_size = size(imread(im_name{1}), 1);

batch_size = numel(batch);

for b = 1:batch_size
    test_image = imread(im_name{b});
    im = normalize_image(single(test_image));
    res = vl_simplenn(net, im) ;
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