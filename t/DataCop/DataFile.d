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


##### Demonstration Script ####
#
# Name: DataFile.d
#
# UUT: DataCop::DataFile
#
# The module STD::TestGen generated this demo script from the contents of
#
# DataCop/DataFile.std 
#
# Don't edit this test script file, edit instead
#
# DataCop/DataFile.std
#
#	ANY CHANGES MADE HERE TO THIS SCRIPT FILE WILL BE LOST
#
#       the next time STD::TestGen generates this script file.
#
#

######
#
# The working directory is the directory of the generated file
#
use vars qw($__restore_dir__ $T);

BEGIN {
    use Cwd;
    use File::Spec;
    use STD::Tester;
    use Getopt::Long;

    ##########
    # Pick up a output redirection file and tests to skip
    # from the command line.
    #
    my $test_log = '';
    GetOptions('log=s' => \$test_log);
 
    ########
    # Start a demo with a new tester
    #
    $T = new STD::Tester( $test_log );

    ########
    # Working directory is that of the script file
    #
    $__restore_dir__ = cwd();
    my ($vol, $dirs, undef) = File::Spec->splitpath( $0 );
    chdir $vol if $vol;
    chdir $dirs if $dirs;
}

END {

    #########
    # Restore working directory back to when enter script
    #
    chdir $__restore_dir__;
}

print << 'MSG';

 ~~~~~~ Demonstration overview ~~~~~
 
Perl code begins with the prompt

 =>

The selected results from executing the Perl Code 
follow on the next lines. For example,

 => 2 + 2
 4

 ~~~~~~ The demonstration follows ~~~~~

MSG

$T->demo(   
"my\ \$errors\ \=\ \$T\-\>load_package\(\ \'DataCop\:\:DataFileI\'\ \)"); # typed in command           
my $errors = $T->load_package( 'DataCop::DataFileI' ); # execution

$T->demo(   
"\$errors", # typed in command           
$errors # execution
) unless     $loaded; # condition for execution                            

$T->demo(   
"\$T\-\>fin\(\ \'DataFile0\.tdb\'\ \)", # typed in command           
$T->fin( 'DataFile0.tdb' )); # execution


$T->demo(   
"\ \ \ \ unlink\ \'DataFile1\.txt\'\;\
\
\ \ \ \ my\ \$record\;\
\ \ \ \ my\ \(\$array_p\,\ \$record_p\)\ \=\ \(\[\]\,\ \\\$record\)\;\
\ \ \ \ my\ \$dbh\ \=\ new\ DataCop\:\:DataFileI\(flag\ \=\>\ \'\<\'\,\ file\ \=\>\ \'DataFile0\.tdb\'\,\
\ \ \ \ \ \ \ \ \ \ \ \ \ \ \ option1\ \=\>\ \'1\'\,\ option2\ \=\>\ \'2\'\ \)\;\
\
\ \ \ \ while\(\ \$dbh\-\>get\(\$array_p\,\ \$record_p\)\ \)\ \{\
\ \ \ \ \ \ \ \ \$T\-\>fout\(\ \'DataFile1\.txt\'\,\ \$\$record_p\ \.\ \"\\n\~\-\~\\n\"\,\ \{append\=\>1\}\)\;\
\ \ \ \ \ \ \ \ \$T\-\>fout\(\ \'DataFile1\.txt\'\,\ join\(\"\\n\+\-\-\\n\"\,\@\$array_p\)\ \.\ \"\\n\~\-\~\\n\"\,\ \{append\=\>1\}\)\;\
\ \ \ \ \}"); # typed in command           
    unlink 'DataFile1.txt';

    my $record;
    my ($array_p, $record_p) = ([], \$record);
    my $dbh = new DataCop::DataFileI(flag => '<', file => 'DataFile0.tdb',
               option1 => '1', option2 => '2' );

    while( $dbh->get($array_p, $record_p) ) {
        $T->fout( 'DataFile1.txt', $$record_p . "\n~-~\n", {append=>1});
        $T->fout( 'DataFile1.txt', join("\n+--\n",@$array_p) . "\n~-~\n", {append=>1});
    }; # execution

$T->demo(   
"\$T\-\>fin\(\'DataFile1\.txt\'\)", # typed in command           
$T->fin('DataFile1.txt')); # execution


