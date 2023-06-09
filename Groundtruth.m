
function [Truth]=Groundtruth(ima)
%We are Taking Groundtruth image as input which has building as red and
%rest as black so we are classifying them as 0 and 1 for Evaluation
a=ima;
sz=size(a)
display(a)
imshow(a)
for i=1:sz
    for j=1:sz
        if(a(i,j)<255)
            Truth(i,j)=0;
        else
            Truth(i,j)=1;
        end
    end
end
figure
 imshow(Truth)
end

