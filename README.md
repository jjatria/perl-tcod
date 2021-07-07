# NAME

TCOD - FFI bindings for libtcod

# SYNOPSIS

    use TCOD;

    TCOD::Console::set_custom_font(
        dist_file( TCOD => 'arial10x10.png' ),
        TCOD::FONT_TYPE_GREYSCALE | TCOD::FONT_LAYOUT_TCOD,
    );

    TCOD::Console::init_root( 80, 40, 'TCOD in Perl', 0 );

    until ( TCOD::Console::is_window_closed ) {
        TCOD::Console::set_default_foreground( undef, TCOD::WHITE );

        TCOD::Console::put_char( undef, 1, 1, ord('@'), TCOD::BKGND_NONE );

        TCOD::Console::flush;

        my $key = TCOD::Console::check_for_keypress(TCOD::EVENT_ANY);
        last if $key->vk == TCOD::K_ESCAPE;
    }

# DESCRIPTION

TCOD offers Perl bindings to libtcod, a library for developing roguelike games.

## On Stability

This distribution is currently **experimental**, and as such, its API might
still change without warning. Any change, breaking or not, will be noted in
the change log, so if you wish to use it, please pin your dependencies and
make sure to check the change log before upgrading.

# FUNCTIONS

# ENUMS

## Alignment

    TCOD::LEFT
    TCOD::RIGHT
    TCOD::CENTER

## Renderer

    TCOD::RENDERER_GLSL
    TCOD::RENDERER_OPENGL
    TCOD::RENDERER_SDL
    TCOD::RENDERER_SDL2
    TCOD::RENDERER_OPENGL2
    TCOD::NB_RENDERERS

## BackgroundFlag

    TCOD::BKGND_NONE
    TCOD::BKGND_SET
    TCOD::BKGND_MULTIPLY
    TCOD::BKGND_LIGHTEN
    TCOD::BKGND_DARKEN
    TCOD::BKGND_SCREEN
    TCOD::BKGND_COLOR_DODGE
    TCOD::BKGND_COLOR_BURN
    TCOD::BKGND_ADD
    TCOD::BKGND_ADDA
    TCOD::BKGND_BURN
    TCOD::BKGND_OVERLAY
    TCOD::BKGND_ALPH
    TCOD::BKGND_DEFAULT

## ColorControl

    TCOD::COLCTRL_1
    TCOD::COLCTRL_2
    TCOD::COLCTRL_3
    TCOD::COLCTRL_4
    TCOD::COLCTRL_5
    TCOD::COLCTRL_NUMBER
    TCOD::COLCTRL_FORE_RGB
    TCOD::COLCTRL_BACK_RGB
    TCOD::COLCTRL_STOP

## Keycode

    TCOD::K_NONE
    TCOD::K_ESCAPE
    TCOD::K_BACKSPACE
    TCOD::K_TAB
    TCOD::K_ENTER
    TCOD::K_SHIFT
    TCOD::K_CONTROL
    TCOD::K_ALT
    TCOD::K_PAUSE
    TCOD::K_CAPSLOCK
    TCOD::K_PAGEUP
    TCOD::K_PAGEDOWN
    TCOD::K_END
    TCOD::K_HOME
    TCOD::K_UP
    TCOD::K_LEFT
    TCOD::K_RIGHT
    TCOD::K_DOWN
    TCOD::K_PRINTSCREEN
    TCOD::K_INSERT
    TCOD::K_DELETE
    TCOD::K_LWIN
    TCOD::K_RWIN
    TCOD::K_APPS
    TCOD::K_0
    TCOD::K_1
    TCOD::K_2
    TCOD::K_3
    TCOD::K_4
    TCOD::K_5
    TCOD::K_6
    TCOD::K_7
    TCOD::K_8
    TCOD::K_9
    TCOD::K_KP0
    TCOD::K_KP1
    TCOD::K_KP2
    TCOD::K_KP3
    TCOD::K_KP4
    TCOD::K_KP5
    TCOD::K_KP6
    TCOD::K_KP7
    TCOD::K_KP8
    TCOD::K_KP9
    TCOD::K_KPADD
    TCOD::K_KPSUB
    TCOD::K_KPDIV
    TCOD::K_KPMUL
    TCOD::K_KPDEC
    TCOD::K_KPENTER
    TCOD::K_F1
    TCOD::K_F2
    TCOD::K_F3
    TCOD::K_F4
    TCOD::K_F5
    TCOD::K_F6
    TCOD::K_F7
    TCOD::K_F8
    TCOD::K_F9
    TCOD::K_F10
    TCOD::K_F11
    TCOD::K_F12
    TCOD::K_NUMLOCK
    TCOD::K_SCROLLLOCK
    TCOD::K_SPACE
    TCOD::K_CHAR
    TCOD::K_TEXT

