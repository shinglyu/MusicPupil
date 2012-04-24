function p = miditoolboxpath()
% p = miditoolboxpath()  Return path to miditoolbox directory
% 2004-08-13 dpwe@ee.columbia.edu

cmd = 'miditoolboxpath';
p = fileparts(which(cmd));
