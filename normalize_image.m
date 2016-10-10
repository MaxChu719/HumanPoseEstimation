function im = normalize_image(input)
im = zeros(size(input), 'single');
for c = 1:3
    im(:,:,c) = input(:,:,c) - mean2(input(:,:,c));
end