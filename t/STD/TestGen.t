#!perl
#
#
use 5.001;
use strict;
use warnings;
use warnings::register;

use vars qw($VERSION $DATE);
$VERSION = '0.02';   # automatically generated file
$DATE = '2003/06/04';

use STD::Tester;
use Getopt::Long;
use Cwd;
use File::Spec;


##### Test Script ####
#
# Name: TestGen.t
#
# UUT: STD::TestGen
#
# The module STD::TestGen generated this test script from the contents of
#
# STD\testgen.std;
#
# Don't edit this test script file, edit instead
#
# STD\testgen.std;
#
#	ANY CHANGES MADE HERE TO THIS SCRIPT FILE WILL BE LOST
#
#       the next time STD::TestGen generates this script file.
#
#

######
#
# T:
#
# use a BEGIN block so we print our plan before Module Under Test is loaded
#
BEGIN { 
   use vars qw( $T $__restore_dir__ @__restore_inc__);

   ##########
   # Pick up a output redirection file and tests to skip
   # from the command line.
   #
   my $test_log = '';
   GetOptions('log=s' => \$test_log);

   ########
   # Start a test with a new tester
   #
   $T = new STD::Tester( $test_log );

   ########
   # Create the test plan by supplying the number of tests
   # and the todo tests
   #
   $T->work_breakdown(tests => 17);

   ########
   # Working directory is that of the script file
   #
   $__restore_dir__ = cwd();
   my ($vol, $dirs, undef) = File::Spec->splitpath( $0 );
   chdir $vol if $vol;
   chdir $dirs if $dirs;

   #######
   # Add the library of the unit under test (UUT) to E:\User\SoftwareDiamonds\installation\libSD E:\User\SoftwareDiamonds\installation\lib E:\User\SoftwareDiamonds\installation\libperl D:/Perl/lib D:/Perl/site/lib .
   #
   my $work_dir = cwd();
   ($vol,$dirs) = File::Spec->splitpath( $work_dir, 'nofile');
   my @dirs = File::Spec->splitdir( $dirs );
   while( $dirs[-1] ne 't' ) { 
       chdir File::Spec->updir();
       pop @dirs;
   };
   chdir File::Spec->updir();
   my $lib_dir = File::Spec->catdir( cwd(), 'lib' );
   @__restore_inc__ = @INC;
   unshift @INC, $lib_dir;
   chdir $work_dir;

}

END {

   #########
   # Restore working directory and @INC back to when enter script
   #
   @INC = @__restore_inc__;
   chdir $__restore_dir__;
}

   # Perl code from C:
    use vars qw($loaded);
    use File::Glob ':glob';
    use File::Copy;

    my $test_results;
    my $loaded = 0;
    my @outputs;

   # Perl code from C:
    @outputs = bsd_glob( 'tg*1.*' );
    unlink @outputs;
    @outputs = bsd_glob( 'tg*1-STD.pm');
    unlink @outputs;

    #### 
    #  Use the test software to generate the test of the test software
    #   
    #  tg -o="clean all" TestGen.std
    # 
    #  0 - series is used to generate an test case test script
    #
    #      generate all output files by 
    #          tg -o=clean TestGen0.std TestGen1.std
    #          tg -o=all TestGen1.std
    #
    #  1 - this is the actual value test case
    #      thus, TestGen1.std is used to produce actual test results
    #
    #  2 - this series is the expected test results
    # 
    #
    # make no residue outputs from last test series
    #
    #  unlink <tg1*.*>;  causes subsequent bsd_blog calls to crash
    #;

$T->test( [$loaded = $T->is_package_loaded('STD::TestGen')], # actual results
          [ ''], # expected results
          'UUT not loaded');

#  ok:  1

   # Perl code from C:
my $errors = $T->load_package( 'STD::TestGen' );


####
# verifies requirement(s):
# L<STD::TestGen/load [1]>
# 

#####
$T->skip_rest() unless $T->verify(
    $loaded, # condition to skip test   
    [$errors], # actual results
    [''],  # expected results
    'Load UUT');
 
#  ok:  2


####
# verifies requirement(s):
# L<STD::TestGen/pod check [2]>
# 

#####
$T->test( [$T->pod_errors( 'STD::TestGen')], # actual results
          [0], # expected results
          'No pod errors');

#  ok:  3

   # Perl code from C:
    copy 'tg0.pm', 'tg1.pm';
    copy 'tgA0.std', 'tgA1.std';
    STD::TestGen->fgenerate('STD/tgA0.std', {fspec_in=>'Unix', output=>'clean', file_out=>'tgAx1.std'});


