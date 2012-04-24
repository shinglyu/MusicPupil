function m = mft2mf(ifname,ofname)
% Conversion of text file containing MIDI information into a proper MIDI file
% m = mft2mf(ifname,ofname)
% Converts a text file containing MIDI information into a proper MIDI file
%
% Input arguments: 
%	IFNAME = Input filename
%	OFNAME = output filename
%
% Output: MIDI file
%
% Remarks:
%
% Example:
%
%  Author		Date
%  T. Eerola	3.1.2003
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

nmat=[];

% PLATFORM DEPENDENT
if strcmp(computer,'PCWIN')
	t2mf(ifname,ofname); % mex converter, works in Windows, but see next
	clear mex % because the converter is still a bit dodgy ...
elseif strcmp(computer, 'GLNX86') | strcmp(computer, 'MAC')
        % Use actual shell command  2004-08-13 dpwe@ee.columbia.edu
	cmd = [miditoolboxpath, '/t2mf.',computer,' ',ifname,' ',ofname];
	disp(cmd);
	system(cmd);
else
	disp('This function works only on Macintosh / Windows / Linux!');
	return;
end
