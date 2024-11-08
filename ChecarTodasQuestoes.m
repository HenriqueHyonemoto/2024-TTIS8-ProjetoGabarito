pkg load image;  % Carregar pacote de processamento de imagens
clc;

% Carrega e binariza a imagem
gabarito = imread("GabaritoP3.jpg");
gabarito = im2bw(gabarito);

% Exibe a imagem binarizada
figure(1), imshow(gabarito);

tamanho = 96;        % Tamanho de cada quadrado de alternativa
distanciaX = 142;    % Distância entre os quadrados das alternativas
distanciaY = 156;    % Distância entre os quadrados das questões

% Função para verificar todas as alternativas de uma questão
function alternativa_assinalada = verificar_questao(gabarito, x_inicial, y_inicial, tamanho, distanciaX)
  % gabarito: imagem binarizada do gabarito (0 = preto, 1 = branco)
  % x_inicial, y_inicial: coordenadas do canto superior esquerdo do quadrado da alternativa A
  % tamanho: tamanho do lado do quadrado
  % distanciaX: distância entre os quadrados das alternativas
  % distanciaY: distância entre os quadrados das questões

  % Array para armazenar o status das alternativas (A, B, C, D)
  alternativas = cell(1, 4);
  alternativas_letras = ['A', 'B', 'C', 'D'];

  % Limiar para determinar se a área está assinalada
  limiar = 0.75;

  % Variável para contar o número de alternativas assinaladas
  num_assinaladas = 0;
  alternativa_assinalada = 'ANULADA'; % Default se nenhuma ou mais de uma alternativa estiver assinalada

  % Itera sobre as quatro alternativas (A, B, C, D)
  for i = 1:4
    % Calcula a coordenada x para a alternativa atual
    x = x_inicial + (i - 1) * distanciaX;

    % Extrai a área correspondente ao quadrado da alternativa
    area_quadrado = gabarito(y_inicial:y_inicial+tamanho-1, x:x+tamanho-1);

    % Calcula a média de intensidade da área
    media_intensidade = mean(area_quadrado(:));

    % Verifica se a média de intensidade está abaixo do limiar (assinalado)
    if media_intensidade < limiar
      alternativas{i} = 'Assinalada'; % Assinalado
      num_assinaladas = num_assinaladas + 1; % Conta a alternativa assinalada
      alternativa_assinalada = alternativas_letras(i); % Armazena a alternativa assinalada
    else
      alternativas{i} = 'Não Assinalada'; % Não assinalado
    end
  end

  % Se mais de uma alternativa for assinalada ou nenhuma, retorna "ANULADA"
  if num_assinaladas != 1
    alternativa_assinalada = 'ANULADA';
  end
end

% Função para verificar todas as 8 questões
function verificar_todas_questoes(gabarito, tamanho, distanciaX, distanciaY)
  % Para cada questão, vamos calcular as coordenadas e verificar as alternativas
  for questao = 1:8
    % Calcula a coordenada inicial (x_inicial e y_inicial) para cada questão
    y_inicial = 296 + (questao - 1) * distanciaY; % Distância entre as questões (na direção Y)

    % A primeira alternativa da questão (alternativa A) está na coordenada x_inicial
    x_inicial = 341;

    % Chama a função para verificar as alternativas da questão
    resultado = verificar_questao(gabarito, x_inicial, y_inicial, tamanho, distanciaX);

    % Exibe o resultado para a alternativa assinalada ou "ANULADA"
    fprintf('Questão %d: %s\n', questao, resultado);
  end
end

% Chama a função para verificar todas as 8 questões
verificar_todas_questoes(gabarito, tamanho, distanciaX, distanciaY);

