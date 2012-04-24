function nmat = readmidi(fn);
% Conversion of MIDI file to notematrix
% nmat = readmidi(fn);
%
% Input argument:
%	FN = name of the MIDI file (string)
%
% Output:
%	NMAT = notematrix
%
% Change History :
% Date		Time	Prog	Note
% 11.8.2002	18:36	PT	Created under MATLAB 5.3 (Macintosh)
% 2.1.2003	13:12	TE	Created under MATLAB 5.3 (PC)
%� Part of the MIDI Toolbox, Copyright � 2004, University of Jyvaskyla, Finland
% See License.txt

nmat=[];
%disp(fn);
if strcmp(computer,'MAC2')
	currdir = cd;
	currdir = char(bitand(double(currdir),255)); % remove high bytes that occasionally occur in the path
	toolboxpath = which('readmidi');
	toolboxpath=toolboxpath(1:end-11); % remove ':readmidi.m'
	cd(toolboxpath);
	fid = fopen('mf2t.param','wt');

	ifile = [currdir ':' fn];
	fprintf(fid, '%s\n', ifile);
	ofile = [toolboxpath ':mf2t.out']; 
	fprintf(fid, '%s\n', ofile);
	fclose(fid);
	! mf2tmac
	delete mf2t.param
	nmat = mftxt2nmat(ofile);
	cd(currdir);
elseif strcmp(computer,'PCWIN')
	midi2text(fn, 'MF2T.OUT'); % uusin mex konvertteri [2. tammikuuta 2003] 
	nmat = mftxt2nmat('MF2T.OUT');
	delete mf2t.out
	clear mex    
elseif strcmp(computer,'GLNX86') || strcmp(computer, 'MAC') || strcmp(computer, 'GLNXA64')
        % Use actual shell command  2004-08-13 dpwe@ee.columbia.edu
	of = [tempname,'.txt'];
	cmd = [miditoolboxpath,'/mf2t.','GLNX86',' ',fn,' ',of];
	cmd = char(cmd);
    disp(cmd);
	system(cmd);
	nmat = mftxt2nmat(of);
	delete(of)
else
	disp('This function works only on Macintosh (OS X), Windows and Linux!');
	return;
end