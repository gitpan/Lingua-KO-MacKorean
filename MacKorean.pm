package Lingua::KO::MacKorean;

require 5.006001;

use strict;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK %EXPORT_TAGS);

require Exporter;
require DynaLoader;

$VERSION = '0.01';
@ISA = qw(Exporter DynaLoader);
@EXPORT = qw(decodeMacKorean encodeMacKorean);
@EXPORT_OK = qw(decode encode);

bootstrap Lingua::KO::MacKorean $VERSION;
1;
__END__

=head1 NAME

Lingua::KO::MacKorean - transcoding between Mac OS Korean and Unicode

=head1 SYNOPSIS

(1) using function names exported by default:

    use Lingua::KO::MacKorean;
    $wchar = decodeMacKorean($octet);
    $octet = encodeMacKorean($wchar);

(2) using function names exported on request:

    use Lingua::KO::MacKorean qw(decode encode);
    $wchar = decode($octet);
    $octet = encode($wchar);

(3) using function names fully qualified:

    use Lingua::KO::MacKorean ();
    $wchar = Lingua::KO::MacKorean::decode($octet);
    $octet = Lingua::KO::MacKorean::encode($wchar);

   # $wchar : a string in Perl's Unicode format
   # $octet : a string in Mac OS Korean

=head1 DESCRIPTION

This module provides decoding from/encoding to Mac OS Korean encoding
(denoted MacKorean hereafter).

In order to ensure roundtrip mapping, MacKorean encoding
has some characters with mapping from a single MacKorean character
to a sequence of Unicode characters and vice versa.
Such characters includes C<0xAAF9> (MacKorean) from/to
C<0xF862+0x0028+0x0032+0x0031+0x0029> (Unicode)
for C<"Parenthesized number twenty-one">.

This module provides functions to transcode between MacKorean
encoding and Unicode, without information loss
for every MacKorean character.

=head2 Functions

=over 4

=item C<$wchar = decode($octet)>

=item C<$wchar = decode($handler, $octet)>

=item C<$wchar = decodeMacKorean($octet)>

=item C<$wchar = decodeMacKorean($handler, $octet)>

Converts MacKorean to Unicode.

C<decodeMacKorean()> is an alias for C<decode()> exported by default.

If the C<$handler> is not specified,
any MacKorean character that is not mapped to Unicode is deleted;
if the C<$handler> is a code reference,
a string returned from that coderef is inserted there.
if the C<$handler> is a scalar reference,
a string (a C<PV>) in that reference (the referent) is inserted there.

The 1st argument for the C<$handler> coderef is
a string of the unmapped MacKorean character (e.g. C<"\xC9\xA1">).

=item C<$octet = encode($wchar)>

=item C<$octet = encode($handler, $wchar)>

=item C<$octet = encodeMacKorean($wchar)>

=item C<$octet = encodeMacKorean($handler, $wchar)>

Converts Unicode to MacKorean.

C<encodeMacKorean()> is an alias for C<encode()> exported by default.

If the C<$handler> is not specified,
any Unicode character that is not mapped to MacKorean is deleted;
if the C<$handler> is a code reference,
a string returned from that coderef is inserted there.
if the C<$handler> is a scalar reference,
a string (a C<PV>) in that reference (the referent) is inserted there.

The 1st argument for the C<$handler> coderef is
the Unicode code point (unsigned integer) of the unmapped character.

E.g.

   sub hexNCR { sprintf("&#x%x;", shift) } # hexadecimal NCR
   sub decNCR { sprintf("&#%d;" , shift) } # decimal NCR

   print encodeMacKorean("ABC\x{100}\x{10000}");
   # "ABC"

   print encodeMacKorean(\"", "ABC\x{100}\x{10000}");
   # "ABC"

   print encodeMacKorean(\"?", "ABC\x{100}\x{10000}");
   # "ABC??"

   print encodeMacKorean(\&hexNCR, "ABC\x{100}\x{10000}");
   # "ABC&#x100;&#x10000;"

   print encodeMacKorean(\&decNCR, "ABC\x{100}\x{10000}");
   # "ABC&#256;&#65536;"

=back

=head1 CAVEAT

Sorry, the author is not working on a Mac OS.
Please let him know if you find something wrong.

=head1 AUTHOR

  SADAHIRO Tomoyuki  SADAHIRO@cpan.org

  http://homepage1.nifty.com/nomenclator/perl/

  Copyright(C) 2003-2003, SADAHIRO Tomoyuki. Japan. All rights reserved.

This module is free software; you can redistribute it
and/or modify it under the same terms as Perl itself.

=head1 SEE ALSO

=over 4

=item Map (external version) from Mac OS Korean encoding
to Unicode 3.2 (version: b3,c1 2002-Dec-19)

http://www.unicode.org/Public/MAPPINGS/VENDORS/APPLE/KOREAN.TXT

=back

=cut
