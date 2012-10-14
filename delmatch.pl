#!/usr/bin/perl -w
use File::Path;

my @files = <.>;
my @needle = "";

if (defined $ARGV[0]) {

  if (defined $ARGV[1]) {
    @files = <$ARGV[0]>;
    @needle = $ARGV[1];
  } else {
    @needle = $ARGV[0];
  }

  print "Deleting all files that matches /";
  print @needle;
  print "/:\n";

  # Process each file in the @files folder
  foreach $file (process_files(@files)) {
    process_file($file, @needle);
  }
} else {
  print "Usage: 'perl delmatch.pl [root/path] regular_expression'";
  print " if you omit the root/path the current working directory will be selected"
}

# Generate a complete list of files in a folder, including files in sub folders
# argument  PATH to root folder for search
# return    list of all files (recursive) in the root folder
sub process_files {
    my $path = shift;

    opendir(DIR, $path) or die "Unable to open $path: $!";

    my @files = 
        map { $path . '/' . $_ } 
        grep { !/^\.{1,2}$/ } 
        readdir(DIR);

    closedir(DIR);

    for (@files) {
        if (-d $_) {
            push @files, process_files($_);
        } 
    }
    return @files;
}

# Deletes a file if it maches the needle
# argument  file handle to process
# argument  needle, delete if matches
sub process_file
{
  $dir = $_[0];
  $needle = $_[1];
  foreach $file ($dir) {
    if ($file =~ m/$needle/){
      print "Deleting: $file \n";
      if (-f $file) {
        unlink($file);
      }
      if (-d $file) {
        rmtree($file);
      }
    }
  }
}
