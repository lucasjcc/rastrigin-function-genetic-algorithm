function [aptidao] = fitness(valoresN, nVar, nBitsVar)
    
    f_x = @(x, n) 10*n + x^2-10*cos(2*pi*x);
    valoresN = valoresN';
    soma = 0;
    
    for i = 1:size(valoresN, 1)
        x = bi2de(valoresN(i,:));
        xNoIntervalor = 5.12*(x/(2^nBitsVar-1));
        f = f_x(xNoIntervalor, nVar);
        soma = soma + f;
    end
    
    aptidao = 1/soma;

end

