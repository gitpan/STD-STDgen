#!perl
#
#
package DataFile-STD;

use 5.001;
use strict;
use warnings;
use warnings::register;

use vars qw($VERSION $DATE);
$VERSION = '0.01';   # automatically generated file
$DATE = '2003/06/03';

##### Software Test Description ####
#
# The module STD::TestGen generated this program module from the contents of
#
# DataCop/DataFile.std
#
# Don't edit this program module file. Edit instead
#
# DataCop/DataFile.std
#
#	ANY CHANGES MADE HERE TO THIS SCRIPT FILE WILL BE LOST
#
#       the next time STD::TestGen generates this program module file.
#
#


=head1 TITLE PAGE

 Software Test Description

 for

 Perl DataCop::DataFile

 Revision: -

 Date: 2003/06/02

 Prepared for: General Public 

 Prepared by:  http://www.SoftwareDiamonds.com support@SoftwareDiamonds.com

 Classification: None

=cut

#######
#  
#  1. SCOPE
#
#  1.1 Identification
#
#  1.2 System overview
#

=head1 SCOPE

This document establishes the test descriptions for the 
Perl L<DataCop::DataFile|DataCop::DataFile> 

=head2 Identification

The Software Version Description (SVD) for DataCop::DataFile,
L<SVD::DataCop-DataFile|SVD::DataCop-DataFile>,
provides configuration, version, and installation information:

=head2 System overview

The system is the Perl programming language software
established by the L<SEE ALSO|SEE ALSO> references.

=head2 1.3 Document overview

This document establishes the tests to verify the requirements
specified in the Perl Plain Old Documentation (POD)
of the L<DataCop::DataFile|DataCop::DataFile>.
The L<SEE ALSO|SEE ALSO> references literature on PODs.

The format of this document is in accordance with
L<STD|Military::STD> as tailered by L<STD Tailoring|STD::STDtailor>.

=cut



#######
#
#  3. TEST PREPARATIONS
#
#  3.1 Hardware preparation
#
#  3.2 Software preparation
#
#  3.3 Other pre-test preparations
#
#  3.4. Criteria for evaluating results.
#
#  3.5 Test procedure.
#
#  3.6 Assumptions and constraints.
#

=head1 TEST PREPARATIONS

There are no safety precautions or privacy considerations
for these tests.

=head2 Hardware preparation

Prepare the site hardware by following general
operating procedure to apply power the computer
running Perl under the site operating system.

=head2 Software preparation

There are no preparations. The tests will
determine if the DataCop::DataFile program module is installed.
If any test fails, contact

 http://www.SoftwareDiamonds.com support@SoftwareDiamonds.com

for consultation on corrective actions.

=head2 Other pre-test preparations

None.

=head2 Criteria for evaluating results.

The criteria for tests and test cases
is an exact match of the acutual test results
and the expected test results.
The Perl L<Test|Test> module determines whether
the actual test results are exactly the same as the expected
test results. 

=head2 Test procedure.

All test and test cases are performed by running the following test script:

 DataFile.t

=head2 Assumptions and constraints.

There are no assumptions or constraints. 

=cut

#######
#  
#  4. TEST DESCRIPTIONS
#
#  4.1 Test 001
#
#  ..
#
#  4.x Test x
#
#

=head1 TEST DESCRIPTIONS

These test descriptions verify the requirments 
as specifed in the L<DataCop::DataFile|DataCop::DataFile>, 
Plain Old Documentation (POD).
These test descriptions contain 9 tests.

A unique test identification used herein consists of the
the test number that is produce by executing the Perl 
test script file:

 DataFile.t

The unique test number id within this module
and the the unique Perl identification for
this module, L<DataCop/DataFile.std|DataCop/DataFile.std>, 
provide an unique Perl system wide identifier of the test.

There are no safety procautions or security
and privacy considerations for any of the tests
or test cases.


=head2 Test 001 - UUT not loaded

=over 4

=item Test 001 - UUT not loaded - Requirements addressed

None.

=item Test 001 - UUT not loaded - Test

 my $loaded = $T->is_package_loaded('DataCop::DataFileI')

=item Test 001 - UUT not loaded - Expected Test Results

 ''



=back

=cut


=head2 Test 002 - Load UUT

=over 4

=item Test 002 - Load UUT - Requirements addressed

L<DataCop::DataFile/general [1] - load>

=item Test 002 - Load UUT - Test

 my $errors = $T->load_package( 'DataCop::DataFileI' );
$errors

=item Test 002 - Load UUT - Expected Test Results

 ''

=item Test 002 - Load UUT - Test procedure Conditions

Skip rest of tests on failure. 



=back

=cut


=head2 Test 003 - No pod errors

=over 4

=item Test 003 - No pod errors - Requirements addressed

L<DataCop::DataFile/general [2] - pod check>

=item Test 003 - No pod errors - Test

 $T->pod_errors( 'DataCop::DataFile')

=item Test 003 - No pod errors - Expected Test Results

 0



