function idealLPF = iLPF(D, m , n)
    c_x = (m+1)/2;
    c_y = (n+1)/2;
    idealLPF = zeros(m,n);
    for u = 0:n/2
        for v = 0:m/2
            if(u^2+v^2 < D^2)
                idealLPF( floor(c_x - u):ceil(c_x + u), floor(c_y - v) : ceil(c_x + v)) = 1;
            end
        end
    end     
end