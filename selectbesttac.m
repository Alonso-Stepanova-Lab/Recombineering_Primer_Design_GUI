function [bestJATY,bestJATYsize,bestJATYori] = selectbesttac(JATYObj,limitup,limitdown,Chromosome,minsizetactoconsider)
chrs=JATYObj.Reference;
chrs=string(chrs);
chrindx=chrs==Chromosome;
starts=JATYObj.Start;
ends=JATYObj.Stop;
startsindx=starts<=limitdown;
endsindx=ends>=limitup;
sizes=JATYObj.Gene;
sizes = cellfun(@(x)str2double(x), sizes);
sizesindx=sizes>=minsizetactoconsider;
goodTACsindex=find(chrindx & startsindx & endsindx & sizesindx);
xp=numel(goodTACsindex);
JATY=[];
JATYori=[];
JATYsize=[];
if xp>0
for np=1:xp %select the best smalles TAC
    JATYori1=cell2mat(JATYObj.Strand(goodTACsindex(np)));
    if isempty(JATYori1) 
        continue
    end
    JATYname=cell2mat(JATYObj.Transcript(goodTACsindex(np)));
    JATYname=convertCharsToStrings(JATYname);
    JATY=cat(1,JATY,JATYname);
    JATYori=cat(1,JATYori,JATYori1);
    JATYsize1=str2num(cell2mat(JATYObj.Gene(goodTACsindex(np))));
    JATYsize=cat(1,JATYsize,JATYsize1);   
end
%JATYsize=str2num(JATYsize);
minJATY=min(JATYsize);
minJATYindx=find(JATYsize==minJATY);
minJATYindx=minJATYindx(1,1);
bestJATY=JATY(minJATYindx,:);
bestJATYori=JATYori(minJATYindx);
bestJATYsize=JATYsize(minJATYindx);
else
 bestJATY=[];
 bestJATYori=[];
 bestJATYsize=[];

end

end
    