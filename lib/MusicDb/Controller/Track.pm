package MusicDb::Controller::Track;

use Dancer;
use MusicDb::Model;
use MusicDb::Controller;

our @ISA = qw(MusicDb::Controller);

sub view_details {
	my $self = shift;
	my $id = shift;
	
	my $instance = MusicDb::Model::Track->_get($id);
	my $values = $instance->{values};
	
	my $albumid = $values->{albumid};
	my $name = $values->{name};
	
	my $album = MusicDb::Model::Album->_get_all({id => $id});
	my $album_name = $album->[0]->{name};
	
	my $params = {
		name => $name,
		album => $album_name,
	};
	
	template 'track_details', {data => $params};
}

1;