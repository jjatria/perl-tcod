# ABSTRACT: FFI bindings for libtcod
package TCOD;

use strict;
use warnings;

use FFI::CheckLib;
use FFI::Platypus 1.00;
use FFI::C;

my $ffi;
BEGIN {
    $ffi = FFI::Platypus->new( api => 1 );
    $ffi->lib( find_lib_or_exit lib => 'tcod' );
    FFI::C->ffi($ffi);
}

$ffi->load_custom_type( '::WideString' => 'wstring', access => 'read' );

sub enum {
    my %enums = @_;
    while ( my ( $name, $values ) = each %enums ) {
        require constant;
        constant->import($values);

        my $variable = __PACKAGE__ . '::' . $name;
        no strict 'refs';
        %{$variable} = ( %{$variable}, reverse %$values );
    }
}

BEGIN {
    enum Renderer => {
        RENDERER_GLSL           =>   0,
        RENDERER_OPENGL         =>   1,
        RENDERER_SDL            =>   2,
        RENDERER_SDL2           =>   3,
        RENDERER_OPENGL2        =>   4,
        NB_RENDERERS            =>   5,
    },
    BackgroundFlag => {
        BKGND_NONE              =>   0,
        BKGND_SET               =>   1,
        BKGND_MULTIPLY          =>   2,
        BKGND_LIGHTEN           =>   3,
        BKGND_DARKEN            =>   4,
        BKGND_SCREEN            =>   5,
        BKGND_COLOR_DODGE       =>   6,
        BKGND_COLOR_BURN        =>   7,
        BKGND_ADD               =>   8,
        BKGND_ADDA              =>   9,
        BKGND_BURN              =>  10,
        BKGND_OVERLAY           =>  11,
        BKGND_ALPH              =>  12,
        BKGND_DEFAULT           =>  13,
    },
    ColorControl => {
        COLCTRL_1               =>   1,
        COLCTRL_2               =>   2,
        COLCTRL_3               =>   3,
        COLCTRL_4               =>   4,
        COLCTRL_5               =>   5,
        COLCTRL_NUMBER          =>   5, # Repeated!
        COLCTRL_FORE_RGB        =>   6,
        COLCTRL_BACK_RGB        =>   7,
        COLCTRL_STOP            =>   8,
    },
    Keycode => {
        K_NONE                  =>   0,
        K_ESCAPE                =>   1,
        K_BACKSPACE             =>   2,
        K_TAB                   =>   3,
        K_ENTER                 =>   4,
        K_SHIFT                 =>   5,
        K_CONTROL               =>   6,
        K_ALT                   =>   7,
        K_PAUSE                 =>   8,
        K_CAPSLOCK              =>   9,
        K_PAGEUP                =>  10,
        K_PAGEDOWN              =>  11,
        K_END                   =>  12,
        K_HOME                  =>  13,
        K_UP                    =>  14,
        K_LEFT                  =>  15,
        K_RIGHT                 =>  16,
        K_DOWN                  =>  17,
        K_PRINTSCREEN           =>  18,
        K_INSERT                =>  19,
        K_DELETE                =>  20,
        K_LWIN                  =>  21,
        K_RWIN                  =>  22,
        K_APPS                  =>  23,
        K_0                     =>  24,
        K_1                     =>  25,
        K_2                     =>  26,
        K_3                     =>  27,
        K_4                     =>  28,
        K_5                     =>  29,
        K_6                     =>  30,
        K_7                     =>  31,
        K_8                     =>  32,
        K_9                     =>  33,
        K_KP0                   =>  34,
        K_KP1                   =>  35,
        K_KP2                   =>  36,
        K_KP3                   =>  37,
        K_KP4                   =>  38,
        K_KP5                   =>  39,
        K_KP6                   =>  40,
        K_KP7                   =>  41,
        K_KP8                   =>  42,
        K_KP9                   =>  43,
        K_KPADD                 =>  44,
        K_KPSUB                 =>  45,
        K_KPDIV                 =>  46,
        K_KPMUL                 =>  47,
        K_KPDEC                 =>  48,
        K_KPENTER               =>  49,
        K_F1                    =>  50,
        K_F2                    =>  51,
        K_F3                    =>  52,
        K_F4                    =>  53,
        K_F5                    =>  54,
        K_F6                    =>  55,
        K_F7                    =>  56,
        K_F8                    =>  57,
        K_F9                    =>  58,
        K_F10                   =>  59,
        K_F11                   =>  60,
        K_F12                   =>  61,
        K_NUMLOCK               =>  62,
        K_SCROLLLOCK            =>  63,
        K_SPACE                 =>  64,
        K_CHAR                  =>  65,
        K_TEXT                  =>  66,
    },
    Char => {
        CHAR_HLINE              => 196,
        CHAR_VLINE              => 179,
        CHAR_NE                 => 191,
        CHAR_NW                 => 218,
        CHAR_SE                 => 217,
        CHAR_SW                 => 192,
        CHAR_TEEW               => 180,
        CHAR_TEEE               => 195,
        CHAR_TEEN               => 193,
        CHAR_TEES               => 194,
        CHAR_CROSS              => 197,
        # double walls
        CHAR_DHLINE             => 205,
        CHAR_DVLINE             => 186,
        CHAR_DNE                => 187,
        CHAR_DNW                => 201,
        CHAR_DSE                => 188,
        CHAR_DSW                => 200,
        CHAR_DTEEW              => 185,
        CHAR_DTEEE              => 204,
        CHAR_DTEEN              => 202,
        CHAR_DTEES              => 203,
        CHAR_DCROSS             => 206,
        # blocks
        CHAR_BLOCK1             => 176,
        CHAR_BLOCK2             => 177,
        CHAR_BLOCK3             => 178,
        # arrows
        CHAR_ARROW_N            =>  24,
        CHAR_ARROW_S            =>  25,
        CHAR_ARROW_E            =>  26,
        CHAR_ARROW_W            =>  27,
        # arrows without tail
        CHAR_ARROW2_N           =>  30,
        CHAR_ARROW2_S           =>  31,
        CHAR_ARROW2_E           =>  16,
        CHAR_ARROW2_W           =>  17,
        # double arrows
        CHAR_DARROW_H           =>  29,
        CHAR_DARROW_V           =>  18,
        # GUI stuff
        CHAR_CHECKBOX_UNSET     => 224,
        CHAR_CHECKBOX_SET       => 225,
        CHAR_RADIO_UNSET        =>   9,
        CHAR_RADIO_SET          =>  10,
        # sub-pixel resoluti    on kit
        CHAR_SUBP_NW            => 226,
        CHAR_SUBP_NE            => 227,
        CHAR_SUBP_N             => 228,
        CHAR_SUBP_SE            => 229,
        CHAR_SUBP_DIAG          => 230,
        CHAR_SUBP_E             => 231,
        CHAR_SUBP_SW            => 232,
        # miscellaneous
        CHAR_SMILIE             =>   1,
        CHAR_SMILIE_INV         =>   2,
        CHAR_HEART              =>   3,
        CHAR_DIAMOND            =>   4,
        CHAR_CLUB               =>   5,
        CHAR_SPADE              =>   6,
        CHAR_BULLET             =>   7,
        CHAR_BULLET_INV         =>   8,
        CHAR_MALE               =>  11,
        CHAR_FEMALE             =>  12,
        CHAR_NOTE               =>  13,
        CHAR_NOTE_DOUBLE        =>  14,
        CHAR_LIGHT              =>  15,
        CHAR_EXCLAM_DOUBLE      =>  19,
        CHAR_PILCROW            =>  20,
        CHAR_SECTION            =>  21,
        CHAR_POUND              => 156,
        CHAR_MULTIPLICATION     => 158,
        CHAR_FUNCTION           => 159,
        CHAR_RESERVED           => 169,
        CHAR_HALF               => 171,
        CHAR_ONE_QUARTER        => 172,
        CHAR_COPYRIGHT          => 184,
        CHAR_CENT               => 189,
        CHAR_YEN                => 190,
        CHAR_CURRENCY           => 207,
        CHAR_THREE_QUARTERS     => 243,
        CHAR_DIVISION           => 246,
        CHAR_GRADE              => 248,
        CHAR_UMLAUT             => 249,
        CHAR_POW1               => 251,
        CHAR_POW3               => 252,
        CHAR_POW2               => 253,
        CHAR_BULLET_SQUARE      => 254,
    },
    FontFlags => {
        FONT_LAYOUT_ASCII_INCOL =>   1,
        FONT_LAYOUT_ASCII_INROW =>   2,
        FONT_TYPE_GREYSCALE     =>   4,
        FONT_TYPE_GRAYSCALE     =>   4,
        FONT_LAYOUT_TCOD        =>   8,
        FONT_LAYOUT_CP437       =>  16,
    },
    FOV => {
        FOV_BASIC               =>  0,
        FOV_DIAMOND             =>  1,
        FOV_SHADOW              =>  2,
        FOV_PERMISSIVE_0        =>  3,
        FOV_PERMISSIVE_1        =>  4,
        FOV_PERMISSIVE_2        =>  5,
        FOV_PERMISSIVE_3        =>  6,
        FOV_PERMISSIVE_4        =>  7,
        FOV_PERMISSIVE_5        =>  8,
        FOV_PERMISSIVE_6        =>  9,
        FOV_PERMISSIVE_7        => 10,
        FOV_PERMISSIVE_8        => 11,
        FOV_RESTRICTIVE         => 12,
        NB_FOV_ALGORITHMS       => 13,
    },
    Event => {
        EVENT_NONE              =>   0,
        EVENT_KEY_PRESS         =>   1,
        EVENT_KEY_RELEASE       =>   2,
        EVENT_MOUSE_MOVE        =>   4,
        EVENT_MOUSE_PRESS       =>   8,
        EVENT_MOUSE_RELEASE     =>  16,
        # Continued below
    },
}

