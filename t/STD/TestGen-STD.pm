#!perl
#
#
package TestGen-STD;

use 5.001;
use strict;
use warnings;
use warnings::register;

use vars qw($VERSION $DATE);
$VERSION = '0.02';   # automatically generated file
$DATE = '2003/06/04';

##### Software Test Description ####
#
# The module STD::TestGen generated this program module from the contents of
#
# STD\testgen.std
#
# Don't edit this program module file. Edit instead
#
# STD\testgen.std
#
#	ANY CHANGES MADE HERE TO THIS SCRIPT FILE WILL BE LOST
#
#       the next time STD::TestGen generates this program module file.
#
#


=head1 TITLE PAGE

 Software Test Description

 for

 Perl STD::TestGen

 Revision: -

 Date: 2003/06/04

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
Perl L<STD::TestGen|STD::TestGen> 

=head2 Identification

The Software Version Description (SVD) for STD::TestGen,
L<SVD::Military-STD2167A|SVD::Military-STD2167A>,
provides configuration, version, and installation information:

=head2 System overview

The system is the Perl programming language software
established by the L<SEE ALSO|SEE ALSO> references.

=head2 1.3 Document overview

This document establishes the tests to verify the requirements
specified in the Perl Plain Old Documentation (POD)
of the L<STD::TestGen|STD::TestGen>.
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
determine if the STD::TestGen program module is installed.
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

 TestGen.t

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
as specifed in the L<STD::TestGen|STD::TestGen>, 
Plain Old Documentation (POD).
These test descriptions contain 14 tests.

A unique test identification used herein consists of the
the test number that is produce by executing the Perl 
test script file:

 TestGen.t

The unique test number id within this module
and the the unique Perl identification for
this module, L<STD\testgen.std|STD\testgen.std>, 
provide an unique Perl system wide identifier of the test.

There are no safety procautions or security
and privacy considerations for any of the tests
or test cases.


=head2 Test 001 - UUT not loaded

=over 4

=item Test 001 - UUT not loaded - Requirements addressed

None.

=item Test 001 - UUT not loaded - Test

     use vars qw($loaded);
     use File::Glob ':glob';
     use File::Copy;

     my $test_results;
     my $loaded = 0;
     my @outputs;
     @outputs = bsd_glob( 'tg*1.*' );
     unlink @outputs;
     @outputs = bsd_glob( 'tg*1-STD.pm');
     unlink @outputs;

     #### 
     #  Use the test software to generate the test of the test software
     #   
     #  tg -o="clean all" TestGen.std
     # 
     #  0 - series is used to generate an test case test script
     #
     #      generate all output files by 
     #          tg -o=clean TestGen0.std TestGen1.std
     #          tg -o=all TestGen1.std
     #
     #  1 - this is the actual value test case
     #      thus, TestGen1.std is used to produce actual test results
     #
     #  2 - this series is the expected test results
     # 
     #
     # make no residue outputs from last test series
     #
     #  unlink <tg1*.*>;  causes subsequent bsd_blog calls to crash
     #;
$loaded = $T->is_package_loaded('STD::TestGen')

=item Test 001 - UUT not loaded - Expected Test Results

 ''



=back

=cut


=head2 Test 002 - Load UUT

=over 4

=item Test 002 - Load UUT - Requirements addressed

L<STD::TestGen/load [1]>

=item Test 002 - Load UUT - Test

 my $errors = $T->load_package( 'STD::TestGen' );
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

L<STD::TestGen/pod check [2]>

=item Test 003 - No pod errors - Test

 $T->pod_errors( 'STD::TestGen')

=item Test 003 - No pod errors - Expected Test Results

 0



=back

=cut


=head2 Test 004 - Generated tgA1-STD.std

=over 4

=item Test 004 - Generated tgA1-STD.std - Requirements addressed

L<STD::TestGen/STD file [1]>, L<STD::TestGen/STD file [2]>

=item Test 004 - Generated tgA1-STD.std - Test

     copy 'tg0.pm', 'tg1.pm';
     copy 'tgA0.std', 'tgA1.std';
     STD::TestGen->fgenerate('STD/tgA0.std', {fspec_in=>'Unix', output=>'clean', file_out=>'tgAx1.std'});
 STD::TestGen->fgenerate('STD/tgB0.std', {fspec_in=>'Unix', output=>'clean', file_out=>'tgBy1.std'});
     #####
     # Make sure there is no residue outputs hanging
     # around from the last test series.
     #
     @outputs = bsd_glob( 'tg*1.*' );
     unlink @outputs;
     @outputs = bsd_glob( 'tg*1-STD.pm');
     unlink @outputs;
 copy 'tgA0.std', 'tgA1.std';
 copy 'tg0.pm', 'tg1.pm';
 STD::TestGen->fgenerate('STD/tgA1.std', {fspec_in=>'Unix', output=>'clean all'} );
$T->scrub_date_version($T->fin('tgA1-STD.pm'))

