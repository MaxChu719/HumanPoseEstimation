function test_getBatch(batch)
imdb = load('imdb_lsp.mat');
[im, label] = getBatch(imdb, batch);
im_name = imdb.images.name(:,batch);

im_size = size(im, 1);
batch_size = numel(batch);

for b = 1:batch_size
    raw_im = single(imread(im_name{b}));
    test_image = uint8(unnormalize_image(im(:,:,:,b), raw_im));
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
end

% -------------------------------------------------------------------------
function im = unnormalize_image(input, raw_input)
im = zeros(size(input));
for c = 1:3
    im(:,:,c) = input(:,:,c) + mean2(raw_input(:,:,c));
end
end