#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
use Fancy::Module;

is_it_the_number(21);
is_it_the_number(42);
is_the_sum_the_number(21,21);
is_the_sum_the_number(42,0);
is_the_sum_the_number(0,42);
is_the_sum_the_number(42,42);
is_the_sum_the_number(23,42);
is_the_sum_the_number(42,23);
is_the_sum_the_number(43,43);
is_the_sum_the_number(43,21);
is_the_sum_the_number(21,43);
is_the_sum_the_number(21,21);

print("done\n");