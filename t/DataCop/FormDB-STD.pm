#!perl
#
#
package FormDB-STD;

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
# DataCop/FormDB.std
#
# Don't edit this program module file. Edit instead
#
# DataCop/FormDB.std
#
#	ANY CHANGES MADE HERE TO THIS SCRIPT FILE WILL BE LOST
#
#       the next time STD::TestGen generates this program module file.
#
#


=head1 TITLE PAGE

 Software Test Description

 for

 Perl DataCop::FileType::FormDB

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
Perl L<DataCop::FileType::FormDB|DataCop::FileType::FormDB> 

=head2 Identification

The Software Version Description (SVD) for DataCop::FileType::FormDB,
L<SVD::DataCop-DataFile|SVD::DataCop-DataFile>,
provides configuration, version, and installation information:

=head2 System overview

The system is the Perl programming language software
established by the L<SEE ALSO|SEE ALSO> references.

=head2 1.3 Document overview

This document establishes the tests to verify the requirements
specified in the Perl Plain Old Documentation (POD)
of the L<DataCop::FileType::FormDB|DataCop::FileType::FormDB>.
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
determine if the DataCop::FileType::FormDB program module is installed.
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

 FormDB.t

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
as specifed in the L<DataCop::FileType::FormDB|DataCop::FileType::FormDB>, 
Plain Old Documentation (POD).
These test descriptions contain 10 tests.

A unique test identification used herein consists of the
the test number that is produce by executing the Perl 
test script file:

 FormDB.t

The unique test number id within this module
and the the unique Perl identification for
this module, L<DataCop/FormDB.std|DataCop/FormDB.std>, 
provide an unique Perl system wide identifier of the test.

There are no safety procautions or security
and privacy considerations for any of the tests
or test cases.


=head2 Test 001 - UUT not loaded

=over 4

=item Test 001 - UUT not loaded - Requirements addressed

None.

=item Test 001 - UUT not loaded - Test

 my $loaded = $T->is_package_loaded('DataCop::FileType::FormDB')

=item Test 001 - UUT not loaded - Expected Test Results

 ''



=back

=cut


=head2 Test 002 - Load UUT

=over 4

=item Test 002 - Load UUT - Requirements addressed

L<DataCop::FileType::FormDB/general [1] - load>

=item Test 002 - Load UUT - Test

 my $errors = $T->load_package( 'DataCop::FileType::FormDB' );
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

L<DataCop::FileType::FormDB/general [2] - pod check>

=item Test 003 - No pod errors - Test

 $T->pod_errors( 'DataCop::FileType::FormDB')

=item Test 003 - No pod errors - Expected Test Results

 0



=back

=cut


=head2 Test 004 - Lenient Get Array

=over 4

=item Test 004 - Lenient Get Array - Requirements addressed

L<DataCop::FileType::FormDB/format [1] - separator strings>, L<DataCop::FileType::FormDB/format [2] - separator escapes>, L<DataCop::FileType::FormDB/format [3] - field names>, L<DataCop::FileType::FormDB/format [4] - field names>, L<DataCop::FileType::FormDB/format [5] - EON>, L<DataCop::FileType::FormDB/format [7] - Lenient EOD>, L<DataCop::FileType::FormDB/methods [2] - decode_field>

=item Test 004 - Lenient Get Array - Test

     #######
     # Test the lenient format.
     #
     unlink 'FormDBa1.tdb';
     unlink 'FormDBr1.txt';
     unlink 'FormDBa1.txt';

     my $dbh_in = new DataCop::FileType::FormDB(flag=>'<', file=>'FormDB0.tdb');
     my $dbh_out = new DataCop::FileType::FormDB(flag=>'>', file=>'FormDBa1.tdb');

     my ($$record_p, $$fields_p) = ('','');
     my $array_p = [];
     while( $dbh_in->get_record($record_p) ) {
         $dbh_in->decode_record($record_p,$fields_p);
         $T->fout( 'FormDBr1.txt',$$fields_p . "\n~-~\n", {append=>1} );
         $dbh_in->decode_field($fields_p, $array_p);
         $T->fout( 'FormDBa1.txt',join("\n",@$array_p) . "\n~-~\n", {append=>1});
         ($$record_p, $$fields_p) = ('','');
         $dbh_out->encode_field( $array_p, $fields_p );
         $dbh_out->encode_record( $fields_p, $record_p);
         $dbh_out->put_record($record_p);
         ($$record_p, $$fields_p) = ('','');
     }

     $dbh_out->finish();
     $dbh_in->finish();
