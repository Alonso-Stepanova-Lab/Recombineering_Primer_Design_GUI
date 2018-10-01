function [good_fwdprimers] = primerdesign1(primerF,tprimersize,lowgc,highgc,minMT,maxMT)

NF = length(primerF); % length of the target sequence

M = tprimersize;  % desired primer length
index = repmat((0:NF-M)',1,M)+repmat(1:M,NF-M+1,1);
fwdprimerlistF = primerF(index);

for i = NF-19:-1:1 % reverse order to pre-allocate structure
    fwdprimerpropsF(i) = oligoprop(fwdprimerlistF(i,:));
end



fwdgc = [fwdprimerpropsF.GC]';


bad_fwdprimers_gc = fwdgc < lowgc | fwdgc > highgc;


fwdtm = cell2mat({fwdprimerpropsF.Tm}');
bad_fwdprimers_tm = fwdtm(:,5) < minMT | fwdtm(:,5) > maxMT;

bad_fwdprimers_dimers  = ~cellfun('isempty',{fwdprimerpropsF.Dimers}');
bad_fwdprimers_hairpin = ~cellfun('isempty',{fwdprimerpropsF.Hairpins}');


bad_fwdprimers_clamp = lower(fwdprimerlistF(:,end)) == 'a' | lower(fwdprimerlistF(:,end)) == 't';


bad_fwd_toomany=sum(fwdprimerlistF(:,:)'=='A')>10' | sum(fwdprimerlistF(:,:)'=='T')>10' | sum(fwdprimerlistF(:,:)'=='C')>10'...
    | sum(fwdprimerlistF(:,:)'=='G')>10';


fwdrepeats = regexpi(cellstr(fwdprimerlistF),'a{4,}|c{4,}|g{4,}|t{4,}','ONCE');

bad_fwdprimers_repeats = ~cellfun('isempty',fwdrepeats);



bad_fwdprimers = [bad_fwdprimers_gc, bad_fwdprimers_tm,...
                  bad_fwdprimers_dimers, bad_fwdprimers_hairpin,...
                  bad_fwdprimers_clamp, bad_fwdprimers_repeats,bad_fwd_toomany.'];

good_fwdpos = find(all(~bad_fwdprimers,2));
good_fwdprimers = fwdprimerlistF(good_fwdpos,:);
good_fwdprop = fwdprimerpropsF(good_fwdpos);
N_good_fwdprimers = numel(good_fwdprop);   
end
