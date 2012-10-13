#!/usr/bin/perl -w
use File::Path;

my @files = <*>;
my @needle = "es";

if (defined $ARGV[0]) {
  if (defined $ARGV[1]) {
      @files = <$ARGV[0]>;
      @needle = $ARGV[1];
    } else {
      @needle = $ARGV[0];
    }

  print "Deleting all files that matches ";
  print @needle;
  print ":\n";

  foreach $file (@files) {
    if ($file =~ m/@needle/){
      print "Deleting: $file \n";
      if (-f $file) {
        unlink($file);
      }
      if (-d $file) {
        rmtree($file);
        unlink($file);
      }
    }
  }
} else {
  print "Usage: 'perl delmatch.pl [root/path] regular_expression' if you omit the root/path the current working directory will be selected"
}
