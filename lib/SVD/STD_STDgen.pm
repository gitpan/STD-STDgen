#!perl
#
# The copyright notice and plain old documentation (POD)
# are at the end of this file.
#
package  SVD::STD_STDgen;

use strict;
use warnings;
use warnings::register;

use vars qw($VERSION $DATE);
$VERSION = '0.02';
$DATE = '2003/06/04';

use vars qw(%INVENTORY $INVENTORY_FSPEC);
$INVENTORY_FSPEC = 'Unix';
%INVENTORY = (
    'lib/SVD/STD-STDgen.svd' => [qw(0.02 2003/06/04), 'revised 0.01'],
    'lib/SVD/STD_STDgen.pm' => [qw(0.02 2003/06/04), 'generated, replaces 0.01'],
    'MANIFEST' => [qw(0.02 2003/06/04), 'generated, replaces 0.01'],
    'Makefile.PL' => [qw(0.02 2003/06/04), 'generated, replaces 0.01'],
    'README' => [qw(0.02 2003/06/04), 'generated, replaces 0.01'],
    'lib/STD/Check.pm' => [qw(1.03 2003/06/04), 'revised 1.02'],
    'lib/STD/FileGen.pm' => [qw(1.02 2003/06/03), 'unchanged'],
    'lib/STD/FileGenI.pm' => [qw(1.02 2003/06/03), 'unchanged'],
    'lib/STD/STD001.frm' => [qw(0.01 2003/06/03), 'unchanged'],
    'lib/STD/STDgen.pm' => [qw(1.02 2003/06/03), 'unchanged'],
    'lib/STD/STDtailor.pm' => [qw(0.01 2003/06/03), 'unchanged'],
    'lib/STD/Tester.pm' => [qw(1.02 2003/06/03), 'unchanged'],
    'lib/STD/TestGen.pm' => [qw(1.03 2003/06/04), 'revised 1.02'],
    'lib/STD/TestUtil.pm' => [qw(1.03 2003/06/04), 'revised 1.02'],
    'lib/STD/GenType/Clean.pm' => [qw(1.02 2003/06/03), 'unchanged'],
    'lib/STD/GenType/Demo.pm' => [qw(1.02 2003/06/03), 'unchanged'],
    'lib/STD/GenType/STD.pm' => [qw(1.02 2003/06/03), 'unchanged'],
    'lib/STD/GenType/Verify.pm' => [qw(1.03 2003/06/04), 'revised 1.02'],
    'lib/DataCop/DataFile.pm' => [qw(0.01 2003/06/03), 'unchanged'],
    'lib/DataCop/DataFileI.pm' => [qw(0.01 2003/06/03), 'unchanged'],
    'lib/DataCop/FileType/FormDB.pm' => [qw(0.01 2003/06/03), 'unchanged'],
    't/DataCop/DataFile-STD.pm' => [qw(0.01 2003/06/03), 'unchanged'],
    't/DataCop/DataFile.d' => [qw(0.01 2003/06/03), 'unchanged'],
    't/DataCop/DataFile.std' => [qw(0.01 2003/06/03), 'unchanged'],
    't/DataCop/DataFile.t' => [qw(0.01 2003/06/03), 'unchanged'],
    't/DataCop/DataFile0.tdb' => [qw(0.01 2003/06/03), 'unchanged'],
    't/DataCop/DataFile2.tdb' => [qw(0.01 2003/06/03), 'unchanged'],
    't/DataCop/DataFile2.txt' => [qw(0.01 2003/06/03), 'unchanged'],
    't/DataCop/DataFile3.tdb' => [qw(0.01 2003/06/03), 'unchanged'],
    't/DataCop/DataFile3.txt' => [qw(0.01 2003/06/03), 'unchanged'],
    't/DataCop/DataFile4.tdb' => [qw(0.01 2003/06/03), 'unchanged'],
    't/DataCop/DataFile4.txt' => [qw(0.01 2003/06/03), 'unchanged'],
    't/DataCop/DataFile5.txt' => [qw(0.01 2003/06/03), 'unchanged'],
    't/DataCop/FormDB-STD.pm' => [qw(0.01 2003/06/03), 'unchanged'],
    't/DataCop/FormDB.d' => [qw(0.01 2003/06/03), 'unchanged'],
    't/DataCop/FormDB.std' => [qw(0.01 2003/06/03), 'unchanged'],
    't/DataCop/FormDB.t' => [qw(0.01 2003/06/03), 'unchanged'],
    't/DataCop/FormDB0.tdb' => [qw(0.01 2003/06/03), 'unchanged'],
    't/DataCop/FormDBa2.tdb' => [qw(0.01 2003/06/03), 'unchanged'],
    't/DataCop/FormDBa2.txt' => [qw(0.01 2003/06/03), 'unchanged'],
    't/DataCop/FormDBa3.tdb' => [qw(0.01 2003/06/03), 'unchanged'],
    't/DataCop/FormDBa3.txt' => [qw(0.01 2003/06/03), 'unchanged'],
    't/DataCop/FormDBa4.tdb' => [qw(0.01 2003/06/03), 'unchanged'],
    't/DataCop/FormDBa4.txt' => [qw(0.01 2003/06/03), 'unchanged'],
    't/DataCop/FormDBr2.txt' => [qw(0.01 2003/06/03), 'unchanged'],
    't/DataCop/FormDBr3.txt' => [qw(0.01 2003/06/03), 'unchanged'],
    't/DataCop/FormDBr4.txt' => [qw(0.01 2003/06/03), 'unchanged'],
    't/DataCop/FormDBs0.tdb' => [qw(0.01 2003/06/03), 'unchanged'],
    't/STD/TestGen-STD.pm' => [qw(0.02 2003/06/04), 'revised 0.01'],
    't/STD/testgen.bat' => [qw(0.01 2003/06/03), 'unchanged'],
    't/STD/TestGen.d' => [qw(0.02 2003/06/04), 'revised 0.01'],
    't/STD/TestGen.std' => [qw(0.02 2003/06/04), 'revised 0.01'],
    't/STD/TestGen.t' => [qw(0.02 2003/06/04), 'revised 0.01'],
    't/STD/TestGenD.pm' => [qw(1.02 2003/06/03), 'unchanged'],
    't/STD/tg0.pm' => [qw(0.01 2003/06/03), 'unchanged'],
    't/STD/tg2A.pm' => [qw(0.01 2003/06/03), 'unchanged'],
    't/STD/tg2B.pm' => [qw(0.02 2003/06/04), 'revised 0.01'],
    't/STD/tgA0.std' => [qw(0.02 2003/06/04), 'revised 0.01'],
    't/STD/tgA2-STD.pm' => [qw(0.02 2003/06/04), 'revised 0.01'],
    't/STD/tgA2.d' => [qw(0.01 2003/06/03), 'unchanged'],
    't/STD/tgA2A.std' => [qw(0.02 2003/06/04), 'revised 0.01'],
    't/STD/tgA2A.txt' => [qw(0.02 2003/06/04), 'revised 0.01'],
    't/STD/tgA2B.std' => [qw(0.02 2003/06/04), 'revised 0.01'],
    't/STD/tgA2B.txt' => [qw(0.02 2003/06/04), 'revised 0.01'],
    't/STD/tgA2C.txt' => [qw(0.02 2003/06/04), 'revised 0.01'],
    't/STD/tgA2D.txt' => [qw(0.02 2003/06/04), 'revised 0.01'],
    't/STD/tgB0.std' => [qw(0.01 2003/06/03), 'unchanged'],
    't/STD/tgB2.std' => [qw(0.01 2003/06/03), 'unchanged'],
    't/STD/tgB2A.std' => [qw(0.01 2003/06/03), 'unchanged'],
    't/STD/tgB2B.std' => [qw(0.01 2003/06/03), 'unchanged'],
    'bin/tg.pl' => [qw(1.02 2003/06/03), 'unchanged'],

);

