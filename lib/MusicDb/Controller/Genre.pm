package MusicDb::Controller::Genre;

use Dancer;
use MusicDb::Model;
use MusicDb::Controller;

our @ISA = qw(MusicDb::Controller);

sub view_details {
	my $self = shift;
	my $id = shift;
	
	my $instance = MusicDb::Model::Genre->_get($id);
	my $values = $instance->{values};
	
	my $name = $values->{name};
	my $description = $values->{description};
	
	my $params = {
		name => $name,
		description => $description,
	};
	
	template 'genre_details', {data => $params};
}

1;