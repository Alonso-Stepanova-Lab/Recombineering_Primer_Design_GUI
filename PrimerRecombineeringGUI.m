function varargout = PrimerRecombineeringGUI(varargin)
% PRIMERRECOMBINEERINGGUI MATLAB code for PrimerRecombineeringGUI.fig
%      PRIMERRECOMBINEERINGGUI, by itself, creates a new PRIMERRECOMBINEERINGGUI or raises the existing
%      singleton*.
%
%      H = PRIMERRECOMBINEERINGGUI returns the handle to a new PRIMERRECOMBINEERINGGUI or the handle to
%      the existing singleton*.
%
%      PRIMERRECOMBINEERINGGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PRIMERRECOMBINEERINGGUI.M with the given input arguments.
%
%      PRIMERRECOMBINEERINGGUI('Property','Value',...) creates a new PRIMERRECOMBINEERINGGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PrimerRecombineeringGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PrimerRecombineeringGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PrimerRecombineeringGUI

% Last Modified by GUIDE v2.5 29-Sep-2018 10:02:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PrimerRecombineeringGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @PrimerRecombineeringGUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before PrimerRecombineeringGUI is made visible.
function PrimerRecombineeringGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PrimerRecombineeringGUI (see VARARGIN)

% Choose default command line output for PrimerRecombineeringGUI
handles.output = hObject;
%load GTF file
GTFObj=GTFAnnotation('Araport11.gtf');
genome1=fastaread('TAIR10.fasta','blockread',1);
genome2=fastaread('TAIR10.fasta','blockread',2);
genome3=fastaread('TAIR10.fasta','blockread',3);
genome4=fastaread('TAIR10.fasta','blockread',4);
genome5=fastaread('TAIR10.fasta','blockread',5);
filename=[];
pathname=[];
x=[];
tprimersize=20;
lowgc=45;
highgc=55;
max=500;
min=100;
maxMT=60;
minMT=50;
recombineeringsize=40;
upstreamsize=10000;
downstreamsize=5000;
insertcoordenada=[];
minsizetactoconsider=25000;

handles.GTFObj=GTFObj;
handles.genome1=genome1;
handles.genome2=genome2;
handles.genome3=genome3;
handles.genome4=genome4;
handles.genome5=genome5;

handles.filename=filename;
handles.pathname=pathname;
handles.x=x;
handles.tprimersize=tprimersize;
handles.lowgc=lowgc;
handles.highgc=highgc;
handles.max=max;
handles.min=min;
handles.maxMT=maxMT;
handles.minMT=minMT;
handles.recombineeringsize=recombineeringsize;
handles.upstreamsize=upstreamsize;
handles.downstreamsize=downstreamsize;
handles.insertcoordenada=insertcoordenada;
handles.minsizetactoconsider=minsizetactoconsider;


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PrimerRecombineeringGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = PrimerRecombineeringGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt = {'Enter the gene ID'};
title = 'Input';
dims = [1 35];
definput = {'AT5G25350.1'};
x = inputdlg(prompt,title,dims,definput);
x=cell2mat(x);
x=upper(x);
w=x=='.';
w=sum(w);
if w==0
    x=strcat(x,'.1');
end
filename=[];
pathname=[];
handles.filename=filename;
handles.pathname=pathname;

handles.x=x;

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename pathname] = uigetfile({'*.csv'},'File Selector');

handles.filename=filename;
handles.pathname=pathname;


% Update handles structure
guidata(hObject, handles);



% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
GTFObj=handles.GTFObj;
genome1=handles.genome1;
genome2=handles.genome2;
genome3=handles.genome3;
genome4=handles.genome4;
genome5=handles.genome5;
tprimersize=handles.tprimersize;
highgc=handles.highgc;
lowgc=handles.lowgc;
max=handles.max;
min=handles.min;
maxMT=handles.maxMT;
minMT=handles.minMT;
recombineeringsize=handles.recombineeringsize;
upstreamsize=handles.upstreamsize;
downstreamsize=handles.downstreamsize;
insertcoordenada=handles.insertcoordenada;
minsizetactoconsider=handles.minsizetactoconsider;


GCcontent=cat(2,lowgc,highgc);
GCcontent=num2str(GCcontent);

set(handles.TprimersGC,'String',GCcontent);
set(handles.Tprimerslength,'String',tprimersize);

Tprimersdistance1=cat(2,min,max);
Tprimersdistance1=num2str(Tprimersdistance1);
set(handles.Tprimersdistance,'String',Tprimersdistance1);

TprimersTM=cat(2,minMT,maxMT);
TprimersTM=num2str(TprimersTM);
set(handles.TprimersMT,'String',TprimersTM);

set(handles.recombPrimsize,'String',recombineeringsize);
set(handles.upstreamsequencesize,'String',upstreamsize);
set(handles.dowsntreamseqsize,'String',downstreamsize);
set(handles.insertcoord,'String',insertcoordenada);


