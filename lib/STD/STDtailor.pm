#!perl
#
#
package Test::STDtailor;

use 5.001;
use strict;
use warnings;
use warnings::register;

use vars qw($VERSION $DATE);
$VERSION = '0.01';  
$DATE = '2003/06/03';

head1 Overview

The Software Test Description (STD) 
Data Item Description (DID), L<STD|Military::STD>,
is overpowering for the addition a simple POD module
file or script file.
This document tailors the STD to steamline
the format. This greatly improves the
readability of the document without any loss 
of information.

The tailoring removes paragraph levels, reducing
the number of paragraph levels from four to two.

While the tailoring improves the readability
considerably, all tailoring is reversible 
for strict, concverative compliance to the DID
by an appropriate special POD translator.

head1 Paragraph Numbers

The tailoring removed paragraph numbers in the 
Plain Old Documentation (POD) file.
Normal POD processing or post-processing of the
normal POD processing, html html whatever, can
add the paragraph numbers and other requirements
that large number of technical communities are
so fond. POD processing is the proper place
for such window dressing, not the POD itself.

=head1 2. REFERENCE DOCUMENTS

Tailoring rename this section to I<SEE ALSO> and
moved it to the end of the document.
This is the customary location for this info
for the Unix community and where the Unix
community expects to find this information.

=head1 3. TEST PREPARATIONS

The test preparations are the same for all tests.
The addition of Perl modules is straight forward,
consistent and the same for all new Perl moduels.

To improve readability with no loss of data provided, 
the test paragraph level x,
3.x.1, 3.x.2, 3.x.3, 3.x.4, 
of the Software Test Description (L<STD|Military::STD>)
Data Item Description (DID),
has been tailored out. 

Similarily sections 4.x.y.5, 4.x.y.6, 4.x.y.7, are
the same for all tests. The tailoring removes the
x.y levels and moves this sections to 3.4, 3.5 and
3.6 respectively.

The tailored Section 3 is as follows:

 3. TEST PREPARATIONS

 3.1 Hardware preparation

 3.2 Software preparation

 3.3 Other pre-test preparations

 3.4 Criteria for evaluating results.

 3.5 Test procedure.

 3.6 Assumptions and constraints 

=head1 Section 4. TEST DESCRIPTIONS 

For the addition of Perl program modules and
scripts the paragraphs
4.x.y.1, 4.x.y.2, 4.x.y.3 and
4.x.y.4 are one-liners herein,
and there is only one test case per test.
Tailoring removes the confusing level y,
and replaces the lower level with a
simple item list.

POD processing has the flexibility of changing
a item list into a level 3 paragraph.

The tailored Section 4 is as follows:
 
  4. TEST DESCRIPTIONS

  4.1 ${Unique Test ID 1}

   (a) ${Unique Test ID 1} Requirements addressed:
   (b) ${Unique Test ID 1} Test:
   (c) ${Unique Test ID 1} Expected test results:


  ..


  4.x ${Unique Test ID x}

   (a) ${Unique Test ID x} Requirements addressed:
   (b) ${Unique Test ID x} Test:
   (c) ${Unique Test ID x} Expected test results:

=cut