=item Test 004 - Generated tgA1-STD.std - Expected Test Results

 '#!perl
  #
  #
  package tgA1-STD;

  use 5.001;
  use strict;
  use warnings;
  use warnings::register;

  use vars qw($VERSION $DATE);
  $VERSION = '0.00'
  ;   # automatically generated file
  $DATE = 'Jan 1, 2000'
  ;

  ##### Software Test Description ####
  #
  # The module STD::TestGen generated this program module from the contents of
  #
  # STD/tgA1.std
  #
  # Don't edit this program module file. Edit instead
  #
  # STD/tgA1.std
  #
  #	ANY CHANGES MADE HERE TO THIS SCRIPT FILE WILL BE LOST
  #
  #       the next time STD::TestGen generates this program module file.
  #
  #


  =head1 TITLE PAGE

   Software Test Description

   for

   Perl STD::tg1

   Revision: -

   $DATE: Jan 1, 2000

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
  Perl L<STD::tg1|STD::tg1> 

  =head2 Identification

  The Software Version Description (SVD) for STD::tg1,
  L<None|None>,
  provides configuration, version, and installation information:

  =head2 System overview

  The system is the Perl programming language software
  established by the L<SEE ALSO|SEE ALSO> references.

  =head2 1.3 Document overview

  This document establishes the tests to verify the requirements
  specified in the Perl Plain Old Documentation (POD)
  of the L<STD::tg1|STD::tg1>.
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
  determine if the STD::tg1 program module is installed.
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

   tgA1.t

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
  as specifed in the L<STD::tg1|STD::tg1>, 
  Plain Old Documentation (POD).
  These test descriptions contain 16 tests.

  A unique test identification used herein consists of the
  the test number that is produce by executing the Perl 
  test script file:

   tgA1.t

  The unique test number id within this module
  and the the unique Perl identification for
  this module, L<STD/tgA1.std|STD/tgA1.std>, 
  provide an unique Perl system wide identifier of the test.

  There are no safety procautions or security
  and privacy considerations for any of the tests
  or test cases.


  =head2 Test 001 - Pass test

  =over 4

  =item Test 001 - Pass test - Requirements addressed

  L<STD::t::tg1/capability-A [1]>

  =item Test 001 - Pass test - Test

   my $x = 2;
   my $y = 3;
  $x + $y

  =item Test 001 - Pass test - Expected Test Results

   '5'

  =item Test 001 - Pass test - Test procedure Conditions

  Skip rest of tests on failure. 



  =back

  =cut


  =head2 Test 002 - Todo test that passes

  =over 4

  =item Test 002 - Todo test that passes - Requirements addressed

  None.

  =item Test 002 - Todo test that passes - Test

   ($x+$y,$y-$x)

  =item Test 002 - Todo test that passes - Expected Test Results

   '5'
    '1'

  =item Test 002 - Todo test that passes - Test procedure Conditions


  Skip. xy feature under development.




  =back

  =cut


  =head2 Test 003 - Test that fails

  =over 4

  =item Test 003 - Test that fails - Requirements addressed

  L<STD::t::tg1/capability-A [2]>, L<STD::t::tg1/Capability-B [1]>

  =item Test 003 - Test that fails - Test

   ($x+4,$x*$y)

  =item Test 003 - Test that fails - Expected Test Results

   '6'
    '5'



  =back

  =cut


  =head2 Test 004 - Skipped tests

  =over 4

  =item Test 004 - Skipped tests - Requirements addressed

  None.

  =item Test 004 - Skipped tests - Test

   $x*$y*2

  =item Test 004 - Skipped tests - Expected Test Results

   Test skipped because the following evaluated true:

    1



  =back

  =cut


  =head2 Test 005 - Todo Test that Fails

  =over 4

  =item Test 005 - Todo Test that Fails - Requirements addressed

  None.

  =item Test 005 - Todo Test that Fails - Test

   $x*$y*2

  =item Test 005 - Todo Test that Fails - Expected Test Results

   '6'

  =item Test 005 - Todo Test that Fails - Test procedure Conditions


  Skip. zyw feature under development.




  =back

  =cut


  =head2 Test 006 - verify only

  =over 4

  =item Test 006 - verify only - Requirements addressed

  None.

  =item Test 006 - verify only - Test

   $x

  =item Test 006 - verify only - Expected Test Results

   2



  =back

  =cut


  =head2 Test 007 - Test loop

  =over 4

  =item Test 007 - Test loop - Requirements addressed

  None.

  =item Test 007 - Test loop - Test

       my @expected = ('200','201','202');
       my $i;
       for( $i=0; $i < 3; $i++) {;
  $i+200

  =item Test 007 - Test loop - Expected Test Results

   '200'



  =back

  =cut


  =head2 Test 008

  =over 4

  =item Test 008 - Requirements addressed

  None.

  =item Test 008 - Test

   $i + ($x * 100)

  =item Test 008 - Expected Test Results

   '200'



  =back

  =cut


  =head2 Test 009

  =over 4

  =item Test 009 - Requirements addressed

  None.

  =item Test 009 - Test

       my @expected = ('200','201','202');
       my $i;
       for( $i=0; $i < 3; $i++) {;
  $i+200

  =item Test 009 - Expected Test Results

   '201'



  =back

  =cut


  =head2 Test 010

  =over 4

  =item Test 010 - Requirements addressed

  None.

  =item Test 010 - Test

   $i + ($x * 100)

  =item Test 010 - Expected Test Results

   '201'



  =back

  =cut


  =head2 Test 011

  =over 4

  =item Test 011 - Requirements addressed

  None.

  =item Test 011 - Test

       my @expected = ('200','201','202');
       my $i;
       for( $i=0; $i < 3; $i++) {;
  $i+200

  =item Test 011 - Expected Test Results

   '202'



  =back

  =cut


  =head2 Test 012

  =over 4

  =item Test 012 - Requirements addressed

  None.

  =item Test 012 - Test

   $i + ($x * 100)

  =item Test 012 - Expected Test Results

   '202'



  =back

  =cut


  =head2 Test 013 - Failed test that skips the rest

  =over 4

  =item Test 013 - Failed test that skips the rest - Requirements addressed

  L<STD::t::tg1/Capability-B [2]>

  =item Test 013 - Failed test that skips the rest - Test

       };
  $x + $y

  =item Test 013 - Failed test that skips the rest - Expected Test Results

   '6'

  =item Test 013 - Failed test that skips the rest - Test procedure Conditions

  Skip rest of tests on failure. 



  =back

  =cut


  =head2 Test 014 - A test to skip

  =over 4

  =item Test 014 - A test to skip - Requirements addressed

  None.

  =item Test 014 - A test to skip - Test

   $x + $y + $x

  =item Test 014 - A test to skip - Expected Test Results

   '9'



  =back

  =cut


  =head2 Test 015 - A not skip to skip

  =over 4

  =item Test 015 - A not skip to skip - Requirements addressed

  L<STD::t::tg1/Capability-B [3]>

  =item Test 015 - A not skip to skip - Test

   $x + $y + $x + $y

  =item Test 015 - A not skip to skip - Expected Test Results

   '10'



  =back

  =cut


  =head2 Test 016 - A skip to skip

  =over 4

  =item Test 016 - A skip to skip - Requirements addressed

  L<STD::t::tg1/Capability-B [3]>

  =item Test 016 - A skip to skip - Test

   $x + $y + $x + $y + $x

  =item Test 016 - A skip to skip - Expected Test Results

   Test skipped because the following evaluated true:

    1



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
   L<STD::t::tg1/Capability-B [1]>                                  L<tgA1-STD/Test 003 - Test that fails>                          
   L<STD::t::tg1/Capability-B [2]>                                  L<tgA1-STD/Test 013 - Failed test that skips the rest>          
   L<STD::t::tg1/Capability-B [3]>                                  L<tgA1-STD/Test 015 - A not skip to skip>                       
   L<STD::t::tg1/Capability-B [3]>                                  L<tgA1-STD/Test 016 - A skip to skip>                           
   L<STD::t::tg1/capability-A [1]>                                  L<tgA1-STD/Test 001 - Pass test>                                
   L<STD::t::tg1/capability-A [2]>                                  L<tgA1-STD/Test 003 - Test that fails>                          
   



   
   Test                                                             Requirement                                                     
   ---------------------------------------------------------------- ----------------------------------------------------------------
   L<tgA1-STD/Test 001 - Pass test>                                 L<STD::t::tg1/capability-A [1]>                                 
   L<tgA1-STD/Test 003 - Test that fails>                           L<STD::t::tg1/Capability-B [1]>                                 
   L<tgA1-STD/Test 003 - Test that fails>                           L<STD::t::tg1/capability-A [2]>                                 
   L<tgA1-STD/Test 013 - Failed test that skips the rest>           L<STD::t::tg1/Capability-B [2]>                                 
   L<tgA1-STD/Test 015 - A not skip to skip>                        L<STD::t::tg1/Capability-B [3]>                                 
   L<tgA1-STD/Test 016 - A skip to skip>                            L<STD::t::tg1/Capability-B [3]>                                 
   



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

  Public Domain

  #######
  #
  #  2. REFERENCED DOCUMENTS
  #
  #
  #

  =head1 SEE ALSO

  http://perl.softwarediamonds.com
  L<STD::t::tg1>

  =back

  =cut

  __END__


  ### end of file ###

  '



=back

=cut


=head2 Test 005 - Demonstration script

=over 4

=item Test 005 - Demonstration script - Requirements addressed

L<STD::TestGen/demo file [1]>, L<STD::TestGen/demo file [2]>

=item Test 005 - Demonstration script - Test

 $test_results = `perl tgA1.d`;
 $T->fout('tgA1.txt', $test_results);
$test_results

=item Test 005 - Demonstration script - Expected Test Results

 '
   ~~~~~~ Demonstration overview ~~~~~
   
  Perl code begins with the prompt

   =>

  The selected results from executing the Perl Code 
  follow on the next lines. For example,

   => 2 + 2
   4

   ~~~~~~ The demonstration follows ~~~~~

   => my $x = 2
   => my $y = 3
   => $x + $y
   '5'
   
   => ($x+$y,$y-$x)
   '5'
   '1'
   
   => ($x+4,$x*$y)
   '6'
   '6'
   
   => $x*$y*2
   '12'
   
   => $x
   2
   
   =>     my @expected = ('200','201','202');
   =>     my $i;
   =>     for( $i=0; $i < 3; $i++) {
   => $i+200
   '200'
   
   => $i + ($x * 100)
   '200'
   
   =>     };
   => $i+200
   '201'
   
   => $i + ($x * 100)
   '201'
   
   =>     };
   => $i+200
   '202'
   
   => $i + ($x * 100)
   '202'
   
   =>     };
   => $x + $y
   '5'
   
   => $x + $y + $x
   '7'
   
   => $x + $y + $x + $y
   '10'
   
  '



