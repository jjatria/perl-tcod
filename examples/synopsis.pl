#!/usr/bin/env perl

use strict;
use warnings;
use TCOD;
use File::Share 'dist_file';

use constant {
    WIDTH  => 80,
    HEIGHT => 60,
};

my $tileset = TCOD::Tileset->load_tilesheet(
    dist_file( TCOD => 'fonts/dejavu10x10_gs_tc.png' ),
    32, 8, TCOD::CHARMAP_TCOD,
);

my $console = TCOD::Console->new( WIDTH, HEIGHT );

my $context = TCOD::Context->new_terminal(
    WIDTH, HEIGHT, tileset => $tileset,
);

while (1) {
    $console->clear;
    $console->print( 0, 0, 'Hello World!' );
    $context->present( $console );

    my $iter = TCOD::Event::wait;
    while ( my $event = $iter->() ) {
        exit if $event->type eq 'QUIT';
    }
}