## Char

    TCOD::CHAR_HLINE
    TCOD::CHAR_VLINE
    TCOD::CHAR_NE
    TCOD::CHAR_NW
    TCOD::CHAR_SE
    TCOD::CHAR_SW
    TCOD::CHAR_TEEW
    TCOD::CHAR_TEEE
    TCOD::CHAR_TEEN
    TCOD::CHAR_TEES
    TCOD::CHAR_CROSS
    TCOD::CHAR_DHLINE
    TCOD::CHAR_DVLINE
    TCOD::CHAR_DNE
    TCOD::CHAR_DNW
    TCOD::CHAR_DSE
    TCOD::CHAR_DSW
    TCOD::CHAR_DTEEW
    TCOD::CHAR_DTEEE
    TCOD::CHAR_DTEEN
    TCOD::CHAR_DTEES
    TCOD::CHAR_DCROSS
    TCOD::CHAR_BLOCK1
    TCOD::CHAR_BLOCK2
    TCOD::CHAR_BLOCK3
    TCOD::CHAR_ARROW_N
    TCOD::CHAR_ARROW_S
    TCOD::CHAR_ARROW_E
    TCOD::CHAR_ARROW_W
    TCOD::CHAR_ARROW2_N
    TCOD::CHAR_ARROW2_S
    TCOD::CHAR_ARROW2_E
    TCOD::CHAR_ARROW2_W
    TCOD::CHAR_DARROW_H
    TCOD::CHAR_DARROW_V
    TCOD::CHAR_CHECKBOX_UNSET
    TCOD::CHAR_CHECKBOX_SET
    TCOD::CHAR_RADIO_UNSET
    TCOD::CHAR_RADIO_SET
    TCOD::CHAR_SUBP_NW
    TCOD::CHAR_SUBP_NE
    TCOD::CHAR_SUBP_N
    TCOD::CHAR_SUBP_SE
    TCOD::CHAR_SUBP_DIAG
    TCOD::CHAR_SUBP_E
    TCOD::CHAR_SUBP_SW
    TCOD::CHAR_SMILIE
    TCOD::CHAR_SMILIE_INV
    TCOD::CHAR_HEART
    TCOD::CHAR_DIAMOND
    TCOD::CHAR_CLUB
    TCOD::CHAR_SPADE
    TCOD::CHAR_BULLET
    TCOD::CHAR_BULLET_INV
    TCOD::CHAR_MALE
    TCOD::CHAR_FEMALE
    TCOD::CHAR_NOTE
    TCOD::CHAR_NOTE_DOUBLE
    TCOD::CHAR_LIGHT
    TCOD::CHAR_EXCLAM_DOUBLE
    TCOD::CHAR_PILCROW
    TCOD::CHAR_SECTION
    TCOD::CHAR_POUND
    TCOD::CHAR_MULTIPLICATION
    TCOD::CHAR_FUNCTION
    TCOD::CHAR_RESERVED
    TCOD::CHAR_HALF
    TCOD::CHAR_ONE_QUARTER
    TCOD::CHAR_COPYRIGHT
    TCOD::CHAR_CENT
    TCOD::CHAR_YEN
    TCOD::CHAR_CURRENCY
    TCOD::CHAR_THREE_QUARTERS
    TCOD::CHAR_DIVISION
    TCOD::CHAR_GRADE
    TCOD::CHAR_UMLAUT
    TCOD::CHAR_POW1
    TCOD::CHAR_POW3
    TCOD::CHAR_POW2
    TCOD::CHAR_BULLET_SQUARE

## FontFlags

    TCOD::FONT_LAYOUT_ASCII_INCOL
    TCOD::FONT_LAYOUT_ASCII_INROW
    TCOD::FONT_TYPE_GREYSCALE
    TCOD::FONT_TYPE_GRAYSCALE
    TCOD::FONT_LAYOUT_TCOD
    TCOD::FONT_LAYOUT_CP437

## FOV

    TCOD::FOV_BASIC
    TCOD::FOV_DIAMOND
    TCOD::FOV_SHADOW
    TCOD::FOV_PERMISSIVE_0
    TCOD::FOV_PERMISSIVE_1
    TCOD::FOV_PERMISSIVE_2
    TCOD::FOV_PERMISSIVE_3
    TCOD::FOV_PERMISSIVE_4
    TCOD::FOV_PERMISSIVE_5
    TCOD::FOV_PERMISSIVE_6
    TCOD::FOV_PERMISSIVE_7
    TCOD::FOV_PERMISSIVE_8
    TCOD::FOV_RESTRICTIVE
    TCOD::NB_FOV_ALGORITHMS

## Event

    TCOD::EVENT_NONE
    TCOD::EVENT_KEY_PRESS
    TCOD::EVENT_KEY_RELEASE
    TCOD::EVENT_MOUSE_MOVE
    TCOD::EVENT_MOUSE_PRESS
    TCOD::EVENT_MOUSE_RELEASE
    TCOD::EVENT_KEY
    TCOD::EVENT_MOUSE
    TCOD::EVENT_ANY

# SEE ALSO

- [libtcod](https://github.com/libtcod/libtcod)
- [TCOD::Color](https://metacpan.org/pod/TCOD%3A%3AColor)
- [TCOD::Console](https://metacpan.org/pod/TCOD%3A%3AConsole)
- [TCOD::Dijkstra](https://metacpan.org/pod/TCOD%3A%3ADijkstra)
- [TCOD::Image](https://metacpan.org/pod/TCOD%3A%3AImage)
- [TCOD::Key](https://metacpan.org/pod/TCOD%3A%3AKey)
- [TCOD::Map](https://metacpan.org/pod/TCOD%3A%3AMap)
- [TCOD::Mouse](https://metacpan.org/pod/TCOD%3A%3AMouse)
- [TCOD::Path](https://metacpan.org/pod/TCOD%3A%3APath)
- [TCOD::Sys](https://metacpan.org/pod/TCOD%3A%3ASys)

# COPYRIGHT AND LICENSE

Copyright 2021 José Joaquín Atria

This library is free software; you can redistribute it and/or modify it under
the Artistic License 2.0.
