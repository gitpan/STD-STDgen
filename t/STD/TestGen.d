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


##### Demonstration Script ####
#
# Name: TestGen.d
#
# UUT: STD::TestGen
#
# The module STD::TestGen generated this demo script from the contents of
#
# STD\testgen.std 
#
# Don't edit this test script file, edit instead
#
# STD\testgen.std
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
"\ \ \ \ use\ vars\ qw\(\$loaded\)\;\
\ \ \ \ use\ File\:\:Glob\ \'\:glob\'\;\
\ \ \ \ use\ File\:\:Copy\;\
\
\ \ \ \ my\ \$test_results\;\
\ \ \ \ my\ \$loaded\ \=\ 0\;\
\ \ \ \ my\ \@outputs\;"); # typed in command           
    use vars qw($loaded);
    use File::Glob ':glob';
    use File::Copy;

    my $test_results;
    my $loaded = 0;
    my @outputs;; # execution

$T->demo(   
"my\ \$errors\ \=\ \$T\-\>load_package\(\ \'STD\:\:TestGen\'\ \)"); # typed in command           
my $errors = $T->load_package( 'STD::TestGen' ); # execution

$T->demo(   
"\$errors", # typed in command           
$errors # execution
) unless     $loaded; # condition for execution                            

$T->demo(   
"\$T\-\>fin\(\'tgA0\.std\'\)", # typed in command           
$T->fin('tgA0.std')); # execution


$T->demo(   
"\$T\-\>fin\(\'tgB0\.std\'\)", # typed in command           
$T->fin('tgB0.std')); # execution


$T->demo(   
"\ \ \ \ \#\#\#\#\#\
\ \ \ \ \#\ Make\ sure\ there\ is\ no\ residue\ outputs\ hanging\
\ \ \ \ \#\ around\ from\ the\ last\ test\ series\.\
\ \ \ \ \#\
\ \ \ \ \@outputs\ \=\ bsd_glob\(\ \'tg\*1\.\*\'\ \)\;\
\ \ \ \ unlink\ \@outputs\;\
\ \ \ \ \@outputs\ \=\ bsd_glob\(\ \'tg\*1\-STD\.pm\'\)\;\
\ \ \ \ unlink\ \@outputs\;"); # typed in command           
    #####
    # Make sure there is no residue outputs hanging
    # around from the last test series.
    #
    @outputs = bsd_glob( 'tg*1.*' );
    unlink @outputs;
    @outputs = bsd_glob( 'tg*1-STD.pm');
    unlink @outputs;; # execution

$T->demo(   
"copy\ \'tgA0\.std\'\,\ \'tgA1\.std\'"); # typed in command           
copy 'tgA0.std', 'tgA1.std'; # execution

$T->demo(   
"\$T\-\>fin\(\'tgA1\.std\'\)", # typed in command           
$T->fin('tgA1.std')); # execution


$T->demo(   
"copy\ \'tg0\.pm\'\,\ \'tg1\.pm\'"); # typed in command           
copy 'tg0.pm', 'tg1.pm'; # execution

$T->demo(   
"\$T\-\>fin\(\'tg1\.pm\'\)", # typed in command           
$T->fin('tg1.pm')); # execution


$T->demo(   
"STD\:\:TestGen\-\>fgenerate\(\'STD\/tgA1\.std\'\,\ \{fspec_in\=\>\'Unix\'\,\ output\=\>\'clean\ all\'\}\ \)"); # typed in command           
STD::TestGen->fgenerate('STD/tgA1.std', {fspec_in=>'Unix', output=>'clean all'} ); # execution

$T->demo(   
"\$T\-\>scrub_file_line\(\$T\-\>fin\(\'tgA1\.std\'\)\)", # typed in command           
$T->scrub_file_line($T->fin('tgA1.std'))); # execution


