package MusicDb::Model::Picture;

use Tie::IxHash;
use MusicDb::Model;

our @ISA = qw(MusicDb::Model);

sub new {
    my $class = shift;
    my $self = {};
    
    bless($self, $class);
    return $self;
}

sub fields {
    
    tie (my %fields, 'Tie::IxHash',
        name => {
            name => 'name',
            display => 'Name',
            type => 'string',
            value => '',
            options => {},
            model => 'picture',
        },
        type => {
            name => 'type',
            display => 'Type',
            type => 'select',
            value => '',
            options => {
                cover => 'Cover',
                band => 'Band',
            },
            model => 'picture',
        },
        filename => {
            name => 'filename',
            display => 'File Name',
            type => 'upload',
            value => '',
            options => {},
            model => 'picture'
        }
    );
    return \%fields;
}

sub _fields {
    my $self = shift;
    
    $self->{_fields} = &fields();
    return $self;
}

1;