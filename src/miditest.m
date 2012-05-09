infname = '../audio/test.mid'
outtxtfname = '../audio/out_test.txt'
outfname = '../audio/out_test.mid'
score = midi2nmat(infname);
nmat2mft(score,outtxtfname );
mft2mf(outtxtfname, outfname );
%nmat2midi(score, outfname);
rescore = midi2nmat(outfname);

