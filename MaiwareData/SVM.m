% define training examples and their labels
X = [ [0; 1] [1;1] [0;0] [1;0]];
Y = [ +1     +1    -1    -1];
m = length( Y );

% kernel matrix for linear kernel
K = (X'*X);

% run libsvm with user-defined kernel
C   = 1;
Svm = svmtrain( Y(:), [[1:m]' K], ['-s 0 -t 4 -c ' num2str(C)] );

% get parameters of kernel classifier
bias             = -Svm.rho;
alpha            = zeros( m, 1);
alpha( Svm.SVs ) = Svm.sv_coef(:);

% predict training examples
score = K*alpha + bias;
predY = 2*double( score >= 0) - 1;

% compute training error
trnErr = mean( predY(:) ~= Y(:) );

% "Usage: [predicted_label, accuracy, decision_values/prob_estimates] = svmpredict(testing_label_vector, testing_instance_matrix, model, 'libsvm_options')\n"
% 		"       [predicted_label] = svmpredict(testing_label_vector, testing_instance_matrix, model, 'libsvm_options')\n"
% 		"Parameters:\n"
% 		"  model: SVM model structure from svmtrain.\n"
% 		"  libsvm_options:\n"
% 		"    -b probability_estimates: whether to predict probability estimates, 0 or 1 (default 0); one-class SVM not supported yet\n"
% 		"    -q : quiet mode (no outputs)\n"
% 		"Returns:\n"
% 		"  predicted_label: SVM prediction output vector.\n"
% 		"  accuracy: a vector with accuracy, mean squared error, squared correlation coefficient.\n"
% 		"  prob_estimates: If selected, probability estimate vector.\n"
% TLV = [ -1, -1, 1, 1 ];
% Xt = X';
% [predicted_label] = svmpredict(TLV', Xt, Svm, '');

