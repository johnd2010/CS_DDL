function [ recimg ] = Method1( Xorg,gb,n,NoofPatches,m,lambda,mu,maxiterdict,maxiterista,NoOfDict)
%METHOD1 Summary of this function goes here
%   Detailed explanation goes here
NoofAtoms=NoofPatches*NoofPatches;
R=SensingMatrix(ceil(m*length(Xorg(:))/100),length(Xorg(:)),gb);
y=R*Xorg(:);
X=pinv(R)*y;
X=reshape(X,size(Xorg));
[~,vecpatch]=patchcreator(X,NoofPatches);
Z=vecpatch;
% max=0;
for i=1:NoOfDict
    [D,Z]=LearnDictionaryForPatches(Z,NoofAtoms,lambda,maxiterdict);
    if i==1
        Dprod=D;
    else
        Dprod=Dprod*D;
    end
end
% zrec=ISTA(vecpatch,Dprod,mu,maxiterista);
opts = spgSetParms('verbosity',0);
for i=1:size(vecpatch,2)
    zrec(:,i) = spg_bp(Dprod,vecpatch(:,i), opts);
end
recvec=Dprod*zrec;
recimg=imagerecreator(recvec,NoofPatches,size(Xorg));
end

