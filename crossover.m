function [filhos] = crossover(pais, pc, nBitsIndividuo)
    filhos = pais;
    aleatorio = rand;
    if aleatorio < pc
        aleatorio = randi([2, nBitsIndividuo-1]);
        filhos(1).Cromossomo = [pais(1).Cromossomo(1:aleatorio) pais(2).Cromossomo(aleatorio+1:end)];
        filhos(2).Cromossomo = [pais(2).Cromossomo(1:aleatorio) pais(1).Cromossomo(aleatorio+1:end)];
    end
end

