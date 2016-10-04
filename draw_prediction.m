function draw_prediction(net, test_index)
test_image = imread(['preprocessed_testing_data\im', sprintf('%05d', test_index), '.jpg']);
input_to_net = single(test_image);
input_to_net = (input_to_net-128)/128;

res = vl_simplenn(net, input_to_net) ;

joint = reshape(res(end).x * 220, 28, 1);
input_joint = ones(14*3, 1);
j = 0;
for i = 0:13
    j = j + 1;
    input_joint(i*3 + 1) = joint(j);
    j = j + 1;
    input_joint(i*3 + 2) = joint(j);
end;

display(input_joint);

draw_joints(test_image, input_joint);