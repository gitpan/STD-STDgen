#!perl
#
# Documentation, copyright and license is at the end of this file.
#

package  STD::STDgen;

use 5.001;
use strict;
use warnings;
use warnings::register;

use File::Glob ':glob';
use File::Spec;
use STD::TestUtil;
use Cwd;

use vars qw($VERSION $DATE);
$VERSION = '1.02';
$DATE = '2003/06/03';

########
# Inherit STD::FileGen
#
use STD::FileGen;
use vars qw(@ISA);
@ISA = qw(STD::FileGen);


sub extension { "-STD.pm" };

sub start
{
    my ($self) = @_;
    my $module = ref($self);
    my $module_db = $self->{$module};

    #####
    # Document wide initialization
    # 
    $module_db->{ok} = 1;
    $module_db->{Test_Descriptions} = '';
    $module_db->{trace_req} = {};
    $module_db->{trace_test} = {};

    $self->test_cleanup(); # test step cleanup
    $self->{STD_PACKAGE} = STD::TestUtil->fspec2pm($self->{File_Spec},  $self->{STD});
    $self->{STD_PM} = STD::TestUtil->fspec2pm($self->{File_Spec},  $self->{std} );
    $self->{UUT_PM} = STD::TestUtil->fspec2pm($self->{File_Spec},  $self->{UUT} );

    << "EOF"
#!perl
#
#
package $self->{STD_PACKAGE};

use 5.001;
use strict;
use warnings;
use warnings::register;

use vars qw(\$VERSION \$DATE);
\$VERSION = '0.01';   # automatically generated file
\$DATE = '$self->{Date}';

##### Software Test Description ####
#
# The module STD::TestGen generated this program module from the contents of
#
# $self->{std}
#
# Don't edit this program module file. Edit instead
#
# $self->{std}
#
#	ANY CHANGES MADE HERE TO THIS SCRIPT FILE WILL BE LOST
#
#       the next time STD::TestGen generates this program module file.
#
#

EOF

}


sub finish
{
    my ($self) = @_;
    my $module = ref($self);
    my $module_db = $self->{$module};

    ######
    # Build macro substitutes
    #
    $module_db->{Trace_Requirement_Table} = "No requirements specified.\n";
    if( $module_db->{trace_req} ) {
       $module_db->{Trace_Requirement_Table} = STD::TestUtil->format_hash_table( $module_db->{trace_req}, [64,64], ["Requirement", "Test"] );
       $module_db->{trace_req} = {};
    }

    $module_db->{Trace_Test_Table} = '';
    if( $module_db->{trace_test} ) {
       $module_db->{Trace_Test_Table} = STD::TestUtil->format_hash_table( $module_db->{trace_test}, [64,64], ["Test", "Requirement"] );
       $module_db->{trace_test} = {};
    }
    $module_db->{Test_Script} = $self->{Verify};
    $module_db->{Tests} = $module_db->{ok};    


    my $template = $self->{Template};
    unless( $template ) {
        warn "No STD template\n";
        return 0;
    }

    ($template) =  STD::TestUtil->find_in_path( $self->{File_Spec}, $template, 
               $self->{options}->{dir_path});

    unless( -e $template ) {
        warn "Cannot find STD template\n";
        return 0;
    }
    unless (open TEMPLATE, "< $template" ) {
        warn "Cannot open template file < $template\n";
        return 0;
    }
    $template = join '',<TEMPLATE>;
    close TEMPLATE;

    my @vars = qw(
      Test_Script Tests Test_Descriptions 
      Trace_Requirement_Table Trace_Test_Table);

    STD::TestUtil->replace_variables(\$template, $module_db, \@vars);

    @vars = qw(
      Date UUT_PM STD_PM Revision End_User Author Classification 
      SVD  See_Also Copyright);

    STD::TestUtil->replace_variables(\$template, $self, \@vars);

    $module_db->{ok} = 0;
    $module_db->{Test_Descriptions} = '';
    $module_db->{Trace_Test_Table} = '';
    $module_db->{Trace_Requirement_Table} = '';



    $template;

}


sub test_cleanup
{
    my ($self) = @_;
    my $module = ref($self);
    my $module_db = $self->{$module};
    $module_db->{stop} = 0;
    $module_db->{setup} = [];
    $module_db->{input} = '';
    $module_db->{expected} = [];
    $module_db->{skip}  = '';
    $module_db->{todo} = 0;
    $module_db->{name} = ''; 
    $module_db->{requirements} = [];
}


sub  T { '' };
sub VO { '' };