1

__END__

=head1 Title Page

 Software Version Description

 for

 Software Tests and Software Test Description (STD) Automation

 Revision: A

 Version: 0.02

 Date: 2003/06/04

 Prepared for: General Public 

 Prepared by:  SoftwareDiamonds.com E<lt>support@SoftwareDiamonds.comE<gt>

 Copyright: copyright © 2003 Software Diamonds

 Classification: NONE

=head1 1.0 SCOPE

This paragraph identifies and provides an overview
of the released files.

=head2 1.1 Indentification

This release is a collection of Perl modules that
extend the capabilities of the Perl language.

=head2 1.2 System overview

The system is the Perl programming language software.
The system does not have any hardware.
The Perl programming language contains two features that
are utilized by this release:

=over 4

=item 1

Program Modules to extend the languages

=item 2

Plain Old Documentation (POD) that may be embedded in the language

=back

These features are established by the referenced documents.

=head2 1.3 Document overview.

This document releases STD::STDgen version 0.02
providing description of the inventory, installation
instructions and other information necessary to
utilize and track this release.

=head1 3.0 VERSION DESCRIPTION

=head2 3.1 Inventory of materials released.

=head2 3.1.1 Files.

This document releases the following file:

 http://www.softwarediamonds/packages/STD-STDgen-0.02.tar.gz 

