#!/usr/bin/perl
#use File::Basename
use File::Copy;
use List::MoreUtils 'any';
$tempfile= "template.meta.txt";

opendir(DIR, ".");
 @files = readdir(DIR);
closedir(DIR);

foreach $file (@files) {
   #if (@files =~/(mid)$/){
   #print "good";
   #
   #}
   if ($file =~ /(mid)$/){
      my $newfile = "$file.meta.txt";
      if (any {/($newfile)/} @files) {
         #print "$newfile already exists.\n";

      }
      else {
         #print $tempfile;
         print "$newfile created.\n";
         copy($tempfile, $newfile) or die "Copy failed: $!";
      }
   }

}
#($name, $path, $suffix) = fileparse()
