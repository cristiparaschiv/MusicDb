package MusicDb::UI::Tabs;

use Dancer;

sub new {
    my $self = shift;
    my $options = shift;
    debug to_dumper $options;
    return (template 'ui/tabs', {options => $options}, {layout => undef});
}

1;

=HEAD

use MusicDb::UI::Tabs;
    
my $tab = new MusicDb::UI::Tabs({
    tabs => [
        'tab1' => {
            title => 'First Tab',
            content => '<p>Text inside first tab</p>',
        },
        'tab2' => {
            title => 'Seconds Tab',
            content => '<p>Text inside seconds tab</p>'
        }
    ]
});

=CUT
