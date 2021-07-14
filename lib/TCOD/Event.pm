package TCOD::Event;

use strict;
use warnings;
use feature 'state';

use TCOD::SDL2;
use Sub::Util ();

our $VERSION = '0.005';

BEGIN {
    require constant;
    constant->import({
        map { $_ => TCOD::SDL2->can($_)->() } grep /^K_/, keys %TCOD::SDL2::
    });
}

package
    TCOD::Event::Base {
    sub new {
        bless {
            type      => uc $_[0] =~ s/.*:://r,
            sdl_event => $_[1],
            '!key'    => $_[2] // '',
        }, $_[0]
    }

    sub init { shift }

    sub AUTOLOAD {
        our $AUTOLOAD;
        my $self = shift;

        return if $AUTOLOAD =~ /DESTROY/;
        my $method = $AUTOLOAD =~ s/.*:://r;

        no strict 'refs';
        *{$AUTOLOAD} = Sub::Util::set_subname $AUTOLOAD,
            sub { shift->{$method} };

        $self->{$method} // die "No such method: $AUTOLOAD";
    }
}

package
    TCOD::Event::Quit {
    our @ISA = 'TCOD::Event::Base';
}

package
    TCOD::Event::Keyboard {
    our @ISA = 'TCOD::Event::Base';
    sub init {
        my $self = shift;
        my ( $e, $k ) = @{ $self }{qw( sdl_event !key )};
        $e = $e->$k if $k;
        $self->{scancode} = $e->scancode;
        $self->{sym}      = $e->sym;
        $self->{mod}      = $e->mod;
        $self->{repeat}   = $e->repeat;
        $self;
    }
}

package
    TCOD::Event::KeyDown {
    our @ISA = 'TCOD::Event::Keyboard';
}

package
    TCOD::Event::KeyUp {
    our @ISA = 'TCOD::Event::Keyboard';
}

package
    TCOD::Event::MouseState {
    our @ISA = 'TCOD::Event::Base';
    sub init {
        my $self = shift;
        my ( $e, $k ) = @{ $self }{qw( sdl_event !key )};
        $e = $e->$k if $k;
        $self->{pixel} = [ $e->x, $e->y ];
        $self->{state} = $e->state;
        $self;
    }
}

package
    TCOD::Event::MouseButtonEvent {
    our @ISA = 'TCOD::Event::MouseState';
    sub init {
        my $self = shift;
        $self->SUPER::init;

        my ( $e, $k ) = @{ $self }{qw( sdl_event !key )};
        $e = $e->$k if $k;

        $self->{button} = $e->button;
        $self;
    }
}

package
    TCOD::Event::MouseButtonUp {
    our @ISA = 'TCOD::Event::MouseButtonEvent';
}

package
    TCOD::Event::MouseButtonDown {
    our @ISA = 'TCOD::Event::MouseButtonEvent';
}

package
    TCOD::Event::MouseMotion {
    our @ISA = 'TCOD::Event::MouseState';
}

package
    TCOD::Event::MouseWheel {
    our @ISA = 'TCOD::Event::Base';
    sub init {
        my $self = shift;

        my ( $e, $k ) = @{ $self }{qw( sdl_event !key )};
        $e = $e->$k if $k;

        $self->{x}       = $e->x;
        $self->{y}       = $e->y;
        $self->{flipped} = $e->direction;
        $self;
    }
}

package
    TCOD::Event::TextInput {
    our @ISA = 'TCOD::Event::Base';
    sub init {
        my $self = shift;

        my ( $e, $k ) = @{ $self }{qw( sdl_event !key )};
        $e = $e->$k if $k;

        $self->{text} = $e->text;
        $self;
    }
}

package
    TCOD::Event::WindowEvent {
    our @ISA = 'TCOD::Event::Base';
    sub init {
        my $self = shift;

        my ( $e, $k ) = @{ $self }{qw( sdl_event !key )};
        my $w = $e->$k if $k;

        $self->{type} = $TCOD::SDL2::WindowEventID{ $w->event }
            // return TCOD::Event::Undefined->new($e)->init;

        $self->{type} =~ s/WINDOWEVENT_/WINDOW_/;
        $self->{type} =~ s/([A-Z])([A-Z]*)_/$1\L$2/g;

        $self;
    }
}

package
    TCOD::Event::Undefined {
    our @ISA = 'TCOD::Event::Base';
}

package TCOD::Event::Dispatch {
    use Role::Tiny;

    sub dispatch {
        my ( $class, $event ) = @_;
        my $type = lc $event->type // '';

        unless ( defined $type ) {
            Carp::carp 'Uninitialised event type in call to dispatch';
            return;
        }

        my $dispatch = $class->can("ev_$type")
            or Carp::croak 'No event handler for event of type ' . $type;

        $dispatch->($event);
    }

    sub ev_                  { }
    sub ev_keydown           { }
    sub ev_keyup             { }
    sub ev_mousebuttondown   { }
    sub ev_mousebuttonup     { }
    sub ev_mousemotion       { }
    sub ev_mousewheel        { }
    sub ev_quit              { }
    sub ev_textinput         { }
    sub ev_windowclose       { }
    sub ev_windowenter       { }
    sub ev_windowexposed     { }
    sub ev_windowfocusgained { }
    sub ev_windowfocuslost   { }
    sub ev_windowhidden      { }
    sub ev_windowhittest     { }
    sub ev_windowleave       { }
    sub ev_windowmaximized   { }
    sub ev_windowminimized   { }
    sub ev_windowmoved       { }
    sub ev_windowresized     { }
    sub ev_windowrestored    { }
    sub ev_windowshown       { }
    sub ev_windowsizechanged { }
    sub ev_windowtakefocus   { }
}

sub new {
    state %map = (
        TCOD::SDL2::QUIT             ,=> [ 'Quit'            => ''       ],
        TCOD::SDL2::KEYDOWN          ,=> [ 'KeyDown'         => 'key'    ],
        TCOD::SDL2::KEYUP            ,=> [ 'KeyUp'           => 'key'    ],
        TCOD::SDL2::MOUSEMOTION      ,=> [ 'MouseMotion'     => 'motion' ],
        TCOD::SDL2::MOUSEBUTTONDOWN  ,=> [ 'MouseButtonDown' => 'button' ],
        TCOD::SDL2::MOUSEBUTTONUP    ,=> [ 'MouseButtonUp'   => 'button' ],
        TCOD::SDL2::MOUSEWHEEL       ,=> [ 'MouseWheel'      => 'wheel'  ],
        TCOD::SDL2::TEXTINPUT        ,=> [ 'TextInput'       => 'text'   ],
        TCOD::SDL2::WINDOWEVENT      ,=> [ 'WindowEvent'     => 'window' ],
    );

    my ( undef, $e ) = @_;

    my ( $class, $method ) = @{ $map{ $e->type } // [ Undefined => '' ] };
    $class = "TCOD::Event::$class";

    $class->new( $e, $method )->init;
}

my $get = sub {
    TCOD::SDL2::PollEvent( my $event = TCOD::SDL2::Event->new )
        or return;

    __PACKAGE__->new($event);
};

sub get { sub { goto $get } }

sub wait {
    my $timeout = shift || 0;

    if ( $timeout ) {
        TCOD::SDL2::WaitEventTimeout( undef, $timeout * 1000 )
            or die TCOD::SDL2::GetError();
    }
    else {
        TCOD::SDL2::WaitEvent( undef )
            or die TCOD::SDL2::GetError();
    }

    goto &get;
}

1;
