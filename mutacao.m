function [filhosMutados] = mutacao(filhos, pm, nBitsIndividuo)
    
    for i = 1:2
        for j = 1:nBitsIndividuo
            aleatorio = rand;
            if aleatorio <= pm
                filhos(i).Cromossomo(j) = 1 - filhos(i).Cromossomo(j);
            end
        end
    end
    
    filhosMutados = filhos;
end

