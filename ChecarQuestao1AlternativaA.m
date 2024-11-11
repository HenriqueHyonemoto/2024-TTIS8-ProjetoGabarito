pkg load image;  % Carregar pacote de processamento de imagens
clc;

% Carrega e binariza a imagem
gabarito = imread("GabaritoP1.jpg");
gabarito = im2bw(gabarito);

% Exibe a imagem binarizada
figure(1), imshow(gabarito);

tamanho = 96;       % Tamanho de cada quadrado de alternativa
distanciaX = 142;   % Distância entre os quadrados das alternativas
distanciaY = 156;   % Distância entre as questões

% Função para verificar se uma alternativa específica está assinalada
function alternativa = verificar_alternativa(gabarito, x, y, tamanho)
  area_quadrado = gabarito(y:y+tamanho-1, x:x+tamanho-1);
  media_intensidade = mean(area_quadrado(:));
  limiar = 0.75;

  if media_intensidade < limiar
    alternativa = 'Assinalada';
  else
    alternativa = 'Não Assinalada';
  end
end

% Função para verificar qual alternativa foi assinalada em uma questão
function alternativa_assinalada = verificar_questao(gabarito, x_inicial, y_inicial, tamanho, distanciaX)
  alternativas_letras = ['A', 'B', 'C', 'D'];
  num_assinaladas = 0;
  alternativa_assinalada = 'ANULADA';

  for i = 1:4
    x = x_inicial + (i - 1) * distanciaX;
    area_quadrado = gabarito(y_inicial:y_inicial+tamanho-1, x:x+tamanho-1);
    media_intensidade = mean(area_quadrado(:));

    if media_intensidade < 0.75
      num_assinaladas = num_assinaladas + 1;
      alternativa_assinalada = alternativas_letras(i);
    end
  end

  if num_assinaladas != 1
    alternativa_assinalada = 'ANULADA';
  end
end

% Função para corrigir a prova comparando com o gabarito de respostas
function corrigir_prova(gabarito, respostas_certas, tamanho, distanciaX, distanciaY)
  nota_final = 0;

  for questao = 1:length(respostas_certas)
    y_inicial = 296 + (questao - 1) * distanciaY;
    x_inicial = 341;

    % Verifica a alternativa assinalada
    resultado = verificar_questao(gabarito, x_inicial, y_inicial, tamanho, distanciaX);

    % Exibe o resultado da questão
    fprintf('Questão %d: %s\n', questao, resultado);

    % Compara com o gabarito e incrementa a nota se correto
    if resultado == respostas_certas(questao)
      nota_final = nota_final + 1;
    end
  end

  % Exibe a nota final
  fprintf('Nota Final: %d/%d\n', nota_final, length(respostas_certas));
end

% Define o gabarito correto
respostas_certas = ['A', 'B', 'C', 'C', 'D'];

% Corrige a prova com base no gabarito correto
corrigir_prova(gabarito, respostas_certas, tamanho, distanciaX, distanciaY);

