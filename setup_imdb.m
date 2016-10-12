function imdb = setup_imdb()
% Meta data
imdb.classes.name = cell(14, 1);
imdb.classes.name{1} = 'Right_ankle';
imdb.classes.name{2} = 'Right_knee';
imdb.classes.name{3} = 'Right_hip';
imdb.classes.name{4} = 'Left_hip';
imdb.classes.name{5} = 'Left_knee';
imdb.classes.name{6} = 'Left_ankle';
imdb.classes.name{7} = 'Right_wrist';
imdb.classes.name{8} = 'Right_elbow';
imdb.classes.name{9} = 'Right_shoulder';
imdb.classes.name{10} = 'Left_shoulder';
imdb.classes.name{11} = 'Left_elbow';
imdb.classes.name{12} = 'Left_wrist';
imdb.classes.name{13} = 'Neck';
imdb.classes.name{14} = 'Head_top';

% Loading training, validing and testing image
train_size = 10000;
val_size = 1000;
test_size = 1000;
train_path = 'preprocessed_training_data/';
val_path = 'preprocessed_testing_data/';
test_path = 'preprocessed_testing_data/';

target_size = 220;
preprocess_database(train_path, 'dataset/lspet_dataset/', train_size, target_size, 5);
preprocess_database(val_path, 'dataset/lsp_dataset_original/', val_size + test_size, target_size, 4);

total_sample_size = train_size + val_size + test_size;
imdb.images.name = cell(1, total_sample_size);
%imdb.images.data = single(zeros(target_size, target_size, 3, total_sample_size));
imdb.images.labels = single(zeros(14*2, total_sample_size));
imdb.images.visibilities = single(zeros(14, total_sample_size));
imdb.images.set = single(zeros(1, total_sample_size));
imdb.images.normalization.average = single(zeros(3, 1));

sizes = [train_size, val_size, test_size];
paths = {train_path, val_path, test_path};
sets = [1, 2, 3];

count = 0;
for i = 1:3
    path = paths{i};
    
    % Since validing samples and testing samples are in the same folder
    file_index_offset = 0;
    if i == 3
        file_index_offset = 1000;
    end
    
    % Calculating the mean of the mean of the training sample
    if i == 1
        for s = 1:sizes(i)
            im = single(imread([path, 'im', sprintf('%05d', file_index_offset + s), '.jpg']));
            for c = 1:3
                imdb.images.normalization.average(c) = imdb.images.normalization.average(c) + mean2(im(:,:,c))/sizes(i);
            end
        end
    end
    
    data_joint_csv = csvread([path, 'joints.csv']);
    for s = 1:sizes(i)
        count = count + 1;
        imdb.images.name{count} = [path, 'im', sprintf('%05d', file_index_offset + s), '.jpg'];
        
        % Organizing image data
        %imdb.images.data(:, :, :, count) = single(imread(imdb.images.name{s}));
        %for c = 1:3
        %    imdb.images.data(:, :, c, count) = imdb.images.data(:, :, c, count) - imdb.images.normalization.average(c);
        %end
        
        % Organizing joints location
        row = data_joint_csv(s,:);
        for j=0:13
            imdb.images.visibilities(j + 1, count) = row(j*3+3);
            if imdb.images.visibilities(j + 1, count) ~= 0
                imdb.images.labels(j*2+1:j*2+2, count) = [row(j*3+1); row(j*3+2)]/target_size;
            else
                imdb.images.labels(j*2+1:j*2+2, count) = [-1; -1];
            end
        end
        
        % Organizing set
        imdb.images.set(count) = sets(i);
    end
end

save('imdb_lsp.mat', '-struct' ,'imdb');