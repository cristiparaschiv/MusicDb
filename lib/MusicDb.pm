package MusicDb;
use Dancer ':syntax';


our $VERSION = '0.1';

get '/' => sub {
    template 'index';
};

get '/test' => sub {
    use MusicDb::UI::Tabs;
    use MusicDb::UI::Form;
    use MusicDb::UI::Grid;
    use MusicDb::Model;
    use MusicDb::Helper;
    
    my $component = new MusicDb::UI::Tabs({
        tabs => {
            'tab1' => {
                title => 'First Tab',
                content => '<p>Text inside first tab</p>',
            },
            'tab2' => {
                title => 'Seconds Tab',
                content => '<p>Text inside seconds tab</p>'
            }
        }
    });
    
    $component = new MusicDb::UI::Form('artist', MusicDb::Model::Artist->_metadata(), '/');
    
    $component = new MusicDb::UI::Grid({
        datasource => {
            data => [
                {
                    id => 1,
                    name => 'test'
                },
                {
                    id => 2,
                    name => 'test2'
                }
            ],
            pageSize => 10,
        },
        columns => MusicDb::Helper->get_columns('artist'),
        dom_id => 'artistGrid',
        width => '800px',
        opts => {
            selectable => 'true',
            sortable => 'false',
        }
    });
    
    debug $component;
    template 'test', {test => $component};
};

true;
