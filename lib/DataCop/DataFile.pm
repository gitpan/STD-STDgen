#!perl
#
# The copyright notice and plain old documentation (POD)
# are at the end of this file.
#
# see POD documentation at end
#
package DataCop::DataFile;

use strict;
use warnings;
use warnings::register;
use 5.001;

use vars qw($VERSION $DATE);
$VERSION = '0.01';
$DATE = '2003/06/03';

########
# Create new FileType Format Parser
#
sub new
{
    my ($class, @args) = @_;

    $class = ref($class) if( ref($class) );

    ##########
    # Take care of the options
    #
    my $options_p = $args[0] if ref($args[0]);
    $options_p = { @args } unless( @args % 2 );
    $options_p = {}  unless ref($options_p);

    my $self = bless {}, $class;
    $self->{options} = $options_p;

    my $file = $self->{options}->{file};
    unless ( $file ) {
        $self->{fh} = '';
        return $self;
    }

    ######
    # Open the table file
    #    
    my $fh;
    my $flag = $self->{options}->{flag};
    $flag = '<' unless $flag;
    unless (open( $fh, "$flag $file" )) {
        warn "Cannot open table\n\t$file\n";
        return undef;
    }

    ########################
    # binary when reading or 
    # binary if reading, writing strict
    #
    binmode $fh if $flag =~ /</ || $self->{options}->{binary}; 

    ########
    # Establish the open values
    #
   
    $self->{fh} = $fh;
    $self;

}


#########
# Parse a record into a field harsh and an field array
#
sub get
{
    my ($self, $fields_ap, $record_p) = @_;
    unless( $fields_ap || $record_p) {
        warn( "No output ref supplied.\n");
        return undef;
    }

    ######
    #  Cannot use the below because Perl treats as read-only
    #
    #    $record_p = \'' unless( ref($record_p) eq 'SCALAR' );
    #
    unless( ref($record_p) eq 'SCALAR' ) {
        my $record = '';
       $record_p = \$record;
    }

    return undef unless $self->get_record($record_p);
    return undef unless $self->decode_record( $record_p );
    return undef unless $self->decode_field( $record_p, $fields_ap);

    1
}



#####
# 
#
sub put
{
    my ($self, $fields_ap, $record_p) = @_;

    unless( ref($record_p) eq 'SCALAR' ) {
        my $record = '';
       $record_p = \$record;
    }

    return undef unless $self->encode_field($fields_ap, $record_p);
    return undef unless $self->encode_record($record_p);
    return undef unless $self->put_record($record_p);

    1

}



#####
# Close the TextDB file.
#
sub finish
{
    my ($self) = @_;

    ##########
    # In order, to avoid closing a file  that has been closed, 
    # the $fh variable is used to determined if the file is closed.
    #
    if( my $fh = $self->{fh} ) {
        unless (close($fh)) {
            warn("Could not close\n\t$self->{options}->{'file'}\n");
            return 0;
        }
        $self->{fh} = undef;
    } 

    1;
}


1;


__END__


=head1 NAME
  
=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 REQUIREMENTS

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

### end of script  ######