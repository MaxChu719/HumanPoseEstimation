function visualize_prediction(net, batch)
imdb = load('imdb_lsp.mat');
im_name = imdb.images.name(:,batch);
im_size = size(imread(im_name{1}), 1);

batch_size = numel(batch);

for b = 1:batch_size
    test_image = imread(im_name{b});
    im = single(test_image);
    for c = 1:3
        im(:,:,c) = im(:,:,c) + imdb.images.normalization.average(c);
    end
    res = vl_simplenn(net, im) ;
    input_joint = ones(14*3, 1);
    for i = 0:13
        input_joint(i*3 + 1) = res(end).x(1, 1, i*2 + 1)*im_size;
        input_joint(i*3 + 2) = res(end).x(1, 1, i*2 + 2)*im_size;
        if input_joint(i*3 + 1) < 0 || input_joint(i*3 + 2) < 0
            input_joint(i*3 + 3) = 0;
        end
    end
    draw_joints(test_image, input_joint);
    
    label = single(imdb.images.labels(:, batch(b)));
    label = reshape(label, 1, 1, size(label, 1));
    loss = l2LossForward(res(end).x, label);
    display(sprintf('loss is %f', loss));

    waitforbuttonpress;
end