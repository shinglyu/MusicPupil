function nmat = mdemo3(input2)
%    ==========================================================
%    EXAMPLE 3: KEY-FINDING
%    ==========================================================
%
%    The classic Krumhansl & Schmuckler key-finding algorithm (Krumhansl, 1990), 
%    is based on key profiles obtained from empirical work by Krumhansl & Kessler (1982). 
%    In the K-S key-finding algorithm, the 24 individual key profiles, 12 major and 12 minor 
%    key profiles, are correlated with the pitch-class distribution of the piece weighted 
%    according to their duration. This gives a measure of the strength of each key. 
%    This measure is first applied to whole passage and then across the selected passage.
%    Finally, a more elaborate version of the key regions is demonstrated.

%    Let us take the C major Prelude in J. S. Bach's Wohltemperierte Klavier II (BWV 870). 
%    =================

%    READ A MIDI FILE TO MATLAB:
	prelude=readmidi('wtcii01a.mid');

%    TAKE ONLY THE FIRST FOUR BARS (ONSETBEATS function)
%    =================
	prelude4=prelude((onset(prelude)<=4*4),:);
pause % Strike any key to continue...


%    FIND THE KEY OF THE WHOLE PASSAGE
%    =================
%
%    A) SIMPLE VERSION: Display the most probable key as a string
pause % Strike any key to continue...

	disp(keyname(kkkey(prelude4)))

%     (Uppercase letter indicates major key, lowercase minor)

pause % Strike any key to continue...

%    B) ELABORATED VERSION: Deconstructing the simple version
%    by calculating and plotting the correlation coefficients of pitch-class
%    distribution of prelude with Krumhansl  & Kessler key profiles.
%    First, calculate the correlations between all key profiles

pause % Strike any key to continue...

	keystrengths = kkcc(prelude4); % corr. to all keys

%    Then, plot the correlations using PLOTDIST function
pause % Strike any key to continue...

	plotdist(keystrengths); hold on % plot all corr. coefficients 

%    Then, highlight the maximum
pause % Strike any key to continue...

	bar(find(max(keystrengths)==keystrengths),max(keystrengths),'r');

pause % Strike any key to continue...

clf
%    ==========================================================
%    EXAMINE THE KEY AREAS ACROSS THE PASSAGE
%    ==========================================================
%
%    Another way of exploring key-finding is to look at how tonality changes over time. 
%    In the technique, key-finding is performed within a small window that runs across 
%    the length of the music. This operation uses the MOVEWINDOW function. Below is an 
%    example of finding the maximal key correlation using a 3-second window that is 
%    moved by 1.5 seconds at a time.

pause % Strike any key to continue...


%    KEY STRENGTHS ACROSS THE SEQUENCE (using MAXKKCC function)
%    =================

pause % Strike any key to continue...

	prelude4=onsetwindow(prelude,0,16,'beat'); % Take first four bars
	keys = movewindow(prelude4,4,2,'beat','maxkkcc');
	label=keyname(movewindow(prelude4,4,2,'beat','kkkey'));

pause % Strike any key to continue...

	subplot(2,1,1); pianoroll(prelude4,'num','r','hold')

%pause % Strike any key to continue...

subplot(2,1,2); 
	time=0:2:16; plot(time,keys,':ko','LineWidth',1.25);
	axis([-0.2 16.2 .4 1])
	for i=1:length(label)
		text(time(i),keys(i)+.025,label(i),...
		'HorizontalAlignment','center','FontSize',12);
	end
	ylabel('\bfMax. key corr. coeff.'); 
	xlabel('\bfTime (beats)')

pause % Strike any key to continue...
clf

%    KEYSOM
%    =================
%
%    A recent dynamic model of tonality induction (Toiviainen & Krumhansl, 2003) 
%    calculates local tonality based on key profiles. The results may be projected onto a 
%    self-organizing map (SOM) trained with the 24 key profiles. In the following example, 
%    the function calculates the key strengths and creates a projection of the results.

pause % Strike any key to continue...

	keysom(prelude4,1); 

pause % Strike any key to continue...

%    KEYSOM (ANIMATED VERSION)
%    =================
%
%    Create an animation of tonality based on self-organizing map projection. 

pause % Strike any key to continue...

	keysomanim(prelude4,2,.5);

pause % Strike any key to continue...

nmat=prelude;