$T->fin('FormDBa1.txt')

=item Test 004 - Lenient Get Array - Expected Test Results

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



=back

=cut


=head2 Test 005 - Lenient Put Array

=over 4

=item Test 005 - Lenient Put Array - Requirements addressed

L<DataCop::FileType::FormDB/format [1] - separator strings>, L<DataCop::FileType::FormDB/format [2] - separator escapes>, L<DataCop::FileType::FormDB/format [3] - field names>, L<DataCop::FileType::FormDB/format [4] - field names>, L<DataCop::FileType::FormDB/format [5] - EON>, L<DataCop::FileType::FormDB/format [7] - Lenient EOD>, L<DataCop::FileType::FormDB/methods [1] - encode_field>, L<DataCop::FileType::FormDB/methods [3] - encode_record>, L<DataCop::FileType::FormDB/methods [5] - put_record>

=item Test 005 - Lenient Put Array - Test

 $T->fin('FormDBa1.tdb')

=item Test 005 - Lenient Put Array - Expected Test Results

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



=back

=cut


=head2 Test 006 - Strict Get Array

=over 4

=item Test 006 - Strict Get Array - Requirements addressed

L<DataCop::FileType::FormDB/format [1] - separator strings>, L<DataCop::FileType::FormDB/format [2] - separator escapes>, L<DataCop::FileType::FormDB/format [3] - field names>, L<DataCop::FileType::FormDB/format [4] - field names>, L<DataCop::FileType::FormDB/format [5] - EON>, L<DataCop::FileType::FormDB/format [6] - Strict EOD>, L<DataCop::FileType::FormDB/methods [2] - decode_field>

=item Test 006 - Strict Get Array - Test

     #######
     # Test the strict format.
     #
     unlink 'FormDBa1.tdb';
     unlink 'FormDBr1.txt';
     unlink 'FormDBa1.txt';

     $dbh_in = new DataCop::FileType::FormDB(flag=>'<', file=>'FormDBs0.tdb', strict=>1);
     $dbh_out = new DataCop::FileType::FormDB(flag=>'>', file=>'FormDBa1.tdb', strict=>1);

     ($$record_p, $$fields_p) = ('','');
     while( $dbh_in->get_record($record_p) ) {
         $dbh_in->decode_record($record_p);
         $T->fout( 'FormDBr1.txt',$$record_p . "\n~-~\n", {append=>1} );
         $dbh_in->decode_field($record_p, $array_p);
         $T->fout( 'FormDBa1.txt',join("\n",@$array_p) . "\n~-~\n", {append=>1});
         ($$record_p, $$fields_p) = ('','');
         $dbh_out->encode_field( $array_p, $record_p );
         $dbh_out->encode_record($record_p);
         $dbh_out->put_record($record_p);
         ($$record_p, $$fields_p) = ('','');
     }


     $dbh_out->finish();
     $dbh_in->finish();
$T->fin('FormDBa1.txt')

=item Test 006 - Strict Get Array - Expected Test Results

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



=back

=cut


=head2 Test 007 - Strict Put Array

=over 4

=item Test 007 - Strict Put Array - Requirements addressed

L<DataCop::FileType::FormDB/format [1] - separator strings>, L<DataCop::FileType::FormDB/format [2] - separator escapes>, L<DataCop::FileType::FormDB/format [3] - field names>, L<DataCop::FileType::FormDB/format [4] - field names>, L<DataCop::FileType::FormDB/format [5] - EON>, L<DataCop::FileType::FormDB/format [6] - Strict EOD>, L<DataCop::FileType::FormDB/methods [1] - encode_field>, L<DataCop::FileType::FormDB/methods [3] - encode_record>, L<DataCop::FileType::FormDB/methods [5] - put_record>

=item Test 007 - Strict Put Array - Test

 $T->fin('FormDBa1.tdb')

