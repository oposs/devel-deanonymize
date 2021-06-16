package Fancy::Module;
use strict;
use warnings FATAL => 'all';
use experimental 'signatures';

use base 'Exporter';
our @EXPORT = qw(is_it_the_number);


my $anon = sub($number) {
    if ($number != 42) {
        return "No, it's not";
    }
};

sub is_it_the_number($number) {
    if ($number == 42) {
        return "It is the number";
    }
    else {
        &{$anon}($number);
    }
}

1;

__END__