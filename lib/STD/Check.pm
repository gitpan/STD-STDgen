#!perl
#
# Documentation, copyright and license is at the end of this file.
#
###########################

package  STD::Check;

use 5.001;
use strict;
use warnings;
use warnings::register;

use File::Spec;
use vars qw($VERSION $DATE);
use Cwd;
use STD::Tester;
use STD::TestUtil;

$VERSION = '1.03';
$DATE = '2003/06/04';

########
# Inherit STD::FileGen
#
use STD::FileGen;
use vars qw(@ISA);
@ISA = qw(STD::FileGen);

use vars qw(@required_data_base); 
@required_data_base = qw(
    File_Spec UUT Revision End_User Author
    SVD Template Classification Temp See_Also Copyright);

sub start
{

    my ($self) = @_;

    #########
    # Always lead off with a N and a T
    #
    my @test_db = ('T', '');
    my $module = ref($self);
    $self->{$module}->{test_db} =  \@test_db;
    $self->{$module}->{ok} = 1;
    $self->{$module}->{success} = 1;
    $self->{$module}->{todo} = [];
    $self->{$module}->{name} = '';

    ###########
    # use in variables without have to backslash escape the dollar sign
    # every which way in the below << here statement
    #   
    my ($__test__, $__restore_dir__) = ('$__test__', '$__restore_dir__');
    my ($vol, $dirs, $T) = ('$vol', '$dirs', '$T');

    << "EOF";
#!perl
#
#
use Cwd;
use File::Spec;
use STD::Tester;

BEGIN { 

   use vars qw(%__tests__ $__test__ $__restore_dir__);

   $__test__ = 0;
   %__tests__ = ();

   ########
   # Start a test with a new tester
   #
   $T = new STD::Tester( );

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

EOF


}

sub finish
{

   my ($self) = @_;

   my $module = ref($self);

   ########
   #  Fill in the number of test at the first instruction
   #
   $self->{$module}->{test_db}->[1] = $self->{$module}->{ok} - 1;
   if (@{$self->{$module}->{todo}}) {
       my $todo = join ',', @{$self->{$module}->{todo}};
       $self->{$module}->{test_db}->[1] .= " - $todo" ;
   }

   ######
   # Replace the std_db with the checked and cleaned test_db
   #
   $self->{std_db} = $self->{$module}->{test_db};
   $self->{$module}->{test_db} = undef;


   #######
   # Change the UUT and Temp file specs with so
   # directed by the fspec_out option and define
   # all required fields
   #
   $self->{File_Spec} = 'Unix' unless $self->{File_Spec};
   my $fspec_out = ($self->{options}->{fspec_out}) ? 
                  $self->{options}->{fspec_out} : $self->{File_Spec};

   my @required_data = @required_data_base;
   $self->{required_data} = \@required_data;
   foreach my $required (@required_data) {
       if( $self->{options}->{fspec_out} ) {

           if( $required eq 'UUT' || $required eq 'Template') {
               $self->{$required} = STD::TestUtil->fspec2fspec( 
                   $self->{File_Spec}, $self->{options}->{fspec_out},
                   $self->{$required} );
           }

       }   
       $self->{$required} = '' unless defined $self->{$required};
   }


   ######
   # Provide an default output file for all output generators
   #
   my @generators = STD::TestUtil->drivers( __FILE__, 'GenType' ); 
   my $package;
   foreach my $generator (@generators) {
       push @required_data, $generator;
       $package = "STD::GenType::" . $generator;
       if( $self->{options}->{file_out} ) {
           $self->{$package}->{file_out} = $self->{options}->{file_out};
           next;
       }
       if( !$self->{$generator} ) {
           $self->{$generator} = $self->{file};
           $self->{$generator} =~ s/\..*?$//; # drop extension
           STD::TestUtil->load_package( $package );
           $self->{$generator} .= $package->extension( );
       }
       elsif( $self->{options}->{fspec_out} ) {
           $self->{$generator} = STD::TestUtil->fspec2fspec( 
                   $self->{File_Spec}, $self->{options}->{fspec_out},
                   $self->{$generator} );
       }
       $self->{$package}->{file_out} = STD::TestUtil->fspec2os( 
                   $fspec_out, $self->{$generator});
   }


   #####
   # If not successful in the check, provide a diagnostic dump
   #
   unless( $self->{$module}->{success} ) {

       #######
       # Diagnostic dump
       #
       my $data_out;
       my $clean = new STD::GenType::Clean( $self );
       $clean->generate( );
       $clean->print( );

   }


   ######
   # Update the file specification
   #
   $self->{File_Spec} = $self->{options}->{fspec_out} if $self->{options}->{fspec_out};
   $self->{File_Spec} = 'Unix' unless $self->{File_Spec};
   
   << 'EOF';

   print "tests\n$__test__\n";

   foreach $__test__ (keys %__tests__) {
      print "$__test__\n$__tests__{$__test__}\n";
   }

EOF
}   


#######
# Ignore
#
sub ok { T(@_) }
sub T { '' }


#######
# These are test sections. Add to the test array,
#
sub DO
{ 
    my ($self, $command,$data) = @_;
    my $module = ref($self);
    push @{$self->{$module}->{test_db}}, ($command, $data);
    $self->{$module}->{demo_only} = "    $data";
   ''
}


sub  A 
{ 
    my ($self, $command, $data) = @_;
    my $module = ref($self);
    push @{$self->{$module}->{test_db}}, ($command, $data);
    if($self->{$module}->{demo_only}) {
        $self->{$module}->{demo_only} = '';
        $self->{$module}->{demo_only_expected} = 1;
        return '';
    }
    $self->{$module}->{demo_only_expected} = '';
    '' 
}


sub VO { R(@_) }
sub  N { R(@_) }
sub  S { R(@_) }
sub  R
{ 
    my ($self, $command, $data) = @_;
    my $module = ref($self);
    push @{$self->{$module}->{test_db}}, ($command, $data);
    '' 
};

sub C
{ 
    my ($self, $command, $data) = @_;
    my $module = ref($self);
    push @{$self->{$module}->{test_db}}, ($command, $data);

    ($data) = $data =~ /^\s*(.*)\s*$/s; # drop leading trailing white space

    my $last_char = substr( $data, length($data)-1,1);
   
    $data .= ';' if $last_char ne ';' && $last_char ne '{';

    << "EOF";
   # Perl code from ${command}:
$data

EOF
 
};

sub U 
{ 
    my ($self, $command, $data) = @_;
    my $module = ref($self);
    push @{$self->{$module}->{test_db}}, ($command, $data);
    push @{$self->{$module}->{todo}},$self->{$module}->{ok};
    ''
}


########
# Count the tests and provide results as a ok command, data pair
#
sub SE { E(@_) }
sub E
{
    my ($self, $command, $data) = @_;
    my $module = ref($self);
    push @{$self->{$module}->{test_db}}, ($command, $data);

    if($self->{$module}->{demo_only_expected}) {
        $self->{$module}->{demo_only_expected} = '';
        return '';
    }

    push @{$self->{$module}->{test_db}}, ('ok', $self->{$module}->{ok});
    
    $data = << "EOF";

    ######
    # ok $self->{$module}->{ok}
    #
    \$__test__++; 
    \$__tests__{ $self->{$module}->{ok} } .= "\$__test__,";    

EOF

    $self->{$module}->{ok}++;

    $data
}


sub AUTOLOAD
{
    our $AUTOLOAD;
    return '' if $AUTOLOAD =~ /DESTROY/;
    my ($self, $command, $data) = @_;
    return '' unless $command && $data;
    $self->{$command} = $data;
    '';
}



#####
#
# post print processing
#
sub post_print
{

    my ($self) = @_;
    my $module = ref($self);

    my $cwd = cwd();

    my @tests = `perl $self->{$module}->{file_out}`;
    return undef unless @tests;
    unlink $self->{$module}->{file_out} unless $self->{options}->{nounlink};
    foreach my $test (@tests) {
         chomp $test;
    }
    my %tests = @tests;

    #######
    # Now that have the test number(s) according to the
    # execution of the code, replace the original ok
    # ident with the one obtained from the code.
    #
    my $db_p = $self->{std_db};
    for( my $i=0; $i < @$db_p; $i += 2) {
        if( $db_p->[$i] eq 'ok' ) {
            $db_p->[$i+1] = $tests{$db_p->[$i+1]};  # test according to code
            $db_p->[$i+1] = substr($db_p->[$i+1],0,length($db_p->[$i+1])-1); # drop last ', '
        }
        elsif( $db_p->[$i] eq 'T' ) {
            my $todo = '';
            foreach my $t (  @{$self->{$module}->{todo}}  ) {
                $todo .= "$tests{$t}";
            }
            $db_p->[$i+1] = "$tests{tests}";
            if ($todo) {
                $todo = substr($todo,0,length($todo)-1); # drop last ', '
                $db_p->[$i+1] .= " - $todo" ;
            }
        }
    }

    1

}

1

__END__

=head1 NOTES

=head2 Author

The holder of the copyright and maintainer is

 E<lt>support@SoftwareDiamonds.comE<gt>

=head2 Copyright

Copyrighted (c) 2002 Software Diamonds

All Rights Reserved

=head2 Binding Requirements

Binding requirements are indexed with the
pharse 'shall[dd]' where dd is an unique number
for each header section.
This conforms to standard federal
government practices, 490A (L<STD490A/3.2.3.6>).
In accordance with the License, Software Diamonds
is not liable for any requirement, binding or otherwise.

=head2 License

Software Diamonds permits the redistribution
and use in source and binary forms, with or
without modification, provided that the 
following conditions are met: 

=over 4

=item 1

Redistributions of source code must retain
the above copyright notice, this list of
conditions and the following disclaimer. 

=item 2

Redistributions in binary form must 
reproduce the above copyright notice,
this list of conditions and the following 
disclaimer in the documentation and/or
other materials provided with the
distribution.

=back

SOFTWARE DIAMONDS PROVIDES THIS SOFTWARE 
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
<p><br>
<!-- BLK ID="HEALTH_PITCH_NOTEXT" -->
<!-- /BLK -->
<p><br>
<!-- BLK ID="OPT-IN" -->
<!-- /BLK -->
<p><br>
<!-- BLK ID="EMAIL" -->
<!-- /BLK -->
<p><br>
<!-- BLK ID="COPYRIGHT" -->
<!-- /BLK -->
<p><br>
<!-- BLK ID="LOG_CGI" -->
<!-- /BLK -->
<p><br>

=cut


### end of file ###