BEGIN {
    enum Event => {
        # Continued above and below
        EVENT_KEY     => EVENT_KEY_PRESS  | EVENT_KEY_RELEASE,
        EVENT_MOUSE   => EVENT_MOUSE_MOVE | EVENT_MOUSE_PRESS | EVENT_MOUSE_RELEASE,
    },
}

BEGIN {
    enum Event => {
        EVENT_ANY     => EVENT_KEY | EVENT_MOUSE,
    },
}

$ffi->type( int    => 'TCOD_keycode' );
$ffi->type( opaque => 'TCOD_event'   );
$ffi->type( '(int, int, int, int, opaque )->float' => 'TCOD_path_func' );

$ffi->custom_type( TCOD_console => {
    native_type    => 'opaque',
    native_to_perl => sub { bless \$_[0], 'TCOD::Console' },
    perl_to_native => sub { $_[0] ? ${ $_[0] } : undef    },
});

$ffi->custom_type( TCOD_map => {
    native_type    => 'opaque',
    native_to_perl => sub { bless \$_[0], 'TCOD::Map' },
    perl_to_native => sub { $_[0] ? ${ $_[0] } : undef },
});

$ffi->custom_type( TCOD_path => {
    native_type    => 'opaque',
    native_to_perl => sub { bless \$_[0], 'TCOD::Path' },
    perl_to_native => sub { $_[0] ? ${ $_[0] } : undef    },
});

