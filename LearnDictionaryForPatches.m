function [ D,Z ] = LearnDictionaryForPatches( X,numOfAtoms,lam,maxIter )
%LEARNDICTIONARYFORPATCHES Summary of this function goes here
%   Detailed explanation goes here
Tol = 1e-3;

if size(X,2) < numOfAtoms
    numOfAtoms=size(X,2)/2;
%     error('Number of atoms cannot be more than the number of samples');
end

%% Dictionary initializiation

% initialize dictionary with randomly chosen samples : overcomplete dict.
% T = randperm(size(X,2));
% D = X(:,T(1:numOfAtoms));
% for i = 1:numOfAtoms
%         D(:,i) = D(:,i)/norm(D(:,i));
% end

% undercomplete dictionary : QR
[Q,~]=qr(X);
D = Q(:,1:numOfAtoms);

%%

% disp('Learning dictionary')

for iter = 1:maxIter
    D = normc(D);
    % Feature Update
    Z = inv(D'*D+lam*eye(size(D'*D)))*D'*X;
    
    Dprev = D;
    
    
    %Dictionary Update
    D = X*Z'*inv(Z*Z'+lam*eye(size(Z*Z')));
    %%%%%%%%%%%%%%update here
    
    if norm(D-Dprev, 'fro') < Tol
        break
    end
end
% disp('Dictionary learnt')
end