=item Test 007 - Strict Put Array - Expected Test Results

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



=back

=cut


=head2 Test 008 - Strict Binary Record

=over 4

=item Test 008 - Strict Binary Record - Requirements addressed

L<DataCop::FileType::FormDB/format [1] - separator strings>, L<DataCop::FileType::FormDB/format [2] - separator escapes>, L<DataCop::FileType::FormDB/format [3] - field names>, L<DataCop::FileType::FormDB/format [4] - field names>, L<DataCop::FileType::FormDB/format [5] - EON>, L<DataCop::FileType::FormDB/format [6] - Strict EOD>, L<DataCop::FileType::FormDB/methods [4] - decode_record>, L<DataCop::FileType::FormDB/methods [6] - get_record>, L<DataCop::FileType::FormDB/methods [7] - get_record>

=item Test 008 - Strict Binary Record - Test

     #######
     # Test the strict binary format.
     #
     unlink 'FormDBa1.tdb';
     unlink 'FormDBh1.tdb';
     unlink 'FormDBr1.txt';
     unlink 'FormDBa1.txt';

     $dbh_in = new DataCop::FileType::FormDB(flag=>'<', file=>'FormDBs0.tdb', strict=>1, binary=>1);
     $dbh_out = new DataCop::FileType::FormDB(flag=>'>', file=>'FormDBa1.tdb', strict=>1, binary=>1);

     ($$record_p, $$fields_p) = ('','');
     while( $dbh_in->get_record($record_p) ) {
         $dbh_in->decode_record($record_p, $record_p);
         $T->fout( 'FormDBr1.txt',$$record_p . "\n~-~\n", {append=>1} );
         $dbh_in->decode_field($record_p, $array_p);
         $T->fout( 'FormDBa1.txt',join("\n",@$array_p) . "\n~-~\n", {append=>1});
         ($$record_p, $$fields_p) = ('','');
         $dbh_out->encode_field( $array_p, $record_p );
         $dbh_out->encode_record( $record_p, $record_p);
         $dbh_out->put_record($record_p);
         ($$record_p, $$fields_p) = ('','');
     }

     $dbh_out->finish();
     $dbh_in->finish();
$T->fin('FormDBr1.txt', {binary=>1})

=item Test 008 - Strict Binary Record - Expected Test Results

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



=back

=cut


=head2 Test 009 - Strict Binary Get Array

=over 4

=item Test 009 - Strict Binary Get Array - Requirements addressed

L<DataCop::FileType::FormDB/format [1] - separator strings>, L<DataCop::FileType::FormDB/format [2] - separator escapes>, L<DataCop::FileType::FormDB/format [3] - field names>, L<DataCop::FileType::FormDB/format [4] - field names>, L<DataCop::FileType::FormDB/format [5] - EON>, L<DataCop::FileType::FormDB/format [6] - Strict EOD>, L<DataCop::FileType::FormDB/methods [2] - decode_field>

=item Test 009 - Strict Binary Get Array - Test

 $T->fin('FormDBa1.txt', {binary=>1})

=item Test 009 - Strict Binary Get Array - Expected Test Results

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



=back

=cut


=head2 Test 010 - Strict Binary Put Array

=over 4

=item Test 010 - Strict Binary Put Array - Requirements addressed

L<DataCop::FileType::FormDB/format [1] - separator strings>, L<DataCop::FileType::FormDB/format [2] - separator escapes>, L<DataCop::FileType::FormDB/format [3] - field names>, L<DataCop::FileType::FormDB/format [4] - field names>, L<DataCop::FileType::FormDB/format [5] - EON>, L<DataCop::FileType::FormDB/format [6] - Strict EOD>, L<DataCop::FileType::FormDB/methods [1] - encode_field>, L<DataCop::FileType::FormDB/methods [3] - encode_record>, L<DataCop::FileType::FormDB/methods [5] - put_record>

=item Test 010 - Strict Binary Put Array - Test

 $T->fin('FormDBa1.tdb', {binary=>1})