[file,path] = uiputfile('*.csv','Save CSV file with the primer list');
destino=strcat(path,file);

cellA={};
filename=handles.filename;
pathname=handles.pathname;
filenamedir=strcat(pathname,filename);
fileID = fopen(filenamedir);
csvfile = textscan(fileID,'%s');

filesize=size(csvfile{1,1});
numberofgenes=filesize(1,1); 

cellA{1,1}='Gene';
cellA{1,2}='Chromosome';
cellA{1,3}='Orientation';
cellA{1,4}='Start';
cellA{1,5}='Stop';
cellA{1,6}='TAC clone';
cellA{1,7}='Orientation';
cellA{1,8}='NterminusF';
cellA{1,9}='NterminusR';
cellA{1,10}='CterminusF';
cellA{1,11}='CterminusR';
cellA{1,12}='DelLeft';
cellA{1,13}='DelRight';
cellA{1,14}='testNterminusF';
cellA{1,15}='testNterminusR';
cellA{1,16}='testCterminusF';
cellA{1,17}='testCterminusR';
cellA{1,18}='testDelLeft';
cellA{1,19}='testDelRight';


for pa=1:numberofgenes
    n=0;%new
    m=0;%new

if isempty(filename)
     str=x;
else
    str=csvfile{1,1}(pa,1);
%x=cell2mat(x);
str=upper(str);
str=cell2mat(str);
w=str=='.';
w=sum(w);
if w==0
    str=strcat(str,'.1');
end

end



geneinfo=getData(GTFObj,'Transcript',str);
dimension=size(geneinfo);
p=dimension(1);
if isempty(geneinfo)
    continue
end
orientation=geneinfo.Strand;
tstart=0;
delup=upstreamsize;
deldown=downstreamsize;
for x=1:p
   s=geneinfo(x).Feature;
   if strcmp(s,'CDS') & tstart==0
   n=x;
   tstart=1;
   end
   
   if strcmp(s,'CDS') & tstart==1
   m=x;
   end

end
if n==0 || m==0 %new
    continue;
end

Chromosome=geneinfo.Reference;
if (Chromosome=='Chr1')
    genome=genome1;
elseif (Chromosome=='Chr2')
    genome=genome2;
elseif (Chromosome=='Chr3')
    genome=genome3;
elseif (Chromosome=='Chr4')
    genome=genome4;
elseif (Chromosome=='Chr5')
    genome=genome5;
end

chrsize=numel(genome.Sequence); %new

if(orientation=='-')
start=geneinfo(m).Stop;
final=geneinfo(n).Start;

origen=start;
if ~isempty(insertcoordenada)
    origen=start+insertcoordenada;    
end



if start+10000>=chrsize || final-5000<=0 %new
    continue
end
oligoNF=seqrcomplement(genome.Sequence(origen+1:origen+recombineeringsize));
oligoNR=genome.Sequence(origen-recombineeringsize-1:origen);
oligoCF=seqrcomplement(genome.Sequence(final+3:final+recombineeringsize+2));
oligoCR=genome.Sequence(final-recombineeringsize-3:final+2);
% oligoDelUpstreamF=seqrcomplement(genome.Sequence(start+1+delup:start+40+delup));
oligoDelUpstreamR=genome.Sequence(start-recombineeringsize-1+delup:start+delup);
oligoDelDownstreamF=seqrcomplement(genome.Sequence(final+3-deldown:final+recombineeringsize-2-deldown));
% oligoDelDownstreamR=genome.Sequence(final-37-deldown:final+2-deldown);
seqforprimersN1=seqrcomplement(genome.Sequence(origen+min:origen+max));
seqforprimersN2=genome.Sequence(origen-max:origen-min);
seqforprimersC1=seqrcomplement(genome.Sequence(final+min:final+max));
seqforprimersC2=genome.Sequence(final-max:final-min);
seqforprimersDelUp=genome.Sequence(start-recombineeringsize-1+delup-max:start+delup-min);
seqforprimersDelDown=seqrcomplement(genome.Sequence(final-recombineeringsize-3-deldown+min:final+2-deldown+max));


elseif(orientation=='+')
start=geneinfo(n).Start;
final=geneinfo(m).Stop;


origen=start;
if ~isempty(insertcoordenada)
    origen=start+insertcoordenada;    
end


if start-10000<=0 || final+5000>=chrsize %new
    continue
end

