clc;
close all;
clear all;
Kmeans=table();
NDVI=table();
Gabor=table();
for i=4:4
    close all;
    T1=table()
    T2=table()
    T3=table()
    j=num2str(i);
    img=imread(['G:\Projects\Major Project\ProjectCode\UsedDataset\Images\Image (' j ').tiff']);
    imgresize=imresize(img,[600,600]);
    grdtrth=imread(['G:\Projects\Major Project\ProjectCode\UsedDataset\Groundtruth\ground (' j ').tif']);
    grdsize=imresize(grdtrth,[600,600]);
    grdsize2=imresize(grdtrth,[300,300]);
%    [mask]=mainkvs(imgresize);
%     [Landsat]=landsatexp(imgresize);
     [filter]=gaborfilter(imgresize);
     filter=uint8(filter);
    [Truth]=Groundtruth(grdsize);
     [Truth1]=Groundtruth(grdsize2);
   % [Accuracy, Sensitivity, Fmeasure, Precision, MCC, Dice, Jaccard, Specitivity]=Evaluation(mask,Truth);
 %    [Accuracy1, Sensitivity1, Fmeasure1, Precision1, MCC1, Dice1, Jaccard1, Specitivity1]=Evaluation(Landsat,Truth);
    [Accuracy2, Sensitivity2, Fmeasure2, Precision2, MCC2, Dice2, Jaccard2, Specitivity2]=Evaluation(filter,Truth1);
%     T1.Accuracy=Accuracy;
%     T1.Sensitivity=Sensitivity;
%     T1.Fmeasure=Fmeasure;
%     T1.Precision=Precision;
%     T1.MCC=MCC;
%     T1.Dice=Dice;
%     T1.Jaccard=Jaccard;
%     T1.Specitivity=Specitivity
%     Kmeans=[Kmeans;T1];
%     T2.Accuracy=Accuracy1;
%     T2.Sensitivity=Sensitivity1;
%     T2.Fmeasure=Fmeasure1;
%     T2.Precision=Precision1;
%     T2.MCC=MCC1;
%     T2.Dice=Dice1;
%     T2.Jaccard=Jaccard1;
%     T2.Specitivity=Specitivity1
   % NDVI=[NDVI;T2]
    T3.Accuracy=Accuracy2;
    T3.Sensitivity=Sensitivity2;
    T3.Fmeasure=Fmeasure2;
    T3.Precision=Precision2;
    T3.MCC=MCC2;
    T3.Dice=Dice2;
    T3.Jaccard=Jaccard2;
    T3.Specitivity=Specitivity2
    Gabor=[Gabor;T3]

    

end





