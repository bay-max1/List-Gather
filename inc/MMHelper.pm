package MMHelper;

use strict;
use warnings;
use Config ();

my $callchecker_h = 'callchecker0.h';
my $callparser_h = 'callparser.h';

sub ccflags_dyn {
    my ($is_dev) = @_;

    my $ccflags = q<( $Config::Config{ccflags} || '' ) . ' -I.'>;
    $ccflags .= q< . ' -Wall -Wdeclaration-after-statement'>
        if $is_dev;

    return $ccflags;
}

sub ccflags_static {
    my $is_dev = shift;
    return eval ccflags_dyn $is_dev;
}


sub mm_args {
    return (
        clean => { FILES => join q{ } => $callchecker_h, $callparser_h },
    );
}

sub header_generator {
    return <<"EOC";
use Devel::CallChecker;
use Devel::CallParser;
use IO::File;

IO::File->new('${callchecker_h}', 'w')->print(
    Devel::CallChecker::callchecker0_h,
);

IO::File->new('${callparser_h}', 'w')->print(
    Devel::CallParser::callparser1_h,
);
EOC
}

1;