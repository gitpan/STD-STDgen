
=head1 TITLE PAGE

 Software Test Description

 for

 Perl ${UUT_PM}

 Revision: ${Revision}

 Date: ${Date}

 Prepared for: ${End_User} 

 Prepared by:  ${Author}

 Classification: ${Classification}

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
Perl L<${UUT_PM}|${UUT_PM}> 

=head2 Identification

The Software Version Description (SVD) for ${UUT_PM},
L<${SVD}|${SVD}>,
provides configuration, version, and installation information:

=head2 System overview

The system is the Perl programming language software
established by the L<SEE ALSO|SEE ALSO> references.

=head2 1.3 Document overview

This document establishes the tests to verify the requirements
specified in the Perl Plain Old Documentation (POD)
of the L<${UUT_PM}|${UUT_PM}>.
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
determine if the ${UUT_PM} program module is installed.
If any test fails, contact

 ${Author}

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

 ${Test_Script}

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
as specifed in the L<${UUT_PM}|${UUT_PM}>, 
Plain Old Documentation (POD).
These test descriptions contain ${Tests} tests.

A unique test identification used herein consists of the
the test number that is produce by executing the Perl 
test script file:

 ${Test_Script}

The unique test number id within this module
and the the unique Perl identification for
this module, L<${STD_PM}|${STD_PM}>, 
provide an unique Perl system wide identifier of the test.

There are no safety procautions or security
and privacy considerations for any of the tests
or test cases.

${Test_Descriptions}

^

=cut

#######
#  
#  5. REQUIREMENTS TRACEABILITY
#
#

=head1 REQUIREMENTS TRACEABILITY

 ${Trace_Requirement_Table}

 ${Trace_Test_Table}

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

${Copyright}

#######
#
#  2. REFERENCED DOCUMENTS
#
#
#

=head1 SEE ALSO

${See_Also}

=back

=cut

__END__


### end of file ###