=head2 3.1.2 Copyright.

copyright © 2003 Software Diamonds

=head2 3.1.3 Copyright holder contact.

E<lt>support@SoftwareDiamonds.comE<gt>

=head2 3.1.4 License.

These files are a POD derived works from the hard copy public domain version
freely distributed by the United States Federal Government.

The original hardcopy version is always the authoritative document
and any conflict between the original hardcopy version governs whenever
there is any conflict. In more explicit terms, any conflict is a 
transcription error in converting the origninal hard-copy version to
this POD format. Software Diamonds assumes no responsible for such errors.

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

=head2 3.2 Inventory of software contents

This inventory uses the Unix operating
system file specification.
The content of the released, compressed, archieve file,

 http://www.softwarediamonds/packages/STD-STDgen-0.02.tar.gz 

consists of the following files:


 file                                                         version date       comment                 
 ------------------------------------------------------------ ------- ---------- ------------------------
 lib/SVD/STD-STDgen.svd                                       0.02    2003/06/04 revised 0.01            
 lib/SVD/STD_STDgen.pm                                        0.02    2003/06/04 generated, replaces 0.01
 MANIFEST                                                     0.02    2003/06/04 generated, replaces 0.01
 Makefile.PL                                                  0.02    2003/06/04 generated, replaces 0.01
 README                                                       0.02    2003/06/04 generated, replaces 0.01
 lib/STD/Check.pm                                             1.03    2003/06/04 revised 1.02            
 lib/STD/FileGen.pm                                           1.02    2003/06/03 unchanged               
 lib/STD/FileGenI.pm                                          1.02    2003/06/03 unchanged               
 lib/STD/STD001.frm                                           0.01    2003/06/03 unchanged               
 lib/STD/STDgen.pm                                            1.02    2003/06/03 unchanged               
 lib/STD/STDtailor.pm                                         0.01    2003/06/03 unchanged               
 lib/STD/Tester.pm                                            1.02    2003/06/03 unchanged               
 lib/STD/TestGen.pm                                           1.03    2003/06/04 revised 1.02            
 lib/STD/TestUtil.pm                                          1.03    2003/06/04 revised 1.02            
 lib/STD/GenType/Clean.pm                                     1.02    2003/06/03 unchanged               
 lib/STD/GenType/Demo.pm                                      1.02    2003/06/03 unchanged               
 lib/STD/GenType/STD.pm                                       1.02    2003/06/03 unchanged               
 lib/STD/GenType/Verify.pm                                    1.03    2003/06/04 revised 1.02            
 lib/DataCop/DataFile.pm                                      0.01    2003/06/03 unchanged               
 lib/DataCop/DataFileI.pm                                     0.01    2003/06/03 unchanged               
 lib/DataCop/FileType/FormDB.pm                               0.01    2003/06/03 unchanged               
 t/DataCop/DataFile-STD.pm                                    0.01    2003/06/03 unchanged               
 t/DataCop/DataFile.d                                         0.01    2003/06/03 unchanged               
 t/DataCop/DataFile.std                                       0.01    2003/06/03 unchanged               
 t/DataCop/DataFile.t                                         0.01    2003/06/03 unchanged               
 t/DataCop/DataFile0.tdb                                      0.01    2003/06/03 unchanged               
 t/DataCop/DataFile2.tdb                                      0.01    2003/06/03 unchanged               
 t/DataCop/DataFile2.txt                                      0.01    2003/06/03 unchanged               
 t/DataCop/DataFile3.tdb                                      0.01    2003/06/03 unchanged               
 t/DataCop/DataFile3.txt                                      0.01    2003/06/03 unchanged               
 t/DataCop/DataFile4.tdb                                      0.01    2003/06/03 unchanged               
 t/DataCop/DataFile4.txt                                      0.01    2003/06/03 unchanged               
 t/DataCop/DataFile5.txt                                      0.01    2003/06/03 unchanged               
 t/DataCop/FormDB-STD.pm                                      0.01    2003/06/03 unchanged               
 t/DataCop/FormDB.d                                           0.01    2003/06/03 unchanged               
 t/DataCop/FormDB.std                                         0.01    2003/06/03 unchanged               
 t/DataCop/FormDB.t                                           0.01    2003/06/03 unchanged               
 t/DataCop/FormDB0.tdb                                        0.01    2003/06/03 unchanged               
 t/DataCop/FormDBa2.tdb                                       0.01    2003/06/03 unchanged               
 t/DataCop/FormDBa2.txt                                       0.01    2003/06/03 unchanged               
 t/DataCop/FormDBa3.tdb                                       0.01    2003/06/03 unchanged               
 t/DataCop/FormDBa3.txt                                       0.01    2003/06/03 unchanged               
 t/DataCop/FormDBa4.tdb                                       0.01    2003/06/03 unchanged               
 t/DataCop/FormDBa4.txt                                       0.01    2003/06/03 unchanged               
 t/DataCop/FormDBr2.txt                                       0.01    2003/06/03 unchanged               
 t/DataCop/FormDBr3.txt                                       0.01    2003/06/03 unchanged               
 t/DataCop/FormDBr4.txt                                       0.01    2003/06/03 unchanged               
 t/DataCop/FormDBs0.tdb                                       0.01    2003/06/03 unchanged               
 t/STD/TestGen-STD.pm                                         0.02    2003/06/04 revised 0.01            
 t/STD/testgen.bat                                            0.01    2003/06/03 unchanged               
 t/STD/TestGen.d                                              0.02    2003/06/04 revised 0.01            
 t/STD/TestGen.std                                            0.02    2003/06/04 revised 0.01            
 t/STD/TestGen.t                                              0.02    2003/06/04 revised 0.01            
 t/STD/TestGenD.pm                                            1.02    2003/06/03 unchanged               
 t/STD/tg0.pm                                                 0.01    2003/06/03 unchanged               
 t/STD/tg2A.pm                                                0.01    2003/06/03 unchanged               
 t/STD/tg2B.pm                                                0.02    2003/06/04 revised 0.01            
 t/STD/tgA0.std                                               0.02    2003/06/04 revised 0.01            
 t/STD/tgA2-STD.pm                                            0.02    2003/06/04 revised 0.01            
 t/STD/tgA2.d                                                 0.01    2003/06/03 unchanged               
 t/STD/tgA2A.std                                              0.02    2003/06/04 revised 0.01            
 t/STD/tgA2A.txt                                              0.02    2003/06/04 revised 0.01            
 t/STD/tgA2B.std                                              0.02    2003/06/04 revised 0.01            
 t/STD/tgA2B.txt                                              0.02    2003/06/04 revised 0.01            
 t/STD/tgA2C.txt                                              0.02    2003/06/04 revised 0.01            
 t/STD/tgA2D.txt                                              0.02    2003/06/04 revised 0.01            
 t/STD/tgB0.std                                               0.01    2003/06/03 unchanged               
 t/STD/tgB2.std                                               0.01    2003/06/03 unchanged               
 t/STD/tgB2A.std                                              0.01    2003/06/03 unchanged               
 t/STD/tgB2B.std                                              0.01    2003/06/03 unchanged               
 bin/tg.pl                                                    1.02    2003/06/03 unchanged               
 



