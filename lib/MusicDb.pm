package MusicDb;
use Dancer ':syntax';

use MusicDb::Controller;
use MusicDb::Menu;

our $VERSION = '0.1';

get '/' => sub {
    template 'index';
};

hook 'before' => sub {
    session user => 'cristi'; # hardcoding for now user in session
    if (! session('user') && request->path_info !~ m{^/login}) {
        var requested_path => request->path_info;
        request->path_info('/login');
    }
    
    # Get megamenu
    my $menu = new MusicDb::Menu;
    session megamenu => $menu;
};

get '/login' => sub {
    template 'login', { path => vars->{requested_path} }, { layout=> undef };
};

get 'logout' => sub {
    session->destroy;
    set_flash('You are logged out.');
    request->path_info('/login');
};

post '/login' => sub {
    if (params->{username} eq 'cristi' && params->{password} eq 'pass') {
        session user => params->{username};
        redirect params->{path} || '/';
    } else {
        redirect '/login?failed=1';
    }
};

get '/admin' => sub {
		template 'admin'
};

any ['get', 'post'] => '/:model/:action' => sub {
    my $model	= params->{model};
    my $action	= params->{action};
    my $method  	= request->{method};
    my $params	= params;
    my $uploads 	= request->uploads // {};
    $params->{uploads} = $uploads;
    return MusicDb::Controller::handle_request($method, $params, $model, $action);
};

any ['get', 'post'] => '/:model/:action/:id' => sub {
    my $model	= params->{model};
    my $action	= params->{action};
    my $id		= params->{id};
    my $method  	= request->{method};
    my $params	= params;
    my $uploads 	= request->uploads // {};
    $params->{uploads} = $uploads;
    return MusicDb::Controller::handle_request($method, $params, $model, $action, $id);
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
