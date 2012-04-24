function nmat=mdemo5(input2)
%    ==========================================================
%    EXAMPLE 5: MELODIC SEGMENTATION
%    ==========================================================
%    One of the fundamental in perceiving music is the segmentation of the auditory stream into 
%    smaller units, melodic phrases, motifs and such issues. Various computational approaches 
%    to segmentation have been taken. With symbolic representations of music, we can 
%    distinguish rule-based and statistical (or memory-based) approaches. The following
%    three examples demonstrate these approaches.

%    READ A MIDI FILE TO MATLAB:
%    =================
	nmat=readmidi('laksin.mid');

%    SEGMENT MELODY USING TENNEY & POLANSKY ALGORITHM
%    =================
%    An example of the first category is the algorithm by Tenney and Polansky (1980), 
%    which finds the locations where the changes in 'clangs' occur. These clangs correspond 
%    to large pitch intervals and large inter-onset-intervals (IOIs). This idea is partly based on 
%    Gestalt psychology. For example, this algorithm segments Läksin in the following way:

pause % Strike any key to continue...
	segmentgestalt(nmat,1);

%    The dark line indicate clang boundaries and dotted lines other, weaker boundaries. Note that 
%    the proposed boundary corresponds with the actual phrasing of the tune.

pause % Strike any key to continue...

%    SEGMENT USING PROBABILITY-BASED ALGORITHM
%    =================
%    Another segmentation technique uses the probabilities derived from the analysis of 
%    melodies (e.g., Bod, 2002). In this technique the probabilities of phrase boundaries 
%    have been derived from pitch-class-, interval- and duration distributions at the segment 
%    boundaries in the Essen folk song collection.

pause % Strike any key to continue...
	segmentprob(nmat,.6,1);

%    The lower panel displays the probabilities of phrase boundaries at the onset of each tone.

pause % Strike any key to continue...

%    SEGMENT USING LOCAL BOUNDARY DETECTION MODEL
%    =================
%    A third segmentation technique assigns probabilities to boundaries based on certain rules 
%    descriping the melodic structure. This Local Boundary Detection Model (Cambouropoulos, 
%    1997) is a simple but efficient segmentation model, as pointed out by the example:

pause % Strike any key to continue...
	boundary(nmat,1);

%    The lower panel displays the probabilities of phrase boundaries at the onset of each tone.

pause % Strike any key to continue...
