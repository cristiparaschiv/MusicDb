package MusicDb::Menu;

use Dancer;
use Dancer::Plugin::Database;
use Data::Dumper;
use MusicDb::Model;

sub new {
    
    my $lib = 'MusicDb::Model::Tool';
    my $tools = $lib->_get_all();
    
    my $menu = build_tree($tools);
    debug to_dumper $tools;
    return $tools;
}

sub build_tree {
    my $records = shift;
    
    my $menu = {};
    
    foreach my $entry (@$records) {
        my $path = $entry->{path};
        my @path_parts = split('/', $path);
        $menu->{$path_parts[0]} = {} if (! exists $menu->{$path_parts[0]});
        $menu->{$path_parts[0]}->{$path_parts[1]} = {} if (! exists $menu->{$path_parts[0]}->{$path_parts[1]});
        $menu->{$path_parts[0]}->{$path_parts[1]}->{$entry->{menuname}} = {
            order => $entry->{order},
            controller => $entry->{controller},
            action => $entry->{action},
        }
    }
    
    return $menu;
}

1;