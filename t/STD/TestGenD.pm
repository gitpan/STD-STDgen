#!perl
#
# Documentation, copyright and license is at the end of this file.
#
package  STD::TestGenD;

use 5.001;
use strict;
use warnings;
use warnings::register;

use vars qw($VERSION $DATE);
$VERSION = '1.02';
$DATE = '2003/06/03';

1

__END__


=head1 Title Page

 Software Design Document (SDD)

 for

 Perl STD::TestGen

 Revision: -

 Date: 2003/04/11

 Prepared for: General Public 

 Prepared by:  http://www.SoftwareDiamonds.com support@SoftwareDiamonds.com

 Classification: None


=head1 SYNOPSIS

 use STD::TestGen

 $success = STD::TestGen->fgenerate($gen, $std ... $std [\%options], [$dir_path]) 
 $success = STD::TestGen->fgenerate($gen, $std, $out, [\%options], [$dir_path]) 
 $success = STD::TestGen->fgenerate($gen, $std, [\%options], [$dir_path])

 $testgen = new STD::TestGen([\%options], [$dir_path])
 $success = $testgen->load_std($std, [\%options], [$dir_path])
 $success = $testgen->generate($gen )
 $success = $testgen->print($out)

 @generators = STD::TestGen->generators()
 $gen = STD::TestGen->is_output_type($gen)

=head1 REQUIREMENTS

=head2 fgenerate

 $success = STD::TestGen->fgenerate($gen, $std ... $std [\%options], [$dir_path]) 
 $success = STD::TestGen->fgenerate($gen, $std, $out, [\%options], [$dir_path]) 
 $success = STD::TestGen->fgenerate($gen, $std, [\%options], [$dir_path])

=head2 new

 $testgen = new STD::TestGen( )

=head2 load_std

 $success = $testgen->load_std($std, [\%options], [$dir_path])

=head2 generate

 $success = $testgen->generate($gen )

=head2 print

 $success = $testgen->print($out)

=head2 generators

 @generators = STD::TestGen->generators()

=head2 is_output_type

 $gen = STD::TestGen->is_output_type($gen)

=head1 NOTES

=head2 Binding Requirements

Binding requirements are uniquely identified with the
pharse 'shall[dd]' where dd is an unique number
for each section.
This conforms to standard federal
government practices, L<DOD STD 490A|STD490A/3.2.3.6>).
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

L<Test|Test> 
L<STD::TestDB|STD::TestDB> 
L<STD::Tester|STD::Tester> 
L<STD::TestUtil|STD::TestUtil>
<Test::Harness|Test::Harness> 
L<STD::Gen::Clean|STD::Gen::Clean> 
L<STD::Gen::Demo|STD::Gen::Demo> 
L<STD::Gen::Verify|STD::Gen::Verify> 
L<STD::t::tg|STD::t::tg>
L<STD::Gen::Check|STD::Gen::Check> 
L<STD::Gen::STD|STD::Gen::STD> 
L<STD::Gen::TestGenI|STD::Gen::TestGenI>

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

### end of file ###