####
# verifies requirement(s):
#     L<STD::TestGen/clean file [2]>
#     L<STD::TestGen/clean file [3]>
#     L<STD::TestGen/clean file [4]>
#     L<STD::TestGen/clean file [5]>
#     L<STD::TestGen/file_out option [1]>
# 

#####
$T->test( [$T->scrub_file_line($T->fin('tgAx1.std'))], # actual results
          [$T->scrub_file_line($T->fin('tgA2B.std'))], # expected results
          'Clean source std with a todo list');

#  ok:  4

   # Perl code from C:
STD::TestGen->fgenerate('STD/tgB0.std', {fspec_in=>'Unix', output=>'clean', file_out=>'tgBy1.std'});


####
# verifies requirement(s):
#     L<STD::TestGen/clean file [2]>
#     L<STD::TestGen/clean file [3]>
#     L<STD::TestGen/clean file [4]>
#     L<STD::TestGen/clean file [5]>
#     L<STD::TestGen/file_out option [1]>
# 

#####
$T->test( [$T->fin('tgBy1.std')], # actual results
          [$T->fin('tgB2.std')], # expected results
          'clean source std without a todo list');

#  ok:  5

   # Perl code from C:
    #####
    # Make sure there is no residue outputs hanging
    # around from the last test series.
    #
    @outputs = bsd_glob( 'tg*1.*' );
    unlink @outputs;
    @outputs = bsd_glob( 'tg*1-STD.pm');
    unlink @outputs;

   # Perl code from C:
copy 'tgA0.std', 'tgA1.std';

   # Perl code from C:
copy 'tg0.pm', 'tg1.pm';

   # Perl code from C:
STD::TestGen->fgenerate('STD/tgA1.std', {fspec_in=>'Unix', output=>'clean all'} );


####
# verifies requirement(s):
#     L<STD::TestGen/clean file [1]>
#     L<STD::TestGen/clean file [2]>
#     L<STD::TestGen/clean file [3]>
#     L<STD::TestGen/clean file [4]>
#     L<STD::TestGen/clean file [5]>
# 

#####
$T->test( [$T->scrub_file_line($T->fin('tgA1.std'))], # actual results
          [$T->scrub_file_line($T->fin('tgA2B.std'))], # expected results
          'Cleaned tgA1.std');

#  ok:  6


####
# verifies requirement(s):
#     L<STD::TestGen/STD file [1]>
#     L<STD::TestGen/STD file [2]>
# 

#####
$T->test( [$T->scrub_date_version($T->fin('tgA1-STD.pm'))], # actual results
          [$T->scrub_date_version($T->fin('tgA2-STD.pm'))], # expected results
          'Generated tgA1-STD.std');

#  ok:  7

   # Perl code from C:
$test_results = `perl tgA1.d`;

   # Perl code from C:
$T->fout('tgA1.txt', $test_results);


####
# verifies requirement(s):
#     L<STD::TestGen/demo file [1]>
#     L<STD::TestGen/demo file [2]>
# 

#####
$T->test( [$test_results], # actual results
          [$T->fin('tgA2A.txt')], # expected results
          'Demonstration script');

#  ok:  8

   # Perl code from C:
$test_results = `perl tgA1.t`;

   # Perl code from C:
$T->fout('tgA1.txt', $test_results);


####
# verifies requirement(s):
#     L<STD::TestGen/verify file [1]>
#     L<STD::TestGen/verify file [2]>
#     L<STD::TestGen/verify file [3]>
# 

#####
$T->test( [$T->scrub_file_line($test_results)], # actual results
          [$T->scrub_file_line($T->fin('tgA2B.txt'))], # expected results
          'Generated and execute the test script');

#  ok:  9

   # Perl code from C:
    #########
    #
    # Individual generate outputs using options
    #
    ########

    #####
    # Make sure there is no residue outputs hanging
    # around from the last test series.
    #
    @outputs = bsd_glob( 'tg*1.*' );
    unlink @outputs;
    @outputs = bsd_glob( 'tg*1-STD.pm');
    unlink @outputs;

   # Perl code from C:
copy 'tg0.pm', 'tg1.pm';

   # Perl code from C:
copy 'tgA0.std', 'tgA1.std';

   # Perl code from C:
STD::TestGen->fgenerate('STD/tgA1.std', {fspec_in=>'Unix', output=>'clean'});