=back

=cut


=head2 Test 006 - Generated and execute the test script

=over 4

=item Test 006 - Generated and execute the test script - Requirements addressed

L<STD::TestGen/verify file [1]>, L<STD::TestGen/verify file [2]>, L<STD::TestGen/verify file [3]>

=item Test 006 - Generated and execute the test script - Test

 $test_results = `perl tgA1.t`;
 $T->fout('tgA1.txt', $test_results);
$T->scrub_file_line($test_results)

=item Test 006 - Generated and execute the test script - Expected Test Results

 '1..16 todo 2 5;
  # Pass test
  ok 1
  # Todo test that passes
  ok 2 # (xxxx.t at line 000 TODO?!)
  # Test that fails
  not ok 3
  # Test 3 got: '$VAR1 = '6';
  $VAR2 = '6';
  ' (xxxx.t at line 000)
  #   Expected: '$VAR1 = '6';
  $VAR2 = '5';
  '
  # Skipped tests
  ok 4 # skip
  # Todo Test that Fails
  not ok 5
  # Test 5 got: '$VAR1 = '12';
  ' (xxxx.t at line 000 *TODO*)
  #   Expected: '$VAR1 = '6';
  '
  # verify only
  ok 6
  # Test loop
  ok 7
  # Test loop
  ok 8
  # Test loop
  ok 9
  # Test loop
  ok 10
  # Test loop
  ok 11
  # Test loop
  ok 12
  # Failed test that skips the rest
  not ok 13
  # Test 13 got: '$VAR1 = '5';
  ' (xxxx.t at line 000)
  #    Expected: '$VAR1 = '6';
  '
  # A test to skip
  # Test invalid because of previous failure.
  ok 14 # skip
  # A not skip to skip
  # Test invalid because of previous failure.
  ok 15 # skip
  # A skip to skip
  # Test invalid because of previous failure.
  ok 16 # skip
  '



=back

=cut


=head2 Test 007 - Generate a clean file

=over 4

=item Test 007 - Generate a clean file - Requirements addressed

L<STD::TestGen/clean file [1]>, L<STD::TestGen/clean file [2]>, L<STD::TestGen/clean file [3]>, L<STD::TestGen/clean file [4]>, L<STD::TestGen/clean file [5]>

=item Test 007 - Generate a clean file - Test

     #########
     #
     # Individual generate outputs using options
     #
     ########

     #####
     # Make sure there is no residue outputs hanging
     # around from the last test series.
     #
     @outputs = bsd_glob( 'tg*1.*' );
     unlink @outputs;
     @outputs = bsd_glob( 'tg*1-STD.pm');
     unlink @outputs;
 copy 'tg0.pm', 'tg1.pm';
 copy 'tgA0.std', 'tgA1.std';
 STD::TestGen->fgenerate('STD/tgA1.std', {fspec_in=>'Unix', output=>'clean'});
$T->scrub_file_line($T->fin('tgA1.std'))

