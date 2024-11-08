pkg load image;  % Carregar pacote de processamento de imagens
clc;

%funcionalidade de anular questao caso mais de uma seja sssinalada

% Carrega a imagem
gabarito = imread("GabaritoP1.jpg");

%  Binariza a imagem
gabarito=im2bw(gabarito);

% Exibe a imagem binarizada
figure(1),imshow(gabarito);

tamanho = 96;
distancia = 142;

% Função principal
function alternativa = verificar_alternativa(gabarito, x, y, tamanho)
  % gabarito: imagem binarizada do gabarito (0 = preto, 1 = branco)
  % x, y: coordenadas do canto superior esquerdo do quadrado
  % tamanho: tamanho do lado do quadrado

  % Extrai a área correspondente ao quadrado
  area_quadrado = gabarito(y:y+tamanho-1, x:x+tamanho-1);

  % Calcula a média de intensidade da área
  media_intensidade = mean(area_quadrado(:));

  % Define um limiar para determinar se a área está assinalada (Ao menoss 25% do quadrado deve estar preenchido)
  limiar = 0.75;

  % Mostrando a intensidade
  disp(media_intensidade);
  % Verifica se a média de intensidade está abaixo do limiar (assinalado)
  if media_intensidade < limiar
    alternativa = 'Assinalada'; % Assinalado
  else
    alternativa = 'Não Assinalada'; % Não assinalado
  end
end

disp(verificar_alternativa(gabarito, 341, 296, tamanho)); %Q1_A
disp(verificar_alternativa(gabarito, 483, 296, tamanho)); %Q1_B
disp(verificar_alternativa(gabarito, 625, 296, tamanho)); %Q1_C
disp(verificar_alternativa(gabarito, 767, 296, tamanho)); %Q1_D
