pkg load image;  % Carregar pacote de processamento de imagens
clc;

% Carrega e binariza a imagem
gabarito = imread("GabaritoP1.jpg");
gabarito = im2bw(gabarito);

% Exibe a imagem binarizada
figure(1), imshow(gabarito);

tamanho = 96;        % Tamanho de cada quadrado de alternativa
distanciaX = 142;    % Distância entre os quadrados das alternativas
distanciaY = 156;    % Distância entre os quadrados das questões

% Função para verificar todas as alternativas de uma questão
% (imagem, posição do pixel superior esquerdo do quadrado, (calculado na função corrigir_prova)
% tamanho do lado do quadrado, distancia entre as alternativas no eixo x)
function alternativa_assinalada = verificar_questao(gabarito, x_inicial, y_inicial, tamanho, distanciaX)

  % Array para armazenar as alternativas (A, B, C, D)
  alternativas = cell(1, 4);
  alternativas_letras = ['A', 'B', 'C', 'D'];

  limiar = 0.75; % Limiar para determinar se a área está assinalada

  num_assinaladas = 0; % Variável para contar o número de alternativas assinaladas
  alternativa_assinalada = 'ANULADA'; % alternativa vem como Default se nenhuma ou mais de uma alternativa estiver assinalada

  % Itera sobre as quatro alternativas (A, B, C, D)
  for i = 1:4
    # para saber qual das alternativas estão sendo verificadas
    % calcula a coordenada esquerda superior do quadrado para a alternativa atual,
    % somando a distancia horizontal entre os quadrados cada vez
    x = x_inicial + (i - 1) * distanciaX;

    % Para calcular a area do quadrado, pegamos a imagem do gabarito,
    % passamos o pixel superior esquerdo do quadrado, e também passamos o tamanho do lado,
    % assim a função calcula a area
    area_quadrado = gabarito(y_inicial:y_inicial+tamanho-1, x:x+tamanho-1);

    % Calcula a média(mean) de preenchimento dentro do quadrado, valor entre 0 a 1
    media_intensidade = mean(area_quadrado(:));

% Verifica se a média de intensidade está abaixo do limiar (75% ou seja, 25% deve estar preenchido)
    if media_intensidade < limiar
      alternativas{i} = 'Assinalada'; % Assinalado
      num_assinaladas = num_assinaladas + 1; % Conta o numero de alternativas assinaladas
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

% Função principal para corrigir a prova com base no gabarito fornecido
% (imagem do gabario, array com as respostas certas, tamanho do quadrado,
% distancia entre os quadrados em horizontal e vertical)
function corrigir_prova(gabarito, respostas_certas, tamanho, distanciaX, distanciaY)
  nota_final = 0;  % Inicializa a nota final

  % percorre todas as 8 questoes (existem 8 respostas certas)
  for questao = 1:length(respostas_certas)
    % calcula a ditancia VERTICAL entre as questões para indicar a questao,
    y_inicial = 296 + (questao - 1) * distanciaY;  % passamos a posição do y, e somamos com a distancia multiplicada pelo numero da questao (dobro da distancia, triplo etc.)
    x_inicial = 341;  % posição horizontal sera utilizado para passar para funçã oque verifica a alternativa, ela que faz o calculo com esse valor

    % Chama a função para verificar as alternativas da questão
    % (imagem do gabarito, posição e tamanho do quadrado
    % a distancia entre os quadrados horizontalmente.
    resultado = verificar_questao(gabarito, x_inicial, y_inicial, tamanho, distanciaX);

    % Exibe o resultado para a alternativa assinalada ou "ANULADA" da questão
    fprintf('Questão %d: %s\n', questao, resultado);

    % Verifica se o resultado está correto e incrementa a nota
    if resultado == respostas_certas(questao)
      nota_final = nota_final + 1;  % Incrementa a nota se a resposta estiver correta
    end
  end

  % Exibe a nota final mostrando o count da nota_final junto com o total de questoes (tamanho do array respostas)
  fprintf('Nota Final: %d/%d\n', nota_final, length(respostas_certas));
end

% Definindo o gabarito das respostas corretas
respostas_certas = ['A', 'B', 'C', 'C','D','A','B','C'];

% Chama a função para corrigir a prova
% (imagem do gabarito, array com as respostas, tamanho do quadrado, distancia horizontal e vertical dos quadrados)
corrigir_prova(gabarito, respostas_certas, tamanho, distanciaX, distanciaY);

