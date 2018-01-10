clear all;

% The input is a binary image I = (I1, . . . , IL) ? {0, 1} 16?8·L displaying a sequence of L handwritten
% characters. Each sub-image Ii ? {0, 1} 16?8 , i ? {1, . . . , L}, is of fixed size hence the
% segmentation of the image I into characters is known. We represent the input image I by a matrix X = (x1, . . . , xL) ? R
% d?L where d is the number of features. The i-th column xi ? Rd is a feature description of the i-th sub-image Ii. 
% The feature vector xi contains the intensity values of Ii and un-ordered products of the intensity values 
% computed from all different pixel pairs of Ii. Therefore the number of features is d = 16 · 8 + (16 · 8 ? 1)(16 · 8)/2 = 8256. In
% addition, each feature vector is normalized to have a unit L2-norm.

data = load('ocr_names.mat');
d = 8256;
A = 26;
weights = zeros(d, A);
b = zeros(1,A);

%Independent linear multi-class classifier

weights = StructeredPerceptronTrain(data.TrnData, weights);
WrongWord = 0;
AllLetters = 0;
NumberOfWrongLetters = 0;
for i = 1:length(data.TstData)
   found_word = PerceptronWordTest(weights, data.TstData(i).X);
   TrueWord = double(data.TstData(i).Y);
   AllLetters = AllLetters + length(TrueWord);
   WrongLetters = found_word ~= TrueWord;
   Sum = sum(WrongLetters);
   NumberOfWrongLetters = NumberOfWrongLetters + Sum;
   if Sum ~= 0
       WrongWord = WrongWord + 1;
   end
end

R1seq = WrongWord/length(data.TstData);
R1char = NumberOfWrongLetters/AllLetters;

% dlmwrite('Weights.txt', weights, 'precision', 8);
% 
% AllPairs = FindAllPairs(data.TrnData);
% dlmwrite('AllPairs.txt', AllPairs, 'precision', 8);
 
weights = load('Weights.txt');
AllPairs = load('AllPairs.txt');




%Linear structured classifier modeling pair-wise dependency

%weights = StructeredPerceptronTrain2(data.TrnData, weights);
for i = 1:length(data.TstData)
    found_word = PercepronTest2(weights, data.TstData(i).X, AllPairs);
end