####
# verifies requirement(s):
#     L<STD::TestGen/clean file [1]>
#     L<STD::TestGen/clean file [2]>
#     L<STD::TestGen/clean file [3]>
#     L<STD::TestGen/clean file [4]>
#     L<STD::TestGen/clean file [5]>
# 

#####
$T->test( [$T->scrub_file_line($T->fin('tgA1.std'))], # actual results
          [$T->scrub_file_line($T->fin('tgA2B.std'))], # expected results
          'Generate a clean file');

#  ok:  10

   # Perl code from C:
STD::TestGen->fgenerate('STD/tgA1.std', {fspec_in=>'Unix', output=>'STD'} );


####
# verifies requirement(s):
#     L<STD::TestGen/STD file [1]>
#     L<STD::TestGen/STD file [2]>
# 

#####
$T->test( [$T->scrub_date_version($T->fin('tgA1-STD.pm'))], # actual results
          [$T->scrub_date_version($T->fin('tgA2-STD.pm'))], # expected results
          'Generate a STD');

#  ok:  11

   # Perl code from C:
STD::TestGen->fgenerate('STD/tgA1.std', {fspec_in=>'Unix', output=>'demo', replace => 1});


####
# verifies requirement(s):
#     L<STD::TestGen/demo file [1]>
#     L<STD::TestGen/demo file [2]>
#     L<STD::TestGen/replace [2]>
# 

#####
$T->test( [$T->scrub_date_version($T->fin('tg1.pm'))], # actual results
          [$T->scrub_date_version($T->fin('tg2B.pm'))], # expected results
          'Generate and replace a demonstration');