sub C
{
    my ($self, $command, $data) = @_;
    my $module = ref($self);

    $data =~ s/(.*?)\n*$/$1/sg;
    $data .= ';' if substr( $data, length($data)-1,1) ne ';';
    $data .= "\n";
    push @{$self->{$module}->{setup}}, $data;
    ''
}

sub R
{
    my ($self, $command, $data) = @_;
    my $module = ref($self);
    while( chomp $data ) {};
    my @data = split /(?:,|;|\n)+/, $data;
    push @{$self->{$module}->{requirements}}, @data;
    ''
}

sub S
{
    my ($self, $command, $data) = @_;
    my $module = ref($self);
    $self->{$module}->{skip} = $data;
    ''
}

sub U
{
    my ($self, $command, $data) = @_;
    my $module = ref($self);
    return '' if  $self->{$module}->{demo_only};
    $self->{$module}->{todo} = ($data) ? $data : 'Feature';
    ''
}


sub N
{
    my ($self, $command, $data) = @_;
    my $module = ref($self);
    $self->{$module}->{name} = $data;
    ''
}



sub A
{
    my ($self, $command, $data) = @_;
    my $module = ref($self);
    $self->{$module}->{input} = $data;
    ''
}


sub SE
{
    my ($self) = @_;
    my $module = ref($self);
    $self->{$module}->{stop}=1;
    E(@_);
}


sub E
{
    my ($self, $command, $data) = @_;
    my $module = ref($self);
    return '' if $self->{$module}->{demo_only};
    if( $self->{$module}->{skip} ) {
       $self->{$module}->{expected} = "Test skipped because the following evaluated true:\n\n $data";
       return ''; 
    }
    $self->{$module}->{expected} = $data;
    ''
}




sub ok 
{
    my ($self, $command, $test_num) = @_;
    my $module = ref($self);
    my $module_db = $self->{$module};

    $module_db->{ok} = $test_num;
    my $trace_req_p = $module_db->{trace_req};
    my $trace_test_p = $module_db->{trace_test};


    ######
    # Provide a link to this test for each data requirement
    # for later output of tracebility matrices. 
    #
    # Tracebility matrices are very important for bean counters
    # who do not understand the code.
    # 
    # 
    my $unique_test_id = sprintf "Test %03d", $test_num;
    $unique_test_id .= " - $module_db->{name}" if $module_db->{name} ;

    my $requirement;
    my @clean_requirement = ();
    my $std_pm = STD::TestUtil->fspec2pm($self->{File_Spec}, $self->{STD});
    foreach $requirement (@{$module_db->{requirements}}) {
        ($requirement) = $requirement =~ /^\s*(.*)\s*$/; # remove leading and tailing white space
        next unless $requirement;
        push @clean_requirement, $requirement;
      
        #####
        # Enter test into trace requirement matrix hash
        #
        $trace_req_p->{$requirement}->{"L<$std_pm/$unique_test_id>"} = 1;

        ######
        # Enter requirement into trace test matrix hash
        #  
        $trace_test_p->{"L<$std_pm/$unique_test_id>"}->{$requirement} = 1;
    }  

    my $requirements = join ', ', @clean_requirement;
    if($requirements) {
        while(chomp $requirements) {};
    }
    else {
        $requirements = 'None.' ;
    }

    my $setup = '';
    if(@{$module_db->{setup}}) {
        $setup = join '', @{$module_db->{setup}};
        if( $setup  ) {
            while(chomp $setup) {};
            $setup =~ s/(\n+)/$1 /g;     
        }
        ($setup) = $setup =~ /^\n*(.*)\n*$/s; # drop beginning trailing newlines
        $setup .= "\n";
    }

    my $input = $module_db->{input};
    while(chomp $input) {};
    $input =~ s/(\n+)/$1 /g;     

    my $stop='';
    $stop = "Skip rest of tests on failure. " if $module_db->{stop};

    my $todo = '';
    $todo = "Skip. $module_db->{todo} under development.\n\n" if $module_db->{todo};

    my $conditions = '';
    if( $stop || $todo ) {

        $conditions = <<"EOF";
=item $unique_test_id - Test procedure Conditions

$stop
$todo
EOF

    }

    my $expected = $module_db->{expected}; 
    $expected =~ s/(\n+)/$1 /g; # space tells POD code its code

    my $msg = << "EOF";

=head2 $unique_test_id

=over 4

=item $unique_test_id - Requirements addressed

$requirements

=item $unique_test_id - Test

 $setup$input

=item $unique_test_id - Expected Test Results

 $expected

$conditions

=back

=cut

EOF

    $self->test_cleanup();
    $module_db->{Test_Descriptions} .= $msg;  # save for template merge
    ''

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

copyright © 2003 SoftwareDiamonds.com

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

