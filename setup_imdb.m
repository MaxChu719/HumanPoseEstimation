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

imdb.images.name = [];
imdb.images.labels = [];
imdb.images.visibilities = [];
imdb.images.set = [];

sizes = [train_size, val_size, test_size];
paths = {train_path, val_path, test_path};
sets = [1, 2, 3];

for i = 1:3
    path = paths{i};
    name = cell(1, sizes(i));
    labels = zeros(14*2, sizes(i));
    visibilities = zeros(14, sizes(i));
    set = zeros(1, sizes(i));
    set(:) = sets(i);
    data_joint_csv = csvread([path, 'joints.csv']);
    for s = 1:sizes(i)
        name{s} = [path, 'im', sprintf('%05d', s), '.jpg'];
        row = data_joint_csv(s,:);
        for j=0:13
            visibilities(j + 1, s) = row(j*3+3);
            if visibilities(j + 1, s) ~= 0
                labels(j*2+1:j*2+2, s) = [row(j*3+1); row(j*3+2)];
            else
                labels(j*2+1:j*2+2, s) = [-1; -1];
            end
        end
    end
    
    imdb.images.name = [imdb.images.name, name];
    imdb.images.labels = [imdb.images.labels, labels];
    imdb.images.visibilities = [imdb.images.visibilities, visibilities];
    imdb.images.set = [imdb.images.set, set];
end

save('imdb_lsp.mat', '-struct' ,'imdb');