=item Test 007 - Generate a clean file - Expected Test Results

 '


  File_Spec: Unix^
  UUT: STD/tg1.pm^
  Revision: -^
  End_User: General Public^
  Author: http://www.SoftwareDiamonds.com support@SoftwareDiamonds.com^
  SVD: None^
  Template: STD/STD001.frm^
  Classification: None^
  Temp: temp.pl^
  Clean: tgA1.std^
  Demo: tgA1.d^
  STD: tgA1-STD.pm^
  Verify: tgA1.t^


   T: 16 - 2,5^

   N: Pass test^
   R: L<STD::t::tg1/capability-A [1]>^
   C: my $x = 2^
   C: my $y = 3^
   A: $x + $y^
  SE: '5'^
  ok: 1^

   N: Todo test that passes^
   U: xy feature^
   A: ($x+$y,$y-$x)^
   E: '5','1'^
  ok: 2^


   R:
      L<STD::t::tg1/capability-A [2]>
      L<STD::t::tg1/Capability-B [1]>
  ^

   N: Test that fails^
   A: ($x+4,$x*$y)^
   E: '6','5'^
  ok: 3^

   N: Skipped tests^
   S: 1^
   A: $x*$y*2^
   E: '6'^
  ok: 4^

   N: Todo Test that Fails^
   U: zyw feature^
   S: 0^
   A: $x*$y*2^
   E: '6'^
  ok: 5^

   N: demo only^
  DO: ^
   A: $x^
   E: $y^
   N: verify only^
  VO: ^
   A: $x^
   E: $x^
  ok: 6^

   N: Test loop^

   C:
      my @expected = ('200','201','202');
      my $i;
      for( $i=0; $i < 3; $i++) {
  ^

   A: $i+200^
   E: $expected[$i]^
  ok: 7,9,11^

   A: $i + ($x * 100)^
   E: $expected[$i]^
  ok: 8,10,12^

   C:     };^
   N: Failed test that skips the rest^
   R: L<STD::t::tg1/Capability-B [2]>^
   A: $x + $y^
  SE: '6'^
  ok: 13^

   N: A test to skip^
   A: $x + $y + $x^
   E: '9'^
  ok: 14^

   N: A not skip to skip^
   S: 0^
   R: L<STD::t::tg1/Capability-B [3]>^
   A: $x + $y + $x + $y^
   E: '10'^
  ok: 15^

   N: A skip to skip^
   S: 1^
   R: L<STD::t::tg1/Capability-B [3]>^
   A: $x + $y + $x + $y + $x^
   E: '10'^
  ok: 16^





  See_Also:
  http://perl.softwarediamonds.com
  L<STD::t::tg1>
  ^

  Copyright: Public Domain^



  ~-~
  '



=back

=cut


=head2 Test 008 - Generate a STD

=over 4

=item Test 008 - Generate a STD - Requirements addressed

L<STD::TestGen/STD file [1]>, L<STD::TestGen/STD file [2]>

=item Test 008 - Generate a STD - Test

 STD::TestGen->fgenerate('STD/tgA1.std', {fspec_in=>'Unix', output=>'STD'} );
$T->scrub_date_version($T->fin('tgA1-STD.pm'))

