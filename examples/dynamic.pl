#!/usr/bin/env perl

use strict;
use warnings;
use TCOD;
use File::Share 'dist_file';

use constant {
    WIDTH  => 720,
    HEIGHT => 480,
    #         RESIZABLE    MAXIMIZED
    FLAGS  => 0x00000020 | 0x00000080,
};

my $tileset = TCOD::Tileset->load_tilesheet(
    path    => dist_file( TCOD => 'fonts/dejavu10x10_gs_tc.png' ),
    columns => 32,
    rows    => 8,
    charmap => TCOD::CHARMAP_TCOD,
);

my $context = TCOD::Context->new(
    width            => WIDTH,
    height           => HEIGHT,
    sdl_window_flags => FLAGS,
);

while (1) {
    my $console = $context->new_console;
    $console->print( 0, 0, 'Hello World!' );
    $context->present( $console, integer_scaling => 1 );

    my $iter = TCOD::Event::wait;
    while ( my $event = $iter->() ) {
        $context->convert_event($event);
        print $event->as_string . "\n";
        exit if $event->type eq 'QUIT';
    }
}
