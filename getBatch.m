function [im, label] = getBatch(imdb, batch)
%GETBATCH  Get a batch of training data
%   [IM, LABEL] = The GETBATCH(IMDB, BATCH) extracts the images IM
%   and labels LABEL from IMDB according to the list of images
%   BATCH.
batch_size = numel(batch);
im_name = imdb.images.name(:,batch);
im_size = size(imread(im_name{1}), 1);
im = single(zeros([size(imread(im_name{1})), batch_size]));
label = single(zeros(size(imdb.images.labels, 1),  batch_size));
set = imdb.images.set(:,batch);
shift_size = floor(im_size * 0.15);
for i = 1:batch_size
    im(:,:,:,i) = single(imread(im_name{i}));
    for c = 1:3
        im(:,:,c,i) = im(:,:,c,i) - imdb.images.normalization.average(c);
    end
    label(:, i) = single(imdb.images.labels(:, batch(i)));
    
    if set(i) ~= 1
        continue
    end
    
    % Data augmentation
    rand_number = randi(2);
    
    if mod(rand_number, 2) == 0
        im(:,:,:,i) = flip(im(:,:,:,i),2);
        for j = 0:13
            if label(j*2 + 1, i) > 0
                label(j*2 + 1, i) = 1.0 - label(j*2 + 1, i);
            end
        end
    end
    
    shift_x = randi([-shift_size, shift_size]);
    shift_y = randi([-shift_size, shift_size]);
    shif_x_normalized = shift_x/im_size;
    shif_y_normalized = shift_y/im_size;
    im(:,:,:,i) = imtranslate(im(:,:,:,i),[shift_x, shift_y]);
    for j = 0:13
        if label(j*2 + 1, i) > 0
            label(j*2 + 1, i) = label(j*2 + 1, i) + shif_x_normalized;
        end
        
        if label(j*2 + 1, i) > 1
            label(j*2 + 1, i) = -1/im_size;
        end
        
        if label(j*2 + 2, i) > 0
            label(j*2 + 2, i) = label(j*2 + 2, i) + shif_y_normalized;
        end
        
        if label(j*2 + 2, i) > 1
            label(j*2 + 2, i) = -1/im_size;
        end
    end
end
label = reshape(label, 1, 1, size(label, 1), batch_size);