oligoNF=genome.Sequence(origen-recombineeringsize:origen-1);
oligoNR=seqrcomplement(genome.Sequence(origen:origen+recombineeringsize-1));
oligoCF=genome.Sequence(final-recombineeringsize+2:final-3);
oligoCR=seqrcomplement(genome.Sequence(final-2:final+recombineeringsize-3));
% oligoDelUpstreamF=genome.Sequence(start-40-delup:start-1-delup);
oligoDelUpstreamR=seqrcomplement(genome.Sequence(start-delup:start+recombineeringsize-1-delup));
oligoDelDownstreamF=genome.Sequence(final-recombineeringsize+2+deldown:final-3+deldown);
% oligoDelDownstreamR=seqrcomplement(genome.Sequence(final-2+deldown:final+37+deldown));
seqforprimersN1=genome.Sequence(origen-max:origen-min);
seqforprimersN2=seqrcomplement(genome.Sequence(origen+min:origen+max));
seqforprimersC1=genome.Sequence(final-max:final-min);
seqforprimersC2=seqrcomplement(genome.Sequence(final+min:final+max));
seqforprimersDelUp=seqrcomplement(genome.Sequence(start-delup+min:start+39-delup+max));
seqforprimersDelDown=(genome.Sequence(final-recombineeringsize+2+deldown-max:final-3+deldown-min));%ojo?
end

[testNF,testNR]=primerdesign(seqforprimersN1,seqforprimersN2,tprimersize,lowgc,highgc,minMT,maxMT);
[testCF,testCR]=primerdesign(seqforprimersC1,seqforprimersC2,tprimersize,lowgc,highgc,minMT,maxMT);
[testDelUp]=primerdesign1(seqforprimersDelUp,tprimersize,lowgc,highgc,minMT,maxMT);
[testDelDown]=primerdesign1(seqforprimersDelDown,tprimersize,lowgc,highgc,minMT,maxMT);



%select TAC clones

JATYObj=GTFAnnotation('JAtYSorted.gtf');
KclonesObj=GTFAnnotation('Kclones.gtf');

if orientation == '-'
    limitup=start+10000;
    limitdown=final-5000;
end

if orientation == '+'
    limitdown=start-10000;
    limitup=final+5000;
end

[bestJATY,bestJATYsize,bestJATYori] = selectbesttac(JATYObj,limitup,limitdown,Chromosome,minsizetactoconsider);
[bestKclone,bestKclonesize,bestKcloneori] = selectbesttac(KclonesObj,limitup,limitdown,Chromosome,minsizetactoconsider);

if isempty(bestJATY)
   bestJATYori=bestKcloneori;
   bestJATY=bestKclone; 
end


if isempty(bestJATY)
    bestJATYori='-';
    bestJATY='Could not find a good JAtY clone. Sorry!';  
end


oligoCF=strcat(oligoCF,'-GGAGGTGGAGGTGGAGCT');
oligoNF=strcat(oligoNF,'-GGAGGTGGAGGTGGAGCT');
oligoNR=strcat(oligoNR,'-GGCCCCAGCGGCCGCAGCAGCACC');
oligoCR=strcat(oligoCR,'-GGCCCCAGCGGCCGCAGCAGCACC');

if (bestJATYori == '+' && orientation == '+') || (bestJATYori == '-' && orientation == '-') 
DelLeft=strcat(oligoDelUpstreamR,'-TTACCAATGCTTAATCAGTG');
DelRight=strcat(oligoDelDownstreamF,'-CGAATGCTAGTCTAGCTGTTGC');
testDelLeft=testDelUp;
testDelRight=testDelDown;
end

if (bestJATYori == '-' && orientation == '+') || (bestJATYori == '+' && orientation == '-')
DelRight=strcat(oligoDelUpstreamR,'-CGAATGCTAGTCTAGCTGTTGC');
DelLeft=strcat(oligoDelDownstreamF,'-TTACCAATGCTTAATCAGTG');
testDelRight=testDelUp;
testDelLeft=testDelDown;
end



set(handles.NF,'String',oligoNF);
set(handles.CF,'String',oligoCF);
set(handles.CR,'String',oligoCR);
set(handles.NR,'String',oligoNR);

if isempty(testNF)
    testNF='Could not find a good primer. Sorry!';
end

if isempty(testCF)
    testCF='Could not find a good primer. Sorry!';
end

if isempty(testNR)
    testNR='Could not find a good primer. Sorry!';
end

if isempty(testCR)
    testCR='Could not find a good primer. Sorry!';
end

if isempty(testDelLeft)
    testDelLeft='Could not find a good primer. Sorry!';
end

if isempty(testDelRight)
    testDelRight='Could not find a good primer. Sorry!';
end

if isempty(bestJATY)
    bestJATY='Could not find a good JAtY clone. Sorry!';
end

if isempty(bestKclone)
    bestKclone='Could not find a good K clone. Sorry!';
end


set(handles.NFtest,'String',testNF(1,:));
set(handles.CFtest,'String',testCF(1,:));
set(handles.CRtest,'String',testCR(1,:));
set(handles.NRtest,'String',testNR(1,:));


