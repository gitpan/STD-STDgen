#!perl
#
# Documentation, copyright and license is at the end of this file.
#
package  STD::TestUtil;

use 5.001;
use strict;
use warnings;
use warnings::register;

use Data::Dumper;
use Cwd;
use File::Spec;
use File::Glob ':glob';

use vars qw($VERSION $DATE);
$VERSION = '1.03';
$DATE = '2003/06/04';


########
########
#
# Below is an attempt to make the reading and writing text files in the
# test software platform independent
#
########
########


####
# slurp in a text file in a platform independent manner
#
sub fin
{
   my (undef, $file, , $options_p) = @_;

   my $fspec = $options_p->{fspec};
   $fspec = 'Unix' unless $fspec;
   $file = STD::TestUtil->fspec2os($fspec, $file );   

   #####
   # slurp in the file contents with no operating system
   # translations
   #
   unless(open IN, "<$file") {
       warn("Cannot open <$file\n");
       return undef;
   }
   binmode IN; # make the test friendly for more platforms
   my $data = join '', <IN>;
   unless(close(IN)) {
       warn( "Cannot close $file\n");
       return undef;
   }
   return $data unless( $data );

   #########
   # No matter what platform generated the data, convert
   # all platform dependent new lines to the new line for
   # the current platform.
   #
   unless($options_p->{binary}) {
       $data =~ s/\015\012|\012\015/\012/g;  # replace LFCR or CRLF with a LF
       $data =~ s/\012|\015/\n/g;   # replace CR or LF with logical \n 
   }
   $data          
}

###
# slurp a file out, current platform text format
#
sub fout
{
   my (undef, $file, $data, $options_p) = @_;

   my $fspec = $options_p->{fspec};
   $fspec = 'Unix' unless $fspec;
   $file = STD::TestUtil->fspec2os($fspec, $file );   

   if($options_p->{append}) {
       unless(open OUT, ">>$file") {
           warn("Cannot open >$file\n");
           return undef;
       }
   }
   else {
       unless(open OUT, ">$file") {
           warn("Cannot open >$file\n");
           return undef;
       }
   }
   binmode OUT if $options_p->{binary};
   my $char_out = print OUT $data;
   unless(close(OUT)) {
       warn( "Cannot close $file\n");
       return undef;
   }
   $char_out; 
}


######
#
#
sub is_package_loaded
{
    my (undef, $package) = @_;
   
    $package .= "::";
    defined %$package

}



######
#
#
sub load_package
{
    my (undef, $package) = @_;
    return '' if STD::TestUtil->is_package_loaded( $package );
    eval "require $package";
    if($@) {
        warn( "Cannot load $package\n");
        return( $@ );
    }
    return "$package not loaded\n" unless STD::TestUtil->is_package_loaded( $package );
    ''
}

  
sub pod_errors 
{

    my (undef, $module, $output_file) = @_;

    use Pod::Checker;
    my $checker = new Pod::Checker();
    my @module = split '::', $module;

    $module = File::Spec->catfile( @module );
    return undef unless ($module) = STD::TestUtil->find_in_path( $^O, $module . '.pm');

    ## Now check the pod document for errors
    if( $output_file ) {
        $checker->parse_from_file($module, $output_file);
    }
    else {
        open (LOG, '> __null__.log');
        $checker->parse_from_file($module, \*LOG);
        close LOG;
        unlink '__null__.log';
    }

    $checker->num_errors()
}

