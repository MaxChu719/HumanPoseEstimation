function preprocess_database(preprocess_folder, data_path, data_size, target_size, image_index_length)

% Parameters
margin_ratio = 1.5;
%target_size = 227;

% Making preprocess folder
%preprocess_folder = 'preprocessed_testing_data/';
if exist(preprocess_folder, 'file') ~= 7
    mkdir(preprocess_folder);
end

% Training data
%data_size = 2000;
%data_path = 'dataset/lsp_dataset_original/';
data_joint_csv = csvread([data_path, 'joints.csv']);

for i = 1:data_size
    % Load the joints coordinate
    row = data_joint_csv(i,:);
    valid_joints = zeros(14, 2);
    k = 0;
    for j=0:13
        if row(j*3+3) ~= 0
            k = k+1;
            valid_joints(k,:) = [row(j*3+1) row(j*3+2)];
        end
    end
    
    % Calculate the bounding box
    valid_joints = valid_joints(1:k,:);
    init_bbox = boundingBox(valid_joints);
    crop_width = (init_bbox(2) - init_bbox(1));
    crop_height = (init_bbox(4) - init_bbox(3));
    max_size = max([crop_width crop_height]) * margin_ratio;
    bbox = [(init_bbox(1) + init_bbox(2) - max_size)/2, (init_bbox(3) + init_bbox(4) - max_size)/2, max_size, max_size];
    
    % Crop the image with the bounding box
    x = imread([data_path, 'images/im', sprintf(['%0' int2str(image_index_length) 'd'],i), '.jpg']);
    smart_bbox = smart_rect(bbox, size(x));
    x = im2single(x);
    cropped_x = imcrop(x, smart_bbox);
    
    % Resize the image into a standard size
    im_size = size(cropped_x);
    if im_size(1) > im_size(2)
        resize_ratio = target_size/im_size(1);
        cropped_x = imresize(cropped_x, [target_size NaN]);
    else
        resize_ratio = target_size/im_size(2);
        cropped_x = imresize(cropped_x, [NaN target_size]);
    end
    cropped_x_size = size(cropped_x);
    temp_im = single(zeros(target_size, target_size, 3));
    start_x = max([floor(target_size/2) - floor(cropped_x_size(2)/2), 1]);
    end_x = min([start_x + cropped_x_size(2) - 1, target_size]);
    start_y = max([floor(target_size/2) - floor(cropped_x_size(1)/2), 1]);
    end_y = min([start_y + cropped_x_size(1) - 1, target_size]);
    temp_im(start_y:end_y, start_x:end_x, :) = cropped_x;
    imwrite(temp_im, [preprocess_folder, 'im', sprintf('%05d',i), '.jpg']);
    
    % Re-calculate the joint locations
    for j=0:13
        row(j*3+1) = (row(j*3+1) - smart_bbox(1))*resize_ratio + start_x;
        row(j*3+2) = (row(j*3+2) - smart_bbox(2))*resize_ratio + start_y;
    end
    data_joint_csv(i,:) = row;
    
    % Display result
    %draw_joints(temp_im, row);
    %figure(1) ; clf ; imagesc(output_im);
end

csvwrite([preprocess_folder, 'joints.csv'], data_joint_csv);