set(handles.BestJAtY,'String',bestJATY);
set(handles.BestKclone,'String',bestKclone);

set(handles.DelLeft,'String',DelLeft);
set(handles.DelRight,'String',DelRight);

set(handles.DelLefttest,'String',testDelLeft(1,:));
set(handles.DelRighttest,'String',testDelRight(1,:));

set(handles.genename,'String',str);
set(handles.recombPrimsize,'String',minsizetactoconsider);



drawnow;

cellA{pa+1,1}=str;
cellA{pa+1,2}=Chromosome;
cellA{pa+1,3}=orientation;
cellA{pa+1,4}=start;
cellA{pa+1,5}=final;
cellA{pa+1,6}=bestJATY;
cellA{pa+1,7}=bestJATYori;
cellA{pa+1,8}=oligoNF;
cellA{pa+1,9}=oligoNR;
cellA{pa+1,10}=oligoCF;
cellA{pa+1,11}=oligoCR;
cellA{pa+1,12}=DelLeft;
cellA{pa+1,13}=DelRight;
cellA{pa+1,14}=testNF(1,:);
cellA{pa+1,15}=testNR(1,:);
cellA{pa+1,16}=testCF(1,:);
cellA{pa+1,17}=testCR(1,:);
cellA{pa+1,18}=testDelLeft(1,:);
cellA{pa+1,19}=testDelRight(1,:);

end

T=cell2table(cellA);
writetable(T,destino);

mensa='Analysis completed';
set(handles.genename,'String',mensa);
drawnow;

% Update handles structure
guidata(hObject, handles);



function NF_Callback(hObject, eventdata, handles)
% hObject    handle to NF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NF as text
%        str2double(get(hObject,'String')) returns contents of NF as a double


% --- Executes during object creation, after setting all properties.
function NF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function CF_Callback(hObject, eventdata, handles)
% hObject    handle to CF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CF as text
%        str2double(get(hObject,'String')) returns contents of CF as a double


% --- Executes during object creation, after setting all properties.
function CF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function NR_Callback(hObject, eventdata, handles)
% hObject    handle to NR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NR as text
%        str2double(get(hObject,'String')) returns contents of NR as a double


% --- Executes during object creation, after setting all properties.
function NR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function NFtest_Callback(hObject, eventdata, handles)
% hObject    handle to NFtest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NFtest as text
%        str2double(get(hObject,'String')) returns contents of NFtest as a double


% --- Executes during object creation, after setting all properties.
function NFtest_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NFtest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function NRtest_Callback(hObject, eventdata, handles)
% hObject    handle to NRtest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NRtest as text
%        str2double(get(hObject,'String')) returns contents of NRtest as a double


% --- Executes during object creation, after setting all properties.
function NRtest_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NRtest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function CR_Callback(hObject, eventdata, handles)
% hObject    handle to CR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CR as text
%        str2double(get(hObject,'String')) returns contents of CR as a double


% --- Executes during object creation, after setting all properties.
function CR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function CFtest_Callback(hObject, eventdata, handles)
% hObject    handle to CFtest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CFtest as text
%        str2double(get(hObject,'String')) returns contents of CFtest as a double


% --- Executes during object creation, after setting all properties.
function CFtest_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CFtest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function CRtest_Callback(hObject, eventdata, handles)
% hObject    handle to CRtest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CRtest as text
%        str2double(get(hObject,'String')) returns contents of CRtest as a double


% --- Executes during object creation, after setting all properties.
function CRtest_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CRtest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DelRight_Callback(hObject, eventdata, handles)
% hObject    handle to DelRight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DelRight as text
%        str2double(get(hObject,'String')) returns contents of DelRight as a double


% --- Executes during object creation, after setting all properties.
function DelRight_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DelRight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DelLeft_Callback(hObject, eventdata, handles)
% hObject    handle to DelLeft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DelLeft as text
%        str2double(get(hObject,'String')) returns contents of DelLeft as a double


% --- Executes during object creation, after setting all properties.
function DelLeft_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DelLeft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DelRighttest_Callback(hObject, eventdata, handles)
% hObject    handle to DelRighttest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DelRighttest as text
%        str2double(get(hObject,'String')) returns contents of DelRighttest as a double


% --- Executes during object creation, after setting all properties.
function DelRighttest_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DelRighttest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DelLefttest_Callback(hObject, eventdata, handles)
% hObject    handle to DelLefttest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DelLefttest as text
%        str2double(get(hObject,'String')) returns contents of DelLefttest as a double


% --- Executes during object creation, after setting all properties.
function DelLefttest_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DelLefttest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function BestJAtY_Callback(hObject, eventdata, handles)
% hObject    handle to BestJAtY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of BestJAtY as text
%        str2double(get(hObject,'String')) returns contents of BestJAtY as a double