#######
# Blank out the Verion, Date for comparision
#
#
sub scrub_file_line
{
    my (undef, $text) = @_;

    return $text unless $text;

    ######
    # Blank out version and date for comparasion
    #
    $text =~ s/\(.*?at line \d+/(xxxx.t at line 000/ig;
    $text

}


#######
# Blank out the Verion, Date for comparision
#
#
sub scrub_test_file
{
    my (undef, $text) = @_;

    return $text unless $text;

    ######
    # Blank out version and date for comparasion
    #
    $text =~ s/Running Tests.*?1\.\./Running Tests xxx.t 1../sig;
    $text

}


#######
# Blank out the Verion, Date for comparision
#
#
sub scrub_date_version
{
    my (undef, $text) = @_;

    return $text unless $text;

    ######
    # Blank out version and date for comparasion
    #
    $text =~ s/\$VERSION\s*=\s*['"].*?['"]/\$VERSION = '0.00'\n/ig;      
    $text =~ s/\$DATE\s*=\s*['"].*?['"]/\$DATE = 'Jan 1, 2000'\n/ig;
    $text =~ s/DATE:\s+.*?\n/\$DATE: Jan 1, 2000\n/ig;
    $text

}

#####
# Date changes between runs so cannot have
# a static compare file unless you eliminate
# the date. Also the ticket is different
#
sub scrub_date_ticket
{
    my (undef, $email) = @_;

    $email =~ s/Date: .*?\n/Date: Apr 12 00 00 00 2003 +0000\n/ig;

    $email =~ s/Subject: .*?,(.*)\n/Subject XXXXXXXXX-X, $1\n/ig;

    $email =~ s/X-SDticket:.*?\n/X-SDticket: XXXXXXXXX-X\n/ig;

    $email =~ s/\QFrom ???@???\E .*?\n/From ???@??? Apr 12 00 00 00 2003 +0000\n/ig;

    $email =~ s/X-eudora-date: .*?\n/X-eudora-date: Apr 12 00 00 00 2003 +0000\n/ig;

    $email =~ s/X-SDmailit: sent .*?\n/X-SDmailit: sent Sat Apr 12 00 00 00 2003 +0000\n/ig;

    $email =~ s/X-SDmailit: dead .*?\n/X-SDmailit: dead Sat Apr 12 00 00 00 2003 +0000\n/ig;

    $email =~ s/Sent email \S+ to (.*?)\n/Sent email XXXXXXXXX-X to $1\n/ig;

    open OUT, '> actual.txt';  # use to gen the expected
    print OUT $email;
    close OUT;;
    $email;
}


######
# Date with year first
#
sub get_date
{
   my @d = localtime();
   @d = @d[5,4,3];
   $d[0] += 1900;
   $d[1] += 1;
   sprintf( "%04d/%02d/%02d", @d[0,1,2]);

}


######
# Format hash table
#
sub format_hash_table
{

    my (undef, $h_p, $width_p, $header_p) = @_;

    my @array_table = ();

    my (@keys, $key, $entries_p, @entries, $entry);
    unless (ref($h_p) eq 'HASH') {
        warn "Table to format must be an hash table\n";
        return undef;
    }
    @keys = sort keys %$h_p;
    foreach $key (@keys) {
       $entries_p = $h_p->{$key};
       @entries = sort keys %$entries_p;
       foreach $entry (@entries) {
           push @array_table, [$key, $entry];
       }
    }

    STD::TestUtil->format_array_table( \@array_table, $width_p, $header_p );

}



######
# Format the inventory list.
#
sub format_array_table
{

    my (undef, $a_p, $width_p, $header_p) = @_;

    unless (ref($a_p) eq 'ARRAY') {
        warn "Table to format must be an array table\n";
        return undef;
    }
    
    ######
    # Format the inventory list
    #
    unless (ref($width_p) eq 'ARRAY') {
        warn "Width  must be an array\n";
        return undef;
    }
    my @w = @$width_p;
    my $total=0;
    my (@dash, @header);
    foreach my $w (@w) {
        $total += $w;
        push @dash,'-' x $w;        

    }
    unshift @$a_p,[@dash];
    unshift @$a_p,[@$header_p];
    
    my ($type, $r_p, @r, $r, $r_total, $c, $size);
    my $str = "\n ";
    foreach $r_p (@$a_p) {
        
        unless (ref($r_p) eq 'ARRAY') {
            warn "Rows in table to format must be an arrays\n";
            return undef;
        }

        @r = @$r_p;

        $r_total = 0;     
        foreach $r (@r) {
            $r_total += length( $r);   
        }

        #####
        # Mutlitple of single line
        #
        $type = ($total < $r_total) ? 1 :0;
        $str .= "\n" if $type;

        while( $r_total ) {
            for( $c=0; $c < @w; $c++ ) {

                #######
                # Determine amount of row entry to use for column
                # 
                $size = length( $r[$c] );
                $size = ($w[$c] < $size) ? $w[$c] : $size;
                
                ########
                # Add row to column
                #  
                $str .= substr( $r[$c], 0, $size );
                if ($size < length( $r[$c] )) {
                    $r[$c] = substr( $r[$c], $size);
                }
                else {
                    $r[$c] = '';
                    $str .= ' ' x ($w[$c] - $size);
                }
                $str .= ($c < (@w - 1)) ? ' ' : "\n ";
            }

            $r_total = 0;     
            foreach $r (@r) {
                $r_total = length( $r);   
            }
        }       

        $str .= "\n" if $type;
    } 
    
    $str .= "\n\n";

}


my %module = (
      MacOS   => 'Mac',
      MSWin32 => 'Win32',
      os2     => 'OS2',
      VMS     => 'VMS',
      epoc    => 'Epoc');

sub fspec2module
{
    my (undef,$fspec) = @_;
    $module{$fspec} || 'Unix';
}


#####
# Convert between file specifications for different operating systems to a Unix file specification
#
sub fspec2fspec
{
    my (undef, $from_fspec, $to_fspec, $fspec_file, $nofile) = @_;

    return $fspec_file if $from_fspec eq $to_fspec;

    #######
    # Extract the raw @dirs, file
    #
    my $from_module = STD::TestUtil->fspec2module( $from_fspec );
    my $from_package = "File::Spec::$from_module";
    STD::TestUtil->load_package( $from_package);
    my (undef, $fspec_dirs, $file) = $from_package->splitpath( $fspec_file, $nofile); 
    my @dirs = (fspec_dirs) ? $from_package->splitdir( $fspec_dirs ) : ();

    return $file unless @dirs;  # no directories, file spec same for all os


    #######
    # Contruct the new file specification
    #
    my $to_module = STD::TestUtil->fspec2module( $to_fspec );
    my $to_package = "File::Spec::$to_module";
    STD::TestUtil->load_package( $to_package);
    my @dirs_up;
    foreach my $dir (@dirs) {
       $dir = $to_package->updir() if $dir eq $to_package->updir();
       push @dirs_up, $dir;
    }
    return $to_package->catdir(@dirs_up) if $nofile;
    $to_package->catfile(@dirs_up, $file); # to native operating system file spec

}


#####
#
#
sub fspec2os
{
    my (undef, $fspec, $fspec_file, $nofile) = @_;
    STD::TestUtil->fspec2fspec( $fspec, $^O, $fspec_file, $nofile);
}


#####
#
#
sub os2fspec
{
    my (undef, $fspec, $os_file, $nofile) = @_;
    STD::TestUtil->fspec2fspec($^O, $fspec, $os_file, $nofile);
}


sub fspec2pm
{
    my (undef, $fspec, $fspec_file) = @_;

    ##########
    # Must be a pm to conver to :: specification
    #
    return $fspec_file unless $fspec_file =~ /\.pm$/; 
    my $module = STD::TestUtil->fspec2module( $fspec );
    my $fspec_package = "File::Spec::$module";
    STD::TestUtil->load_package( $fspec_package);
    
    #####
    # extract the raw @dirs and file from the file spec
    # 
    my (undef, $fspec_dirs, $file) = $fspec_package->splitpath( $fspec_file ); 
    my @dirs = $fspec_package->splitdir( $fspec_dirs );
    pop @dirs unless $dirs[-1]; # sometimes get empty for last directory

    #####
    # Contruct the pm specification
    #
    $file =~ s/\..*?$//g; # drop extension
    $file = join '::', (@dirs,$file);    
    $file
}


####
# Find find
#
sub find_in_path
{
   my (undef, $fspec, $file, $path) = @_;
   $file = STD::TestUtil->fspec2os($fspec, $file);
   $path = [] unless( $path );
   push @$path, @INC;

   #######
   # Add t directories to the search path
   #
   my ($t_dir,@dirs,$vol);
   my @t_path=();
   foreach my $dir (@$path) {
       ($vol,$t_dir) = File::Spec->splitpath( $dir, 'nofile' );
       @dirs = File::Spec->splitdir($t_dir);
       if( $dirs[-1] eq 'lib' ) {
           $dirs[-1] = 't';
           $t_dir = File::Spec->catdir( @dirs);
           $t_dir = File::Spec->catpath( $vol, $t_dir, '');
           push @t_path,$t_dir;
       }
   }
   unshift @$path, @t_path if @t_path;

   ######
   # Add the bin directories to the search path
   #
   if( $ENV{PATH} ) {
       my @env_path = split /(?: |,|;)+/, $ENV{PATH};
       push @$path, @env_path;
   }
   elsif( $ENV{path} ) {
       my @env_path = split /(?: |,|;)+/, $ENV{path};
       push @$path, @env_path;
   }

   ######
   # Find the file in the search path
   #
   (undef, my $dirs, $file) = File::Spec->splitpath( $file ); 
   (@dirs) = File::Spec->splitdir( $dirs );
   foreach my $path_dir (@$path) {
       my $file_abs = File::Spec->catfile( $path_dir, @dirs, $file );  
       return ($file_abs, $path_dir) if(-f $file_abs);
   }
   return undef;
}


sub path_glob
{
   my (undef, $fspec, @files) = @_;
# bsd_glob, find_in_path
   @files
}


sub fspec_glob
{
   my (undef, $fspec, @files) = @_;
   my @glob_files = ();
   foreach my $file (@files) {
       $file = STD::TestUtil->fspec2os( $fspec, $file );
       push @glob_files, bsd_glob( $file );
   }
   @glob_files;
}

#######
# Replace variables in template
#
sub replace_variables
{
    my (undef, $template_p, $hash_p, $variables_p) = @_;

    unless( $variables_p ) {
        my @keys = sort keys %$hash_p;
        $variables_p = \@keys;
    }

    #########
    # Substitute selected content macros
    # 
    my $count = 1;
    while( $count ) {
        $count = 0;
        foreach my $variable (@$variables_p) {
            $count += $$template_p =~ s/([^\\])\$\{$variable\}/${1}$hash_p->{$variable}/g;
        }
    }
    $$template_p =~ s/\\\$/\$/g;  # unescape macro dollar

    1;
}


#####
# Determine the output generator program modules
#
sub drivers
{
   my ($self, $base_file, @dirs ) = @_;
   my $restore_dir = cwd();
   my ($vol, $dirs, undef) = File::Spec->splitpath(File::Spec->rel2abs($base_file));
   chdir $vol if $vol;
   chdir $dirs if $dirs;
   $dirs = File::Spec->catdir( @dirs );
   chdir $dirs if $dirs;
   my @drivers = bsd_glob( '*.pm' );
   foreach my $driver (@drivers) {
       $driver =~ s/\.pm$//;
   }
   chdir $restore_dir;
   @drivers
}


#####
# Determine if the output type is valid
#
sub is_driver
{
   my ($self, $driver, @drivers) = @_;

   ($driver) = $driver =~ /^\s*(.*)\s*$/; # zap leading, trailing white space
   my $length = length($driver);
   $driver = lc($driver);
   return undef unless( $length );

   my $driver_found = '';
   foreach my $driver_test (@drivers) {
       if( $driver eq  substr(lc($driver_test), 0, $length)) {
           if( $driver_found ) {
               warn "Ambiguous $driver\n";
               return undef;
           }
           $driver_found = $driver_test;
       }
   }
   return $driver_found if $driver_found;
   warn( "Cannot find a module for $driver.\n");
   undef

}



1


__END__

=head1 NAME
  
STD::Testit - functions that support scripts generated by STD::TestGen

=head1 SYNOPSIS

  use STD::TestUtil

  $data          = STD::TestUtil->fin( $file_name )
  $success       = STD::TestUtil->fout($file_name, $data)

  $require       = STD::TestUtil->package2require( $package )
  $package       = STD::TestUtil->is_package_loaded($package)
  $error         = STD::TestUtil->load_package($package)

  $errors        = STD::TestUtil->pod_errors($module)

  $scrub_script  = STD::TestUtil->scrub_date_version($script)

  $date          = STD::TestUtil->get_date( )

  $table         = STD::TestUtil->format_hash_table($hash_p, $width_p, $header_p)
  $table         = STD::TestUtil->format_array_table($array_p, $width_p, $header_p)

  $file          = STD::TestUtil->fspec2fspec($from_fspec, $to_fspec $fspec_file, $nofile)
  $os_file       = STD::TestUtil->fspec2os($fspec, $file, [$no_file])
  $fspec_file    = STD::TestUtil->os2fspec($fspec, $file, [$no_file])
  ($file, $path) = STD::TestUtil->find_in_path($fspec, $file, [\@os_path])
  $pm_file       = STD::TestUtil->fspec2pm( $fpec, $file )

  $success       = STD::TestUtil->replace_variables( $template_p, $variable_hash_p, $variable_p)

  @drivers       = STD::TestUtil->drivers($base_file, @dirs)
  $driver        = STD::TestUtil->is_driver($driver, @drivers)

  @globed_files  = STD::TestUtil->fspec_glob($fspec, @files)
  @globed_files  = STD::TestUtil->path_glob($fspec, @files)

=head1 DESCRIPTION

The C<STD::Testit> functions are designed to be used in test scripts
generated by C<STD::Testgen> (L<Testgen>) module.
The C<Teset::Testit> functions shall[1] isolated the actual and expected Perl
statements so they may be easily index for use in
automatically generated test documents 
and hide the intermediate variables used
to pass the acutal and expected values to the verification
routine. The C<Teset::Testit> functions shall[2] 
use the functions from the Test 
(L<Test>) module so that the results of the test scripts
generated by the STD::Testgen module may be used
with the currently developed Perl test tools.

=head1 QUALITY

The STD::Tester functions are a integral part of
the STD::Testgen module. 
The tests performed for the C<STD::Testgen>
module, (L<Testgen/QUALITY>), (L<testgen_p) by F<testgen_t.pl>
verifies all the requirements for the STD::Tester module.

=head1 AUTHOR

The holder of the copyright and maintainer is

E<lt>support@SoftwareDiamonds.comE<gt>

=head2 COPYRIGHT NOTICE

Copyrighted (c) 2002 Software Diamonds

All Rights Reserved

=head2 BINDING REQUIREMENTS NOTICE

Binding requirements are indexed with the
pharse 'shall[dd]' where dd is an unique number
for each header section.
This conforms to standard federal
government practices, 490A (L<STD490A/3.2.3.6>).
In accordance with the License, Software Diamonds
is not liable for any requirement, binding or otherwise.

=head2 LICENSE

Software Diamonds permits the redistribution
and use in source and binary forms, with or
without modification, provided that the 
following conditions are met: 

=over 4

=item 1

Redistributions of source code must retain
the above copyright notice, this list of
conditions and the following disclaimer. 

=item 2

Redistributions in binary form must 
reproduce the above copyright notice,
this list of conditions and the following 
disclaimer in the documentation and/or
other materials provided with the
distribution.

=back

SOFTWARE DIAMONDS, http::www.softwarediamonds.com,
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

L<Test> L<Testgen/QUALITY> L<testgen_p> L<testgen_t>

=for html
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
<!-- BLK ID="COPYRIGHT" -->
<!-- /BLK -->
<p><br>
<!-- BLK ID="LOG_CGI" -->
<!-- /BLK -->
<p><br>

=cut

### end of file ###