package MusicDb::UI::Form;

use Dancer;
use MusicDb::UI::Field;

sub new {
    my $self = shift;
    my $model = shift;
    my $metadata = shift;
    my $action = shift;

    my $fields = [];
    
    foreach my $field_data (@$metadata) {
        my $field = new MusicDb::UI::Field($field_data);
        push @$fields, $field;
    }
    
    my $form_data = {
        fields => $fields,
        model => $model,
        name => ucfirst($model), 
    };
    
    return (template 'ui/form', {form_data => $form_data, action => $action}, {layout => undef});
}

1;