function [selecionados] = selecao(populacao, individuo, nIndividuos)
    %Selecionar o tipo de seleção
    tipoSelecao = rand;
    
    %Seleção por torneio
    if tipoSelecao < 0.5     
        %Seleciona 6 indivíduos para o torneio
        aleatorio = randperm(nIndividuos, 6);
        aleatorioDecrescente = sort(aleatorio);
        selecionados = repmat(individuo, 2, 1);
        for i = 1:2
            selecionados(i) = populacao(aleatorioDecrescente(i));
        end
    %Seleção por roleta
    else
        selecionados = repmat(individuo, 2, 1);
        sumFitness = 0;
        soma = 0;
        for i = 1:nIndividuos
            sumFitness = sumFitness + populacao(i).Fitness;
        end
        for i = 1:2
            aleatorio = sumFitness*rand;
            for j = 1:nIndividuos
                soma = soma + populacao(i).Fitness;
                if aleatorio < soma
                    selecionados(i) = populacao(j);
                    break;
                end
            end
        end
    end
end

