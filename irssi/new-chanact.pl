#!/usr/bin/env perl
use strict;

use Irssi;
use Irssi::TextUI;

our $VERSION = '0.0.1';
our %IRSSI = (
    authors     => 'Shawn M Moore',
    contact     => 'sartak@gmail.com',
    name        => 'new-chanact',
    description => 'Reimplementation of chanact with sorting and more',
    license     => 'GNU GPLv2 or Artistic',
    url         => 'http://sartak.org/'
);

our %abbrev_table = (
    netmonster      => 'nm',
    nethack         => 'nh',
    interhack       => 'ih',
    perl            => 'pl',
    haskell         => 'hs',
    letsplay        => 'lp',
);

our $cached_chanact;
our $needs_rerender = 1;

# replace variables in the format with mappings by %args
sub expand {
    my $format = shift;
    my %args   = @_;

    $format =~ s[{\$(.+?)\?\?(.*?)!!(.*?)}][
        length $args{$1} ? $2 : $3
    ]eg;

    while (my ($var, $value) = each %args) {
        $format =~ s/\$$var/$value/g;
    }

    return $format;
}

# the function called by irssi to get the string
sub chanact {
    my ($item, $get_size_only) = @_;

    if ($needs_rerender) {
        $cached_chanact = render_chanact();
        $needs_rerender = 0;
    }

    $item->default_handler($get_size_only, $cached_chanact, undef, 1);
}

# renders our new chanact
sub render_chanact {
    my @pieces;

    my @hilights = (
        '',
        '{sb_act_text ',
        '{sb_act_msg ',
        '{sb_act_hilight ',
    );

    for my $win (sort { $a->{refnum} <=> $b->{refnum} } Irssi::windows) {

        # something about threading mumbled by chanact
        next
            unless ref $win;

        my $number      = $win->{refnum};
        my $name        = $win->get_active_name;
        my $data_level  = $win->{data_level};

        my $hilight     = $hilights[ $data_level ] or next;

        (my $symbolless = $name) =~ s/^[&#+!=]+//;
        my $abbrev      = $abbrev_table{$symbolless};
        my $tiny        = $abbrev || substr($symbolless, 0, 2);

        my $display     = Irssi::settings_get_str('newchanact_display');

        my $expanded    = expand($display,
                                 A => $abbrev,
                                 C => $name,
                                 N => $number,
                                 T => $tiny,
                                 H => $hilight,
                                 S => '}{sb_background}');

        # sort the pieces by hilight level
        push @{ $pieces[ $data_level ] }, $expanded;
    }

    # join the array of arrays into the final string
    my $final = join ' ', map { @{ $_ || [] } } reverse @pieces;
    return "{sb $final}";
}

sub expire_chanact {
    $needs_rerender = 1;
	Irssi::statusbar_items_redraw('chanact');
}

# some config
Irssi::settings_add_str('newchanact', 'newchanact_display', '$H$N:$T');

# register our chanact function to be called by irssi
Irssi::statusbar_item_register('chanact', '$0', 'chanact');

# signals that tell us we need to rerender
Irssi::signal_add_last('setup changed',  'expire_chanact');
Irssi::signal_add_last('window hilight', 'expire_chanact');
Irssi::signal_add('window created',      'expire_chanact');
Irssi::signal_add('window destroyed',    'expire_chanact');
Irssi::signal_add('window name changed', 'expire_chanact');
Irssi::signal_add('nick mode changed',   'expire_chanact');

