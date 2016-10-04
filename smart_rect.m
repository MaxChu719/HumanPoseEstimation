function smart_bbox = smart_rect(bbox, im_size)

smart_bbox = bbox;
if smart_bbox(1) < 0
    smart_bbox(1) = 0;
    smart_bbox(3) = min([max([bbox(3) + bbox(1), 0]), im_size(2)]);
elseif smart_bbox(1) + bbox(3) >= im_size(2)
    smart_bbox(1) = min([smart_bbox(1), im_size(2) - 1]);
    smart_bbox(3) = (im_size(2) - 1) - smart_bbox(1);
end

if smart_bbox(2) < 0
    smart_bbox(2) = 0;
    smart_bbox(4) = min([max([bbox(4) + bbox(2), 0]), im_size(1)]);
elseif smart_bbox(2) + bbox(4) >= im_size(1)
    smart_bbox(2) = min([smart_bbox(2), im_size(1) - 1]);
    smart_bbox(4) = (im_size(1) - 1) - smart_bbox(2);
end
    