#!perl
#
#
use 5.001;
use strict;
use warnings;
use warnings::register;

use vars qw($VERSION $DATE);
$VERSION = '0.01';   # automatically generated file
$DATE = '2003/06/03';

use STD::Tester;
use Getopt::Long;
use Cwd;
use File::Spec;


##### Test Script ####
#
# Name: DataFile.t
#
# UUT: DataCop::DataFile
#
# The module STD::TestGen generated this test script from the contents of
#
# DataCop/DataFile.std;
#
# Don't edit this test script file, edit instead
#
# DataCop/DataFile.std;
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
   use vars qw( $T $__restore_dir__);

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
   $T->work_breakdown(tests => 10);

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
   chdir File::Spec->updir();
   my $lib_dir = File::Spec->catdir( cwd(), 'lib' );
   unshift @INC, $lib_dir;
   chdir $work_dir;

}

END {

   #########
   # Restore working directory back to when enter script
   #
   chdir $__restore_dir__;
}

$T->test( [my $loaded = $T->is_package_loaded('DataCop::DataFileI')], # actual results
          [ ''], # expected results
          'UUT not loaded');

#  ok:  1

   # Perl code from C:
my $errors = $T->load_package( 'DataCop::DataFileI' );


####
# verifies requirement(s):
# L<DataCop::DataFile/general [1] - load>
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
# L<DataCop::DataFile/general [2] - pod check>
# 

#####
$T->test( [$T->pod_errors( 'DataCop::DataFile')], # actual results
          [0], # expected results
          'No pod errors');

#  ok:  3

   # Perl code from C:
    unlink 'DataFile1.txt';

    my $record;
    my ($array_p, $record_p) = ([], \$record);
    my $dbh = new DataCop::DataFileI(flag => '<', file => 'DataFile0.tdb',
               option1 => '1', option2 => '2' );

    while( $dbh->get($array_p, $record_p) ) {
        $T->fout( 'DataFile1.txt', $$record_p . "\n~-~\n", {append=>1});
        $T->fout( 'DataFile1.txt', join("\n+--\n",@$array_p) . "\n~-~\n", {append=>1});
    };

$T->test( [$T->fin('DataFile1.txt')], # actual results
          [$T->fin('DataFile2.txt')], # expected results
          'get with record');

#  ok:  4

   # Perl code from C:
    unlink 'DataFile1.txt';
    $dbh->finish();

    $dbh = new DataCop::DataFileI(flag => '<', file => 'DataFile0.tdb',
               option3 => '3', option4 => '4',  option5 => '5' );

    while( $dbh->get($array_p) ) {
        $T->fout( 'DataFile1.txt', join("\n+--\n",@$array_p) . "\n~-~\n", {append=>1});
    }
    $dbh->finish();

$T->test( [$T->fin('DataFile1.txt')], # actual results
          [$T->fin('DataFile3.txt')], # expected results
          'get without record');

#  ok:  5

   # Perl code from C:
    unlink 'DataFile1.txt';
    unlink 'DataFile1.tdb';

    $dbh = new DataCop::DataFileI(flag => '>', file => 'DataFile1.tdb',
               option6 => '6', option7 => '7' );

    my @db = ( [ 'name1','data1','name2','data2'], [ 'name3', 'data3', 'name4', 'data4' ] );  
 
    foreach $array_p (@db) {
        $record = ''; 
        $dbh->put($array_p, $record_p);
        $T->fout('DataFile1.txt', $$record_p . "\n~-~\n", {append=>1});
    }
    $dbh->finish();

$T->test( [$T->fin('DataFile1.tdb')], # actual results
          [$T->fin('DataFile2.tdb')], # expected results
          'put with record');

#  ok:  6

$T->test( [$T->fin('DataFile1.txt')], # actual results
          [$T->fin('DataFile4.txt')], # expected results
          'put with record');

#  ok:  7

   # Perl code from C:
    $dbh->finish();
    unlink 'DataFile1.txt';
    unlink 'DataFile1.tdb';

    $dbh = new DataCop::DataFileI(flag => '>', file => 'DataFile1.tdb',
               option8 => '8' );

    @db = ( [ 'name5','data5','name6','data6'], [ 'name7', 'data7' ] );  
 
    foreach $array_p (@db) { 
        $dbh->put($array_p);
    }
    $dbh->finish();

$T->test( [$T->fin('DataFile1.tdb')], # actual results
          [$T->fin('DataFile3.tdb')], # expected results
          'put with without record');

#  ok:  8

   # Perl code from C:
    unlink 'DataFile1.txt';
    unlink 'DataFile1.tdb';

    $dbh = new DataCop::DataFileI(flag => '>', file => 'DataFile1.tdb',
              binary => 1, option9 => '9' );

    @db = ( [ 'name5','data5','name6','data6'], [ 'name7', 'data7' ] );  
 
    foreach $array_p (@db) { 
        $dbh->put($array_p);
    }
    $dbh->finish();

$T->test( [$T->fin('DataFile1.tdb')], # actual results
          [$T->fin('DataFile4.tdb')], # expected results
          'binary put with without record');

#  ok:  9

   # Perl code from C:
    unlink 'DataFile1.txt';
    unlink 'DataFile1.tdb';

    $dbh = new DataCop::DataFileI(flag => '<', file => 'DataFile0.tdb',
               binary => 1, option10 => '10', option11 => '11' );

    while( $dbh->get($array_p, $record_p) ) {
        $T->fout( 'DataFile1.txt', $$record_p . "\n~-~\n", {append=>1});
        $T->fout( 'DataFile1.txt', join("\n+--\n",@$array_p) . "\n~-~\n", {append=>1});
    }
    $dbh->finish();

$T->test( [$T->fin('DataFile1.txt')], # actual results
          [$T->fin('DataFile5.txt')], # expected results
          'binary get with record');

#  ok:  10

   # Perl code from C:
    unlink 'DataFile1.txt';
    unlink 'DataFile1.tdb';


$T->finish();


=head1 NAME

DataFile.t - test script for DataCop/DataFile.pm

=head1 SYNOPSIS

 DataFile.t -log=I<string>

=head1 OPTIONS

All options may be abbreviated with enough leading characters
to distinguish it from the other options.

=over 4

=item C<-log>

DataFile.t uses this option to redirect the test results 
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

