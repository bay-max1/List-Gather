use strict;
use warnings;
use Test::More 0.89;
use Test::Fatal;

use gather;

{
    no warnings 'void';
    my $x = eval 'sub { gather { take 42 }; 42 }';
    is $@, '';

    eval 'sub { gather({ take 42 }); 42 }';
    is $@, '';

    eval 'sub { gather  (  { take 42 }  )  ; 42 }';
    is $@, '';
}

eval 'sub { gather { take 42 } 42 }';
like $@, qr/^syntax error/;

eval 'sub { gather({ take 42 }) 42 }';
like $@, qr/^syntax error/;

eval 'sub { gather({ take 42 }; 42 }';
like $@, qr/^syntax error/;

eval 'sub { gather([]) }';
like $@, qr/^syntax error/;

done_testing;
