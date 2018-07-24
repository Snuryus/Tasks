package TestPlugin;

use strict;
use warnings FATAL => 'all';

my $html;
my $lang;

#**********************************************************
=head2 new($Tasks, $html)

=cut
#**********************************************************
sub new {
  my $class = shift;
  my $Tasks = shift;
  $html = shift;
  $lang = shift;
  
  my $self = {
    Tasks => $Tasks
  };
  
  bless($self, $class);
  
  return $self;
}

#**********************************************************
=head2 plugin_info()

=cut
#**********************************************************
sub plugin_info {
  return "Вообще ничего не делает.";
}

1;