=item Test 008 - Generate a STD - Expected Test Results

 '#!perl
  #
  #
  package tgA1-STD;

  use 5.001;
  use strict;
  use warnings;
  use warnings::register;

  use vars qw($VERSION $DATE);
  $VERSION = '0.00'
  ;   # automatically generated file
  $DATE = 'Jan 1, 2000'
  ;

  ##### Software Test Description ####
  #
  # The module STD::TestGen generated this program module from the contents of
  #
  # STD/tgA1.std
  #
  # Don't edit this program module file. Edit instead
  #
  # STD/tgA1.std
  #
  #	ANY CHANGES MADE HERE TO THIS SCRIPT FILE WILL BE LOST
  #
  #       the next time STD::TestGen generates this program module file.
  #
  #


  =head1 TITLE PAGE

   Software Test Description

   for

   Perl STD::tg1

   Revision: -

   $DATE: Jan 1, 2000

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
  Perl L<STD::tg1|STD::tg1> 

  =head2 Identification

  The Software Version Description (SVD) for STD::tg1,
  L<None|None>,
  provides configuration, version, and installation information:

  =head2 System overview

  The system is the Perl programming language software
  established by the L<SEE ALSO|SEE ALSO> references.

  =head2 1.3 Document overview

  This document establishes the tests to verify the requirements
  specified in the Perl Plain Old Documentation (POD)
  of the L<STD::tg1|STD::tg1>.
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
  determine if the STD::tg1 program module is installed.
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

   tgA1.t

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
  as specifed in the L<STD::tg1|STD::tg1>, 
  Plain Old Documentation (POD).
  These test descriptions contain 16 tests.

  A unique test identification used herein consists of the
  the test number that is produce by executing the Perl 
  test script file:

   tgA1.t

  The unique test number id within this module
  and the the unique Perl identification for
  this module, L<STD/tgA1.std|STD/tgA1.std>, 
  provide an unique Perl system wide identifier of the test.

  There are no safety procautions or security
  and privacy considerations for any of the tests
  or test cases.


  =head2 Test 001 - Pass test

  =over 4

  =item Test 001 - Pass test - Requirements addressed

  L<STD::t::tg1/capability-A [1]>

  =item Test 001 - Pass test - Test

   my $x = 2;
   my $y = 3;
  $x + $y

  =item Test 001 - Pass test - Expected Test Results

   '5'

  =item Test 001 - Pass test - Test procedure Conditions

  Skip rest of tests on failure. 



  =back

  =cut


  =head2 Test 002 - Todo test that passes

  =over 4

  =item Test 002 - Todo test that passes - Requirements addressed

  None.

  =item Test 002 - Todo test that passes - Test

   ($x+$y,$y-$x)

  =item Test 002 - Todo test that passes - Expected Test Results

   '5'
    '1'

  =item Test 002 - Todo test that passes - Test procedure Conditions


  Skip. xy feature under development.




  =back

  =cut


  =head2 Test 003 - Test that fails

  =over 4

  =item Test 003 - Test that fails - Requirements addressed

  L<STD::t::tg1/capability-A [2]>, L<STD::t::tg1/Capability-B [1]>

  =item Test 003 - Test that fails - Test

   ($x+4,$x*$y)

  =item Test 003 - Test that fails - Expected Test Results

   '6'
    '5'



  =back

  =cut


  =head2 Test 004 - Skipped tests

  =over 4

  =item Test 004 - Skipped tests - Requirements addressed

  None.

  =item Test 004 - Skipped tests - Test

   $x*$y*2

  =item Test 004 - Skipped tests - Expected Test Results

   Test skipped because the following evaluated true:

    1



  =back

  =cut


  =head2 Test 005 - Todo Test that Fails

  =over 4

  =item Test 005 - Todo Test that Fails - Requirements addressed

  None.

  =item Test 005 - Todo Test that Fails - Test

   $x*$y*2

  =item Test 005 - Todo Test that Fails - Expected Test Results

   '6'

  =item Test 005 - Todo Test that Fails - Test procedure Conditions


  Skip. zyw feature under development.




  =back

  =cut


  =head2 Test 006 - verify only

  =over 4

  =item Test 006 - verify only - Requirements addressed

  None.

  =item Test 006 - verify only - Test

   $x

  =item Test 006 - verify only - Expected Test Results

   2



  =back

  =cut


  =head2 Test 007 - Test loop

  =over 4

  =item Test 007 - Test loop - Requirements addressed

  None.

  =item Test 007 - Test loop - Test

       my @expected = ('200','201','202');
       my $i;
       for( $i=0; $i < 3; $i++) {;
  $i+200

  =item Test 007 - Test loop - Expected Test Results

   '200'



  =back

  =cut


  =head2 Test 008

  =over 4

  =item Test 008 - Requirements addressed

  None.

  =item Test 008 - Test

   $i + ($x * 100)

  =item Test 008 - Expected Test Results

   '200'



  =back

  =cut


  =head2 Test 009

  =over 4

  =item Test 009 - Requirements addressed

  None.

  =item Test 009 - Test

       my @expected = ('200','201','202');
       my $i;
       for( $i=0; $i < 3; $i++) {;
  $i+200

  =item Test 009 - Expected Test Results

   '201'



  =back

  =cut


  =head2 Test 010

  =over 4

  =item Test 010 - Requirements addressed

  None.

  =item Test 010 - Test

   $i + ($x * 100)

  =item Test 010 - Expected Test Results

   '201'



  =back

  =cut


  =head2 Test 011

  =over 4

  =item Test 011 - Requirements addressed

  None.

  =item Test 011 - Test

       my @expected = ('200','201','202');
       my $i;
       for( $i=0; $i < 3; $i++) {;
  $i+200

  =item Test 011 - Expected Test Results

   '202'



  =back

  =cut


  =head2 Test 012

  =over 4

  =item Test 012 - Requirements addressed

  None.

  =item Test 012 - Test

   $i + ($x * 100)

  =item Test 012 - Expected Test Results

   '202'



  =back

  =cut


  =head2 Test 013 - Failed test that skips the rest

  =over 4

  =item Test 013 - Failed test that skips the rest - Requirements addressed

  L<STD::t::tg1/Capability-B [2]>

  =item Test 013 - Failed test that skips the rest - Test

       };
  $x + $y

  =item Test 013 - Failed test that skips the rest - Expected Test Results

   '6'

  =item Test 013 - Failed test that skips the rest - Test procedure Conditions

  Skip rest of tests on failure. 



  =back

  =cut


  =head2 Test 014 - A test to skip

  =over 4

  =item Test 014 - A test to skip - Requirements addressed

  None.

  =item Test 014 - A test to skip - Test

   $x + $y + $x

  =item Test 014 - A test to skip - Expected Test Results

   '9'



  =back

  =cut


  =head2 Test 015 - A not skip to skip

  =over 4

  =item Test 015 - A not skip to skip - Requirements addressed

  L<STD::t::tg1/Capability-B [3]>

  =item Test 015 - A not skip to skip - Test

   $x + $y + $x + $y

  =item Test 015 - A not skip to skip - Expected Test Results

   '10'



  =back

  =cut


  =head2 Test 016 - A skip to skip

  =over 4

  =item Test 016 - A skip to skip - Requirements addressed

  L<STD::t::tg1/Capability-B [3]>

  =item Test 016 - A skip to skip - Test

   $x + $y + $x + $y + $x

  =item Test 016 - A skip to skip - Expected Test Results

   Test skipped because the following evaluated true:

    1



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
   L<STD::t::tg1/Capability-B [1]>                                  L<tgA1-STD/Test 003 - Test that fails>                          
   L<STD::t::tg1/Capability-B [2]>                                  L<tgA1-STD/Test 013 - Failed test that skips the rest>          
   L<STD::t::tg1/Capability-B [3]>                                  L<tgA1-STD/Test 015 - A not skip to skip>                       
   L<STD::t::tg1/Capability-B [3]>                                  L<tgA1-STD/Test 016 - A skip to skip>                           
   L<STD::t::tg1/capability-A [1]>                                  L<tgA1-STD/Test 001 - Pass test>                                
   L<STD::t::tg1/capability-A [2]>                                  L<tgA1-STD/Test 003 - Test that fails>                          
   



   
   Test                                                             Requirement                                                     
   ---------------------------------------------------------------- ----------------------------------------------------------------
   L<tgA1-STD/Test 001 - Pass test>                                 L<STD::t::tg1/capability-A [1]>                                 
   L<tgA1-STD/Test 003 - Test that fails>                           L<STD::t::tg1/Capability-B [1]>                                 
   L<tgA1-STD/Test 003 - Test that fails>                           L<STD::t::tg1/capability-A [2]>                                 
   L<tgA1-STD/Test 013 - Failed test that skips the rest>           L<STD::t::tg1/Capability-B [2]>                                 
   L<tgA1-STD/Test 015 - A not skip to skip>                        L<STD::t::tg1/Capability-B [3]>                                 
   L<tgA1-STD/Test 016 - A skip to skip>                            L<STD::t::tg1/Capability-B [3]>                                 
   



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

  Public Domain

  #######
  #
  #  2. REFERENCED DOCUMENTS
  #
  #
  #

  =head1 SEE ALSO

  http://perl.softwarediamonds.com
  L<STD::t::tg1>

  =back

  =cut

  __END__


  ### end of file ###

  '



=back

=cut


=head2 Test 009 - Generate and replace a demonstration

=over 4

=item Test 009 - Generate and replace a demonstration - Requirements addressed

L<STD::TestGen/demo file [1]>, L<STD::TestGen/demo file [2]>, L<STD::TestGen/replace [2]>

=item Test 009 - Generate and replace a demonstration - Test

 STD::TestGen->fgenerate('STD/tgA1.std', {fspec_in=>'Unix', output=>'demo', replace => 1});
$T->scrub_date_version($T->fin('tg1.pm'))

=item Test 009 - Generate and replace a demonstration - Expected Test Results

 '#!perl
  #
  # Documentation, copyright and license is at the end of this file.
  #
  package  STD::tg1;

  use 5.001;
  use strict;
  use warnings;
  use warnings::register;

  use vars qw($VERSION);

  $VERSION = '0.00'
  ;

  1

  __END__

  =head1 Requirements

  =head2 Capability-A 

  The requriements are as follows:

  =over 4

  =item capability-A [1]

  This subroutine shall[1] have feature 1. 

  =item capability-A [2]

  This subroutine shall[2] have feature 2.

  =back

  =head2 Capability-B
   
  =over 4

  =item Capability-B [1]

  This subroutine shall[1] have feature 1.

  =item Capability-B [2]

  This subroutine shall[2] have feature 2.

  =item Capability-B [3]

  This subroutine shall[3] have feature 3.

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

   => my $x = 2
   => my $y = 3
   => $x + $y
   '5'

   => ($x+$y,$y-$x)
   '5'
   '1'

   => ($x+4,$x*$y)
   '6'
   '6'

   => $x*$y*2
   '12'

   => $x
   2

   =>     my @expected = ('200','201','202');
   =>     my $i;
   =>     for( $i=0; $i < 3; $i++) {
   => $i+200
   '200'

   => $i + ($x * 100)
   '200'

   =>     };
   => $i+200
   '201'

   => $i + ($x * 100)
   '201'

   =>     };
   => $i+200
   '202'

   => $i + ($x * 100)
   '202'

   =>     };
   => $x + $y
   '5'

   => $x + $y + $x
   '7'

   => $x + $y + $x + $y
   '10'


  =head1 SEE ALSO

  http://perl.SoftwareDiamonds.com

  '



