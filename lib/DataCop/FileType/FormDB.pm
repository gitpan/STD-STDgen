#!perl
#
# The copyright notice and plain old documentation (POD)
# are at the end of this file.
#
# see POD documentation at end
#
package DataCop::FileType::FormDB;

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

    my( $name, $data );
    for( my $i=0; $i < @$fields_ap; $i += 2) {

        ($name, $data) = ($fields_ap->[$i], $fields_ap->[$i+1]);

        if( $name =~ /[\x00-\x1f]/ ) {
            $name =~ s/[\x00-\x1f]/*/g;
            warn( "The field name contains ASCII control characters:\n\t$name" );
            return '';
        }
 
        $data = '' unless defined $data;  # handle undefs as empty strings 

        ######
        # Escape the $EOF character by adding one more character
        #    
        $name =~ s/(\:+)/:$1/g;

        ######
        # need space to escape $EOF. The space will not become part of the field 
        # The space will be stripped because leading and trailing spaces are not allowed.
        $name .= ' ' if substr( $name, -1, 1) eq $EOF; 

        #######
        # Use single line field encoding or multiple line encoding
        #
        my $field;
        if( ($data !~ /[\x00-\x1f]/) && (length($data) + length($name) < 120) ) {
            $field = "$name${EOF} $data";
            $field =~ s/(\^+)/\^$1/g;  # escape $EOL by adding one more
       
            #########
            # In strict mode the character in front of the $EOL is part of
            # the sequence and will not become part of field
            #  
            if( $self->{options}->{strict} ) {
                $field .= ' ';
            }
            else {

                ##########
                # need space to escape $EOL, however the space will become part of the field
                # This makes the lenient format ambiguous as to whether the space should
                # or should not be part of the field data
                # 
                $field .= ' ' if substr($field, -1, 1) eq $EOL; 

            } 
            $$fields_sp .= "$field${EOL}\n" # single line encoding
        }
        else {
            $field = "$name${EOF}\n$data";
            $field =~ s/(\^+)/\^$1/g;    # escape $EOL by adding one more
            $$fields_sp .= "\n$field\n${EOL}\n\n"; # multiple line encoding
        }

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

    #######
    # Try to patch up where there is no last field delimiting [^\^]\^[^\^]
    #
    $$fields_sp =~ s/[ \x00-\x1f]*$//;  # drop trailing white space
    unless( $$fields_sp =~ /[^\^]\^$/ ) {
        $$fields_sp .= ' ' unless ( $$fields_sp =~ /\^$/ );        
        $$fields_sp .= '^';
    }
    $$fields_sp .= "\n";
 
    #########
    # The ending negated : and begining negated ^ cannot be the same character
    # for generic simple decode statement to work, so insert a space for 
    # the ending negated :
    #
    $$fields_sp =~ s/([^:]:)(\^[^\^])/$1  $2/g; 
    $$fields_sp =~ s/([^:]:)([^:\^]\^[^\^])/$1 $2/g; 
    if( $self->{options}->{strict} ) {
        (@$fields_ap) = $$fields_sp =~  /(.*?[^:]):[^:](.*?)[^\^]\^[^\^]/sg;
    }
    else {
        (@$fields_ap) = $$fields_sp =~  /(.*?[^:]):[^:](.*?[^\^])\^[^\^]/sg;

    }
    for( my $i=0; $i < @$fields_ap; $i += 2 ) {

        $fields_ap->[$i] =~ s/:(:+)/$1/g;        # unescape EOF
        $fields_ap->[$i] =~ s/\^(\^+)/$1/g;      # unescape EOL
        $fields_ap->[$i+1] =~ s/\^(\^+)/$1/g;    # unescape EOL

        ######
        # Could keep picking up \n as part of negated separation char in lenient format
        $fields_ap->[$i+1] =~ s/^[\012\015]*(.*?)[ \x00-\x1f]*$/$1/s unless $self->{options}->{strict};

        ##### 
        # no leading or trailing white space, ASCII controls characters allowed in field names
        $fields_ap->[$i] =~ s/^[ \x00-\x1f]*(.*?)[ \x00-\x1f]*$/$1/; 
        $fields_ap->[$i] =~ s/[\x00-\x1f]/_/g; # no ASCII control characters in name

    }
 
    1;
}



###########
###########
# 
# The following code is the record encoding and decoding layer
#
##########
##########


######
# This is the record seperator
#
use vars qw($REC_SEP);
$REC_SEP = "~-~";

#########
# This function gets the next record from
# the file and unescapes the record separator
#
sub get_record
{
    my ($self, $record_p) = @_;

    local($/);
    $/ = $REC_SEP;

    #####
    # get the record
    #
    my ($fh) = $self->{fh};
    
    $$record_p = <$fh>;
    
    return (undef) unless( $$record_p );

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

    $$fields_sp =~ s/$REC_SEP$//;

    ####### 
    # unescape $REC_SEP by taking away one - .
    #
    # "~--~"  => "~-~"
    # "~---~  => "~--~"
    # "~----~ => "~---~"
    #
    $$fields_sp =~ s/~-(-+)~/~$1~/g;

    #######
    # Unless in strict mode, change CR and LF
    # to end of line string for current operating system
    #
    unless( $self->{options}->{binary} ) {
        $$fields_sp =~ s/\015\012|\012\015/\012/g;  # replace LFCR or CRLF with a LF
        $$fields_sp =~ s/\012|\015/\n/g;   # replace CR or LF with logical \n 
    }

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
    
    ####### 
    # escape $REC_SEP by adding one more .
    #
    # "~-~" => "~--~"
    # "~--~ => "~---~"
    # "~---~ => "~----~"
    #
    # Thus, the record will never contain the
    # record separator sequence.
    # 
    # ~-~n
    #
    $$record_p =~ s/~(-+)~/~-$1~/g;  
    $$record_p .= "\n" if($$record_p =~ /[\n\r]/ && substr($$record_p, -1) ne "\n");
    $$record_p .= ${REC_SEP};
    $$record_p .= "\n";

    1

} # end encode_rec


#######
# append the record to the file 
#
sub put_record
{
    my ($self, $record_p) = @_;

    unless( $self->{options}->{file} ) {
       print $$record_p;
       return 1;
    }

    my ($fh) = $self->{fh};
    return undef unless $fh;

    print $fh $$record_p;

    1;

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

The C<DataCop::FileType::FormDB> module provides a text database file
suitable for local data such as private mailing lists.
The C<DataCop::FileType::FormDB> cannot provide a data warehouse shared
by mulitple users.

=head2 File format description

Desireable goals for small local private databases file format are as follows:

=over 4

=item *

The database is a text file that can be edited with a simple text editor.
How many times have a basebase been corrupted and the data
cannot be recoveried? For most people many times.
One time is one time too many

=item *

The text format resembles as much as possible the standard
forms that all civilized people must from time to time fill
out in order to survive in a civilized society.
Forms are a necessary evil in the
pursue of happiness, freedom and prosperity
in a civilized society.
An example of a form is as follows:

  manhood length: ________
  time spent in big house: _________
  what drugs do you use: _________

Notice the applicant is not required to specify the
form data using Perl hash notation such as

  manhood_length => 2

By the way, that would be your entry. My entry would be

  manhood_length => 22

The political incorrect NH live free or die response would be

  manhood length: come up to my place and I'll show you
  time spent in big house: none of your business
  what drugs do you use: put it where the sun doesn't shine

The feds response to NH: no federal funding.
  
=item *

The record separator, field separator and any other
separator is unique and not embedded in the data.
With unique separators, various components of the
database may be accessed with simple file read and
write functions. 
There is no need to buffer and process the data to determine
if the separator is really a separtor or part of
the data.

=item *

The format has simple, straightforward method of escaping separators
when they are embedded in the data.  
Escape techiques such as the back-slash besides
causing blurred vision also leave the separator
embedded in the data. 
Try looking at the output of the metachar() function
and then try to read a eye chart.
This is totally unacceptable not only because it impairs
vision but also for poor computation performance.

=back

The L<DataCopy::FileType::FormDB|DataCopy::FileType::FormDB>
solution is to use separators of the following form:

 (not_the_char) . (char) . (not_the_char)

The separators are escaped in embedded text by
adding a extra (char) as follows:

 sequence             escaped

 [^$c]$c[^c]          [^$c]$c$c[^c]
 [^$c]$c$c[^c]        [^$c]$c$c$c[^c]

                 ...

 [^$c]$c x n[^c]      [^$c]$c($c x n)[^c]


=head2 Methods description

This package inherits most of its methods from the
L<C<DataCop::DataFile>|DataCop::DataFile> package.
The methods specific to this package are to encode
and decode fields and records, and to put and get
records as follows:

=over 4

=item encode_field method

The encode_field method method takes a \@decode and
returns an unencoded record \$record string. 
This method will escape all field separators.

=item decode_field method

The decode_field method takes a decoded record string, \$record,
unescape the field separators, decodes the fields and places
the results in \@fields. 
For the decoded array, the even array elements are the
field names and the following odd array element is the
field data.

The below code will convert the decoded @fields to a hash:

  %fields = @fields

=item encode_record method

The encode_record method takes a \$record string of concatenated
fields and encodes it as a record. This method escapes the
record separator and embeds the record separate in the \$record
string.  
In the process, this method will modify the orginal contents of \$record.

=item decode_record method

The decode_record method takes a \$record string, removes the record
separator,  unescapes the record separator in the fields string
and leaves the fields string in \$record.
In the process, this method will modify the orginal contents of \$record.

=item put_record

The put_record method writes a fully encoded \$record out to the
file specified when the object was created.

=item get_record

The get_record method reads a fully encoded \$record from the
file specified when the object was created.

=back


The <DataCop::FileType::FormDB|DataCop::FileType::FormDB>
inherits all the methods from the 
L<DataCop::DataFile Description|DataCop::DataFile/Description>.

The description of the rest of the methods are in accordance with 
L<DataCop::DataFile Description|DataCop::DataFile/Description>.

=head1 REQUIREMENTS

The general C<STD::TestGen> Perl module requirements are as follows:

=over 4

=item general [1] - load 

shall[1] load without error and

=item general [2] - pod check  

shall[2] passed the L<Pod::Checker|Pod::Checker> check
without error.

=back

=head2 File format requirements

For most databases, the file format is hidden.
In this case, since the file may be accessed and
edited by any text editor, the file format requirements
must be rigorously established in order that
they may be properly edited.

The C<DataCop::FileType::FormDB> module file 
format will be as follows:

 $field_name: $field_data ^

      ...

 $field_name: $field_data ^
 ~-~

     ...

 ~-~
 $field_name: $field_data ^

      ...

 $field_name: $field_data ^
 ~-~

The requirements for the file format are as follows:

=over 4

=item format [1] - separator strings

The format separator strings shall[1] be as follows:

 End of Field Name (EON):  [^:]:[^:]
 ENd of Field Data (EOD):  [^\^]\^[^\^]
 End of Record(EOR):  ~-~

The separator strings have the following format:

 (not_the_char) . (char) . (not_the_char)

The '^' character was and still available in console
text editors as a cursor. 
Because it appears very rarely in text, 
it is a good choice for use in a separator string.
If it does not appear a lot, it will not have to
be escaped a lot.
The "~-~" separator sequence is a natural looking 
text section separator.

=item format [2] - separator escapes

Separator strings embedded in $field_name and $field_data
strings shall[2] be escaped by adding one additional
middle character.
Escaped sequences must also be escaped. 
An escaped separator sequence will always have one additional
middle character from an unescaped separator sequence.

=item format [3] - field names

The characters [\x00-\x1f] shall[3] not be allowed in $field_name
strings. Spaces will be allowed. 
The character set [\x00-\x1f] are the ASCII control characters.
See ascii.computerdiamonds.com.
Embedded [\x00-\x1f] characters will be converted to
the '_' character. 

=item format [4] - field names

Leading and trailing [ \x00-\x1f] characters in any potential
$field_name string shall[4] not be part of the $field_name 
and discarded.

=item format [5] - EON

A leading [^:] in the EON separator
that is not a [ \x00-\x1f] shall[5] be the be the last character
in the $field_name string;
otherwise, it is not part of the the $field_name string
and discarded.
For the situation where the last part of a $field_name string 
is an escape sequence a [ \x00-\x1f] will be required between
the $field_name string and the EON. 
The following is a valid $field_name EON sequence:

  escaped              unescaped

  field_name:: :       fieldname:

=item format [6] - Strict EOD

For the strict format option, the leading [^\^] of the EOD shall[6]
not be part of the $field_data. The [^\^] character may be any
character including the [\x00-\x1f] characters.

Examples of strict format option are as follows:

 $field_name: $data ^
 $field_name: $data$c^

 $field_name: 
 line1
   ..
 line2
 ^

The $field_data for the above example is as follows:

 Example               $field_data   

 "$data ^"             "$data"  
 "$data$c^"            "$data"
 "$line1\n$line2\n^"   "$line1\n$line2"

=item format [7] - Lenient EOD

For the lenient format option, the leading [^\^] of the EOD shall[7]
be part of the $field_data.
The lenient format has ambiguous case when the last character in the
$field_data is the [\^] character. 
In order to be valid, a [^\^] must be used before the [\^],
making the [^\^] part of the $field_data whether that is intended
or not. 
For example in, "$data^^ ^", the $field_data is "$data^ " whether
or not the space is intended as part of the $field_data.
If this cannot be tolerated for an application the strict format
opion should be specified.

Examples of lenient format option are as follows:

 $field_name: $data1 ^

 $field_name: $data2^

 $field_name: 
 $line1
 $line2
 ^

The $field_data for the above example is as follows:

 Example               $field_data   

 "$data1 ^"            "$data1 "  
 "$data2^"             "$data2"
 "$line1\n$line2\n^"   "$line1\n$line2\n"

=back

=head2 Methods requirements

There are two options, that impact the methodsas
follows:

=over 4

=item strict => 1 option

This option determines whether to encode a
field in strict or lenient format.

=item binary => 1 option

This option determines whether or not to
process carriage returns and line feeds.
Different operating systems handle these
characters differently for text files.

=back

The options are established as follows:

 $tdb = new DataCop::FileType::FormDB new ($flag, $file, {binary=>1, strict=>1})

The new method is inherited from 
L<DataCop::DataFile|DataCop::DataFile>.
The $tdb object passes the options hash
reference to all $tdb methods as 

 $tdb->{options}

The requirements for the methods are as follows:

=over 4

=item methods [1] - encode_field

 $field = $tdb->encode_field (\@fields, \$fields)

The @fields array will contain a number of fields.
The $field_names will be the even elements and
the $field_data the following odd elements.

The encode_field subroutine shall[1] encode the $field_name string and
$field_data string into the $field string in accordance with the
L<File Format requirements|DataCop::FileType::FormDB/File Format>.
The encoding shall escape the EON and EOD separators and embed
the EON and EOD separators. 

The encoding will be conservative in complying
with the L<File Format requirements|DataCop::FileType::FormDB/File Format>.

As established by the
L<File Format requirements|DataCop::FileType::FormDB/File Format>,
the encoding will be different depending upon the
value of the strict option, $tdb->{options}->{strict}.

=item methods [2] - decode_field

 $success = $tdb->decode_field(\$fields, \@fields)

The decode_field subroutine shall[2] decode a $record string 
into the @fields array
in accordance with the
L<File Format requirements|DataCop::FileType::FormDB/File Format>.
The $field_names will be the even elements in the @fields array and
the $field_data the following odd elements.

The decoding will be liberal what it considers that complies to
the L<File Format requirements|DataCop::FileType::FormDB/File Format>.

As established by the
L<File Format requirements|DataCop::FileType::FormDB/File Format>,
the decoding will be different depending upon the
value of the strict option, $tdb->{options}->{strict}.

=item methods [3] - encode_record

 $success = $tdb->encode_record(\$fields, \$record) 
 $success = $tdb->encode_record( \$fields) 

The encode_record subroutine shall[3] encode the $fields string 
into the $record string in accordance with
L<File Format requirements|DataCop::FileType::FormDB/File Format>.
If the $record string is absence or the \$record reference
and the \$fields reference are the same, 
the encoding will modify the \$fields string.
In this case, the encoding will not
perserve the $fields string.
The encoding will escape the EOR and embed the EOR.

=item methods [4] - decode_record

 $success  = $tdb->decode_record(\$record, \$fields) 
 $success  = $tdb->decode_record(\$record) 

The decode_record subroutine shall[4] decode the $record string and
into the $fields string in accordance with the
L<File Format requirements|DataCop::FileType::FormDB/File Format>.
If the $fields string is absence or the \$record reference
and the \$fields reference are the same, 
the encoding will modify the \$record string.
In this case, the encoding will not
perserve the $record string.
The decoding will remove the EOR and unescape the EOR.

=item methods [5] - put_record

 $success = $tdb_out->put_record( \$record )

The put_record subroutine shall[5] write out the $record to the
file specified when the object $tdb_out was created with
the following statement

 $tdb_out = DataCop::FileType::FormDB( flag => '>', file => $file, @options );

=item methods [6] - get_record

 $success = $tdb_in->get_record( \$record )

The get_record subroutine shall[6] read a $record from the
file specified when the object $tdb_in was created with
the following statement

 $tdb_in = DataCop::FileType::FormDB( flag => '<', file=>$file, @options );

=item methods [7] - get_record

Unless $tdb_in was created with the binary option, {binary => 1},
the get_record subroutine shall[7] translate any "\015\012"
combination into the "\n" for the current operating system.

=item DataCop::DataFile

The methods inherit from
L<DataCop::DataFile|DataCop::DataFile>
will comply to the
L<DataCop::DataFile requirements|DataCop::DataFile/REQUIREMENTS>

=back

=head1 DEMONSTRATION

 ~~~~~~ Demonstration overview ~~~~~

Perl code begins with the prompt

 =>

The selected results from executing the Perl Code 
follow on the next lines. For example,

 => 2 + 2
 4

 ~~~~~~ The demonstration follows ~~~~~

 => $T->fin( 'FormDB0.tdb' )
 '

 UUT: File/Version.pm^
 File_Spec:  ^
 Revision: ^
 End_User:^

 Copyright:
 copyright © 2003 Software Diamonds.

 Software Diamonds permits unlimited redistribution
 and use in source and binary forms, with or
 without modification.
 ^

 Author: http://www.SoftwareDiamonds.com support@SoftwareDiamonds.com^
 SVD: SVD::DataCop-DataFile^
 Template: STD/STD001.frm^

 ~-~

 Email: nobody@hotmail.com^
 Form: Udo-fully processed oils^
 Tutorial: *~~* Better Health thru Biochemistry *~~*^
 REMOTE_ADDR: 213.158.186.150^
 HTTP_USER_AGENT: Mozilla/4.0 (compatible; MSIE 5.0; Windows 98; DigExt)^
 HTTP_REFERER: http://computerdiamonds.com/^

 ~-~

 EOF: \n^  EOL: \n^^\n^ EOV: }^ SOV: ${^ ~-~
 EOF: ^^ ^ EOL: ~--~^   SOV: ${^ EOV: }~-~
 EOF: ^^^ ^ EOL: ~----~^   SOV: ${^  EOV: }

 '

 =>     #######
 =>     # Test the lenient format.
 =>     #
 =>     unlink 'FormDBa1.tdb';
 =>     unlink 'FormDBr1.txt';
 =>     unlink 'FormDBa1.txt';

 =>     my $dbh_in = new DataCop::FileType::FormDB(flag=>'<', file=>'FormDB0.tdb');
 =>     my $dbh_out = new DataCop::FileType::FormDB(flag=>'>', file=>'FormDBa1.tdb');

 =>     my ($$record_p, $$fields_p) = ('','');
 =>     my $array_p = [];

 =>     while( $dbh_in->get_record($record_p) ) {
 =>         $dbh_in->decode_record($record_p,$fields_p);
 =>         $T->fout( 'FormDBr1.txt',$$fields_p . "\n~-~\n", {append=>1} );
 =>         $dbh_in->decode_field($fields_p, $array_p);
 =>         $T->fout( 'FormDBa1.txt',join("\n",@$array_p) . "\n~-~\n", {append=>1});

 =>         ($$record_p, $$fields_p) = ('','');
 =>         $dbh_out->encode_field( $array_p, $fields_p );
 =>         $dbh_out->encode_record( $fields_p, $record_p);
 =>         $dbh_out->put_record($record_p);
 =>         ($$record_p, $$fields_p) = ('','');
 =>     }

 =>     $dbh_out->finish();
 =>     $dbh_in->finish();
 => $T->fin('FormDBr1.txt')
 '

 UUT: File/Version.pm^
 File_Spec:  ^
 Revision: ^
 End_User:^

 Copyright:
 copyright © 2003 Software Diamonds.

 Software Diamonds permits unlimited redistribution
 and use in source and binary forms, with or
 without modification.
 ^

 Author: http://www.SoftwareDiamonds.com support@SoftwareDiamonds.com^
 SVD: SVD::DataCop-DataFile^
 Template: STD/STD001.frm^

 ~-~

 Email: nobody@hotmail.com^
 Form: Udo-fully processed oils^
 Tutorial: *~~* Better Health thru Biochemistry *~~*^
 REMOTE_ADDR: 213.158.186.150^
 HTTP_USER_AGENT: Mozilla/4.0 (compatible; MSIE 5.0; Windows 98; DigExt)^
 HTTP_REFERER: http://computerdiamonds.com/^

 ~-~

 EOF: \n^  EOL: \n^^\n^ EOV: }^ SOV: ${^ 
 ~-~

 EOF: ^^ ^ EOL: ~-~^   SOV: ${^ EOV: }
 ~-~

 EOF: ^^^ ^ EOL: ~---~^   SOV: ${^  EOV: }

 ~-~
 '

 => $T->fin('FormDBa1.txt')
 'UUT
 File/Version.pm
 File_Spec

 Revision

 End_User

 Copyright
 copyright © 2003 Software Diamonds.

 Software Diamonds permits unlimited redistribution
 and use in source and binary forms, with or
 without modification.
 Author
 http://www.SoftwareDiamonds.com support@SoftwareDiamonds.com
 SVD
 SVD::DataCop-DataFile
 Template
 STD/STD001.frm
 ~-~
 Email
 nobody@hotmail.com
 Form
 Udo-fully processed oils
 Tutorial
 *~~* Better Health thru Biochemistry *~~*
 REMOTE_ADDR
 213.158.186.150
 HTTP_USER_AGENT
 Mozilla/4.0 (compatible; MSIE 5.0; Windows 98; DigExt)
 HTTP_REFERER
 http://computerdiamonds.com/
 ~-~
 EOF
 \n
 EOL
 \n^\n
 EOV
 }
 SOV
 ${
 ~-~
 EOF
 ^
 EOL
 ~-~
 SOV
 ${
 EOV
 }
 ~-~
 EOF
 ^^
 EOL
 ~---~
 SOV
 ${
 EOV
 }
 ~-~
 '

 => $T->fin('FormDBa1.tdb')
 'UUT: File/Version.pm^
 File_Spec: ^
 Revision: ^
 End_User: ^

 Copyright:
 copyright © 2003 Software Diamonds.

 Software Diamonds permits unlimited redistribution
 and use in source and binary forms, with or
 without modification.
 ^

 Author: http://www.SoftwareDiamonds.com support@SoftwareDiamonds.com^
 SVD: SVD::DataCop-DataFile^
 Template: STD/STD001.frm^
 ~-~
 Email: nobody@hotmail.com^
 Form: Udo-fully processed oils^
 Tutorial: *~~* Better Health thru Biochemistry *~~*^
 REMOTE_ADDR: 213.158.186.150^
 HTTP_USER_AGENT: Mozilla/4.0 (compatible; MSIE 5.0; Windows 98; DigExt)^
 HTTP_REFERER: http://computerdiamonds.com/^
 ~-~
 EOF: \n^
 EOL: \n^^\n^
 EOV: }^
 SOV: ${^
 ~-~
 EOF: ^^ ^
 EOL: ~--~^
 SOV: ${^
 EOV: }^
 ~-~
 EOF: ^^^ ^
 EOL: ~----~^
 SOV: ${^
 EOV: }^
 ~-~
 '

 => $T->fin( 'FormDBs0.tdb' )
 '

 UUT: File/Version.pm ^
 File_Spec:  ^
 Revision: ^
 End_User:^

 Copyright:
 copyright © 2003 Software Diamonds.

 Software Diamonds permits unlimited redistribution
 and use in source and binary forms, with or
 without modification.
 ^

 Author: http://www.SoftwareDiamonds.com support@SoftwareDiamonds.com ^
 SVD: SVD::DataCop-DataFile ^
 Template: STD/STD001.frm ^

 ~-~

 Email: nobody@hotmail.com ^
 Form: Udo-fully processed oils ^
 Tutorial: *~~* Better Health thru Biochemistry *~~* ^
 REMOTE_ADDR: 213.158.186.150 ^
 HTTP_USER_AGENT: Mozilla/4.0 (compatible; MSIE 5.0; Windows 98; DigExt) ^
 HTTP_REFERER: http://computerdiamonds.com/ ^

 ~-~

 EOF: \n ^  EOL: \n^^\n ^ EOV: } ^ SOV: ${ ^ ~-~
 EOF: ^^ ^ EOL: ~--~ ^   SOV: ${ ^ EOV: }~-~
 EOF: ^^^ ^ EOL: ~----~ ^   SOV: ${ ^  EOV: }

 '

 =>     #######
 =>     # Test the strict format.
 =>     #
 =>     unlink 'FormDBa1.tdb';
 =>     unlink 'FormDBr1.txt';
 =>     unlink 'FormDBa1.txt';

 =>     $dbh_in = new DataCop::FileType::FormDB(flag=>'<', file=>'FormDBs0.tdb', strict=>1);
 =>     $dbh_out = new DataCop::FileType::FormDB(flag=>'>', file=>'FormDBa1.tdb', strict=>1);

 =>     ($$record_p, $$fields_p) = ('','');
 =>     while( $dbh_in->get_record($record_p) ) {
 =>         $dbh_in->decode_record($record_p);
 =>         $T->fout( 'FormDBr1.txt',$$record_p . "\n~-~\n", {append=>1} );
 =>         $dbh_in->decode_field($record_p, $array_p);
 =>         $T->fout( 'FormDBa1.txt',join("\n",@$array_p) . "\n~-~\n", {append=>1});
 =>         ($$record_p, $$fields_p) = ('','');
 =>         $dbh_out->encode_field( $array_p, $record_p );
 =>         $dbh_out->encode_record($record_p);
 =>         $dbh_out->put_record($record_p);
 =>         ($$record_p, $$fields_p) = ('','');
 =>     }

 =>     $dbh_out->finish();
 =>     $dbh_in->finish();
 => $T->fin('FormDBr1.txt')
 '

 UUT: File/Version.pm ^
 File_Spec:  ^
 Revision: ^
 End_User:^

 Copyright:
 copyright © 2003 Software Diamonds.

 Software Diamonds permits unlimited redistribution
 and use in source and binary forms, with or
 without modification.
 ^

 Author: http://www.SoftwareDiamonds.com support@SoftwareDiamonds.com ^
 SVD: SVD::DataCop-DataFile ^
 Template: STD/STD001.frm ^

 ~-~

 Email: nobody@hotmail.com ^
 Form: Udo-fully processed oils ^
 Tutorial: *~~* Better Health thru Biochemistry *~~* ^
 REMOTE_ADDR: 213.158.186.150 ^
 HTTP_USER_AGENT: Mozilla/4.0 (compatible; MSIE 5.0; Windows 98; DigExt) ^
 HTTP_REFERER: http://computerdiamonds.com/ ^

 ~-~

 EOF: \n ^  EOL: \n^^\n ^ EOV: } ^ SOV: ${ ^ 
 ~-~

 EOF: ^^ ^ EOL: ~-~ ^   SOV: ${ ^ EOV: }
 ~-~

 EOF: ^^^ ^ EOL: ~---~ ^   SOV: ${ ^  EOV: }

 ~-~
 '

 => $T->fin('FormDBa1.txt')
 'UUT
 File/Version.pm
 File_Spec

 Revision

 End_User

 Copyright
 copyright © 2003 Software Diamonds.

 Software Diamonds permits unlimited redistribution
 and use in source and binary forms, with or
 without modification.
 Author
 http://www.SoftwareDiamonds.com support@SoftwareDiamonds.com
 SVD
 SVD::DataCop-DataFile
 Template
 STD/STD001.frm
 ~-~
 Email
 nobody@hotmail.com
 Form
 Udo-fully processed oils
 Tutorial
 *~~* Better Health thru Biochemistry *~~*
 REMOTE_ADDR
 213.158.186.150
 HTTP_USER_AGENT
 Mozilla/4.0 (compatible; MSIE 5.0; Windows 98; DigExt)
 HTTP_REFERER
 http://computerdiamonds.com/
 ~-~
 EOF
 \n
 EOL
 \n^\n
 EOV
 }
 SOV
 ${
 ~-~
 EOF
 ^
 EOL
 ~-~
 SOV
 ${
 EOV
 }
 ~-~
 EOF
 ^^
 EOL
 ~---~
 SOV
 ${
 EOV
 }
 ~-~
 '

 => $T->fin('FormDBa1.tdb')
 'UUT: File/Version.pm ^
 File_Spec:  ^
 Revision:  ^
 End_User:  ^

 Copyright:
 copyright © 2003 Software Diamonds.

 Software Diamonds permits unlimited redistribution
 and use in source and binary forms, with or
 without modification.
 ^

 Author: http://www.SoftwareDiamonds.com support@SoftwareDiamonds.com ^
 SVD: SVD::DataCop-DataFile ^
 Template: STD/STD001.frm ^
 ~-~
 Email: nobody@hotmail.com ^
 Form: Udo-fully processed oils ^
 Tutorial: *~~* Better Health thru Biochemistry *~~* ^
 REMOTE_ADDR: 213.158.186.150 ^
 HTTP_USER_AGENT: Mozilla/4.0 (compatible; MSIE 5.0; Windows 98; DigExt) ^
 HTTP_REFERER: http://computerdiamonds.com/ ^
 ~-~
 EOF: \n ^
 EOL: \n^^\n ^
 EOV: } ^
 SOV: ${ ^
 ~-~
 EOF: ^^ ^
 EOL: ~--~ ^
 SOV: ${ ^
 EOV: } ^
 ~-~
 EOF: ^^^ ^
 EOL: ~----~ ^
 SOV: ${ ^
 EOV: } ^
 ~-~
 '

 =>     #######
 =>     # Test the strict binary format.
 =>     #
 =>     unlink 'FormDBa1.tdb';
 =>     unlink 'FormDBh1.tdb';
 =>     unlink 'FormDBr1.txt';
 =>     unlink 'FormDBa1.txt';

 =>     $dbh_in = new DataCop::FileType::FormDB(flag=>'<', file=>'FormDBs0.tdb', strict=>1, binary=>1);
 =>     $dbh_out = new DataCop::FileType::FormDB(flag=>'>', file=>'FormDBa1.tdb', strict=>1, binary=>1);

 =>     ($$record_p, $$fields_p) = ('','');
 =>     while( $dbh_in->get_record($record_p) ) {
 =>         $dbh_in->decode_record($record_p, $record_p);
 =>         $T->fout( 'FormDBr1.txt',$$record_p . "\n~-~\n", {append=>1} );
 =>         $dbh_in->decode_field($record_p, $array_p);
 =>         $T->fout( 'FormDBa1.txt',join("\n",@$array_p) . "\n~-~\n", {append=>1});
 =>         ($$record_p, $$fields_p) = ('','');
 =>         $dbh_out->encode_field( $array_p, $record_p );
 =>         $dbh_out->encode_record( $record_p, $record_p);
 =>         $dbh_out->put_record($record_p);
 =>         ($$record_p, $$fields_p) = ('','');
 =>     }

 =>     $dbh_out->finish();
 =>     $dbh_in->finish();
 => $T->fin('FormDBr1.txt', {binary=>1})
 '

 UUT: File/Version.pm ^
 File_Spec:  ^
 Revision: ^
 End_User:^

 Copyright:
 copyright © 2003 Software Diamonds.

 Software Diamonds permits unlimited redistribution
 and use in source and binary forms, with or
 without modification.
 ^

 Author: http://www.SoftwareDiamonds.com support@SoftwareDiamonds.com ^
 SVD: SVD::DataCop-DataFile ^
 Template: STD/STD001.frm ^

 ~-~

 Email: nobody@hotmail.com ^
 Form: Udo-fully processed oils ^
 Tutorial: *~~* Better Health thru Biochemistry *~~* ^
 REMOTE_ADDR: 213.158.186.150 ^
 HTTP_USER_AGENT: Mozilla/4.0 (compatible; MSIE 5.0; Windows 98; DigExt) ^
 HTTP_REFERER: http://computerdiamonds.com/ ^

 ~-~

 EOF: \n ^  EOL: \n^^\n ^ EOV: } ^ SOV: ${ ^ 
 ~-~

 EOF: ^^ ^ EOL: ~-~ ^   SOV: ${ ^ EOV: }
 ~-~

 EOF: ^^^ ^ EOL: ~---~ ^   SOV: ${ ^  EOV: }

 ~-~
 '

 => $T->fin('FormDBa1.txt', {binary=>1})
 'UUT
 File/Version.pm
 File_Spec

 Revision

 End_User

 Copyright

 copyright © 2003 Software Diamonds.

 Software Diamonds permits unlimited redistribution
 and use in source and binary forms, with or
 without modification.
 Author
 http://www.SoftwareDiamonds.com support@SoftwareDiamonds.com
 SVD
 SVD::DataCop-DataFile
 Template
 STD/STD001.frm
 ~-~
 Email
 nobody@hotmail.com
 Form
 Udo-fully processed oils
 Tutorial
 *~~* Better Health thru Biochemistry *~~*
 REMOTE_ADDR
 213.158.186.150
 HTTP_USER_AGENT
 Mozilla/4.0 (compatible; MSIE 5.0; Windows 98; DigExt)
 HTTP_REFERER
 http://computerdiamonds.com/
 ~-~
 EOF
 \n
 EOL
 \n^\n
 EOV
 }
 SOV
 ${
 ~-~
 EOF
 ^
 EOL
 ~-~
 SOV
 ${
 EOV
 }
 ~-~
 EOF
 ^^
 EOL
 ~---~
 SOV
 ${
 EOV
 }
 ~-~
 '

 => $T->fin('FormDBa1.tdb', {binary=>1})
 'UUT: File/Version.pm ^
 File_Spec:  ^
 Revision:  ^
 End_User:  ^

 Copyright:

 copyright © 2003 Software Diamonds.

 Software Diamonds permits unlimited redistribution
 and use in source and binary forms, with or
 without modification.
 ^

 Author: http://www.SoftwareDiamonds.com support@SoftwareDiamonds.com ^
 SVD: SVD::DataCop-DataFile ^
 Template: STD/STD001.frm ^
 ~-~
 Email: nobody@hotmail.com ^
 Form: Udo-fully processed oils ^
 Tutorial: *~~* Better Health thru Biochemistry *~~* ^
 REMOTE_ADDR: 213.158.186.150 ^
 HTTP_USER_AGENT: Mozilla/4.0 (compatible; MSIE 5.0; Windows 98; DigExt) ^
 HTTP_REFERER: http://computerdiamonds.com/ ^
 ~-~
 EOF: \n ^
 EOL: \n^^\n ^
 EOV: } ^
 SOV: ${ ^
 ~-~
 EOF: ^^ ^
 EOL: ~--~ ^
 SOV: ${ ^
 EOV: } ^
 ~-~
 EOF: ^^^ ^
 EOL: ~----~ ^
 SOV: ${ ^
 EOV: } ^
 ~-~
 '

 =>     #######
 =>     # Test the strict binary format.
 =>     #
 =>     unlink 'FormDBa1.tdb';
 =>     unlink 'FormDBh1.tdb';
 =>     unlink 'FormDBr1.txt';
 =>     unlink 'FormDBa1.txt';

=head1 QUALITY ASSURANCE

The file F<DataCop/FileType/t/DataDB.std> is the Software
Test Description file for the C<DataCop::FileType::DataDB>
module. This file contains all the information
necessary for this module to verify that
this module meets its requirements.

To generate all the test output files, 
run the generated test script F<DataCop/FileType/t/DataDB.t>
and the demonstration script F<DataCop/FileType/t/DataDB.d>,
execute the following in any directory:

 tg -o="clean all" -verbose -replace -run DataCop/FileType/t/DataDB.std

Note that F<tg.pl> must be in the execution path C<$ENV{PATH}>.
A copy F<tg.pl> is at C<STD/t/tg.pl>

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