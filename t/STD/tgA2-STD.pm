#!perl
#
#
package tgA1-STD;

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

