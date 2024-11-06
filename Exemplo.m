pkg load image;  % Carregar pacote de processamento de imagens

% Função principal
function gabarito = analisar_gabarito(imagem)
    % Carregar imagem e converter para escala de cinza
    img = imread(imagem);
    img_gray = rgb2gray(img);  % Converter para escala de cinza

    % Binarizar a imagem (preto e branco)
    img_bin = img_gray < 128;  % Ajuste do limiar conforme necessário

    % Exibir a imagem binarizada (opcional, para depuração)
    imshow(img_bin);

    % Definir o tamanho da tabela (4x8 para 4 alternativas e 8 questões)
    num_questoes = 8;
    num_alternativas = 4;

    % Definir o tamanho da célula para cada questão
    [height, width] = size(img_bin);
    cell_height = floor(height / num_alternativas);
    cell_width = floor(width / num_questoes);

    % Inicializar o vetor de respostas
    gabarito = zeros(1, num_questoes);  % Vetor para armazenar a alternativa marcada para cada questão

    % Loop para cada questão
    for i = 1:num_questoes
        % Coordenadas da célula da questão (na direção horizontal)
        x_start = (i - 1) * cell_width + 1;
        x_end = i * cell_width;

        % Analisar as alternativas (4 alternativas por questão)
        alternativas_media = zeros(1, num_alternativas);

        for j = 1:num_alternativas
            % Coordenadas da célula de uma alternativa (na direção vertical)
            y_start = (j - 1) * cell_height + 1;
            y_end = j * cell_height;

            % Extrair a região da alternativa
            alternativa_regiao = img_bin(y_start:y_end, x_start:x_end);

            % Calcular a média da intensidade de cor na região da alternativa
            alternativas_media(j) = mean(alternativa_regiao(:));
        end

        % Encontrar a alternativa marcada (a que tem a maior intensidade)
        [~, gabarito(i)] = max(alternativas_media);  % 1=Alternativa A, 2=Alternativa B, 3=Alternativa C, 4=Alternativa D
    end

    % Exibir o gabarito final
    disp('Respostas Assinaladas:');
    disp(gabarito);
end

% Teste com uma imagem do gabarito
gabarito =
