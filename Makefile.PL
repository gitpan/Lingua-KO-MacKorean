use ExtUtils::MakeMaker;

require 5.006001;

do "mkheader";

WriteMakefile(
    'NAME'		=> 'Lingua::KO::MacKorean',
    'VERSION_FROM'	=> 'MacKorean.pm',
    'ABSTRACT_FROM'	=> 'MacKorean.pm',
    'AUTHOR'		=> 'SADAHIRO Tomoyuki <SADAHIRO@cpan.org>',
    clean =>  {FILES=> 'fmmacko.h tomacko.h'},
);