=item Test 010 - Strict Binary Put Array - Expected Test Results

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
 L<DataCop::FileType::FormDB/format [1] - separator strings>      L<FormDB-STD/Test 004 - Lenient Get Array>                      
 L<DataCop::FileType::FormDB/format [1] - separator strings>      L<FormDB-STD/Test 005 - Lenient Put Array>                      
 L<DataCop::FileType::FormDB/format [1] - separator strings>      L<FormDB-STD/Test 006 - Strict Get Array>                       
 L<DataCop::FileType::FormDB/format [1] - separator strings>      L<FormDB-STD/Test 007 - Strict Put Array>                       
 L<DataCop::FileType::FormDB/format [1] - separator strings>      L<FormDB-STD/Test 008 - Strict Binary Record>                   
 L<DataCop::FileType::FormDB/format [1] - separator strings>      L<FormDB-STD/Test 009 - Strict Binary Get Array>                
 L<DataCop::FileType::FormDB/format [1] - separator strings>      L<FormDB-STD/Test 010 - Strict Binary Put Array>                
 L<DataCop::FileType::FormDB/format [2] - separator escapes>      L<FormDB-STD/Test 004 - Lenient Get Array>                      
 L<DataCop::FileType::FormDB/format [2] - separator escapes>      L<FormDB-STD/Test 005 - Lenient Put Array>                      
 L<DataCop::FileType::FormDB/format [2] - separator escapes>      L<FormDB-STD/Test 006 - Strict Get Array>                       
 L<DataCop::FileType::FormDB/format [2] - separator escapes>      L<FormDB-STD/Test 007 - Strict Put Array>                       
 L<DataCop::FileType::FormDB/format [2] - separator escapes>      L<FormDB-STD/Test 008 - Strict Binary Record>                   
 L<DataCop::FileType::FormDB/format [2] - separator escapes>      L<FormDB-STD/Test 009 - Strict Binary Get Array>                
 L<DataCop::FileType::FormDB/format [2] - separator escapes>      L<FormDB-STD/Test 010 - Strict Binary Put Array>                
 L<DataCop::FileType::FormDB/format [3] - field names>            L<FormDB-STD/Test 004 - Lenient Get Array>                      
 L<DataCop::FileType::FormDB/format [3] - field names>            L<FormDB-STD/Test 005 - Lenient Put Array>                      
 L<DataCop::FileType::FormDB/format [3] - field names>            L<FormDB-STD/Test 006 - Strict Get Array>                       
 L<DataCop::FileType::FormDB/format [3] - field names>            L<FormDB-STD/Test 007 - Strict Put Array>                       
 L<DataCop::FileType::FormDB/format [3] - field names>            L<FormDB-STD/Test 008 - Strict Binary Record>                   
 L<DataCop::FileType::FormDB/format [3] - field names>            L<FormDB-STD/Test 009 - Strict Binary Get Array>                
 L<DataCop::FileType::FormDB/format [3] - field names>            L<FormDB-STD/Test 010 - Strict Binary Put Array>                
 L<DataCop::FileType::FormDB/format [4] - field names>            L<FormDB-STD/Test 004 - Lenient Get Array>                      
 L<DataCop::FileType::FormDB/format [4] - field names>            L<FormDB-STD/Test 005 - Lenient Put Array>                      
 L<DataCop::FileType::FormDB/format [4] - field names>            L<FormDB-STD/Test 006 - Strict Get Array>                       
 L<DataCop::FileType::FormDB/format [4] - field names>            L<FormDB-STD/Test 007 - Strict Put Array>                       
 L<DataCop::FileType::FormDB/format [4] - field names>            L<FormDB-STD/Test 008 - Strict Binary Record>                   
 L<DataCop::FileType::FormDB/format [4] - field names>            L<FormDB-STD/Test 009 - Strict Binary Get Array>                
 L<DataCop::FileType::FormDB/format [4] - field names>            L<FormDB-STD/Test 010 - Strict Binary Put Array>                
 L<DataCop::FileType::FormDB/format [5] - EON>                    L<FormDB-STD/Test 004 - Lenient Get Array>                      
 L<DataCop::FileType::FormDB/format [5] - EON>                    L<FormDB-STD/Test 005 - Lenient Put Array>                      
 L<DataCop::FileType::FormDB/format [5] - EON>                    L<FormDB-STD/Test 006 - Strict Get Array>                       
 L<DataCop::FileType::FormDB/format [5] - EON>                    L<FormDB-STD/Test 007 - Strict Put Array>                       
 L<DataCop::FileType::FormDB/format [5] - EON>                    L<FormDB-STD/Test 008 - Strict Binary Record>                   
 L<DataCop::FileType::FormDB/format [5] - EON>                    L<FormDB-STD/Test 009 - Strict Binary Get Array>                
 L<DataCop::FileType::FormDB/format [5] - EON>                    L<FormDB-STD/Test 010 - Strict Binary Put Array>                
 L<DataCop::FileType::FormDB/format [6] - Strict EOD>             L<FormDB-STD/Test 006 - Strict Get Array>                       
 L<DataCop::FileType::FormDB/format [6] - Strict EOD>             L<FormDB-STD/Test 007 - Strict Put Array>                       
 L<DataCop::FileType::FormDB/format [6] - Strict EOD>             L<FormDB-STD/Test 008 - Strict Binary Record>                   
 L<DataCop::FileType::FormDB/format [6] - Strict EOD>             L<FormDB-STD/Test 009 - Strict Binary Get Array>                
 L<DataCop::FileType::FormDB/format [6] - Strict EOD>             L<FormDB-STD/Test 010 - Strict Binary Put Array>                
 L<DataCop::FileType::FormDB/format [7] - Lenient EOD>            L<FormDB-STD/Test 004 - Lenient Get Array>                      
 L<DataCop::FileType::FormDB/format [7] - Lenient EOD>            L<FormDB-STD/Test 005 - Lenient Put Array>                      
 L<DataCop::FileType::FormDB/general [1] - load>                  L<FormDB-STD/Test 002 - Load UUT>                               
 L<DataCop::FileType::FormDB/general [2] - pod check>             L<FormDB-STD/Test 003 - No pod errors>                          
 L<DataCop::FileType::FormDB/methods [1] - encode_field>          L<FormDB-STD/Test 005 - Lenient Put Array>                      
 L<DataCop::FileType::FormDB/methods [1] - encode_field>          L<FormDB-STD/Test 007 - Strict Put Array>                       
 L<DataCop::FileType::FormDB/methods [1] - encode_field>          L<FormDB-STD/Test 010 - Strict Binary Put Array>                
 L<DataCop::FileType::FormDB/methods [2] - decode_field>          L<FormDB-STD/Test 004 - Lenient Get Array>                      
 L<DataCop::FileType::FormDB/methods [2] - decode_field>          L<FormDB-STD/Test 006 - Strict Get Array>                       
 L<DataCop::FileType::FormDB/methods [2] - decode_field>          L<FormDB-STD/Test 009 - Strict Binary Get Array>                
 L<DataCop::FileType::FormDB/methods [3] - encode_record>         L<FormDB-STD/Test 005 - Lenient Put Array>                      
 L<DataCop::FileType::FormDB/methods [3] - encode_record>         L<FormDB-STD/Test 007 - Strict Put Array>                       
 L<DataCop::FileType::FormDB/methods [3] - encode_record>         L<FormDB-STD/Test 010 - Strict Binary Put Array>                
 L<DataCop::FileType::FormDB/methods [4] - decode_record>         L<FormDB-STD/Test 008 - Strict Binary Record>                   
 L<DataCop::FileType::FormDB/methods [5] - put_record>            L<FormDB-STD/Test 005 - Lenient Put Array>                      
 L<DataCop::FileType::FormDB/methods [5] - put_record>            L<FormDB-STD/Test 007 - Strict Put Array>                       
 L<DataCop::FileType::FormDB/methods [5] - put_record>            L<FormDB-STD/Test 010 - Strict Binary Put Array>                
 L<DataCop::FileType::FormDB/methods [6] - get_record>            L<FormDB-STD/Test 008 - Strict Binary Record>                   
 L<DataCop::FileType::FormDB/methods [7] - get_record>            L<FormDB-STD/Test 008 - Strict Binary Record>                   
 



 
 Test                                                             Requirement                                                     
 ---------------------------------------------------------------- ----------------------------------------------------------------
 L<FormDB-STD/Test 002 - Load UUT>                                L<DataCop::FileType::FormDB/general [1] - load>                 
 L<FormDB-STD/Test 003 - No pod errors>                           L<DataCop::FileType::FormDB/general [2] - pod check>            
 L<FormDB-STD/Test 004 - Lenient Get Array>                       L<DataCop::FileType::FormDB/format [1] - separator strings>     
 L<FormDB-STD/Test 004 - Lenient Get Array>                       L<DataCop::FileType::FormDB/format [2] - separator escapes>     
 L<FormDB-STD/Test 004 - Lenient Get Array>                       L<DataCop::FileType::FormDB/format [3] - field names>           
 L<FormDB-STD/Test 004 - Lenient Get Array>                       L<DataCop::FileType::FormDB/format [4] - field names>           
 L<FormDB-STD/Test 004 - Lenient Get Array>                       L<DataCop::FileType::FormDB/format [5] - EON>                   
 L<FormDB-STD/Test 004 - Lenient Get Array>                       L<DataCop::FileType::FormDB/format [7] - Lenient EOD>           
 L<FormDB-STD/Test 004 - Lenient Get Array>                       L<DataCop::FileType::FormDB/methods [2] - decode_field>         
 L<FormDB-STD/Test 005 - Lenient Put Array>                       L<DataCop::FileType::FormDB/format [1] - separator strings>     
 L<FormDB-STD/Test 005 - Lenient Put Array>                       L<DataCop::FileType::FormDB/format [2] - separator escapes>     
 L<FormDB-STD/Test 005 - Lenient Put Array>                       L<DataCop::FileType::FormDB/format [3] - field names>           
 L<FormDB-STD/Test 005 - Lenient Put Array>                       L<DataCop::FileType::FormDB/format [4] - field names>           
 L<FormDB-STD/Test 005 - Lenient Put Array>                       L<DataCop::FileType::FormDB/format [5] - EON>                   
 L<FormDB-STD/Test 005 - Lenient Put Array>                       L<DataCop::FileType::FormDB/format [7] - Lenient EOD>           
 L<FormDB-STD/Test 005 - Lenient Put Array>                       L<DataCop::FileType::FormDB/methods [1] - encode_field>         
 L<FormDB-STD/Test 005 - Lenient Put Array>                       L<DataCop::FileType::FormDB/methods [3] - encode_record>        
 L<FormDB-STD/Test 005 - Lenient Put Array>                       L<DataCop::FileType::FormDB/methods [5] - put_record>           
 L<FormDB-STD/Test 006 - Strict Get Array>                        L<DataCop::FileType::FormDB/format [1] - separator strings>     
 L<FormDB-STD/Test 006 - Strict Get Array>                        L<DataCop::FileType::FormDB/format [2] - separator escapes>     
 L<FormDB-STD/Test 006 - Strict Get Array>                        L<DataCop::FileType::FormDB/format [3] - field names>           
 L<FormDB-STD/Test 006 - Strict Get Array>                        L<DataCop::FileType::FormDB/format [4] - field names>           
 L<FormDB-STD/Test 006 - Strict Get Array>                        L<DataCop::FileType::FormDB/format [5] - EON>                   
 L<FormDB-STD/Test 006 - Strict Get Array>                        L<DataCop::FileType::FormDB/format [6] - Strict EOD>            
 L<FormDB-STD/Test 006 - Strict Get Array>                        L<DataCop::FileType::FormDB/methods [2] - decode_field>         
 L<FormDB-STD/Test 007 - Strict Put Array>                        L<DataCop::FileType::FormDB/format [1] - separator strings>     
 L<FormDB-STD/Test 007 - Strict Put Array>                        L<DataCop::FileType::FormDB/format [2] - separator escapes>     
 L<FormDB-STD/Test 007 - Strict Put Array>                        L<DataCop::FileType::FormDB/format [3] - field names>           
 L<FormDB-STD/Test 007 - Strict Put Array>                        L<DataCop::FileType::FormDB/format [4] - field names>           
 L<FormDB-STD/Test 007 - Strict Put Array>                        L<DataCop::FileType::FormDB/format [5] - EON>                   
 L<FormDB-STD/Test 007 - Strict Put Array>                        L<DataCop::FileType::FormDB/format [6] - Strict EOD>            
 L<FormDB-STD/Test 007 - Strict Put Array>                        L<DataCop::FileType::FormDB/methods [1] - encode_field>         
 L<FormDB-STD/Test 007 - Strict Put Array>                        L<DataCop::FileType::FormDB/methods [3] - encode_record>        
 L<FormDB-STD/Test 007 - Strict Put Array>                        L<DataCop::FileType::FormDB/methods [5] - put_record>           
 L<FormDB-STD/Test 008 - Strict Binary Record>                    L<DataCop::FileType::FormDB/format [1] - separator strings>     
 L<FormDB-STD/Test 008 - Strict Binary Record>                    L<DataCop::FileType::FormDB/format [2] - separator escapes>     
 L<FormDB-STD/Test 008 - Strict Binary Record>                    L<DataCop::FileType::FormDB/format [3] - field names>           
 L<FormDB-STD/Test 008 - Strict Binary Record>                    L<DataCop::FileType::FormDB/format [4] - field names>           
 L<FormDB-STD/Test 008 - Strict Binary Record>                    L<DataCop::FileType::FormDB/format [5] - EON>                   
 L<FormDB-STD/Test 008 - Strict Binary Record>                    L<DataCop::FileType::FormDB/format [6] - Strict EOD>            
 L<FormDB-STD/Test 008 - Strict Binary Record>                    L<DataCop::FileType::FormDB/methods [4] - decode_record>        
 L<FormDB-STD/Test 008 - Strict Binary Record>                    L<DataCop::FileType::FormDB/methods [6] - get_record>           
 L<FormDB-STD/Test 008 - Strict Binary Record>                    L<DataCop::FileType::FormDB/methods [7] - get_record>           
 L<FormDB-STD/Test 009 - Strict Binary Get Array>                 L<DataCop::FileType::FormDB/format [1] - separator strings>     
 L<FormDB-STD/Test 009 - Strict Binary Get Array>                 L<DataCop::FileType::FormDB/format [2] - separator escapes>     
 L<FormDB-STD/Test 009 - Strict Binary Get Array>                 L<DataCop::FileType::FormDB/format [3] - field names>           
 L<FormDB-STD/Test 009 - Strict Binary Get Array>                 L<DataCop::FileType::FormDB/format [4] - field names>           
 L<FormDB-STD/Test 009 - Strict Binary Get Array>                 L<DataCop::FileType::FormDB/format [5] - EON>                   
 L<FormDB-STD/Test 009 - Strict Binary Get Array>                 L<DataCop::FileType::FormDB/format [6] - Strict EOD>            
 L<FormDB-STD/Test 009 - Strict Binary Get Array>                 L<DataCop::FileType::FormDB/methods [2] - decode_field>         
 L<FormDB-STD/Test 010 - Strict Binary Put Array>                 L<DataCop::FileType::FormDB/format [1] - separator strings>     
 L<FormDB-STD/Test 010 - Strict Binary Put Array>                 L<DataCop::FileType::FormDB/format [2] - separator escapes>     
 L<FormDB-STD/Test 010 - Strict Binary Put Array>                 L<DataCop::FileType::FormDB/format [3] - field names>           
 L<FormDB-STD/Test 010 - Strict Binary Put Array>                 L<DataCop::FileType::FormDB/format [4] - field names>           
 L<FormDB-STD/Test 010 - Strict Binary Put Array>                 L<DataCop::FileType::FormDB/format [5] - EON>                   
 L<FormDB-STD/Test 010 - Strict Binary Put Array>                 L<DataCop::FileType::FormDB/format [6] - Strict EOD>            
 L<FormDB-STD/Test 010 - Strict Binary Put Array>                 L<DataCop::FileType::FormDB/methods [1] - encode_field>         
 L<FormDB-STD/Test 010 - Strict Binary Put Array>                 L<DataCop::FileType::FormDB/methods [3] - encode_record>        
 L<FormDB-STD/Test 010 - Strict Binary Put Array>                 L<DataCop::FileType::FormDB/methods [5] - put_record>           
 



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

L<DataCop::FileType::FormDB>

=back

=cut

__END__


### end of file ###

