#!/usr/bin/env perl

use Test2::V0;
use TCOD;

ok my $context = TCOD::Context->new(
    columns => 100,
    rows    => 100,
    sdl_window_flags => 8, # Hidden window
);

done_testing;