=back

=cut


=head2 Test 004 - get without record

=over 4

=item Test 004 - get without record - Requirements addressed

None.

=item Test 004 - get without record - Test

     unlink 'DataFile1.txt';

     my $record;
     my ($array_p, $record_p) = ([], $record);
     my $dbh = new DataCop::DataFileI(flag => '<', file => 'DataFile0.tdb',
                option1 => '1', option2 => '2' );

     while( $dbh->get($array_p, $record_p) ) {
         $T->fout( 'DataFile1.txt', $$record_p . "\n~-~\n", {append=>1});
         $T->fout( 'DataFile1.txt', join("\n+--\n",@$array_p) . "\n~-~\n", {append=>1});
     };
     unlink 'DataFile1.txt';
     $dbh->finish();

     $dbh = new DataCop::DataFileI(flag => '<', file => 'DataFile0.tdb',
                option3 => '3', option4 => '4',  option5 => '5' );

     while( $dbh->get($array_p) ) {
         $T->fout( 'DataFile1.txt', join("\n+--\n",@$array_p) . "\n~-~\n", {append=>1});
     }
     $dbh->finish();
$T->fin('DataFile1.txt')

=item Test 004 - get without record - Expected Test Results

 'fields
  +--
  test record 1
  file => DataFile0.tdb
  flag => <
  option3 => 3
  option4 => 4
  option5 => 5
  get_record

  file => DataFile0.tdb
  flag => <
  option3 => 3
  option4 => 4
  option5 => 5
  decode_record

  +--
  file
  +--
  DataFile0.tdb
  +--
  flag
  +--
  <
  +--
  option3
  +--
  3
  +--
  option4
  +--
  4
  +--
  option5
  +--
  5
  +--
  subroutine
  +--
  decode_field
  ~-~
  fields
  +--
  test record 2
  file => DataFile0.tdb
  flag => <
  option3 => 3
  option4 => 4
  option5 => 5
  get_record

  file => DataFile0.tdb
  flag => <
  option3 => 3
  option4 => 4
  option5 => 5
  decode_record

  +--
  file
  +--
  DataFile0.tdb
  +--
  flag
  +--
  <
  +--
  option3
  +--
  3
  +--
  option4
  +--
  4
  +--
  option5
  +--
  5
  +--
  subroutine
  +--
  decode_field
  ~-~
  '



=back

=cut


=head2 Test 005 - put with record

=over 4

=item Test 005 - put with record - Requirements addressed

None.

=item Test 005 - put with record - Test

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
$T->fin('DataFile1.tdb')

=item Test 005 - put with record - Expected Test Results

 'put_record
  encode_record
  encode_field
  name1
  data1
  name2
  data2
  option file => DataFile1.tdb
  option flag => >
  option option6 => 6
  option option7 => 7

  option file => DataFile1.tdb
  option flag => >
  option option6 => 6
  option option7 => 7

  ~-~
  put_record
  encode_record
  encode_field
  name3
  data3
  name4
  data4
  option file => DataFile1.tdb
  option flag => >
  option option6 => 6
  option option7 => 7

  option file => DataFile1.tdb
  option flag => >
  option option6 => 6
  option option7 => 7

  ~-~
  '



=back

=cut


=head2 Test 006

=over 4

=item Test 006 - Requirements addressed

None.

=item Test 006 - Test

 $T->fin('DataFile1.txt')

=item Test 006 - Expected Test Results

 'encode_record
  encode_field
  name1
  data1
  name2
  data2
  option file => DataFile1.tdb
  option flag => >
  option option6 => 6
  option option7 => 7

  option file => DataFile1.tdb
  option flag => >
  option option6 => 6
  option option7 => 7

  ~-~
  encode_record
  encode_field
  name3
  data3
  name4
  data4
  option file => DataFile1.tdb
  option flag => >
  option option6 => 6
  option option7 => 7

  option file => DataFile1.tdb
  option flag => >
  option option6 => 6
  option option7 => 7

  ~-~
  '



=back

=cut


=head2 Test 007 - put with without record

=over 4

=item Test 007 - put with without record - Requirements addressed

None.

=item Test 007 - put with without record - Test

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
$T->fin('DataFile1.tdb')

=item Test 007 - put with without record - Expected Test Results

 'put_record
  encode_record
  encode_field
  name5
  data5
  name6
  data6
  option file => DataFile1.tdb
  option flag => >
  option option8 => 8

  option file => DataFile1.tdb
  option flag => >
  option option8 => 8

  ~-~
  put_record
  encode_record
  encode_field
  name7
  data7
  option file => DataFile1.tdb
  option flag => >
  option option8 => 8

  option file => DataFile1.tdb
  option flag => >
  option option8 => 8

  ~-~
  '



=back

=cut


=head2 Test 008 - binary put with without record

=over 4

=item Test 008 - binary put with without record - Requirements addressed

None.

