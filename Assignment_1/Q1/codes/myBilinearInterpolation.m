function output = myBilinearInterpolation(input)
%%Image Enlargement using Bilinear Interpolation 
        [height, width] = size(input);
        output = zeros(3*height - 2 , 2*width - 1);
        output([1:3:end],[1:2:end]) = input; 
        output([1:3:end],[2:2:end]) = (output([1:3:end],[1:2:end-2]) + output([1:3:end],[3:2:end]) )/2;
        output([2:3:end],[1:end]) = (2*output([1:3:end-3],[1:end]) + output([4:3:end],[1:end]))/3;
        output([3:3:end],[1:end]) = (output([1:3:end-3],[1:end]) + 2*output([4:3:end],[1:end]))/3;
        
end