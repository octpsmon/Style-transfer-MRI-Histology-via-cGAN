% based on https://www.mathworks.com/help/images/registering-multimodal-mri-images.html#RegisterMultimodalImagesExample-1

fixed = imread('gfap1_1000.tif');
moving = imread('sag1.tiff');


fixed  = im2gray(fixed);
moving(:,:,4) = [];
%proceed with rgb2gray
moving = im2gray(moving);
imshow(moving);


imshowpair(moving,fixed,'montage')
title('Unregistered')

imshowpair(moving,fixed)
title('Unregistered')

[optimizer,metric] = imregconfig('multimodal');
movingRegisteredDefault = imregister(moving,fixed,'affine',optimizer,metric);

imshowpair(movingRegisteredDefault,fixed)
title('A: Default Registration')

disp(optimizer)
disp(metric)

optimizer.InitialRadius = optimizer.InitialRadius/3.5;
movingRegisteredAdjustedInitialRadius = imregister(moving,fixed,'affine',optimizer,metric);

imshowpair(movingRegisteredAdjustedInitialRadius,fixed)
title('B: Adjusted InitialRadius')

optimizer.MaximumIterations = 1000;
movingRegisteredAdjustedInitialRadius1000 = imregister(moving,fixed,'affine',optimizer,metric);

imshowpair(movingRegisteredAdjustedInitialRadius1000,fixed)
title('C: Adjusted InitialRadius, MaximumIterations = 1000')

tformSimilarity = imregtform(moving,fixed,'similarity',optimizer,metric);
Rfixed = imref2d(size(fixed));
movingRegisteredRigid = imwarp(moving,tformSimilarity,'OutputView',Rfixed);

imshowpair(movingRegisteredRigid, fixed)
title('D: Registration Based on Similarity Transformation Model')

movingRegisteredAffineWithIC = imregister(moving,fixed,'affine',optimizer,metric,...
    'InitialTransformation',tformSimilarity);

imshowpair(movingRegisteredAffineWithIC,fixed)
title('E: Registration from Affine Model Based on Similarity Initial Condition')
