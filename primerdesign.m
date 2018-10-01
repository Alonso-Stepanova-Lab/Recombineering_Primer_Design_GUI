function [good_fwdprimers,good_revprimers] = primerdesign(primerF,primerR,tprimersize,lowgc,highgc,minMT,maxMT)

NF = length(primerF); % length of the target sequence
NR = length(primerR); % length of the target sequence

M = tprimersize;  % desired primer length
index = repmat((0:NF-M)',1,M)+repmat(1:M,NF-M+1,1);
fwdprimerlistF = primerF(index);

for i = NF-19:-1:1 % reverse order to pre-allocate structure
    fwdprimerpropsF(i) = oligoprop(fwdprimerlistF(i,:));
end

index = repmat((0:NR-M)',1,M)+repmat(1:M,NR-M+1,1);
fwdprimerlistR = primerR(index);

for i = NR-19:-1:1 % reverse order to pre-allocate structure
    fwdprimerpropsR(i) = oligoprop(fwdprimerlistR(i,:));
end

fwdgc = [fwdprimerpropsF.GC]';
revgc = [fwdprimerpropsR.GC]';

bad_fwdprimers_gc = fwdgc < lowgc | fwdgc > highgc;
bad_revprimers_gc = revgc < lowgc | revgc > highgc;

fwdtm = cell2mat({fwdprimerpropsF.Tm}');
revtm = cell2mat({fwdprimerpropsR.Tm}');
bad_fwdprimers_tm = fwdtm(:,5) < minMT | fwdtm(:,5) > maxMT;
bad_revprimers_tm = revtm(:,5) < minMT | revtm(:,5) > maxMT;

bad_fwdprimers_dimers  = ~cellfun('isempty',{fwdprimerpropsF.Dimers}');
bad_fwdprimers_hairpin = ~cellfun('isempty',{fwdprimerpropsF.Hairpins}');
bad_revprimers_dimers  = ~cellfun('isempty',{fwdprimerpropsR.Dimers}');
bad_revprimers_hairpin = ~cellfun('isempty',{fwdprimerpropsR.Hairpins}');

bad_fwdprimers_clamp = lower(fwdprimerlistF(:,end)) == 'a' | lower(fwdprimerlistF(:,end)) == 't';
bad_revprimers_clamp = lower(fwdprimerlistR(:,end)) == 'a' | lower(fwdprimerlistR(:,end)) == 't';

bad_fwd_toomany=sum(fwdprimerlistF(:,:)'=='A')>10' | sum(fwdprimerlistF(:,:)'=='T')>10' | sum(fwdprimerlistF(:,:)'=='C')>10'...
    | sum(fwdprimerlistF(:,:)'=='G')>10';

bad_rev_toomany=sum(fwdprimerlistR(:,:)'=='A')>10' | sum(fwdprimerlistR(:,:)'=='T')>10' | sum(fwdprimerlistR(:,:)'=='C')>10'...
    | sum(fwdprimerlistR(:,:)'=='G')>10';

fwdrepeats = regexpi(cellstr(fwdprimerlistF),'a{4,}|c{4,}|g{4,}|t{4,}','ONCE');
revrepeats = regexpi(cellstr(fwdprimerlistR),'a{4,}|c{4,}|g{4,}|t{4,}','ONCE');
bad_fwdprimers_repeats = ~cellfun('isempty',fwdrepeats);
bad_revprimers_repeats = ~cellfun('isempty',revrepeats);


bad_fwdprimers = [bad_fwdprimers_gc, bad_fwdprimers_tm,...
                  bad_fwdprimers_dimers, bad_fwdprimers_hairpin,...
                  bad_fwdprimers_clamp, bad_fwdprimers_repeats,bad_fwd_toomany.'];
bad_revprimers = [bad_revprimers_gc, bad_revprimers_tm,...
                  bad_revprimers_dimers, bad_revprimers_hairpin,...
                  bad_revprimers_clamp, bad_revprimers_repeats,bad_rev_toomany.'];

good_fwdpos = find(all(~bad_fwdprimers,2));
good_fwdprimers = fwdprimerlistF(good_fwdpos,:);
good_fwdprop = fwdprimerpropsF(good_fwdpos);
N_good_fwdprimers = numel(good_fwdprop);

good_revpos = find(all(~bad_revprimers,2));
good_revprimers = fwdprimerlistR(good_revpos,:);
good_revprop = fwdprimerpropsR(good_revpos);
N_good_revprimers = numel(good_revprop);

 
    
end
