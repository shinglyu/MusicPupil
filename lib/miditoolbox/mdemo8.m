function nmat=mdemo8(input2)
%    ==========================================================
%    EXAMPLE 8: MELODIC SIMILARITY
%    ==========================================================
%    The meldistance function provides a versatile method for making comparisons between
%    melodies. Although pairs of melodies can be tested for degree of similarity, 
%    the function is often more usefully applied to melodic collections.

pause % Strike any key to continue...

%    LOAD A COLLECTION OF FINNISH FOLK TUNES
%    =================

    load finfolktunes.mat % we get two variables, nm and names

pause % Strike any key to continue...

%    EXAMPLE OF PAIR-WISE DISTANCE
%    =================
%    Calculate the distance between the first and 
%    second melodies in our collection using a contour representation and 
%    the taxi-cab distance measure.

    meldistance(nm{1},nm{2},'contour','taxi')

pause % Strike any key to continue...

%    BUILD A RANKED LIST OF SIMILARITY TO A GIVEN MELODY
%    =================
%    MELDISTANCE can also be used to provide a ranked list of the three melodies which
%    begin most similarly to a given melody. First we load an example.

    laksin=reftune('laksin');
    l2 = trim(onsetwindow(laksin,-1,8,'beat'));

pause % Strike any key to continue...

%    Next we use meldistance to generate a list of distance comparisons between 
%    laksin and each of the 50 melodies in our collection. BRACE YOURSELF!

    for i=1:length(nm)
        sim_ratings(i)=meldistance(l2,trim(onsetwindow(nm{i},-1,8)),'contour','taxi');
    end

    sim_ratings =[1:50; sim_ratings]';

pause % Strike any key to continue...

%   This list is then sorted by ranking and the three entries with lowest 
%    pair-wise distance selected

sorted=sortrows(sim_ratings,2);
ranked=sorted(1:3,:)

pause % Strike any key to continue...

%    Plot the first 8 beats Laksin followed by the 
%    three top rated melodies

subplot(4,1,1)
	plotmelcontour(trim(onsetwindow(laksin,0,8)),.5,'abs',':kp'); m=axis; minim=m(3); xlabel(''); 
	text(.5,minim+2,'Läksin Minä Kesäyönä');
subplot(4,1,2)
	plotmelcontour(trim(onsetwindow(nm{ranked(1,1)},0,8))); m=axis; minim=m(3); xlabel('');
	text(.5,minim+2,[name(ranked(1,1),:) lyric(ranked(1,1),:)]);
subplot(4,1,3)
	plotmelcontour(trim(onsetwindow(nm{ranked(2,1)},0,8))); m=axis; minim=m(3); xlabel('');
	text(.5,minim+2,[name(ranked(2,1),:) lyric(ranked(2,1),:)]); 
subplot(4,1,4)
	plotmelcontour(trim(onsetwindow(nm{ranked(3,1)},0,8))); m=axis; minim=m(3);
	text(.5,minim+2,[name(ranked(3,1),:) lyric(ranked(3,1),:)]); 

pause % Strike any key to continue...


%    BUILD RANKED LIST USING A STATISTICAL REPRESENTATION
%    =================
%    We can also build a ranked list of similarity using a statistical 
%    distribution rather than contour.
%    we use meldistance to generate a list of distance comparisons between 
%    laksin and each of the 50 melodies in our collection. BRACE YOURSELF!

pause % Strike any key to continue...

clear sim_ratings sorted ranked;

    for i=1:length(nm)
        sim_ratings(i)=meldistance(l2,trim(onsetwindow(nm{i},-1,8)),'pcdist1','taxi');
    end
    sim_ratings =[1:50; sim_ratings]';

pause % Strike any key to continue...

%    This list is then sorted by ranking and the three entries with lowest 
%    pair-wise distance selected

sorted=sortrows(sim_ratings,2);
ranked=sorted(1:3,:)

pause % Strike any key to continue...

%    Plot the first 8 beats Laksin followed by the 
%    three top rated melodies

subplot(4,1,1)
plotmelcontour(trim(onsetwindow(laksin,-1,8)))
title('laksin')
subplot(4,1,2)
plotmelcontour(trim(onsetwindow(nm{ranked(1,1)},-1,8)))
subplot(4,1,3)
plotmelcontour(trim(onsetwindow(nm{ranked(2,1)},-1,8)))
subplot(4,1,4)
plotmelcontour(trim(onsetwindow(nm{ranked(3,1)},-1,8)))

pause % Strike any key to continue...

%    The contours of these melodies are not so similar, but how about 
%    their pitch-class distributions?

pause % Strike any key to continue...

subplot(4,1,1)
plotdist(pcdist1((trim(onsetwindow(laksin,-1,8))))); ylabel('')
title('laksin')
subplot(4,1,2)
plotdist(pcdist1((trim(onsetwindow(nm{ranked(1,1)},-1,8)))))
subplot(4,1,3)
plotdist(pcdist1((trim(onsetwindow(nm{ranked(2,1)},-1,8))))); ylabel('')
subplot(4,1,4)
plotdist(pcdist1((trim(onsetwindow(nm{ranked(3,1)},-1,8))))); ylabel('')

%    It appears that all of the chosen melodies are in the same key and
%    contain very similar pitch content.

pause % Strike any key to continue...