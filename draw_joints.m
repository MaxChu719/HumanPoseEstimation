function draw_joints(input_im, row)
line_index = [0, 1, 3, 4, 6, 7, 9, 10, 12] + 1;
line_color = ['r', 'r', 'b', 'b', 'r', 'r', 'b', 'b', 'g'];

joints = zeros(14, 2);
visibility = zeros(14, 1);

for j = 1:14
    joints(j, :) = [row((j-1)*3 + 1), row((j-1)*3 + 2)];
    visibility(j) = row((j-1)*3 + 3);
end

imshow(input_im, 'InitialMagnification','fit');
for i=1:size(line_index, 2)
    if visibility(line_index(i)) > 0 && visibility(line_index(i)+1) > 0
        line = imline(gca, [joints(line_index(i),:);joints(line_index(i)+1,:)]);
        setColor(line, line_color(i));
    end
end