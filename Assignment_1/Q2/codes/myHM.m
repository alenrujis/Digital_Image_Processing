
 input = imread('../data/retina.png');
 ref = imread('../data/retinaRef.png');
 input_mask = imread('../data/retinaMask.png');
 ref_mask = imread('../data/retinaRefMask.png');

% function [op_intermediate,output] = myHM_test(input,input_mask,ref,ref_mask)

    op_intermediate = myHE(input,'ind',input_mask);
    output = op_intermediate;
    
    ref_r = ref(:,:,1);
    ref_g = ref(:,:,2);
    ref_b = ref(:,:,3);
    
    cdf_r = CDF_gen(ref_r(ref_mask));
    cdf_g = CDF_gen(ref_g(ref_mask));
    cdf_b = CDF_gen(ref_b(ref_mask));

    r_hm = cell2mat(arrayfun(@(z)CDF_inv(cdf_r,z),op_intermediate(:,:,1),'UniformOutput',false));
    g_hm = cell2mat(arrayfun(@(z)CDF_inv(cdf_g,z),op_intermediate(:,:,2),'UniformOutput',false));
    b_hm = cell2mat(arrayfun(@(z)CDF_inv(cdf_b,z),op_intermediate(:,:,3),'UniformOutput',false));
      
    output(:,:,1) = r_hm;
% .*ref_mask;
    output(:,:,2) = g_hm;
% .*ref_mask;
    output(:,:,3) = b_hm;
% .*ref_mask;
% end
figure(1)
imshow(output);
function cdf = CDF_gen(ip)
    hist= imhist(ip);
    hist = hist + ones(size(hist));
    cdf = cumsum(hist)/sum(hist);
end

function op_value = CDF_inv(cdf,ip)
    ip = double(ip);
    [c, index_1] = min(abs(cdf-ip));
    index_2 = index_1 +sign(ip-cdfa(index_1));
    if(index_2 < 1)
        index_2 = 1;
    elseif(index_2 > 256)
        index_2 = 256;
    end
    op_value = (cdf(index_1)*index_2 + cdf(index_2)*index_1 )/(cdf(index_1)+ cdf(index_2));
end