$T->demo(   
"\ \ \ \ unlink\ \'DataFile1\.txt\'\;\
\ \ \ \ \$dbh\-\>finish\(\)\;\
\
\ \ \ \ \$dbh\ \=\ new\ DataCop\:\:DataFileI\(flag\ \=\>\ \'\<\'\,\ file\ \=\>\ \'DataFile0\.tdb\'\,\
\ \ \ \ \ \ \ \ \ \ \ \ \ \ \ option3\ \=\>\ \'3\'\,\ option4\ \=\>\ \'4\'\,\ \ option5\ \=\>\ \'5\'\ \)\;\
\
\ \ \ \ while\(\ \$dbh\-\>get\(\$array_p\)\ \)\ \{\
\ \ \ \ \ \ \ \ \$T\-\>fout\(\ \'DataFile1\.txt\'\,\ join\(\"\\n\+\-\-\\n\"\,\@\$array_p\)\ \.\ \"\\n\~\-\~\\n\"\,\ \{append\=\>1\}\)\;\
\ \ \ \ \}\
\ \ \ \ \$dbh\-\>finish\(\)\;"); # typed in command           
    unlink 'DataFile1.txt';
    $dbh->finish();

    $dbh = new DataCop::DataFileI(flag => '<', file => 'DataFile0.tdb',
               option3 => '3', option4 => '4',  option5 => '5' );

    while( $dbh->get($array_p) ) {
        $T->fout( 'DataFile1.txt', join("\n+--\n",@$array_p) . "\n~-~\n", {append=>1});
    }
    $dbh->finish();; # execution

$T->demo(   
"\$T\-\>fin\(\'DataFile1\.txt\'\)", # typed in command           
$T->fin('DataFile1.txt')); # execution


$T->demo(   
"\ \ \ \ unlink\ \'DataFile1\.txt\'\;\
\ \ \ \ unlink\ \'DataFile1\.tdb\'\;\
\
\ \ \ \ \$dbh\ \=\ new\ DataCop\:\:DataFileI\(flag\ \=\>\ \'\>\'\,\ file\ \=\>\ \'DataFile1\.tdb\'\,\
\ \ \ \ \ \ \ \ \ \ \ \ \ \ \ option6\ \=\>\ \'6\'\,\ option7\ \=\>\ \'7\'\ \)\;\
\
\ \ \ \ my\ \@db\ \=\ \(\ \[\ \'name1\'\,\'data1\'\,\'name2\'\,\'data2\'\]\,\ \[\ \'name3\'\,\ \'data3\'\,\ \'name4\'\,\ \'data4\'\ \]\ \)\;\ \ \
\ \
\ \ \ \ foreach\ \$array_p\ \(\@db\)\ \{\
\ \ \ \ \ \ \ \ \$record\ \=\ \'\'\;\ \
\ \ \ \ \ \ \ \ \$dbh\-\>put\(\$array_p\,\ \$record_p\)\;\
\ \ \ \ \ \ \ \ \$T\-\>fout\(\'DataFile1\.txt\'\,\ \$\$record_p\ \.\ \"\\n\~\-\~\\n\"\,\ \{append\=\>1\}\)\;\
\ \ \ \ \}\
\ \ \ \ \$dbh\-\>finish\(\)\;"); # typed in command           
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
    $dbh->finish();; # execution

$T->demo(   
"\$T\-\>fin\(\'DataFile1\.tdb\'\)", # typed in command           
$T->fin('DataFile1.tdb')); # execution


$T->demo(   
"\$T\-\>fin\(\'DataFile1\.txt\'\)", # typed in command           
$T->fin('DataFile1.txt')); # execution


$T->demo(   
"\ \ \ \ \$dbh\-\>finish\(\)\;\
\ \ \ \ unlink\ \'DataFile1\.txt\'\;\
\ \ \ \ unlink\ \'DataFile1\.tdb\'\;\
\
\ \ \ \ \$dbh\ \=\ new\ DataCop\:\:DataFileI\(flag\ \=\>\ \'\>\'\,\ file\ \=\>\ \'DataFile1\.tdb\'\,\
\ \ \ \ \ \ \ \ \ \ \ \ \ \ \ option8\ \=\>\ \'8\'\ \)\;\
\
\ \ \ \ \@db\ \=\ \(\ \[\ \'name5\'\,\'data5\'\,\'name6\'\,\'data6\'\]\,\ \[\ \'name7\'\,\ \'data7\'\ \]\ \)\;\ \ \
\ \
\ \ \ \ foreach\ \$array_p\ \(\@db\)\ \{\ \
\ \ \ \ \ \ \ \ \$dbh\-\>put\(\$array_p\)\;\
\ \ \ \ \}\
\ \ \ \ \$dbh\-\>finish\(\)\;"); # typed in command           
    $dbh->finish();
    unlink 'DataFile1.txt';
    unlink 'DataFile1.tdb';

    $dbh = new DataCop::DataFileI(flag => '>', file => 'DataFile1.tdb',
               option8 => '8' );

    @db = ( [ 'name5','data5','name6','data6'], [ 'name7', 'data7' ] );  
 
    foreach $array_p (@db) { 
        $dbh->put($array_p);
    }
    $dbh->finish();; # execution