=item Test 008 - binary put with without record - Test

     unlink 'DataFile1.txt';
     unlink 'DataFile1.tdb';

     $dbh = new DataCop::DataFileI(flag => '>', file => 'DataFile1.tdb',
               binary => 1, option9 => '9' );

     @db = ( [ 'name5','data5','name6','data6'], [ 'name7', 'data7' ] );  
  
     foreach $array_p (@db) { 
         $dbh->put($array_p);
     }
     $dbh->finish();
$T->fin('DataFile1.tdb')

=item Test 008 - binary put with without record - Expected Test Results

 'put_record
  encode_record
  encode_field
  name5
  data5
  name6
  data6
  option binary => 1
  option file => DataFile1.tdb
  option flag => >
  option option9 => 9

  option binary => 1
  option file => DataFile1.tdb
  option flag => >
  option option9 => 9

  ~-~
  put_record
  encode_record
  encode_field
  name7
  data7
  option binary => 1
  option file => DataFile1.tdb
  option flag => >
  option option9 => 9

  option binary => 1
  option file => DataFile1.tdb
  option flag => >
  option option9 => 9

  ~-~
  '



=back

=cut


=head2 Test 009 - binary get with record

=over 4

=item Test 009 - binary get with record - Requirements addressed

None.

=item Test 009 - binary get with record - Test

     unlink 'DataFile1.txt';
     unlink 'DataFile1.tdb';

     $dbh = new DataCop::DataFileI(flag => '<', file => 'DataFile0.tdb',
                binary => 1, option10 => '10', option11 => '11' );

     while( $dbh->get($array_p, $record_p) ) {
         $T->fout( 'DataFile1.txt', $$record_p . "\n~-~\n", {append=>1});
         $T->fout( 'DataFile1.txt', join("\n+--\n",@$array_p) . "\n~-~\n", {append=>1});
     }
     $dbh->finish();
$T->fin('DataFile1.txt')

=item Test 009 - binary get with record - Expected Test Results

 'test record 1

  binary => 1
  file => DataFile0.tdb
  flag => <
  option10 => 10
  option11 => 11
  get_record

  binary => 1
  file => DataFile0.tdb
  flag => <
  option10 => 10
  option11 => 11
  decode_record

  ~-~
  fields
  +--
  test record 1

  binary => 1
  file => DataFile0.tdb
  flag => <
  option10 => 10
  option11 => 11
  get_record

  binary => 1
  file => DataFile0.tdb
  flag => <
  option10 => 10
  option11 => 11
  decode_record

  +--
  binary
  +--
  1
  +--
  file
  +--
  DataFile0.tdb
  +--
  flag
  +--
  <
  +--
  option10
  +--
  10
  +--
  option11
  +--
  11
  +--
  subroutine
  +--
  decode_field
  ~-~
  test record 2

  binary => 1
  file => DataFile0.tdb
  flag => <
  option10 => 10
  option11 => 11
  get_record

  binary => 1
  file => DataFile0.tdb
  flag => <
  option10 => 10
  option11 => 11
  decode_record

  ~-~
  fields
  +--
  test record 2

  binary => 1
  file => DataFile0.tdb
  flag => <
  option10 => 10
  option11 => 11
  get_record

  binary => 1
  file => DataFile0.tdb
  flag => <
  option10 => 10
  option11 => 11
  decode_record

  +--
  binary
  +--
  1
  +--
  file
  +--
  DataFile0.tdb
  +--
  flag
  +--
  <
  +--
  option10
  +--
  10
  +--
  option11
  +--
  11
  +--
  subroutine
  +--
  decode_field
  ~-~
  '



=back

=cut



^

=cut

#######
#  
#  5. REQUIREMENTS TRACEABILITY
#
#

=head1 REQUIREMENTS TRACEABILITY

 
 Requirement                                                      Test                                                            
 ---------------------------------------------------------------- ----------------------------------------------------------------
 L<DataCop::DataFile/general [1] - load>                          L<DataFile-STD/Test 002 - Load UUT>                             
 L<DataCop::DataFile/general [2] - pod check>                     L<DataFile-STD/Test 003 - No pod errors>                        
 



 
 Test                                                             Requirement                                                     
 ---------------------------------------------------------------- ----------------------------------------------------------------
 L<DataFile-STD/Test 002 - Load UUT>                              L<DataCop::DataFile/general [1] - load>                         
 L<DataFile-STD/Test 003 - No pod errors>                         L<DataCop::DataFile/general [2] - pod check>                    
 



=cut

#######
#  
#  6. NOTES
#
#

=head1 NOTES

=head2 Acronyms

This document uses the following acronyms:

=over 4

=item POD

Plain Old Documentation

=item .pm

extension for a Perl Module

=item .t

extension for a Perl test script file

=item .d

extension for a Perl demonstration script file

=item DID

Data Item Description

=back

=head2 Copyright

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

#######
#
#  2. REFERENCED DOCUMENTS
#
#
#

=head1 SEE ALSO

L<DataCop::DataFile>

=back

=cut

__END__


### end of file ###

