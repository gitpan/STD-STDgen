#!perl
#
# The copyright notice and plain old documentation (POD)
# are at the end of this file.
#
# see POD documentation at end
#
package DataCop::DataFileI;

use strict;
use warnings;
use warnings::register;
use 5.001;


use vars qw($VERSION $DATE);
$VERSION = '0.01';
$DATE = '2003/06/03';

use DataCop::DataFile;
use vars qw(@ISA);
@ISA = qw(DataCop::DataFile);


###########
###########
# 
# The following code is the field encoding and decoding layer
#
##########
##########

#####
# These are fixed, since there is a very simple
# way to escape them.
#
use vars qw($EOF $EOL);
$EOF = ":";
$EOL = "^";

#####
# 
# encodes a field 
#
#
sub encode_field
{
    my ($self, $fields_ap, $fields_sp) = @_;
 
   return undef unless( $fields_sp && ref($fields_ap));

    $$fields_sp .= "encode_field\n";

    my( $name, $data );
    for( my $i=0; $i < @$fields_ap; $i += 2) {
        ($name, $data) = ($fields_ap->[$i], $fields_ap->[$i+1]);   
        $$fields_sp .= "$name\n$data\n";
    }
    my $options_p = $self->{options};
    foreach my $key (sort keys %$options_p ) {
        $$fields_sp .= "option $key => $options_p->{$key}\n";
    }
    1
}


##########
# Parse a email record into a field harsh
#
sub decode_field
{ 
    my ($self, $fields_sp, $fields_ap) = @_;

    return undef unless( $fields_sp && $$fields_sp && ref($fields_ap));

    ##########
    # Place the fields in the db into a hash, %$record,
    # where the field name is the hash key.
    # 
    @$fields_ap = ('fields', $$fields_sp);
    my $options_p = $self->{options};
    foreach my $key (sort keys %$options_p ) {
        push @$fields_ap, ("$key", $options_p->{$key});
    }
    $fields_ap = push @$fields_ap, ('subroutine', 'decode_field');
 
    1;

}



###########
###########
# 
# The following code is the record encoding and decoding layer
#
##########
##########


#########
# This function gets the next record from
# the file and unescapes the record separator
#
sub get_record
{
    my ($self, $record_p) = @_;

        
 
    my ($fh) = $self->{fh};
    $$record_p = <$fh>;
    return undef unless $$record_p;
   
    my $options_p = $self->{options};
    foreach my $key (sort keys %$options_p ) {
        $$record_p .= "$key => $options_p->{$key}\n";
    }
    $$record_p .= "get_record\n";

    1

} # end get_rec


#########
# This function un escapes the record separator
#
sub decode_record
{
    my ($self, $record_p, $fields_sp) = @_;

    return undef unless $record_p;

    ###############
    # If $fields_sp and $record_p are the same, there
    # will not be any new copy for $fields_sp and
    # the $$record_p will not be perserved. It
    # is one and the same as the $$fields_sp string
    # and will be converted to the $$fields_sp string
    #
    if(!$fields_sp) {
        $fields_sp = $record_p;
    }
    elsif($record_p ne $fields_sp) {
        $$fields_sp = $$record_p;
    }

    $$fields_sp = "$$record_p\n";

    #######
    # Unless in strict mode, change CR and LF
    # to end of line string for current operating system
    #
    unless( $self->{options}->{binary} ) {
        $$fields_sp =~ s/\015\012|\012\015/\012/g;  # replace LFCR or CRLF with a LF
        $$fields_sp =~ s/\012|\015/\n/g;   # replace CR or LF with logical \n 
    }

    my $options_p = $self->{options};
    foreach my $key (sort keys %$options_p ) {
        $$fields_sp .= "$key => $options_p->{$key}\n";
    }
    $$fields_sp .= "decode_record\n";


    1
}


#############
# encode the record
#
sub encode_record
{
    my ($self, $fields_sp, $record_p) = @_;

    return undef unless $fields_sp;

    ###############
    # If $record_p and are $fields_sp the same, there
    # will not be any new copy for $fields_sp and
    # the $fields_sp will not be perserved. It
    # is one and the same as the $record_p string
    # and will be converted to the $record_p string
    #
    if(!$record_p) {
        $record_p = $fields_sp;
    }
    elsif($record_p ne $fields_sp) {
        $$record_p = $$fields_sp;
    }

    $$record_p = "encode_record\n$$fields_sp\n";
    my $options_p = $self->{options};
    foreach my $key (sort keys %$options_p ) {
        $$record_p .= "option $key => $options_p->{$key}\n";
    }

   

    1

} # end encode_rec


#######
# encode and append the record to the file 
#
sub put_record
{

    my ($self, $record_p) = @_;

    my ($fh) = $self->{fh};
    print $fh "put_record\n$$record_p\n~-~\n";

} # end put_rec




1;


__END__

=head1 NAME

DataCop::FileType::FormDB - access text database file in a field variable pair format

=head1 SYNOPSIS

 use DatatCop::FileType::FormDB

 $success  = $tdb_in->get_record(\$record)
 $success  = $tdb->decode_record(\$record, \$fields) 
 $success  = $tdb->decode_field(\$fields, \@fields)

 $success  = $tdb->encode_field (\@fields,\$fields)
 $success  = $tdb->encode_record($fields, \$record) 
 $success  = $tdb_out->put_record(\$record) 

 $success  = $tdb->decode_record(\$record) 
 $success  = $tdb->decode_field(\$record, \@fields)

 $success  = $tdb->encode_field (\@fields,\$record)
 $success  = $tdb->encode_record(\$record) 

 Inherited: L<DataCop::FileData SYNOPSIS|DataCop::FileData/SYNOPSIS>

 $tdb      = new DatatCop::FileType::FormDB(@options);
 $tdb_in   = new DatatCop::FileType::FormDB(flag=>'<', file=>$file, @options);
 $tdb_out  = new DatatCop::FileType::FormDB(flag=>'>', file=>$file, @options);

 $success  = $tdb->finish()

=head1 DESCRIPTION

The C<DataCop::t::DataDBI> module provides 
test stub for the L<DataCop::FileData|DataCop::FileData> interface
to the modules in C<DataCop::FileType>.
The requirement is that it records the method and the parameters
use by the L<DataCop::FileData|DataCop::FileData> module during
it tests.
The tests will take this record of data usage and determine
if the L<DataCop::FileData|DataCop::FileData> module is meeting
its requirements.

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

L<DataCopy::DataFile>
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

### end of script  ######