$ffi->custom_type( TCOD_dijkstra => {
    native_type    => 'opaque',
    native_to_perl => sub { bless \$_[0], 'TCOD::Dijkstra' },
    perl_to_native => sub { $_[0] ? ${ $_[0] } : undef    },
});

package TCOD::Key {
    use FFI::Platypus::Record;
    record_layout_1(
        int => 'vk',
        uint8        => 'c',
        'uint8[32]'  => 'text',
        bool         => 'pressed',
        bool         => 'lalt',
        bool         => 'lctrl',
        bool         => 'lmeta',
        bool         => 'ralt',
        bool         => 'rctrl',
        bool         => 'rmeta',
        bool         => 'shift',
    );
    $ffi->type( 'record(TCOD::Key)'  => 'TCOD_key'  );
}

package TCOD::Mouse {
    use FFI::Platypus::Record;
    record_layout_1(
        int  => 'x',
        int  => 'y',
        int  => 'dx',
        int  => 'dy',
        int  => 'dcx',
        int  => 'dcy',
        bool => 'lbutton',
        bool => 'rbutton',
        bool => 'mbutton',
        bool => 'lbutton_pressed',
        bool => 'rbutton_pressed',
        bool => 'mbutton_pressed',
        bool => 'wheel_up',
        bool => 'wheel_down',
    );
    $ffi->type( 'record(TCOD::Mouse)'  => 'TCOD_mouse'  );
}

package TCOD::Color {
    $ffi->mangler( sub { 'TCOD_color_' . shift } );

    use FFI::Platypus::Record;
    record_layout_1( uint8 => 'r', uint8 => 'g', uint8 => 'b' );
    $ffi->type( 'record(TCOD::Color)'  => 'TCOD_color'  );

    {
        # Give color a positional constructor
        no strict 'refs';
        no warnings 'redefine';

        my $old  = __PACKAGE__->can('new') or die;
        my $new  = sub { shift->$old({ r => shift, g => shift, b => shift })  };
        my $name = __PACKAGE__ . '::new';

        require Sub::Util;
        *{$name} = Sub::Util::set_subname $name => $new;
    }

    sub rgb { my $self = shift; sprintf '#%02x%02x%02x', $self->r, $self->g, $self->b }

    $ffi->attach( equals          => [qw( TCOD_color TCOD_color           )] => 'bool'       );
    $ffi->attach( add             => [qw( TCOD_color TCOD_color           )] => 'TCOD_color' );
    $ffi->attach( subtract        => [qw( TCOD_color TCOD_color           )] => 'TCOD_color' );
    $ffi->attach( multiply        => [qw( TCOD_color TCOD_color           )] => 'TCOD_color' );
    $ffi->attach( multiply_scalar => [qw( TCOD_color float                )] => 'TCOD_color' );

    $ffi->attach( lerp            => [qw( TCOD_color TCOD_color float     )] => 'TCOD_color' );

    $ffi->attach( get_hue         => [qw( TCOD_color                      )] => 'double'     );
    $ffi->attach( set_hue         => [qw( TCOD_color float                )] => 'void'       );

    $ffi->attach( get_saturation  => [qw( TCOD_color                      )] => 'double'     );
    $ffi->attach( set_saturation  => [qw( TCOD_color float                )] => 'void'       );

    $ffi->attach( get_value       => [qw( TCOD_color                      )] => 'double'     );
    $ffi->attach( set_value       => [qw( TCOD_color float                )] => 'void'       );

    $ffi->attach( shift_hue       => [qw( TCOD_color float                )] => 'void'       );
    $ffi->attach( scale_HSV       => [qw( TCOD_color float float          )] => 'void'       );

    $ffi->attach( get_HSV         => [qw( TCOD_color float* float* float* )] => 'void'       );
    $ffi->attach( set_HSV         => [qw( TCOD_color float float float    )] => 'void'       );

    sub gen_map {
        shift if ref $_[0]; # Discard first arg if called like $color->gen_map( %map )
        my ( $this, @rest ) = List::Util::pairs @_;

        my @map;
        for my $next (@rest) {
            my ( $start, $end ) = ( $this->[1], $next->[1] );

            for my $i ( $start .. $end ) {
                $map[$i] = $this->[0]->lerp( $next->[0], ( $i - $start ) / ( $end - $start ) );
            }

            $this = $next;
        }

        @map;
    }
}