=back

=cut


=head2 Test 010 - Generate and verbose test harness run test script

=over 4

=item Test 010 - Generate and verbose test harness run test script - Requirements addressed

L<STD::TestGen/verify file [1]>, L<STD::TestGen/verify file [2]>, L<STD::TestGen/verify file [3]>, L<STD::TestGen/verify file [4]>, L<STD::TestGen/execute [3]>, L<STD::TestGen/execute [4]>

=item Test 010 - Generate and verbose test harness run test script - Test

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
     $T->fout('tgA1.txt',$test_results);
$T->scrub_test_file($T->scrub_file_line($test_results))

=item Test 010 - Generate and verbose test harness run test script - Expected Test Results

 'SoftwareDiamonds.com - Harnessing the power of automation.

  ~~~~
  Processing STD/tgA1.std
  ~~~~
  Running Tests xxx.t 1..16 todo 2 5;
  # Pass test
  ok 1
  # Todo test that passes
  ok 2 # (xxxx.t at line 000 TODO?!)
  # Test that fails
  not ok 3
  # Test 3 got: '$VAR1 = '6';
  $VAR2 = '6';
  ' (xxxx.t at line 000)
  #   Expected: '$VAR1 = '6';
  $VAR2 = '5';
  '
  # Skipped tests
  ok 4 # skip
  # Todo Test that Fails
  not ok 5
  # Test 5 got: '$VAR1 = '12';
  ' (xxxx.t at line 000 *TODO*)
  #   Expected: '$VAR1 = '6';
  '
  # verify only
  ok 6
  # Test loop
  ok 7
  # Test loop
  ok 8
  # Test loop
  ok 9
  # Test loop
  ok 10
  # Test loop
  ok 11
  # Test loop
  ok 12
  # Failed test that skips the rest
  not ok 13
  # Test 13 got: '$VAR1 = '5';
  ' (xxxx.t at line 000)
  #    Expected: '$VAR1 = '6';
  '
  # A test to skip
  # Test invalid because of previous failure.
  ok 14 # skip
  # A not skip to skip
  # Test invalid because of previous failure.
  ok 15 # skip
  # A skip to skip
  # Test invalid because of previous failure.
  ok 16 # skip
  FAILED tests 3, 13
  	Failed 2/16 tests, 87.50% okay (-4 skipped tests: 10 okay, 62.50%)
  Failed Test                      Status Wstat Total Fail  Failed  List of Failed

    (1 subtest UNEXPECTEDLY SUCCEEDED), 4 subtests skipped.
  Failed 1/1 test scripts, 0.00% okay. 2/16 subtests failed, 87.50% okay.
  ****
  Finish Processing
  ****
  '



=back

=cut


=head2 Test 011 - Generate and test harness run test script

=over 4

=item Test 011 - Generate and test harness run test script - Requirements addressed

L<STD::TestGen/verify file [1]>, L<STD::TestGen/verify file [2]>, L<STD::TestGen/verify file [3]>, L<STD::TestGen/execute [3]>

