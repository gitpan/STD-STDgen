#!perl
#
# Documentation, copyright and license is at the end of this file.
#
###########################

package  STD::GenType::Clean;

use 5.001;
use strict;
use warnings;
use warnings::register;

use DataCop::FileType::FormDB;

use vars qw($VERSION $DATE);
$VERSION = '1.02';
$DATE = '2003/06/03';

########
# Inherit STD::FileGen
#
use STD::FileGen;
use vars qw(@ISA);
@ISA = qw(STD::FileGen);


sub extension { ".std" };

sub start
{
    my ($self) = @_;
    my $module = ref($self);
     
    my $dbh = new  DataCop::FileType::FormDB();

    my $fields = "\n\n\n";
    foreach my $item (@{$self->{required_data}}) {
        next if $item eq 'Copyright' || $item eq 'See_Also';
        $dbh->encode_field( [$item, $self->{$item}], \$fields);
    }
    $fields .= "\n\n";
    $self->{$module}->{fields} = $fields;
    $self->{$module}->{dbh} = $dbh;
    ''
} 

sub finish
{
    my ($self) = @_;
    my $module = ref($self);

    my $dbh = $self->{$module}->{dbh};
            
    my $fields = "\n\n\n";
    $dbh->encode_field( ['See_Also', $self->{'See_Also'}], \$fields );
    $dbh->encode_field( ['Copyright', $self->{'Copyright'}], \$fields );
    $fields  .= "\n\n\n";
    $fields  = $self->{$module}->{fields} . $fields;
    $self->{$module}->{fields} = '';
    my $record = '';  
    $dbh->encode_record(\$fields, \$record);
    $dbh->finish();
    $record 
}


AUTOLOAD
{
    our $AUTOLOAD;
    return '' if $AUTOLOAD =~ /DESTROY/;

    my ($self, $command, $data) = @_;
    my $module = ref($self);

    my $precision   = $self->{precision};
    $precision = 2 unless $precision;
    $command = sprintf("%${precision}s", $command);
    my $field = '';
    $self->{$module}->{dbh}->encode_field( [$command, $data], \$field );            
    $field .= "\n" if ($command =~ /\s*ok\s*/ | $command =~ /\s*T\s*/);
    $self->{$module}->{fields} .= $field;
    ''
}

1

__END__


=head1 AUTHOR

The holder of the copyright and maintainer is

 E<lt>support@SoftwareDiamonds.comE<gt>

=head2 COPYRIGHT NOTICE

Copyrighted (c) 2002 Software Diamonds

All Rights Reserved

=head2 BINDING REQUIREMENTS NOTICE

Binding requirements are indexed with the
pharse 'shall[dd]' where dd is an unique number
for each header section.
This conforms to standard federal
government practices, 490A (L<STD490A/3.2.3.6>).
In accordance with the License, Software Diamonds
is not liable for any requirement, binding or otherwise.

=head2 LICENSE

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

