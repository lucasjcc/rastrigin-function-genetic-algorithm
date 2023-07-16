function [xOtimo,fOtimo] = main(dimensaoProblema,numeroEpocas)

    %Limpar a tela e as variáveis alocadas
    close all;
    clc;
    
    %Parâmetros
    pc = 0.9;
    pm = 1;
    precisao = 10^-3;
    nIndividuos = ceil(numeroEpocas/dimensaoProblema);
    individuo.Cromossomo = [];
    individuo.Fitness = [];
    
    %Número de genes por cromossomo
    nBitsVar = log((5.12-(-5.12)+precisao)/precisao)/log(2);
    nBitsVar = ceil(nBitsVar);
    nBitsIndividuo = nBitsVar*dimensaoProblema;
    
    %Gerar população inicial
    populacao = repmat(individuo, nIndividuos, 1);
    for i = 1:nIndividuos
        populacao(i).Cromossomo = randi([0, 1], 1,nBitsIndividuo);
    end
    
    %Calcular o fitness da população
    for i=1:nIndividuos
        valoresN = nan(nBitsVar,ceil(numel(populacao(i).Cromossomo)./nBitsVar));
        valoresN(1:numel(populacao(i).Cromossomo)) = populacao(i).Cromossomo;
        populacao(i).Fitness = fitness(valoresN, dimensaoProblema, nBitsVar);
    end
    
    %Ordenar por ordem decrescente de aptidão
    T = struct2table(populacao);
    sortedT = sortrows(T, 'Fitness', 'descend');
    populacao = table2struct(sortedT);
    
    %Testa indivíduo ótimo na população inicial
    if populacao(1).Fitness == Inf
        valoresN = nan(nBitsVar,ceil(numel(populacao(1).Cromossomo)./nBitsVar));
        valoresN(1:numel(populacao(1).Cromossomo)) = populacao(1).Cromossomo;
        xOtimo = valoresN;
        fOtimo = 1/populacao(1).Fitness;
        return;
    end
    
    for geracao = 1:numeroEpocas
    
        %Seleção dos indivíduos para o cruzamento
        selecionados = selecao(populacao, individuo, nIndividuos);

        %Cruzamento
        filhos = crossover(selecionados, pc, nBitsIndividuo);

        %Mutação
        filhosMutados = mutacao(filhos, pm, nBitsIndividuo);

        %Calcular o fitness dos filhos gerados e inserir na populacão
        for i=1:2
            valoresN = nan(nBitsVar,ceil(numel(filhosMutados(i).Cromossomo)./nBitsVar));
            valoresN(1:numel(filhosMutados(i).Cromossomo)) = filhosMutados(i).Cromossomo;
            filhosMutados(i).Fitness = fitness(valoresN, 2, nBitsVar);
            populacao(nIndividuos+i) = filhosMutados(i);
        end

        %Ordenar por ordem decrescente de aptidão
        T = struct2table(populacao);
        sortedT = sortrows(T, 'Fitness', 'descend');
        populacao = table2struct(sortedT);
        
        %Eliminar os 2 piores
        populacao(nIndividuos+2) = [];
        populacao(nIndividuos+1) = [];
        
        melhorAptidao(geracao) = populacao(1).Fitness;
        aptidaoMedia(geracao) = sum([populacao(:).Fitness])/length(populacao);

        %Condições de parada
        if populacao(1).Fitness == Inf || geracao == numeroEpocas
            valoresN = nan(nBitsVar,ceil(numel(populacao(1).Cromossomo)./nBitsVar));
            valoresN(1:numel(populacao(1).Cromossomo)) = populacao(1).Cromossomo;
            xOtimo = valoresN;
            fOtimo = 1/populacao(1).Fitness;
            plot(aptidaoMedia);
            hold on;
            plot(melhorAptidao, '-');
            xlabel("Geração");
            ylabel("Melhor fitness e fitness médio da população");
            return;
        end
        
    end
    
end

