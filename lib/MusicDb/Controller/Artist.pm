package MusicDb::Controller::Artist;

use Dancer;
use MusicDb::Model;
use MusicDb::Controller;
use MusicDb::UI::Tabs;

our @ISA = qw(MusicDb::Controller);

sub view_details {
	my $self = shift;
	my $id = shift;

	my $instance = MusicDb::Model::Artist->_get($id);
	my $values = $instance->{values};
	
	my $name = $values->{name};
	my $description = $values->{description};
	my $picture = $values->{picture};

	my $params = {
		name => $name,
		bio => $description,
		picture => $picture,
		id => $id,
	};
	
	my $albums = MusicDb::Model::Album->_get_all({
		artistid => $id
	});
	my $data = [];
	foreach my $album (@$albums) {
		push @$data, {
			id => $album->{id},
			name => $album->{name},
		};
	}
	my $discography_template = $self->browse_objects($data, 'album');
	my $tabstrip = new MusicDb::UI::Tabs({
		tabs => [
			{
				title => 'Biography',
				dom_id => 'biography',
				content => (template 'artist_details_bio', {data => $params}, {layout => undef}),
			},
			{
				title => 'Discography',
				dom_id => 'discography',
				content => $discography_template,
			},
		],
	});
	
	template 'artist_details', {content => $tabstrip};
}

1;