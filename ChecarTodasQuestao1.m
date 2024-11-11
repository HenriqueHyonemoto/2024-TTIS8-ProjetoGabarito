pkg load image;  % Carregar pacote de processamento de imagens
clc;

% Carrega e binariza a imagem
gabarito = imread("GabaritoP1.jpg");
gabarito = im2bw(gabarito);

% Exibe a imagem binarizada
figure(1), imshow(gabarito);

tamanho = 96;      % Tamanho de cada quadrado de alternativa
distanciaX = 142;   % Distância entre os quadrados das alternativas
distanciaY = 156;   % Distância entre os quadrados das questões

% Função para verificar todas as alternativas de uma questão
function alternativa_assinalada = verificar_questao(gabarito, x_inicial, y_inicial, tamanho, distanciaX)
  % Array para armazenar o status das alternativas (A, B, C, D)
  alternativas_letras = ['A', 'B', 'C', 'D'];
  limiar = 0.75;  % Limiar de intensidade para determinar marcação
  num_assinaladas = 0;
  alternativa_assinalada = 'ANULADA';

  % Itera sobre as quatro alternativas (A, B, C, D)
  for i = 1:4
    x = x_inicial + (i - 1) * distanciaX; % Calcula a coordenada x para a alternativa atual
    area_quadrado = gabarito(y_inicial:y_inicial+tamanho-1, x:x+tamanho-1); % Extrai a área da alternativa
    media_intensidade = mean(area_quadrado(:));  % Calcula a média de intensidade da área

    % Verifica se a média de intensidade está abaixo do limiar (assinalado)
    if media_intensidade < limiar
      num_assinaladas = num_assinaladas + 1;
      alternativa_assinalada = alternativas_letras(i); % Armazena a alternativa assinalada
    end
  end

  % Retorna "ANULADA" se mais de uma alternativa for marcada ou nenhuma
  if num_assinaladas != 1
    alternativa_assinalada = 'ANULADA';
  end
end

% Função principal para corrigir a prova com base no gabarito fornecido
function corrigir_prova(gabarito, respostas_certas, tamanho, distanciaX, distanciaY)
  nota_final = 0;  % Inicializa a nota final

  % Para cada questão, calcula as coordenadas e verifica as alternativas
  for questao = 1:length(respostas_certas)
    y_inicial = 296 + (questao - 1) * distanciaY; % Coordenada y para cada questão
    x_inicial = 341;  % Coordenada x para a alternativa A

    % Verifica a alternativa assinalada para a questão
    resultado = verificar_questao(gabarito, x_inicial, y_inicial, tamanho, distanciaX);

    % Exibe o resultado da questão e compara com o gabarito
    fprintf('Questão %d: %s\n', questao, resultado);

    % Se a resposta estiver correta, incrementa a nota
    if resultado == respostas_certas(questao)
      nota_final = nota_final + 1;
    end
  end

  % Exibe a nota final
  fprintf('Nota Final: %d/%d\n', nota_final, length(respostas_certas));
end

% Definindo o gabarito das respostas corretas
respostas_certas = ['A', 'B', 'C', 'C', 'D'];  % Gabarito esperado

% Chama a função para corrigir a prova
corrigir_prova(gabarito, respostas_certas, tamanho, distanciaX, distanciaY);