#  ok:  12

   # Perl code from C:
    no warnings;
    open SAVEOUT, ">&STDOUT";
    use warnings;
    open STDOUT, ">tgA1.txt";
    STD::TestGen->fgenerate('STD/tgA1.std', {fspec_in=>'Unix', output=>'verify', run=>1, verbose=>1});
    close STDOUT;
    open STDOUT, ">&SAVEOUT";
    
    ######
    # For some reason, test harness puts in a extra line when running u
    # under the Active debugger on Win32. So just take it out.
    # Also the script name is absolute which is site dependent.
    # Take it out of the comparision.
    #
    $test_results = $T->fin('tgA1.txt');
    $test_results =~ s/.*?1..9/1..9/; 
    $test_results =~ s/------.*?\n(\s*\()/\n $1/s;
    $T->fout('tgA1.txt',$test_results);


####
# verifies requirement(s):
#     L<STD::TestGen/verify file [1]>
#     L<STD::TestGen/verify file [2]>
#     L<STD::TestGen/verify file [3]>
#     L<STD::TestGen/verify file [4]>
#     L<STD::TestGen/execute [3]>
#     L<STD::TestGen/execute [4]>
# 

#####
$T->test( [$T->scrub_test_file($T->scrub_file_line($test_results))], # actual results
          [$T->scrub_test_file($T->scrub_file_line($T->fin('tgA2C.txt')))], # expected results
          'Generate and verbose test harness run test script');

#  ok:  13

   # Perl code from C:
    no warnings;
    open SAVEOUT, ">&STDOUT";
    use warnings;
    open STDOUT, ">tgA1.txt";
    $main::SIG{__WARN__}=\&__warn__; # kill pesty Format STDOUT and Format STDOUT_TOP redefined
    STD::TestGen->fgenerate('STD/tgA1.std', {fspec_in=>'Unix', output=>'verify', run=>1});
    $main::SIG{__WARN__}=\&CORE::warn;
    close STDOUT;
    open STDOUT, ">&SAVEOUT";

    ######
    # For some reason, test harness puts in a extra line when running u
    # under the Active debugger on Win32. So just take it out.
    # Also with absolute file, the file is chopped off, and see
    # stuff that is site dependent. Need to take it out also.
    #
    $test_results = $T->fin('tgA1.txt');
    $test_results =~ s/.*?FAILED/FAILED/; 
    $test_results =~ s/(\)\s*\n).*?\n(\s*\()/$1$2/s;
    $T->fout('TgA1.txt',$test_results);


####
# verifies requirement(s):
#     L<STD::TestGen/verify file [1]>
#     L<STD::TestGen/verify file [2]>
#     L<STD::TestGen/verify file [3]>
#     L<STD::TestGen/execute [3]>
# 

#####
$T->test( [$test_results], # actual results
          [$T->fin('tgA2D.txt')], # expected results
          'Generate and test harness run test script');

#  ok:  14

   # Perl code from C:
    STD::TestGen->fgenerate('STD/tgB0.std', 
      {fspec_in=>'MSWin32', fspec_out=>'os2',  output=>'clean', 
      file_out=>'tgB1.std'});


####
# verifies requirement(s):
#     L<STD::TestGen/fspec_in option [5]>
#     L<STD::TestGen/fspec_out option [6]>
# 

#####
$T->test( [$T->fin('tgB1.std')], # actual results
          [$T->fin('tgB2A.std')], # expected results
          'Change File Spec');

#  ok:  15

   # Perl code from C:
    STD::TestGen->fgenerate('STD/tgB0.std', 
      {fspec_in=>'os2', fspec_out=>'MacOS',  output=>'clean', 
      file_out=>'tgB1.std'});


####
# verifies requirement(s):
#     L<STD::TestGen/fspec_in option [5]>
#     L<STD::TestGen/fspec_out option [6]>
# 

#####
$T->test( [$T->fin('tgB1.std')], # actual results
          [$T->fin('tgB2B.std')], # expected results
          'Change File Spec');

#  ok:  16

   # Perl code from C:
    use File::Spec;
    my (undef, $xdirs, undef) = File::Spec->splitpath( File::Spec->rel2abs(__FILE__) );
    my @xdirs = File::Spec->splitdir($xdirs);
    pop @xdirs;
    pop @xdirs if $xdirs[-1] eq 't';
    $xdirs = File::Spec->catdir( @xdirs );
    STD::TestGen->fgenerate('STD/tgB0.std', 
      {fspec_in=>'UNIX', dir_path => $xdirs, output=>'clean', 
        file_out=>'tgBz1.std'});


####
# verifies requirement(s):
# <STD::TestGen/dir-path option [7]>
# 

#####
$T->test( [$T->fin('tgBz1.std')], # actual results
          [$T->fin('tgB2.std')], # expected results
          'Add to search path');

#  ok:  17

   # Perl code from C:
    sub __warn__ 
    { 
       my ($text) = @_;
       return $text =~ /STDOUT/;
       CORE::warn( $text );
    };

    #####
    # Make sure there is no residue outputs hanging
    # around from the last test series.
    #
    @outputs = bsd_glob( 'tg*1.*' );
    unlink @outputs;
    @outputs = bsd_glob( 'tg*1-STD.pm');
    unlink @outputs;


$T->finish();


=head1 NAME

TestGen.t - test script for STD/TestGen.pm

=head1 SYNOPSIS

 TestGen.t -log=I<string>

=head1 OPTIONS

All options may be abbreviated with enough leading characters
to distinguish it from the other options.

=over 4

=item C<-log>

TestGen.t uses this option to redirect the test results 
from the standard output to a log file.

=back

=head1 COPYRIGHT

copyright © 2003 Software Diamonds.

Software Diamonds permits the redistribution
and use in source and binary forms, with or
without modification, provided that the 
following conditions are met: 

=over 4

=item 1

Redistributions of source code, modified or unmodified
must retain the above copyright notice, this list of
conditions and the following disclaimer. 

=item 2

Redistributions in binary form must 
reproduce the above copyright notice,
this list of conditions and the following 
disclaimer in the documentation and/or
other materials provided with the
distribution.

=back

SOFTWARE DIAMONDS, http://www.SoftwareDiamonds.com,
PROVIDES THIS SOFTWARE 
'AS IS' AND ANY EXPRESS OR IMPLIED WARRANTIES,
INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT
SHALL SOFTWARE DIAMONDS BE LIABLE FOR ANY DIRECT,
INDIRECT, INCIDENTAL, SPECIAL,EXEMPLARY, OR 
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE,DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING USE OF THIS SOFTWARE, EVEN IF
ADVISED OF NEGLIGENCE OR OTHERWISE) ARISING IN
ANY WAY OUT OF THE POSSIBILITY OF SUCH DAMAGE.

=for html
<hr>
<p><br>
<!-- BLK ID="NOTICE" -->
<!-- /BLK -->
<p><br>
<!-- BLK ID="OPT-IN" -->
<!-- /BLK -->
<p><br>
<!-- BLK ID="EMAIL" -->
<!-- /BLK -->
<p><br>
<!-- BLK ID="LOG_CGI" -->
<!-- /BLK -->
<p><br>

=cut

## end of test script file ##