=head2 3.3 Changes

The file structure from release 0.01 was
restructured as follows:

   open PM,"< lib\\SVD\\STD_STDgen.pm";
    my $data = join '',<PM>;
   close PM;
   $data =~ s/Military_STD2167A/STD_STDgen/;
   open PM,"> lib\\SVD\\STD_STDgen.pm";
   print PM $data;
   close PM;



Changes are as follows:

=over 4

=item t/STD/tgA0.std changes

Added test for DO: field

Added test for VO: field

Added a loop around two A: and E: fields.

=item STD/TestGen.pm changes

Added requirements for DO: VO: and looping
a test

=item STD/Check.pm changes

Added and revise code to make DO: VO: and
looping work

=item STD/Verify.pm changes

Added and revise code to make DO: VO: and
looping work

=back

=head2 3.4 Adaptation data.

This installation requires that the installation site
has the Perl programming language installed.
Installation sites running Microsoft Operating systems require
the installation of Unix utilities. 
The installation instructions, hereinbelow,
provides instruction on obtaining and installation
UNIX utilities on Microsoft operating systems.
There are no other additional or tailoring needed of 
configurations files, adaptation data or other software needed for this
installation particular to any installation site.

=head2 3.5 Related documents.

There are no related documents needed for the installation and
test of this release.

