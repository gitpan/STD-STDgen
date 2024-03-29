#!perl
#
# Documentation, copyright and license is at the end of this file.
#
package  STD::GenType::Demo;

use 5.001;
use strict;
use warnings;
use warnings::register;

use File::Spec;
use File::Glob ':glob';
use File::Spec;
use STD::TestUtil;

use vars qw($VERSION $DATE);
$VERSION = '1.02';
$DATE = '2003/06/03';


########
# Inherit STD::FileGen
#
use STD::FileGen;
use vars qw(@ISA);
@ISA = qw(STD::FileGen);


sub extension { ".d" };


#####
#
# Start generating the file 
#
sub start
{
    my ($self) = @_;

    ###########
    # use in variables without have to backslash escape the dollar sign
    # every which way in the below << here statement
    #   
    my ($test_log,$T) = ('$test_log','$T');
    my ($vol, $dirs, $__restore_dir__, $VERSION, $DATE) = 
      ('$vol', '$dirs', '$__restore_dir__','$VERSION', '$DATE');


    my (undef,undef,$demo_script) = File::Spec->splitpath( $self->{Demo} );
    my $uut = STD::TestUtil->fspec2pm($self->{File_Spec}, $self->{UUT}  );

    << "EOF";
#!perl
#
#
use 5.001;
use strict;
use warnings;
use warnings::register;

use vars qw($VERSION $DATE);
$VERSION = '0.01';   # automatically generated file
$DATE = '$self->{Date}';


##### Demonstration Script ####
#
# Name: $demo_script
#
# UUT: $uut
#
# The module STD::TestGen generated this demo script from the contents of
#
# $self->{std} 
#
# Don't edit this test script file, edit instead
#
# $self->{std}
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
    GetOptions('log=s' => \\$test_log);
 
    ########
    # Start a demo with a new tester
    #
    $T = new STD::Tester( $test_log );

    ########
    # Working directory is that of the script file
    #
    $__restore_dir__ = cwd();
    my ($vol, $dirs, undef) = File::Spec->splitpath( \$0 );
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

EOF

}

sub finish
{
    my ($self) = @_;

    ########
    #  End the test
    #
    my $data =  "\n\$T->finish();\n\n";
    $data .= $self->perl_podgen( ); 
    $data;
}



#####
#
# post print processing
#
sub post_print
{
     my ($self) = @_;

     return 1 unless $self->{options}->{replace};
 
     my $module = ref($self);

     my $demo_script = shift @{$self->{$module}->{generated_files}};
     @{$self->{$module}->{generated_files}} = ();
    
     return 1 unless $demo_script;

     ######
     # Generate demo
     #
     my @demo = `perl $demo_script`;
     my $demo = join '',@demo;
     return undef unless $demo;

     $demo =~ s/\n\s+\n/\n\n/g;

     ######
     # Find uut file
     #
     my $uut = $self->{'UUT'};
     unless( $uut ) {
         warn("No UUT specified.\n");
         return undef;
     }
     
     my ($uut_file) = STD::TestUtil->find_in_path($self->{File_Spec}, $uut, $self->{dir_path} );

     return undef unless $uut_file && -e $uut_file;
     my $uut_contents = STD::TestUtil->fin( $uut_file );
     $uut_contents =~ s/(\n=head\d\s+Demonstration).*?\n=/$1\n$demo\n=/si;
     STD::TestUtil->fout( $uut_file, $uut_contents);
 
     1   

}



#######
# No processing
#
sub ok { '' }
sub  T { '' }
sub  R { '' }
sub  E { '' }
sub SE { '' }
sub  N { '' }
sub  U { '' }
sub DO { '' }

#######
# Condition to skip a test
#
sub VO
{
    my ($self, $command,$data) = @_;
    my $module = ref($self);
    $self->{$module}->{'verify_only'} = "    $data";
    ''
}


#######
# Condition to skip a test
#
sub S
{
    my ($self, $command,$data) = @_;
    my $module = ref($self);
    return '' if  $self->{$module}->{'verify_only'};
    $self->{$module}->{'skip'} = "    $data";
    ''
}


#########
# Print text string of the Perl expression
# and then execute the expression 
#
sub C
{
    my ($self, $command, $data) = @_;
    my $module = ref($self);
    return '' if  $self->{$module}->{'verify_only'};
    my $datameta = quotemeta($data);
    my $msg = << "EOF";
\$T->demo(   
\"$datameta\"); # typed in command           
$data; # execution

EOF

}


#######
# Simulate typing in commands at the terminal
#
sub A
{
    my ($self, $command, $data) = @_;
    my $module = ref($self);

    if ( $self->{$module}->{'verify_only'} ) {
        $self->{$module}->{'verify_only'} = '';
        $self->{$module}->{'skip'} = '';
        return '';
    }

    my $msg;
    my $datameta = quotemeta($data);

   if( $self->{$module}->{'skip'} ) {

       $msg = << "EOF";
\$T->demo(   
\"$datameta\", # typed in command           
$data # execution
) unless $self->{$module}->{'skip'}; # condition for execution                            

EOF

       $self->{$module}->{'skip'} = '';
   }
   else {

       $msg = << "EOF";
\$T->demo(   
\"$datameta\", # typed in command           
$data); # execution


EOF
   
  }

  $msg;

}



sub perl_podgen
{
    my ($self) = @_;
    my $module = ref($self);

    my (undef,undef,$demo_script) = File::Spec->splitpath( $self->{'Demo'} );
    my $uut = STD::TestUtil->fspec2pm($self->{File_Spec}, $self->{UUT});

    << "EOF";

=head1 NAME

$demo_script - demostration script for $uut

=head1 SYNOPSIS

 $demo_script

=head1 OPTIONS

None.

=head1 COPYRIGHT

$self->{Copyright}

## end of test script file ##

=cut

EOF

}


sub AUTOLOAD
{
    our $AUTOLOAD;
    return undef if $AUTOLOAD =~ /DESTROY/;
    warn "Method $AUTOLOAD not supported by STD::Gen::STD";
    undef;
}


1

__END__


=head1 NOTES

=head2 Binding Requirements

In accordance with the License, Software Diamonds
is not liable for any requirement, binding or otherwise.

=head2 Author

The author, holder of the copyright and maintainer is

E<lt>support@SoftwareDiamonds.comE<gt>

=head2 Copyright

copyright � 2003 SoftwareDiamonds.com

=head2 License

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

=head1 SEE ALSO

L<Test|Test> 
L<Test::Harness|Test::Harness> 
L<tg|STD::t::tg>
L<STDtailor|STD::STDtailor>
L<STD|Military::STD>
L<SVD|Military::SVD>
L<DOD STD 490A|Military::STD490A>
L<DOD STD 2167A|Military::STD2167A>

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


### end of file ###