=item Test 011 - Generate and test harness run test script - Test

     no warnings;
     open SAVEOUT, ">&STDOUT";
     use warnings;
     open STDOUT, ">tgA1.txt";
     $main::SIG{__WARN__}=\&__warn__; # kill pesty Format STDOUT and Format STDOUT_TOP redefined
     STD::TestGen->fgenerate('STD/tgA1.std', {fspec_in=>'Unix', output=>'verify', run=>1});
     $main::SIG{__WARN__}=\&CORE::warn;
     close STDOUT;
     open STDOUT, ">&SAVEOUT";

     ######
     # For some reason, test harness puts in a extra line when running u
     # under the Active debugger on Win32. So just take it out.
     # Also with absolute file, the file is chopped off, and see
     # stuff that is site dependent. Need to take it out also.
     #
     $test_results = $T->fin('tgA1.txt');
     $test_results =~ s/.*?FAILED/FAILED/; 
     $test_results =~ s/(\)\s*\n).*?\n(\s*\()/$1$2/s;
     $T->fout('TgA1.txt',$test_results);
$test_results

=item Test 011 - Generate and test harness run test script - Expected Test Results

 'FAILED tests 3, 13
  	Failed 2/16 tests, 87.50% okay (-4 skipped tests: 10 okay, 62.50%)
   (1 subtest UNEXPECTEDLY SUCCEEDED), 8 subtests skipped.
  Failed 1/1 test scripts, 0.00% okay. 2/16 subtests failed, 87.50% okay.
  '



=back

=cut


=head2 Test 012 - Change File Spec

=over 4

=item Test 012 - Change File Spec - Requirements addressed

L<STD::TestGen/fspec_in option [5]>, L<STD::TestGen/fspec_out option [6]>

=item Test 012 - Change File Spec - Test

     STD::TestGen->fgenerate('STD/tgB0.std', 
       {fspec_in=>'MSWin32', fspec_out=>'os2',  output=>'clean', 
       file_out=>'tgB1.std'});
$T->fin('tgB1.std')

=item Test 012 - Change File Spec - Expected Test Results

 '


  File_Spec: os2^
  UUT: STD/tg1.pm^
  Revision: -^
  End_User: General Public^
  Author: http://www.SoftwareDiamonds.com support@SoftwareDiamonds.com^
  SVD: None^
  Template: STD/STD001.frm^
  Classification: None^
  Temp: temp.pl^
  Clean: tg1B.std^
  Demo: tg1B.d^
  STD: tg1B-STD.pm^
  Verify: tg1B.t^


   T: 2^

   R: L<STD::t::tg1/capability-A [1]>^
   C: my $x = 2^
   C: my $y = 3^
   A: $x + $y^
  SE: '5'^
  ok: 1^

   A: ($x+$y,$y-$x)^
   E: '5','1'^
  ok: 2^





  See_Also:
  http://perl.softwarediamonds.com
  L<STD::t::tg1>
  ^

  Copyright: Public Domain^



  ~-~
  '



=back

=cut


=head2 Test 013 - Change File Spec

=over 4

=item Test 013 - Change File Spec - Requirements addressed

L<STD::TestGen/fspec_in option [5]>, L<STD::TestGen/fspec_out option [6]>

=item Test 013 - Change File Spec - Test

     STD::TestGen->fgenerate('STD/tgB0.std', 
       {fspec_in=>'os2', fspec_out=>'MacOS',  output=>'clean', 
       file_out=>'tgB1.std'});
$T->fin('tgB1.std')

=item Test 013 - Change File Spec - Expected Test Results

 '


  File_Spec: MacOS^
  UUT: STD::tg1.pm^
  Revision: -^
  End_User: General Public^
  Author: http://www.SoftwareDiamonds.com support@SoftwareDiamonds.com^
  SVD: None^
  Template: STD::STD001.frm^
  Classification: None^
  Temp: temp.pl^
  Clean: tg1B.std^
  Demo: tg1B.d^
  STD: tg1B-STD.pm^
  Verify: tg1B.t^


   T: 2^

   R: L<STD::t::tg1/capability-A [1]>^
   C: my $x = 2^
   C: my $y = 3^
   A: $x + $y^
  SE: '5'^
  ok: 1^

   A: ($x+$y,$y-$x)^
   E: '5','1'^
  ok: 2^





  See_Also:
  http://perl.softwarediamonds.com
  L<STD::t::tg1>
  ^

  Copyright: Public Domain^



  ~-~
  '



=back

=cut


=head2 Test 014 - Add to search path

=over 4

=item Test 014 - Add to search path - Requirements addressed

<STD::TestGen/dir-path option [7]>

=item Test 014 - Add to search path - Test

     use File::Spec;
     my (undef, $xdirs, undef) = File::Spec->splitpath( File::Spec->rel2abs(__FILE__) );
     my @xdirs = File::Spec->splitdir($xdirs);
     pop @xdirs;
     pop @xdirs if $xdirs[-1] eq 't';
     $xdirs = File::Spec->catdir( @xdirs );
     STD::TestGen->fgenerate('STD/tgB0.std', 
       {fspec_in=>'UNIX', dir_path => $xdirs, output=>'clean', 
         file_out=>'tgBz1.std'});
$T->fin('tgBz1.std')

=item Test 014 - Add to search path - Expected Test Results

 '


  File_Spec: Unix^
  UUT: STD/tg1.pm^
  Revision: -^
  End_User: General Public^
  Author: http://www.SoftwareDiamonds.com support@SoftwareDiamonds.com^
  SVD: None^
  Template: STD/STD001.frm^
  Classification: None^
  Temp: temp.pl^
  Clean: tg1B.std^
  Demo: tg1B.d^
  STD: tg1B-STD.pm^
  Verify: tg1B.t^


   T: 2^

   R: L<STD::t::tg1/capability-A [1]>^
   C: my $x = 2^
   C: my $y = 3^
   A: $x + $y^
  SE: '5'^
  ok: 1^

   A: ($x+$y,$y-$x)^
   E: '5','1'^
  ok: 2^





  See_Also:
  http://perl.softwarediamonds.com
  L<STD::t::tg1>
  ^

  Copyright: Public Domain^



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
 <STD::TestGen/dir-path option [7]>                               L<TestGen-STD/Test 014 - Add to search path>                    
 L<STD::TestGen/STD file [1]>                                     L<TestGen-STD/Test 004 - Generated tgA1-STD.std>                
 L<STD::TestGen/STD file [1]>                                     L<TestGen-STD/Test 008 - Generate a STD>                        
 L<STD::TestGen/STD file [2]>                                     L<TestGen-STD/Test 004 - Generated tgA1-STD.std>                
 L<STD::TestGen/STD file [2]>                                     L<TestGen-STD/Test 008 - Generate a STD>                        
 L<STD::TestGen/clean file [1]>                                   L<TestGen-STD/Test 007 - Generate a clean file>                 
 L<STD::TestGen/clean file [2]>                                   L<TestGen-STD/Test 007 - Generate a clean file>                 
 L<STD::TestGen/clean file [3]>                                   L<TestGen-STD/Test 007 - Generate a clean file>                 
 L<STD::TestGen/clean file [4]>                                   L<TestGen-STD/Test 007 - Generate a clean file>                 
 L<STD::TestGen/clean file [5]>                                   L<TestGen-STD/Test 007 - Generate a clean file>                 
 L<STD::TestGen/demo file [1]>                                    L<TestGen-STD/Test 005 - Demonstration script>                  
 L<STD::TestGen/demo file [1]>                                    L<TestGen-STD/Test 009 - Generate and replace a demonstration>  
 L<STD::TestGen/demo file [2]>                                    L<TestGen-STD/Test 005 - Demonstration script>                  
 L<STD::TestGen/demo file [2]>                                    L<TestGen-STD/Test 009 - Generate and replace a demonstration>  
 L<STD::TestGen/execute [3]>                                      L<TestGen-STD/Test 010 - Generate and verbose test harness run t
                                                                  est script>                                                     
 L<STD::TestGen/execute [3]>                                      L<TestGen-STD/Test 011 - Generate and test harness run test scri
                                                                  pt>                                                             
 L<STD::TestGen/execute [4]>                                      L<TestGen-STD/Test 010 - Generate and verbose test harness run t
                                                                  est script>                                                     
 L<STD::TestGen/fspec_in option [5]>                              L<TestGen-STD/Test 012 - Change File Spec>                      
 L<STD::TestGen/fspec_in option [5]>                              L<TestGen-STD/Test 013 - Change File Spec>                      
 L<STD::TestGen/fspec_out option [6]>                             L<TestGen-STD/Test 012 - Change File Spec>                      
 L<STD::TestGen/fspec_out option [6]>                             L<TestGen-STD/Test 013 - Change File Spec>                      
 L<STD::TestGen/load [1]>                                         L<TestGen-STD/Test 002 - Load UUT>                              
 L<STD::TestGen/pod check [2]>                                    L<TestGen-STD/Test 003 - No pod errors>                         
 L<STD::TestGen/replace [2]>                                      L<TestGen-STD/Test 009 - Generate and replace a demonstration>  
 L<STD::TestGen/verify file [1]>                                  L<TestGen-STD/Test 006 - Generated and execute the test script> 
 L<STD::TestGen/verify file [1]>                                  L<TestGen-STD/Test 010 - Generate and verbose test harness run t
                                                                  est script>                                                     
 L<STD::TestGen/verify file [1]>                                  L<TestGen-STD/Test 011 - Generate and test harness run test scri
                                                                  pt>                                                             
 L<STD::TestGen/verify file [2]>                                  L<TestGen-STD/Test 006 - Generated and execute the test script> 
 L<STD::TestGen/verify file [2]>                                  L<TestGen-STD/Test 010 - Generate and verbose test harness run t
                                                                  est script>                                                     
 L<STD::TestGen/verify file [2]>                                  L<TestGen-STD/Test 011 - Generate and test harness run test scri
                                                                  pt>                                                             
 L<STD::TestGen/verify file [3]>                                  L<TestGen-STD/Test 006 - Generated and execute the test script> 
 L<STD::TestGen/verify file [3]>                                  L<TestGen-STD/Test 010 - Generate and verbose test harness run t
                                                                  est script>                                                     
 L<STD::TestGen/verify file [3]>                                  L<TestGen-STD/Test 011 - Generate and test harness run test scri
                                                                  pt>                                                             
 L<STD::TestGen/verify file [4]>                                  L<TestGen-STD/Test 010 - Generate and verbose test harness run t
                                                                  est script>                                                     
 



 
 Test                                                             Requirement                                                     
 ---------------------------------------------------------------- ----------------------------------------------------------------
 L<TestGen-STD/Test 002 - Load UUT>                               L<STD::TestGen/load [1]>                                        
 L<TestGen-STD/Test 003 - No pod errors>                          L<STD::TestGen/pod check [2]>                                   
 L<TestGen-STD/Test 004 - Generated tgA1-STD.std>                 L<STD::TestGen/STD file [1]>                                    
 L<TestGen-STD/Test 004 - Generated tgA1-STD.std>                 L<STD::TestGen/STD file [2]>                                    
 L<TestGen-STD/Test 005 - Demonstration script>                   L<STD::TestGen/demo file [1]>                                   
 L<TestGen-STD/Test 005 - Demonstration script>                   L<STD::TestGen/demo file [2]>                                   
 L<TestGen-STD/Test 006 - Generated and execute the test script>  L<STD::TestGen/verify file [1]>                                 
 L<TestGen-STD/Test 006 - Generated and execute the test script>  L<STD::TestGen/verify file [2]>                                 
 L<TestGen-STD/Test 006 - Generated and execute the test script>  L<STD::TestGen/verify file [3]>                                 
 L<TestGen-STD/Test 007 - Generate a clean file>                  L<STD::TestGen/clean file [1]>                                  
 L<TestGen-STD/Test 007 - Generate a clean file>                  L<STD::TestGen/clean file [2]>                                  
 L<TestGen-STD/Test 007 - Generate a clean file>                  L<STD::TestGen/clean file [3]>                                  
 L<TestGen-STD/Test 007 - Generate a clean file>                  L<STD::TestGen/clean file [4]>                                  
 L<TestGen-STD/Test 007 - Generate a clean file>                  L<STD::TestGen/clean file [5]>                                  
 L<TestGen-STD/Test 008 - Generate a STD>                         L<STD::TestGen/STD file [1]>                                    
 L<TestGen-STD/Test 008 - Generate a STD>                         L<STD::TestGen/STD file [2]>                                    
 L<TestGen-STD/Test 009 - Generate and replace a demonstration>   L<STD::TestGen/demo file [1]>                                   
 L<TestGen-STD/Test 009 - Generate and replace a demonstration>   L<STD::TestGen/demo file [2]>                                   
 L<TestGen-STD/Test 009 - Generate and replace a demonstration>   L<STD::TestGen/replace [2]>                                     
 L<TestGen-STD/Test 010 - Generate and verbose test harness run t L<STD::TestGen/execute [3]>                                     
 L<TestGen-STD/Test 010 - Generate and verbose test harness run t L<STD::TestGen/execute [4]>                                     
 L<TestGen-STD/Test 010 - Generate and verbose test harness run t L<STD::TestGen/verify file [1]>                                 
 L<TestGen-STD/Test 010 - Generate and verbose test harness run t L<STD::TestGen/verify file [2]>                                 
 L<TestGen-STD/Test 010 - Generate and verbose test harness run t L<STD::TestGen/verify file [3]>                                 
 L<TestGen-STD/Test 010 - Generate and verbose test harness run t L<STD::TestGen/verify file [4]>                                 
 L<TestGen-STD/Test 011 - Generate and test harness run test scri L<STD::TestGen/execute [3]>                                     
 L<TestGen-STD/Test 011 - Generate and test harness run test scri L<STD::TestGen/verify file [1]>                                 
 L<TestGen-STD/Test 011 - Generate and test harness run test scri L<STD::TestGen/verify file [2]>                                 
 L<TestGen-STD/Test 011 - Generate and test harness run test scri L<STD::TestGen/verify file [3]>                                 
 L<TestGen-STD/Test 012 - Change File Spec>                       L<STD::TestGen/fspec_in option [5]>                             
 L<TestGen-STD/Test 012 - Change File Spec>                       L<STD::TestGen/fspec_out option [6]>                            
 L<TestGen-STD/Test 013 - Change File Spec>                       L<STD::TestGen/fspec_in option [5]>                             
 L<TestGen-STD/Test 013 - Change File Spec>                       L<STD::TestGen/fspec_out option [6]>                            
 L<TestGen-STD/Test 014 - Add to search path>                     <STD::TestGen/dir-path option [7]>                              
 



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

L<STD::TestGen|STD::TestGen>
L<SVD for STD::TestGen|SVD::Military-STD2167A>
L<SVD DID|Military::SVD>
L<STD DID|Military::STD>
L<Tailoring of the STD DID|STD::STDtailor>
L<Test Harness|Test::Harness>
L<STD Automated Genaration|STD:TestGen>

The web page http://perl.SoftwareDiamonds.com provides a list of educational
and reference litature on the Perl Programming Language including
Plain Old Documentation (POD)s

=back

=cut

__END__


### end of file ###

