
####
# 
# The module Build::SVDgen generated this file from the contents of
#
# SVD/STD-STDgen.svd 
#
# Don't edit this file, edit instead
#
# SVD/STD-STDgen.svd
#
#	ANY CHANGES MADE HERE WILL BE LOST
#
#       the next time Build::SVDgen generates it.
#
#

use ExtUtils::MakeMaker; 

WriteMakefile(
    NAME => 'STD::STDgen',
    DISTNAME => 'STD-STDgen',
    VERSION  => '0.02',
    dist     => {COMPRESS => 'gzip',
                'gz' => 'gz'},
    test     => {TESTS => 't\DataCop\DataFile.t t\DataCop\FormDB.t t\STD\TestGen.t'},

    PREREQ_PM => {'MILITARY::STD490A' => 0,
                  'MILITARY::STD' => 0,},


    ($] >= 5.005 ?     
        (AUTHOR    => 'SoftwareDiamonds.com E<lt>support@SoftwareDiamonds.comE<gt>',
       ABSTRACT  => 'Software to generate Software Test Description (STD) documents and test scripts from a test database file.', ) : ()),
);