$T->demo(   
"\$T\-\>fin\(\'DataFile1\.tdb\'\)", # typed in command           
$T->fin('DataFile1.tdb')); # execution


$T->demo(   
"\ \ \ \ unlink\ \'DataFile1\.txt\'\;\
\ \ \ \ unlink\ \'DataFile1\.tdb\'\;\
\
\ \ \ \ \$dbh\ \=\ new\ DataCop\:\:DataFileI\(flag\ \=\>\ \'\>\'\,\ file\ \=\>\ \'DataFile1\.tdb\'\,\
\ \ \ \ \ \ \ \ \ \ \ \ \ \ binary\ \=\>\ 1\,\ option9\ \=\>\ \'9\'\ \)\;\
\
\ \ \ \ \@db\ \=\ \(\ \[\ \'name5\'\,\'data5\'\,\'name6\'\,\'data6\'\]\,\ \[\ \'name7\'\,\ \'data7\'\ \]\ \)\;\ \ \
\ \
\ \ \ \ foreach\ \$array_p\ \(\@db\)\ \{\ \
\ \ \ \ \ \ \ \ \$dbh\-\>put\(\$array_p\)\;\
\ \ \ \ \}\
\ \ \ \ \$dbh\-\>finish\(\)\;"); # typed in command           
    unlink 'DataFile1.txt';
    unlink 'DataFile1.tdb';

    $dbh = new DataCop::DataFileI(flag => '>', file => 'DataFile1.tdb',
              binary => 1, option9 => '9' );

    @db = ( [ 'name5','data5','name6','data6'], [ 'name7', 'data7' ] );  
 
    foreach $array_p (@db) { 
        $dbh->put($array_p);
    }
    $dbh->finish();; # execution

$T->demo(   
"\$T\-\>fin\(\'DataFile1\.tdb\'\)", # typed in command           
$T->fin('DataFile1.tdb')); # execution


$T->demo(   
"\ \ \ \ unlink\ \'DataFile1\.txt\'\;\
\ \ \ \ unlink\ \'DataFile1\.tdb\'\;\
\
\ \ \ \ \$dbh\ \=\ new\ DataCop\:\:DataFileI\(flag\ \=\>\ \'\<\'\,\ file\ \=\>\ \'DataFile0\.tdb\'\,\
\ \ \ \ \ \ \ \ \ \ \ \ \ \ \ binary\ \=\>\ 1\,\ option10\ \=\>\ \'10\'\,\ option11\ \=\>\ \'11\'\ \)\;\
\
\ \ \ \ while\(\ \$dbh\-\>get\(\$array_p\,\ \$record_p\)\ \)\ \{\
\ \ \ \ \ \ \ \ \$T\-\>fout\(\ \'DataFile1\.txt\'\,\ \$\$record_p\ \.\ \"\\n\~\-\~\\n\"\,\ \{append\=\>1\}\)\;\
\ \ \ \ \ \ \ \ \$T\-\>fout\(\ \'DataFile1\.txt\'\,\ join\(\"\\n\+\-\-\\n\"\,\@\$array_p\)\ \.\ \"\\n\~\-\~\\n\"\,\ \{append\=\>1\}\)\;\
\ \ \ \ \}\
\ \ \ \ \$dbh\-\>finish\(\)\;"); # typed in command           
    unlink 'DataFile1.txt';
    unlink 'DataFile1.tdb';

    $dbh = new DataCop::DataFileI(flag => '<', file => 'DataFile0.tdb',
               binary => 1, option10 => '10', option11 => '11' );

    while( $dbh->get($array_p, $record_p) ) {
        $T->fout( 'DataFile1.txt', $$record_p . "\n~-~\n", {append=>1});
        $T->fout( 'DataFile1.txt', join("\n+--\n",@$array_p) . "\n~-~\n", {append=>1});
    }
    $dbh->finish();; # execution

$T->demo(   
"\$T\-\>fin\(\'DataFile1\.txt\'\)", # typed in command           
$T->fin('DataFile1.txt')); # execution


$T->demo(   
"\ \ \ \ unlink\ \'DataFile1\.txt\'\;\
\ \ \ \ unlink\ \'DataFile1\.tdb\'\;"); # typed in command           
    unlink 'DataFile1.txt';
    unlink 'DataFile1.tdb';; # execution


$T->finish();


=head1 NAME

DataFile.d - demostration script for DataCop::DataFile

=head1 SYNOPSIS

 DataFile.d

=head1 OPTIONS

None.

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

## end of test script file ##

=cut

