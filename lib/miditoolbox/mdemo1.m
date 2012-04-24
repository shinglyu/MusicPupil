function nmat=mdemo1(input2)
%    ==========================================================
%    EXAMPLE 1: VISUALIZING AND PLAYING MIDI DATA
%    ==========================================================
%    The first aim of this demonstration is to show how to read midi files into 
%    matlab and give some examples of how to visualize and listen to the resulting notematrix.
%    The second aim is to introduce simple manipulations that can be performed to the 
%    notematrix, ranging from transposition to elimination of certain parts of the notematrix. 
%    Finally, certain distributions of the example tune are visualized.

%    READ A MIDI FILE TO MATLAB (A FINNISH FOLK TUNE):
%    =================

pause % Strike any key to continue...

	laksin=readmidi('laksin.mid');

%    PLOT THE FILE USING PIANOROLL NOTATION
%    =================

pause % Strike any key to continue...

	pianoroll(laksin,'b');

%    PLAY MIDI FILE USING EXTERNAL MIDI PLAYER
%    =================
pause % Strike any key to continue...

	playmidi(laksin);

pause % Strike any key to continue...
%    SYNTHESIZE MIDI FILE TO AUDIO AND PLAY THE RESULTING SIGNAL
%    =================

	playsound(settempo(laksin,120));

pause % Strike any key to continue...


%    ==========================================================
%    SIMPLE MANIPULATION OF A MIDI FILE (NMAT)
%    ==========================================================

%    HIGHLIGHT LONG DURATIONS IN THE PIANOROLL (DROPSHORTNOTES function)
%    =================
pause % Strike any key to continue...

	nmat2 = dropshortnotes(laksin,'beat',1);
	pianoroll(nmat2,'name','r','hold');

pause % Strike any key to continue...

%    SELECT EVENTS BETWEEN 8 AND 17 BEATS (ONSETWINDOW function)
%    =================
pause % Strike any key to continue...

	laksin_phrase = onsetwindow(laksin,8,17,'beat');
	pianoroll(laksin_phrase,'name','k','hold');

pause % Strike any key to continue...

%    HALVE THE DURATION OF THE NOTES IN THE SEGMENT (SCALE function)
%    =================
pause % Strike any key to continue...

	laksin_shortened = scale(laksin_phrase,'dur',.5);
	pianoroll(laksin_shortened,'name','y','hold');

pause % Strike any key to continue...

%    TRANSPOSE THE SEGMENT A MINOR THIRD DOWN (TRANS function)
%    =================
pause % Strike any key to continue...

	laksin_transposed = shift(laksin_shortened,'pitch',-4);
	pianoroll(laksin_transposed,'name','beat','m','hold');

pause % Strike any key to continue...

%    PLOT ONLY THE SELECTED SEGMENT (TRIM function)
%    =================

	pianoroll(trim(laksin_transposed),'name','beat','m');

pause % Strike any key to continue...

clf


%    ==========================================================
%    PLOT FEW DISTRIBUTIONS OF THE EXAMPLE MELODY
%    ==========================================================
 
%    Pitch-class distributions
pause % Strike any key to continue...
	plotdist(pcdist1(laksin),'g');

%    Interval distributions
pause % Strike any key to continue...
	plotdist(ivdist1(laksin),'y');

%    Pitch-class transition distributions
pause % Strike any key to continue...
	plotdist(pcdist2(laksin),'hot');

pause % Strike any key to continue...
clf

%    ==========================================================
%    MANIPULATE POLYPHONIC MIDI FILE
%    ==========================================================

%    READ A NEW MIDI FILE TO MATLAB (A BACH EXAMPLE):
%    =================

pause % Strike any key to continue...

	prelude=readmidi('wtcii01a.mid');
	prelude=onsetwindow(prelude,0,8,'beat');
	pianoroll(prelude,'num','beat','k','hold'); 


pause % Strike any key to continue...

%    QUANTIZE AND SELECT ONLY UPPER VOICE
%    =================

%    Quantize the prelude using sixteenth note resolution
pause % Strike any key to continue...

	prelude_edited = quantize(prelude, 1/16,1/16,1/16);
	pianoroll(prelude_edited,'num','m','hold'); 

pause % Strike any key to continue...

%    SELECT ONLY THE UPPER VOICE AND PLOT IT
%    =================
pause % Strike any key to continue...

	prelude_edited = extreme(prelude_edited,'high');
	pianoroll(prelude_edited,'num','g','hold'); 

pause % Strike any key to continue...