% --- Executes during object creation, after setting all properties.
function BestJAtY_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BestJAtY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function BestKclone_Callback(hObject, eventdata, handles)
% hObject    handle to BestKclone (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of BestKclone as text
%        str2double(get(hObject,'String')) returns contents of BestKclone as a double


% --- Executes during object creation, after setting all properties.
function BestKclone_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BestKclone (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
GTFObj=handles.GTFObj;
genome1=handles.genome1;
genome2=handles.genome2;
genome3=handles.genome3;
genome4=handles.genome4;
genome5=handles.genome5;
filename=handles.filename;
pathname=handles.pathname;
tprimersize=handles.tprimersize;
lowgc=handles.lowgc;
highgc=handles.highgc;
max=handles.max;
min=handles.min;
maxMT=handles.maxMT;
minMT=handles.minMT;
recombineeringsize=handles.recombineeringsize;
upstreamsize=handles.upstreamsize;
insertcoordenada=handles.insertcoordenada;
downstreamsize=handles.downstreamsize;
minsizetactoconsider=handles.minsizetactoconsider;



x=handles.x;

GCcontent=cat(2,lowgc,highgc);
GCcontent=num2str(GCcontent);

set(handles.TprimersGC,'String',GCcontent);
set(handles.Tprimerslength,'String',tprimersize);

Tprimersdistance1=cat(2,min,max);
Tprimersdistance1=num2str(Tprimersdistance1);
set(handles.Tprimersdistance,'String',Tprimersdistance1);

TprimersTM=cat(2,minMT,maxMT);
TprimersTM=num2str(TprimersTM);
set(handles.TprimersMT,'String',TprimersTM);

set(handles.recombPrimsize,'String',recombineeringsize);
set(handles.upstreamsequencesize,'String',upstreamsize);
set(handles.dowsntreamseqsize,'String',downstreamsize);
set(handles.insertcoord,'String',insertcoordenada);
set(handles.recombPrimsize,'String',minsizetactoconsider);

if isempty(filename)
    numberofgenes=1;
else
filename=handles.filename;
pathname=handles.pathname;
filenamedir=strcat(pathname,filename);
csvfile=csvread(filenamedir);
filesize=size(csvfile);
numberofgenes=filesize(1,1);    
end


for pa=1:numberofgenes
    n=0;%new
    m=0;%new
if isempty(filename)
     str=x;
else
    str=csvfile(pa,1);
%x=cell2mat(x);
str=upper(str);
w=str=='.';
w=sum(w);
if w==0
    str=strcat(str,'.1');
end

end



geneinfo=getData(GTFObj,'Transcript',str);
dimension=size(geneinfo);
p=dimension(1);
orientation=geneinfo.Strand;
tstart=0;
delup=upstreamsize;
deldown=5000;
for x=1:p
   s=geneinfo(x).Feature;
   if strcmp(s,'CDS') & tstart==0
   n=x;
   tstart=1;
   end
   
   if strcmp(s,'CDS') & tstart==1
   m=x;
   end

end


Chromosome=geneinfo.Reference;
if (Chromosome=='Chr1')
    genome=genome1;
elseif (Chromosome=='Chr2')
    genome=genome2;
elseif (Chromosome=='Chr3')
    genome=genome3;
elseif (Chromosome=='Chr4')
    genome=genome4;
elseif (Chromosome=='Chr5')
    genome=genome5;
end

chrsize=numel(genome.Sequence); %new


if(orientation=='-')
start=geneinfo(m).Stop;
final=geneinfo(n).Start;


origen=start;
if ~isempty(insertcoordenada)
    origen=start+insertcoordenada;    
end


if start+10000>=chrsize || final-5000<=0 %new
    continue
end


oligoNF=seqrcomplement(genome.Sequence(origen+1:origen+recombineeringsize));
oligoNR=genome.Sequence(origen-recombineeringsize-1:origen);
oligoCF=seqrcomplement(genome.Sequence(final+3:final+recombineeringsize+2));
oligoCR=genome.Sequence(final-recombineeringsize-3:final+2);
% oligoDelUpstreamF=seqrcomplement(genome.Sequence(start+1+delup:start+40+delup));
oligoDelUpstreamR=genome.Sequence(start-recombineeringsize-1+delup:start+delup);
oligoDelDownstreamF=seqrcomplement(genome.Sequence(final+3-deldown:final+recombineeringsize+2-deldown));
% oligoDelDownstreamR=genome.Sequence(final-37-deldown:final+2-deldown);
seqforprimersN1=seqrcomplement(genome.Sequence(origen+min:origen+max));
seqforprimersN2=genome.Sequence(origen-max:origen-min);
seqforprimersC1=seqrcomplement(genome.Sequence(final+min:final+max));
seqforprimersC2=genome.Sequence(final-max:final-min);
seqforprimersDelUp=genome.Sequence(start-recombineeringsize-1+delup-max:start+delup-min);
seqforprimersDelDown=seqrcomplement(genome.Sequence(final-recombineeringsize-3-deldown+min:final+2-deldown+max));


elseif(orientation=='+')
start=geneinfo(n).Start;
final=geneinfo(m).Stop;


origen=start;
if ~isempty(insertcoordenada)
    origen=start+insertcoordenada;    
end


if start-10000<=0 || final+5000>=chrsize %new
    continue
end

oligoNF=genome.Sequence(origen-recombineeringsize:origen-1);
oligoNR=seqrcomplement(genome.Sequence(origen:origen+recombineeringsize-1));
oligoCF=genome.Sequence(final-recombineeringsize+2:final-3);
oligoCR=seqrcomplement(genome.Sequence(final-2:final+recombineeringsize-3));
% oligoDelUpstreamF=genome.Sequence(start-40-delup:start-1-delup);
oligoDelUpstreamR=seqrcomplement(genome.Sequence(start-delup:start+recombineeringsize-1-delup));
oligoDelDownstreamF=genome.Sequence(final-recombineeringsize+2+deldown:final-3+deldown);
% oligoDelDownstreamR=seqrcomplement(genome.Sequence(final-2+deldown:final+37+deldown));
seqforprimersN1=genome.Sequence(origen-max:origen-min);
seqforprimersN2=seqrcomplement(genome.Sequence(origen+min:origen+max));
seqforprimersC1=genome.Sequence(final-max:final-min);
seqforprimersC2=seqrcomplement(genome.Sequence(final+min:final+max));
seqforprimersDelUp=seqrcomplement(genome.Sequence(start-delup+min:start+recombineeringsize-1-delup+max));
seqforprimersDelDown=(genome.Sequence(final-recombineeringsize+2+deldown-max:final-3+deldown-min));%ojo?
end

[testNF,testNR]=primerdesign(seqforprimersN1,seqforprimersN2,tprimersize,lowgc,highgc,minMT,maxMT);
[testCF,testCR]=primerdesign(seqforprimersC1,seqforprimersC2,tprimersize,lowgc,highgc,minMT,maxMT);
[testDelUp]=primerdesign1(seqforprimersDelUp,tprimersize,lowgc,highgc,minMT,maxMT);
[testDelDown]=primerdesign1(seqforprimersDelDown,tprimersize,lowgc,highgc,minMT,maxMT);



%select TAC clones

JATYObj=GTFAnnotation('JAtYSorted.gtf');
KclonesObj=GTFAnnotation('Kclones.gtf');

if orientation == '-'
    limitup=start+10000;
    limitdown=final-5000;
end

if orientation == '+'
    limitdown=start-10000;
    limitup=final+5000;
end

[bestJATY,bestJATYsize,bestJATYori] = selectbesttac(JATYObj,limitup,limitdown,Chromosome,minsizetactoconsider);
[bestKclone,bestKclonesize,bestKcloneori] = selectbesttac(KclonesObj,limitup,limitdown,Chromosome,minsizetactoconsider);

if isempty(bestJATY)
   bestJATYori=bestKcloneori;
   bestJATY=bestKclone;   
end

if isempty(bestJATY)
    bestJATYori='-';
    bestJATY='Could not find a good JAtY clone. Sorry!';  
end


oligoCF=strcat(oligoCF,'-GGAGGTGGAGGTGGAGCT');
oligoNF=strcat(oligoNF,'-GGAGGTGGAGGTGGAGCT');
oligoNR=strcat(oligoNR,'-GGCCCCAGCGGCCGCAGCAGCACC');
oligoCR=strcat(oligoCR,'-GGCCCCAGCGGCCGCAGCAGCACC');

if (bestJATYori == '+' && orientation == '+') || (bestJATYori == '-' && orientation == '-') 
DelLeft=strcat(oligoDelUpstreamR,'-TTACCAATGCTTAATCAGTG');
DelRight=strcat(oligoDelDownstreamF,'-CGAATGCTAGTCTAGCTGTTGC');
testDelLeft=testDelUp;
testDelRight=testDelDown;
end

if (bestJATYori == '-' && orientation == '+') || (bestJATYori == '+' && orientation == '-')
DelRight=strcat(oligoDelUpstreamR,'-CGAATGCTAGTCTAGCTGTTGC');
DelLeft=strcat(oligoDelDownstreamF,'-TTACCAATGCTTAATCAGTG');
testDelRight=testDelUp;
testDelLeft=testDelDown;
end



set(handles.NF,'String',oligoNF);
set(handles.CF,'String',oligoCF);
set(handles.CR,'String',oligoCR);
set(handles.NR,'String',oligoNR);

if isempty(testNF)
    testNF='Could not find a good primer. Sorry!';
end

if isempty(testCF)
    testCF='Could not find a good primer. Sorry!';
end

if isempty(testNR)
    testNR='Could not find a good primer. Sorry!';
end

if isempty(testCR)
    testCR='Could not find a good primer. Sorry!';
end

if isempty(testDelLeft)
    testDelLeft='Could not find a good primer. Sorry!';
end

if isempty(testDelRight)
    testDelRight='Could not find a good primer. Sorry!';
end

if isempty(bestJATY)
    bestJATY='Could not find a good JAtY clone. Sorry!';
end

if isempty(bestKclone)
    bestKclone='Could not find a good K clone. Sorry!';
end


set(handles.NFtest,'String',testNF(1,:));
set(handles.CFtest,'String',testCF(1,:));
set(handles.CRtest,'String',testCR(1,:));
set(handles.NRtest,'String',testNR(1,:));


set(handles.BestJAtY,'String',bestJATY);
set(handles.BestKclone,'String',bestKclone);

set(handles.DelLeft,'String',DelLeft);
set(handles.DelRight,'String',DelRight);

set(handles.DelLefttest,'String',testDelLeft(1,:));
set(handles.DelRighttest,'String',testDelRight(1,:));

set(handles.genename,'String',str);

end









% Update handles structure
guidata(hObject, handles);



function genename_Callback(hObject, eventdata, handles)
% hObject    handle to genename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of genename as text
%        str2double(get(hObject,'String')) returns contents of genename as a double


% --- Executes during object creation, after setting all properties.
function genename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to genename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in PrimerLength.
function PrimerLength_Callback(hObject, eventdata, handles)
% hObject    handle to PrimerLength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt = {'Enter legth of test primers'};
title = 'Input';
dims = [1 35];
definput = {'20'};
x = inputdlg(prompt,title,dims,definput);
x=cell2mat(x);
set(handles.Tprimerslength,'String',x);
x=str2num(x);
tprimersize=x;
handles.tprimersize=tprimersize;


% Update handles structure
guidata(hObject, handles);




% --- Executes on button press in PrimerGC.
function PrimerGC_Callback(hObject, eventdata, handles)
% hObject    handle to PrimerGC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt = {'Enter GC content for test primers'};
title = 'Input';
dims = [1 35];
definput = {'45-55'};
x = inputdlg(prompt,title,dims,definput);
x=cell2mat(x);
set(handles.TprimersGC,'String',x);
gccontent=strsplit(x,'-');
lowgc=cell2mat(gccontent(1,1));
highgc=cell2mat(gccontent(1,2));
lowgc=str2num(lowgc);
highgc=str2num(highgc);

handles.lowgc=lowgc;
handles.highgc=highgc;


% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in TestJunction.
function TestJunction_Callback(hObject, eventdata, handles)
% hObject    handle to TestJunction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt = {'Enter min-max distance from junction for test primers'};
title = 'Input';
dims = [1 35];
definput = {'100-500'};
x = inputdlg(prompt,title,dims,definput);
x=cell2mat(x);
set(handles.Tprimersdistance,'String',x);
gccontent=strsplit(x,'-');
max=cell2mat(gccontent(1,2));
min=cell2mat(gccontent(1,1));
max=str2num(max);
min=str2num(min);

handles.max=max;
handles.min=min;


% Update handles structure
guidata(hObject, handles);



% --- Executes on button press in testTemperature.
function testTemperature_Callback(hObject, eventdata, handles)
% hObject    handle to testTemperature (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

prompt = {'Enter min-max melting temperature for test primers'};
title = 'Input';
dims = [1 35];
definput = {'50-60'};
x = inputdlg(prompt,title,dims,definput);
x=cell2mat(x);
set(handles.TprimersMT,'String',x);
gccontent=strsplit(x,'-');
maxMT=cell2mat(gccontent(1,2));
minMT=cell2mat(gccontent(1,1));
maxMT=str2num(maxMT);
minMT=str2num(minMT);

handles.maxMT=maxMT;
handles.minMT=minMT;


% Update handles structure
guidata(hObject, handles);



% --- Executes on button press in upstreamsize.
function upstreamsize_Callback(hObject, eventdata, handles)
% hObject    handle to upstreamsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt = {'Enter sequence size to keep upstream of the gene'};
title = 'Input';
dims = [1 35];
definput = {'10000'};
x = inputdlg(prompt,title,dims,definput);
x=cell2mat(x);
set(handles.upstreamsequencesize,'String',x);
x=str2num(x);
upstreamsize=x;
handles.upstreamsize=upstreamsize;


% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in downstreamsize.
function downstreamsize_Callback(hObject, eventdata, handles)
% hObject    handle to downstreamsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt = {'Enter sequence size to keep downstream of the gene'};
title = 'Input';
dims = [1 35];
definput = {'5000'};
x = inputdlg(prompt,title,dims,definput);
x=cell2mat(x);
set(handles.dowsntreamseqsize,'String',x);
x=str2num(x);
downstreamsize=x;
handles.downstreamsize=downstreamsize;


% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in insertionpoint.
function insertionpoint_Callback(hObject, eventdata, handles)
% hObject    handle to insertionpoint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt = {'Enter the coordinates (from start codon) of the insertion point'};
title = 'Input';
dims = [1 35];
definput = {'Before start or stop codons'};
x = inputdlg(prompt,title,dims,definput);
x=cell2mat(x);
set(handles.insertcoord,'String',x);
x=str2num(x);
insertcoordenada=x;
handles.insertcoordenada=insertcoordenada;



% Update handles structure
guidata(hObject, handles);



% --- Executes on button press in recombprimersize.
function recombprimersize_Callback(hObject, eventdata, handles)
% hObject    handle to recombprimersize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


prompt = {'Enter efective recombination length in recombineering primers'};
title = 'Input';
dims = [1 35];
definput = {'40'};
x = inputdlg(prompt,title,dims,definput);
x=cell2mat(x);
set(handles.recombPrimsize,'String',x);
x=str2num(x);
recombineeringsize=x;
handles.recombineeringsize=recombineeringsize;

% Update handles structure
guidata(hObject, handles);






function Tprimerslength_Callback(hObject, eventdata, handles)
% hObject    handle to Tprimerslength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Tprimerslength as text
%        str2double(get(hObject,'String')) returns contents of Tprimerslength as a double


% --- Executes during object creation, after setting all properties.
function Tprimerslength_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Tprimerslength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TprimersGC_Callback(hObject, eventdata, handles)
% hObject    handle to TprimersGC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TprimersGC as text
%        str2double(get(hObject,'String')) returns contents of TprimersGC as a double


% --- Executes during object creation, after setting all properties.
function TprimersGC_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TprimersGC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Tprimersdistance_Callback(hObject, eventdata, handles)
% hObject    handle to Tprimersdistance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Tprimersdistance as text
%        str2double(get(hObject,'String')) returns contents of Tprimersdistance as a double


% --- Executes during object creation, after setting all properties.
function Tprimersdistance_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Tprimersdistance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TprimersMT_Callback(hObject, eventdata, handles)
% hObject    handle to TprimersMT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TprimersMT as text
%        str2double(get(hObject,'String')) returns contents of TprimersMT as a double


% --- Executes during object creation, after setting all properties.
function TprimersMT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TprimersMT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function recombPrimsize_Callback(hObject, eventdata, handles)
% hObject    handle to recombPrimsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of recombPrimsize as text
%        str2double(get(hObject,'String')) returns contents of recombPrimsize as a double


% --- Executes during object creation, after setting all properties.
function recombPrimsize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to recombPrimsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function upstreamsequencesize_Callback(hObject, eventdata, handles)
% hObject    handle to upstreamsequencesize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of upstreamsequencesize as text
%        str2double(get(hObject,'String')) returns contents of upstreamsequencesize as a double


% --- Executes during object creation, after setting all properties.
function upstreamsequencesize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to upstreamsequencesize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dowsntreamseqsize_Callback(hObject, eventdata, handles)
% hObject    handle to dowsntreamseqsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dowsntreamseqsize as text
%        str2double(get(hObject,'String')) returns contents of dowsntreamseqsize as a double


% --- Executes during object creation, after setting all properties.
function dowsntreamseqsize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dowsntreamseqsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function insertcoord_Callback(hObject, eventdata, handles)
% hObject    handle to insertcoord (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of insertcoord as text
%        str2double(get(hObject,'String')) returns contents of insertcoord as a double


% --- Executes during object creation, after setting all properties.
function insertcoord_CreateFcn(hObject, eventdata, handles)
% hObject    handle to insertcoord (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in minsizeTAC.
function minsizeTAC_Callback(hObject, eventdata, handles)
% hObject    handle to minsizeTAC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

prompt = {'Enter minimum size of the TAC clone'};
title = 'Input';
dims = [1 35];
definput = {'25000'};
x = inputdlg(prompt,title,dims,definput);
x=cell2mat(x);
set(handles.recombPrimsize,'String',x);
x=str2num(x);
minsizetactoconsider=x;
handles.minsizetactoconsider=minsizetactoconsider;

% Update handles structure
guidata(hObject, handles);




function minsizetacclone_Callback(hObject, eventdata, handles)
% hObject    handle to minsizetacclone (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of minsizetacclone as text
%        str2double(get(hObject,'String')) returns contents of minsizetacclone as a double


% --- Executes during object creation, after setting all properties.
function minsizetacclone_CreateFcn(hObject, eventdata, handles)
% hObject    handle to minsizetacclone (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