=head2 3.6 Installation instructions.

The files may be installed under many different operating systems.
The compresssed, archived, distribution file containing all installation
files is at the following respository:

 http://www.softwarediamonds/packages/STD-STDgen-0.02.tar.gz 

Follow the general Perl software installation procedure
to install the files contained in this distribution file.

The distribution name for and version are as follows:

 distribution name: STD-STDgen
 version          : 0.02

=head2 3.6.1 Installation support.

If there are installation problems or questions with the installation
contact

 603 882-0846 E<lt>support@SoftwareDiamonds.comE<gt>

=head2 3.6.2 Installation Tests.

Most Perl installation software will run the following test script(s)
as part of the installation:

 t\DataCop\DataFile.t
 t\DataCop\FormDB.t
 t\STD\TestGen.t

=head2 3.7 Possible problems and known errors

The open issures are as follows:

=over 4

=item *

There is no requirement tracebility to a particular line
in a file containing the expected results

=item *

There is no provisions for Software Development Document (SDD)
design requirements and tracing functional requirements to
design requirements and to design requirements tests

=item *

Functional requirements are basically requirements important
to the end-user and stated for the point of view of the
end-user.  
Test coverage is not an issue. 
However, when design requirements are added to the mix,
test coverage of the design requirements becomes important.

=back

=head1 4.0 NOTES

The following are useful acronyms:

=over 4

=item .d

extension for a Perl demo script file

=item .pm

extension for a Perl Library Module

=item .t

extension for a Perl test script file

=item .svd

extension for a Software Vesion Description database file

=item DID

Data Item Description

=item POD

Plain Old Documentation

=item STD

Software Test Description

=item SVD

Software Version Description

=back

=head1 2.0 SEE ALSO

L<Test|Test> L<Test::Harness|Test::Harness>
L<STD::STDgen|STD::STDgen> L<DataCop::FileType::FormDB|DataCop::FileType::FormDB>
L<DataCop::DataFileI|DataCop::DataFileI>
L<STD::STDtailor|STD::STDtailor>
L<MILITARY::STD2167A|MILITARY::STD2167A>
L<MILITARY::STD490A|MILITARY::STD490A>
L<MILITARY::STD|MILITARY::STD>

=for html
<hr>
<p><br>
<!-- BLK ID="PROJECT_MANAGEMENT" -->
<!-- /BLK -->
<p><br>
<!-- BLK ID="NOTICE" -->
<!-- /BLK -->
<p><br>
<!-- BLK ID="OPT-IN" -->
<!-- /BLK -->
<p><br>
<!-- BLK ID="LOG_CGI" -->
<!-- /BLK -->
<p><br>