$T->demo(   
"STD\:\:TestGen\-\>fgenerate\(\'STD\/tgA1\.std\'\,\ \{fspec_in\=\>\'Unix\'\,\ output\=\>\'demo\'\,\ replace\ \=\>\ 1\}\)\;"); # typed in command           
STD::TestGen->fgenerate('STD/tgA1.std', {fspec_in=>'Unix', output=>'demo', replace => 1});; # execution

$T->demo(   
"\$T\-\>scrub_date_version\(\$T\-\>fin\(\'tg1\.pm\'\)\)", # typed in command           
$T->scrub_date_version($T->fin('tg1.pm'))); # execution


$T->demo(   
"\ \ \ \ no\ warnings\;\
\ \ \ \ open\ SAVEOUT\,\ \"\>\&STDOUT\"\;\
\ \ \ \ use\ warnings\;\
\ \ \ \ open\ STDOUT\,\ \"\>tgA1\.txt\"\;\
\ \ \ \ STD\:\:TestGen\-\>fgenerate\(\'STD\/tgA1\.std\'\,\ \{fspec_in\=\>\'Unix\'\,\ output\=\>\'verify\'\,\ run\=\>1\,\ verbose\=\>1\}\)\;\
\ \ \ \ close\ STDOUT\;\
\ \ \ \ open\ STDOUT\,\ \"\>\&SAVEOUT\"\;\
\ \ \ \ \
\ \ \ \ \#\#\#\#\#\#\
\ \ \ \ \#\ For\ some\ reason\,\ test\ harness\ puts\ in\ a\ extra\ line\ when\ running\ u\
\ \ \ \ \#\ under\ the\ Active\ debugger\ on\ Win32\.\ So\ just\ take\ it\ out\.\
\ \ \ \ \#\ Also\ the\ script\ name\ is\ absolute\ which\ is\ site\ dependent\.\
\ \ \ \ \#\ Take\ it\ out\ of\ the\ comparision\.\
\ \ \ \ \#\
\ \ \ \ \$test_results\ \=\ \$T\-\>fin\(\'tgA1\.txt\'\)\;\
\ \ \ \ \$test_results\ \=\~\ s\/\.\*\?1\.\.9\/1\.\.9\/\;\ \
\ \ \ \ \$test_results\ \=\~\ s\/\-\-\-\-\-\-\.\*\?\\n\(\\s\*\\\(\)\/\\n\ \$1\/s\;\
\ \ \ \ \$T\-\>fout\(\'tgA1\.txt\'\,\$test_results\)\;"); # typed in command           
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
    $T->fout('tgA1.txt',$test_results);; # execution

$T->demo(   
"\$T\-\>scrub_test_file\(\$T\-\>scrub_file_line\(\$test_results\)\)", # typed in command           
$T->scrub_test_file($T->scrub_file_line($test_results))); # execution


$T->demo(   
"\ \ \ \ sub\ __warn__\ \
\ \ \ \ \{\ \
\ \ \ \ \ \ \ my\ \(\$text\)\ \=\ \@_\;\
\ \ \ \ \ \ \ return\ \$text\ \=\~\ \/STDOUT\/\;\
\ \ \ \ \ \ \ CORE\:\:warn\(\ \$text\ \)\;\
\ \ \ \ \}\;\
\
\ \ \ \ \#\#\#\#\#\
\ \ \ \ \#\ Make\ sure\ there\ is\ no\ residue\ outputs\ hanging\
\ \ \ \ \#\ around\ from\ the\ last\ test\ series\.\
\ \ \ \ \#\
\ \ \ \ \@outputs\ \=\ bsd_glob\(\ \'tg\*1\.\*\'\ \)\;\
\ \ \ \ unlink\ \@outputs\;\
\ \ \ \ \@outputs\ \=\ bsd_glob\(\ \'tg\*1\-STD\.pm\'\)\;\
\ \ \ \ unlink\ \@outputs\;"); # typed in command           
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
    unlink @outputs;; # execution


$T->finish();


=head1 NAME

TestGen.d - demostration script for STD::TestGen

=head1 SYNOPSIS

 TestGen.d

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

