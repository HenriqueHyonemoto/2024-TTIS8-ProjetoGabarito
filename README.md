# 2024-TTIS8-ProjetoGabarito

Necessario binarizar a imagem, para pixel preto ter valor 0 e branco ter valor 1

Tamanho: 96
Coordenadas: x  |  y 
Questão 1A: 341 | 296
Questão 1B: 483 | 297


# Funcionalidades
## Primeira função (Verifica alternativas)
- Calcula a area do quadrado com a posição do pixel superior esquerdo mais o tamanho do quadrado
- Passamos a distancia horizontal entre os quadrados para o sistema fazer o calculos dos 3 demais quadrados
- O Sistema calcula a media de preenchimento de cada quadrado, retornando aquela alternativa preenchida se tiver mais de 25% de preenchimento
- Se for assinalado qualquer valor diferente de 1, a questão é dado como anulada
  
## Segunda Função (Verifica Questão 1 a 8 e atribuir nota)
- Responsavel por percorrer as 8 questões
- Posição em x do pixel superior esquerdo é fixo aqui, pois ele só é modificado na primeira função
- Posição em y do pixel superior esquerdo é definido atrvés de um calculo utilizando a distancia das questões no eixo Y, somando a distancia multiplicada pelo numero da questão 
  - Questão 1 (Posição 296 + 0 * Distancia 156) = 296
  - Questão 2 (Posição 296 + 1 * Distancia 156) = 452
  - Questão 3 (Posição 296 + 2 * Distancia 156) = 608
- Após isso se chama a primeira função com esses parametros (posição do pixel esquerdo superior da Alternativa "A" dessa questão especifica)
- Imprime a questão e a alternativa assinalada
- Compara com as alternativas corretas e conta o numero de alternativas acertadas