package TCOD::Map {
    $ffi->mangler( sub { 'TCOD_map_' . shift } );

    $ffi->attach( new            => [qw(          int int              )] => 'TCOD_map' => sub { $_[0]->( @_[ 2 .. $#_ ] ) } );
    $ffi->attach( set_properties => [qw( TCOD_map int int bool bool    )] => 'void' );
    $ffi->attach( clear          => [qw( TCOD_map         bool bool    )] => 'void' );
    $ffi->attach( copy           => [qw( TCOD_map TCOD_map             )] => 'void' );

    $ffi->attach( compute_fov    => [qw( TCOD_map int int int bool int )] => 'void' );
    $ffi->attach( is_in_fov      => [qw( TCOD_map int int              )] => 'bool' );
    $ffi->attach( is_transparent => [qw( TCOD_map int int              )] => 'bool' );
    $ffi->attach( is_walkable    => [qw( TCOD_map int int              )] => 'bool' );

    $ffi->attach( get_width      => [qw( TCOD_map                      )] => 'int'  );
    $ffi->attach( get_height     => [qw( TCOD_map                      )] => 'int'  );
}

package TCOD::Console {
    $ffi->mangler( sub { shift } );
    $ffi->attach( [ TCOD_console_delete => 'DESTROY' ] => [qw( TCOD_console )] => 'void' );

    $ffi->mangler( sub { 'TCOD_console_' . shift } );

    # Constructors
    $ffi->attach( new       => [qw( int int )] => 'TCOD_console' => sub { $_[0]->( @_[ 2 .. $#_ ] ) } );
    $ffi->attach( from_file => [qw( string  )] => 'TCOD_console' );
    $ffi->attach( load_asc  => [qw( string  )] => 'TCOD_console' );
    $ffi->attach( load_apf  => [qw( string  )] => 'TCOD_console' );

    # Methods
    $ffi->attach( save_asc      => [qw( TCOD_console string                                           )] => 'bool' );
    $ffi->attach( save_apf      => [qw( TCOD_console string                                           )] => 'bool' );
    $ffi->attach( blit          => [qw( TCOD_console int int int int TCOD_console int int float float )] => 'void' );
    $ffi->attach( set_key_color => [qw( TCOD_console TCOD_color                                       )] => 'void' );
    $ffi->attach( clear         => [qw( TCOD_console                                                  )] => 'void' );

    $ffi->attach( get_width              => [qw( TCOD_console                                   )] => 'int'  );
    $ffi->attach( get_height             => [qw( TCOD_console                                   )] => 'int'  );

    $ffi->attach( set_background_flag    => [qw( TCOD_console int                               )] => 'void' );
    $ffi->attach( get_background_flag    => [qw( TCOD_console                                   )] => 'int'  );

    $ffi->attach( set_alignment          => [qw( TCOD_console int                               )] => 'void' );
    $ffi->attach( get_alignment          => [qw( TCOD_console                                   )] => 'int'  );

    $ffi->attach( set_char_background    => [qw( TCOD_console int int TCOD_color int            )] => 'void' );
    $ffi->attach( get_char_background    => [qw( TCOD_console int int                           )] => 'TCOD_color'  );

    $ffi->attach( set_char_foreground    => [qw( TCOD_console int int TCOD_color                )] => 'void' );
    $ffi->attach( get_char_foreground    => [qw( TCOD_console int int                           )] => 'TCOD_color'  );

    $ffi->attach( set_default_background => [qw( TCOD_console TCOD_color                        )] => 'void' );
    $ffi->attach( get_default_background => [qw( TCOD_console                                   )] => 'TCOD_color'  );

    $ffi->attach( set_default_foreground => [qw( TCOD_console TCOD_color                        )] => 'void' );
    $ffi->attach( get_default_foreground => [qw( TCOD_console                                   )] => 'TCOD_color'  );

    $ffi->attach( set_char               => [qw( TCOD_console int int int                       )] => 'void' );
    $ffi->attach( get_char               => [qw( TCOD_console int int                           )] => 'int'  );
    $ffi->attach( put_char               => [qw( TCOD_console int int int int                   )] => 'void' );
    $ffi->attach( put_char_ex            => [qw( TCOD_console int int int TCOD_color TCOD_color )] => 'void' );

    # We support up to two controls per function for now
    $ffi->attach( print           => [qw( TCOD_console int int string                      )] => ['int', 'int'] => 'void' );
    $ffi->attach( print_ex        => [qw( TCOD_console int int int int string              )] => ['int', 'int'] => 'void' );
    $ffi->attach( print_rect      => [qw( TCOD_console int int int int string              )] => ['int', 'int'] => 'void' );
    $ffi->attach( print_rect_ex   => [qw( TCOD_console int int int int int int string      )] => ['int', 'int'] => 'void' );
    $ffi->attach( get_height_rect => [qw( TCOD_console int int int int string              )] => ['int', 'int'] => 'void' );
    # UTF-8 variants
    $ffi->attach( print_utf           => [qw( TCOD_console int int wstring                 )] => ['int', 'int'] => 'void' );
    $ffi->attach( print_ex_utf        => [qw( TCOD_console int int int int wstring         )] => ['int', 'int'] => 'void' );
    $ffi->attach( print_rect_utf      => [qw( TCOD_console int int int int wstring         )] => ['int', 'int'] => 'void' );
    $ffi->attach( print_rect_ex_utf   => [qw( TCOD_console int int int int int int wstring )] => ['int', 'int'] => 'void' );
    $ffi->attach( get_height_rect_utf => [qw( TCOD_console int int int int wstring         )] => ['int', 'int'] => 'void' );

    # Root console functions
    $ffi->attach( init_root               => [qw( int int string int bool                 )] => 'void' );
    $ffi->attach( set_custom_font         => [qw( string int int int                      )] => 'void' );
    $ffi->attach( map_ascii_code_to_font  => [qw( int int int                             )] => 'void' );
    $ffi->attach( map_ascii_codes_to_font => [qw( int int int int                         )] => 'void' );
    $ffi->attach( map_string_to_font      => [qw( string int int                          )] => 'void' );
    $ffi->attach( is_fullscreen           => [                                             ] => 'bool' );
    $ffi->attach( set_fullscreen          => [qw( bool                                    )] => 'void' );
    $ffi->attach( set_window_title        => [qw( string                                  )] => 'void' );
    $ffi->attach( is_window_closed        => [                                             ] => 'bool' );
    $ffi->attach( has_mouse_focus         => [                                             ] => 'bool' );
    $ffi->attach( is_active               => [                                             ] => 'bool' );
    $ffi->attach( credits                 => [                                             ] => 'void' );
    $ffi->attach( credits_render          => [qw( int int bool                            )] => 'bool' );
    $ffi->attach( credits_reset           => [                                             ] => 'void' );
    $ffi->attach( flush                   => [                                             ] => 'void' );
    $ffi->attach( set_fade                => [qw( uint8 TCOD_color                        )] => 'void' );
    $ffi->attach( get_fade                => [                                             ] => 'uint8' );
    $ffi->attach( get_fading_color        => [                                             ] => 'TCOD_color' );

    $ffi->attach( set_color_control      => [qw( int TCOD_color TCOD_color                )] => 'void' );

    $ffi->attach( check_for_keypress => ['int'] => 'TCOD_key' );
    $ffi->attach( is_key_pressed     => ['int'] => 'bool'     );
}

package TCOD::Sys {
    $ffi->mangler( sub { 'TCOD_sys_' . shift } );

    $ffi->attach( wait_for_event  => [qw( int TCOD_key* TCOD_mouse* bool )] => 'TCOD_event' );
    $ffi->attach( check_for_event => [qw( int TCOD_key* TCOD_mouse*      )] => 'TCOD_event' );
}

package TCOD::Path {
    $ffi->mangler( sub { 'TCOD_path_' . shift } );

    my $new = sub {
        my $sub = shift;
        my $class = ref $_[0] || $_[0];
        shift if $class eq __PACKAGE__;
        $sub->(@_);
    };

    # Constructors
    $ffi->attach( new_using_map      => [qw(         TCOD_map              float )] => 'TCOD_path' => $new );
    $ffi->attach( new_using_function => [qw( int int TCOD_path_func opaque float )] => 'TCOD_path' => $new );

    $ffi->attach( compute  => [qw( TCOD_path int int int int )] => 'bool' );
    $ffi->attach( reverse  => [qw( TCOD_path                 )] => 'void' );
    $ffi->attach( is_empty => [qw( TCOD_path                 )] => 'bool' );
    $ffi->attach( size     => [qw( TCOD_path                 )] => 'int'  );

    $ffi->attach( get_origin => [qw( TCOD_path int* int* )] => 'void' => sub {
        my ( $x, $y );
        $_[0]->( $_[1], \$x, \$y );
        return ( $x, $y );
    });

    $ffi->attach( get_destination => [qw( TCOD_path int* int* )] => 'void' => sub {
        my ( $x, $y );
        $_[0]->( $_[1], \$x, \$y );
        return ( $x, $y );
    });

    $ffi->attach( get => [qw( TCOD_path int int* int* )] => 'void' => sub {
        my ( $x, $y );
        $_[0]->( @_[ 1, 2 ], \$x, \$y );
        return ( $x, $y );
    });

    $ffi->attach( walk => [qw( TCOD_path int* int* bool )] => 'bool' => sub {
        my ( $x, $y );
        $_[0]->( $_[1], \$x, \$y, $_[2] ) or return;
        return ( $x, $y );
    });

    $ffi->mangler( sub { shift } );
    $ffi->attach( [ TCOD_path_delete => 'DESTROY' ] => ['TCOD_path'] => 'void' );
}

package TCOD::Dijkstra {
    $ffi->mangler( sub { 'TCOD_dijkstra_' . shift } );

    my $new = sub {
        my $sub = shift;
        my $class = ref $_[0] || $_[0];
        shift if $class eq __PACKAGE__;
        $sub->(@_);
    };

    # Constructors
    $ffi->attach( new                => [qw(         TCOD_map              float )] => 'TCOD_dijkstra' => $new );
    $ffi->attach( new_using_function => [qw( int int TCOD_path_func opaque float )] => 'TCOD_dijkstra' => $new );

    $ffi->attach( compute      => [qw( TCOD_dijkstra int int )] => 'void'  );
    $ffi->attach( path_set     => [qw( TCOD_dijkstra int int )] => 'bool'  );
    $ffi->attach( reverse      => [qw( TCOD_dijkstra         )] => 'void'  );
    $ffi->attach( is_empty     => [qw( TCOD_dijkstra         )] => 'bool'  );
    $ffi->attach( size         => [qw( TCOD_dijkstra         )] => 'int'   );
    $ffi->attach( get_distance => [qw( TCOD_dijkstra int int )] => 'float' );

    $ffi->attach( get => [qw( TCOD_dijkstra int int* int* )] => 'void' => sub {
        my ( $x, $y );
        $_[0]->( @_[ 1, 2 ], \$x, \$y );
        return ( $x, $y );
    });

    # FIXME: Where did this function go?
    # $ffi->attach( walk => [qw( TCOD_dijkstra int* int* )] => 'bool' => sub {
    #     my ( $x, $y );
    #     shift->( shift, \$x, \$y ) or return;
    #     return ( $x, $y );
    # });

    $ffi->mangler( sub { shift } );
    $ffi->attach( [ TCOD_dijkstra_delete => 'DESTROY' ] => ['TCOD_dijkstra'] => 'void' );
}

constant->import({
    # color values
    BLACK                  => TCOD::Color->new(   0,   0,   0 ),
    DARKEST_GREY           => TCOD::Color->new(  31,  31,  31 ),
    DARKER_GREY            => TCOD::Color->new(  63,  63,  63 ),
    DARK_GREY              => TCOD::Color->new(  95,  95,  95 ),
    GREY                   => TCOD::Color->new( 127, 127, 127 ),
    LIGHT_GREY             => TCOD::Color->new( 159, 159, 159 ),
    LIGHTER_GREY           => TCOD::Color->new( 191, 191, 191 ),
    LIGHTEST_GREY          => TCOD::Color->new( 223, 223, 223 ),
    WHITE                  => TCOD::Color->new( 255, 255, 255 ),

    DARKEST_SEPIA          => TCOD::Color->new(  31,  24,  15 ),
    DARKER_SEPIA           => TCOD::Color->new(  63,  50,  31 ),
    DARK_SEPIA             => TCOD::Color->new(  94,  75,  47 ),
    SEPIA                  => TCOD::Color->new( 127, 101,  63 ),
    LIGHT_SEPIA            => TCOD::Color->new( 158, 134, 100 ),
    LIGHTER_SEPIA          => TCOD::Color->new( 191, 171, 143 ),
    LIGHTEST_SEPIA         => TCOD::Color->new( 222, 211, 195 ),

    # desaturated
    DESATURATED_RED        => TCOD::Color->new( 127,  63,  63 ),
    DESATURATED_FLAME      => TCOD::Color->new( 127,  79,  63 ),
    DESATURATED_ORANGE     => TCOD::Color->new( 127,  95,  63 ),
    DESATURATED_AMBER      => TCOD::Color->new( 127, 111,  63 ),
    DESATURATED_YELLOW     => TCOD::Color->new( 127, 127,  63 ),
    DESATURATED_LIME       => TCOD::Color->new( 111, 127,  63 ),
    DESATURATED_CHARTREUSE => TCOD::Color->new(  95, 127,  63 ),
    DESATURATED_GREEN      => TCOD::Color->new(  63, 127,  63 ),
    DESATURATED_SEA        => TCOD::Color->new(  63, 127,  95 ),
    DESATURATED_TURQUOISE  => TCOD::Color->new(  63, 127, 111 ),
    DESATURATED_CYAN       => TCOD::Color->new(  63, 127, 127 ),
    DESATURATED_SKY        => TCOD::Color->new(  63, 111, 127 ),
    DESATURATED_AZURE      => TCOD::Color->new(  63,  95, 127 ),
    DESATURATED_BLUE       => TCOD::Color->new(  63,  63, 127 ),
    DESATURATED_HAN        => TCOD::Color->new(  79,  63, 127 ),
    DESATURATED_VIOLET     => TCOD::Color->new(  95,  63, 127 ),
    DESATURATED_PURPLE     => TCOD::Color->new( 111,  63, 127 ),
    DESATURATED_FUCHSIA    => TCOD::Color->new( 127,  63, 127 ),
    DESATURATED_MAGENTA    => TCOD::Color->new( 127,  63, 111 ),
    DESATURATED_PINK       => TCOD::Color->new( 127,  63,  95 ),
    DESATURATED_CRIMSON    => TCOD::Color->new( 127,  63,  79 ),

    # lightest
    LIGHTEST_RED           => TCOD::Color->new( 255, 191, 191 ),
    LIGHTEST_FLAME         => TCOD::Color->new( 255, 207, 191 ),
    LIGHTEST_ORANGE        => TCOD::Color->new( 255, 223, 191 ),
    LIGHTEST_AMBER         => TCOD::Color->new( 255, 239, 191 ),
    LIGHTEST_YELLOW        => TCOD::Color->new( 255, 255, 191 ),
    LIGHTEST_LIME          => TCOD::Color->new( 239, 255, 191 ),
    LIGHTEST_CHARTREUSE    => TCOD::Color->new( 223, 255, 191 ),
    LIGHTEST_GREEN         => TCOD::Color->new( 191, 255, 191 ),
    LIGHTEST_SEA           => TCOD::Color->new( 191, 255, 223 ),
    LIGHTEST_TURQUOISE     => TCOD::Color->new( 191, 255, 239 ),
    LIGHTEST_CYAN          => TCOD::Color->new( 191, 255, 255 ),
    LIGHTEST_SKY           => TCOD::Color->new( 191, 239, 255 ),
    LIGHTEST_AZURE         => TCOD::Color->new( 191, 223, 255 ),
    LIGHTEST_BLUE          => TCOD::Color->new( 191, 191, 255 ),
    LIGHTEST_HAN           => TCOD::Color->new( 207, 191, 255 ),
    LIGHTEST_VIOLET        => TCOD::Color->new( 223, 191, 255 ),
    LIGHTEST_PURPLE        => TCOD::Color->new( 239, 191, 255 ),
    LIGHTEST_FUCHSIA       => TCOD::Color->new( 255, 191, 255 ),
    LIGHTEST_MAGENTA       => TCOD::Color->new( 255, 191, 239 ),
    LIGHTEST_PINK          => TCOD::Color->new( 255, 191, 223 ),
    LIGHTEST_CRIMSON       => TCOD::Color->new( 255, 191, 207 ),

    # lighter
    LIGHTER_RED            => TCOD::Color->new( 255, 127, 127 ),
    LIGHTER_FLAME          => TCOD::Color->new( 255, 159, 127 ),
    LIGHTER_ORANGE         => TCOD::Color->new( 255, 191, 127 ),
    LIGHTER_AMBER          => TCOD::Color->new( 255, 223, 127 ),
    LIGHTER_YELLOW         => TCOD::Color->new( 255, 255, 127 ),
    LIGHTER_LIME           => TCOD::Color->new( 223, 255, 127 ),
    LIGHTER_CHARTREUSE     => TCOD::Color->new( 191, 255, 127 ),
    LIGHTER_GREEN          => TCOD::Color->new( 127, 255, 127 ),
    LIGHTER_SEA            => TCOD::Color->new( 127, 255, 191 ),
    LIGHTER_TURQUOISE      => TCOD::Color->new( 127, 255, 223 ),
    LIGHTER_CYAN           => TCOD::Color->new( 127, 255, 255 ),
    LIGHTER_SKY            => TCOD::Color->new( 127, 223, 255 ),
    LIGHTER_AZURE          => TCOD::Color->new( 127, 191, 255 ),
    LIGHTER_BLUE           => TCOD::Color->new( 127, 127, 255 ),
    LIGHTER_HAN            => TCOD::Color->new( 159, 127, 255 ),
    LIGHTER_VIOLET         => TCOD::Color->new( 191, 127, 255 ),
    LIGHTER_PURPLE         => TCOD::Color->new( 223, 127, 255 ),
    LIGHTER_FUCHSIA        => TCOD::Color->new( 255, 127, 255 ),
    LIGHTER_MAGENTA        => TCOD::Color->new( 255, 127, 223 ),
    LIGHTER_PINK           => TCOD::Color->new( 255, 127, 191 ),
    LIGHTER_CRIMSON        => TCOD::Color->new( 255, 127, 159 ),

    # light
    LIGHT_RED              => TCOD::Color->new( 255,  63,  63 ),
    LIGHT_FLAME            => TCOD::Color->new( 255, 111,  63 ),
    LIGHT_ORANGE           => TCOD::Color->new( 255, 159,  63 ),
    LIGHT_AMBER            => TCOD::Color->new( 255, 207,  63 ),
    LIGHT_YELLOW           => TCOD::Color->new( 255, 255,  63 ),
    LIGHT_LIME             => TCOD::Color->new( 207, 255,  63 ),
    LIGHT_CHARTREUSE       => TCOD::Color->new( 159, 255,  63 ),
    LIGHT_GREEN            => TCOD::Color->new(  63, 255,  63 ),
    LIGHT_SEA              => TCOD::Color->new(  63, 255, 159 ),
    LIGHT_TURQUOISE        => TCOD::Color->new(  63, 255, 207 ),
    LIGHT_CYAN             => TCOD::Color->new(  63, 255, 255 ),
    LIGHT_SKY              => TCOD::Color->new(  63, 207, 255 ),
    LIGHT_AZURE            => TCOD::Color->new(  63, 159, 255 ),
    LIGHT_BLUE             => TCOD::Color->new(  63,  63, 255 ),
    LIGHT_HAN              => TCOD::Color->new( 111,  63, 255 ),
    LIGHT_VIOLET           => TCOD::Color->new( 159,  63, 255 ),
    LIGHT_PURPLE           => TCOD::Color->new( 207,  63, 255 ),
    LIGHT_FUCHSIA          => TCOD::Color->new( 255,  63, 255 ),
    LIGHT_MAGENTA          => TCOD::Color->new( 255,  63, 207 ),
    LIGHT_PINK             => TCOD::Color->new( 255,  63, 159 ),
    LIGHT_CRIMSON          => TCOD::Color->new( 255,  63, 111 ),

    # normal
    RED                    => TCOD::Color->new( 255,   0,   0 ),
    FLAME                  => TCOD::Color->new( 255,  63,   0 ),
    ORANGE                 => TCOD::Color->new( 255, 127,   0 ),
    AMBER                  => TCOD::Color->new( 255, 191,   0 ),
    YELLOW                 => TCOD::Color->new( 255, 255,   0 ),
    LIME                   => TCOD::Color->new( 191, 255,   0 ),
    CHARTREUSE             => TCOD::Color->new( 127, 255,   0 ),
    GREEN                  => TCOD::Color->new(   0, 255,   0 ),
    SEA                    => TCOD::Color->new(   0, 255, 127 ),
    TURQUOISE              => TCOD::Color->new(   0, 255, 191 ),
    CYAN                   => TCOD::Color->new(   0, 255, 255 ),
    SKY                    => TCOD::Color->new(   0, 191, 255 ),
    AZURE                  => TCOD::Color->new(   0, 127, 255 ),
    BLUE                   => TCOD::Color->new(   0,   0, 255 ),
    HAN                    => TCOD::Color->new(  63,   0, 255 ),
    VIOLET                 => TCOD::Color->new( 127,   0, 255 ),
    PURPLE                 => TCOD::Color->new( 191,   0, 255 ),
    FUCHSIA                => TCOD::Color->new( 255,   0, 255 ),
    MAGENTA                => TCOD::Color->new( 255,   0, 191 ),
    PINK                   => TCOD::Color->new( 255,   0, 127 ),
    CRIMSON                => TCOD::Color->new( 255,   0,  63 ),

    # dark
    DARK_RED               => TCOD::Color->new( 191,   0,   0 ),
    DARK_FLAME             => TCOD::Color->new( 191,  47,   0 ),
    DARK_ORANGE            => TCOD::Color->new( 191,  95,   0 ),
    DARK_AMBER             => TCOD::Color->new( 191, 143,   0 ),
    DARK_YELLOW            => TCOD::Color->new( 191, 191,   0 ),
    DARK_LIME              => TCOD::Color->new( 143, 191,   0 ),
    DARK_CHARTREUSE        => TCOD::Color->new(  95, 191,   0 ),
    DARK_GREEN             => TCOD::Color->new(   0, 191,   0 ),
    DARK_SEA               => TCOD::Color->new(   0, 191,  95 ),
    DARK_TURQUOISE         => TCOD::Color->new(   0, 191, 143 ),
    DARK_CYAN              => TCOD::Color->new(   0, 191, 191 ),
    DARK_SKY               => TCOD::Color->new(   0, 143, 191 ),
    DARK_AZURE             => TCOD::Color->new(   0,  95, 191 ),
    DARK_BLUE              => TCOD::Color->new(   0,   0, 191 ),
    DARK_HAN               => TCOD::Color->new(  47,   0, 191 ),
    DARK_VIOLET            => TCOD::Color->new(  95,   0, 191 ),
    DARK_PURPLE            => TCOD::Color->new( 143,   0, 191 ),
    DARK_FUCHSIA           => TCOD::Color->new( 191,   0, 191 ),
    DARK_MAGENTA           => TCOD::Color->new( 191,   0, 143 ),
    DARK_PINK              => TCOD::Color->new( 191,   0,  95 ),
    DARK_CRIMSON           => TCOD::Color->new( 191,   0,  47 ),

    # darker
    DARKER_RED             => TCOD::Color->new( 127,   0,   0 ),
    DARKER_FLAME           => TCOD::Color->new( 127,  31,   0 ),
    DARKER_ORANGE          => TCOD::Color->new( 127,  63,   0 ),
    DARKER_AMBER           => TCOD::Color->new( 127,  95,   0 ),
    DARKER_YELLOW          => TCOD::Color->new( 127, 127,   0 ),
    DARKER_LIME            => TCOD::Color->new(  95, 127,   0 ),
    DARKER_CHARTREUSE      => TCOD::Color->new(  63, 127,   0 ),
    DARKER_GREEN           => TCOD::Color->new(   0, 127,   0 ),
    DARKER_SEA             => TCOD::Color->new(   0, 127,  63 ),
    DARKER_TURQUOISE       => TCOD::Color->new(   0, 127,  95 ),
    DARKER_CYAN            => TCOD::Color->new(   0, 127, 127 ),
    DARKER_SKY             => TCOD::Color->new(   0,  95, 127 ),
    DARKER_AZURE           => TCOD::Color->new(   0,  63, 127 ),
    DARKER_BLUE            => TCOD::Color->new(   0,   0, 127 ),
    DARKER_HAN             => TCOD::Color->new(  31,   0, 127 ),
    DARKER_VIOLET          => TCOD::Color->new(  63,   0, 127 ),
    DARKER_PURPLE          => TCOD::Color->new(  95,   0, 127 ),
    DARKER_FUCHSIA         => TCOD::Color->new( 127,   0, 127 ),
    DARKER_MAGENTA         => TCOD::Color->new( 127,   0,  95 ),
    DARKER_PINK            => TCOD::Color->new( 127,   0,  63 ),
    DARKER_CRIMSON         => TCOD::Color->new( 127,   0,  31 ),

    # darkest
    DARKEST_RED            => TCOD::Color->new(  63,   0,   0 ),
    DARKEST_FLAME          => TCOD::Color->new(  63,  15,   0 ),
    DARKEST_ORANGE         => TCOD::Color->new(  63,  31,   0 ),
    DARKEST_AMBER          => TCOD::Color->new(  63,  47,   0 ),
    DARKEST_YELLOW         => TCOD::Color->new(  63,  63,   0 ),
    DARKEST_LIME           => TCOD::Color->new(  47,  63,   0 ),
    DARKEST_CHARTREUSE     => TCOD::Color->new(  31,  63,   0 ),
    DARKEST_GREEN          => TCOD::Color->new(   0,  63,   0 ),
    DARKEST_SEA            => TCOD::Color->new(   0,  63,  31 ),
    DARKEST_TURQUOISE      => TCOD::Color->new(   0,  63,  47 ),
    DARKEST_CYAN           => TCOD::Color->new(   0,  63,  63 ),
    DARKEST_SKY            => TCOD::Color->new(   0,  47,  63 ),
    DARKEST_AZURE          => TCOD::Color->new(   0,  31,  63 ),
    DARKEST_BLUE           => TCOD::Color->new(   0,   0,  63 ),
    DARKEST_HAN            => TCOD::Color->new(  15,   0,  63 ),
    DARKEST_VIOLET         => TCOD::Color->new(  31,   0,  63 ),
    DARKEST_PURPLE         => TCOD::Color->new(  47,   0,  63 ),
    DARKEST_FUCHSIA        => TCOD::Color->new(  63,   0,  63 ),
    DARKEST_MAGENTA        => TCOD::Color->new(  63,   0,  47 ),
    DARKEST_PINK           => TCOD::Color->new(  63,   0,  31 ),
    DARKEST_CRIMSON        => TCOD::Color->new(  63,   0,  15 ),

    # metallic
    BRASS                  => TCOD::Color->new( 191, 151,  96 ),
    COPPER                 => TCOD::Color->new( 197, 136, 124 ),
    GOLD                   => TCOD::Color->new( 229, 191,   0 ),
    SILVER                 => TCOD::Color->new( 203, 203, 203 ),

    # miscellaneous
    CELADON                => TCOD::Color->new( 172, 255, 175 ),
    PINKEACH               => TCOD::Color->new( 255, 159, 127 ),
});

1;
