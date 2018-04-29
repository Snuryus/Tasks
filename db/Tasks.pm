package Tasks;

=head1 NAME

 Tasks sql functions

=cut

use strict;
use parent 'dbcore';
my $MODULE = 'Tasks';

my Admins $admin;
my $CONF;

use Abills::Base qw/_bp/;

#**********************************************************
=head2 new($db, $admin, \%conf)

=cut
#**********************************************************
sub new {
  my $class = shift;
  my $db = shift;
  ($admin, $CONF) = @_;
  
  $admin->{MODULE} = $MODULE;
  
  my $self = {
    db    => $db,
    admin => $admin,
    conf  => $CONF
  };
  
  bless($self, $class);
  
  return $self;
}

#**********************************************************
=head2 info($attr)

=cut
#**********************************************************
sub info {
  my $self = shift;
  my ($attr) = @_;
  return [ ] unless ($attr->{ID});

  $self->list({ ID => $attr->{ID}, SKIP_TOTAL => 1 });
  return [ ] if ($self->{errno});

  return $self->{list}->[0];
}

#**********************************************************
=head2 add($attr)

=cut
#**********************************************************
sub add {
  my $self = shift;
  my ($attr) = @_;

  $self->query_add('tasks_main', $attr);
  return [ ] if ($self->{errno});

  return $self;
}

#**********************************************************
=head2 chg($attr)

  Arguments:
    $attr - hash_ref

  Returns:
    1

=cut
#**********************************************************
sub chg {
  my $self = shift;
  my ($attr) = @_;

  $self->changes(
    {
      CHANGE_PARAM => 'ID',
      TABLE        => 'tasks_main',
      DATA         => $attr,
    } );

  return 1;
}

#**********************************************************
=head2 list($attr)

=cut
#**********************************************************
sub list {
  my $self = shift;
  my ($attr) = @_;

  my $PG   = $attr->{PG} || '0';
  my $PAGE_ROWS = $attr->{PAGE_ROWS} || 25;
  my $SORT = ($attr->{SORT}) ? $attr->{SORT} : 1;
  my $DESC = ($attr->{DESC}) ? $attr->{DESC} : '';

  my $WHERE =  $self->search_former($attr, [
      ['ID',               'INT',         'tm.id',                    1 ],
      ['TASK_TYPE',        'INT',         'tm.task_type',             1 ],
      ['STATE',            'INT',         'tm.state',                 1 ],
      ['AID',              'INT',         'tm.aid',                   1 ],
      ['RESPOSIBLE',       'INT',         'tm.resposible',            1 ],
      ['PLAN_DATE',        'DATE',        'tm.plan_date',             1 ],
      ['CONTROL_DATE',     'DATE',        'tm.control_date',          1 ],
    ],
    { WHERE => 1 }
  );

  $self->query("SELECT 
      $self->{SEARCH_FIELDS}
      tm.id,
      tm.name,
      tm.task_type,
      tm.descr,
      tm.state,
      tm.aid,
      tm.resposible,
      tm.plan_date,
      tm.control_date,
      tm.additional_values,
      tm.comments,
      tt.name as type_name,
      tt.plugins as plugins,
      r.name as resposible_name,
      a.name as admin_name
      FROM tasks_main tm
      LEFT JOIN tasks_type tt ON (tm.task_type=tt.id)
      LEFT JOIN admins a ON (tm.aid=a.aid)
      LEFT JOIN admins r ON (tm.resposible=r.aid)
      $WHERE
      ORDER BY $SORT $DESC LIMIT $PG, $PAGE_ROWS;",
    undef,
    {%$attr, COLS_NAME => 1, COLS_UPPER => 1}
  );

  return [] if ($self->{errno});

  my $list = $self->{list};

  if ($self->{TOTAL} >= 0 && !$attr->{SKIP_TOTAL}) {
    $self->query("SELECT count( DISTINCT tm.id) AS total 
        FROM tasks_main tm
        LEFT JOIN tasks_type tt ON (tm.task_type=tt.id)
        LEFT JOIN admins a ON (tm.aid=a.aid)
        LEFT JOIN admins r ON (tm.resposible=r.aid)
        $WHERE",
      undef,
      { INFO => 1 }
    );
  }

  return $list;
}

#**********************************************************
=head2 del($attr)

=cut
#**********************************************************
sub del {
  my $self = shift;
  my ($attr) = @_;

  $self->query_del('tasks_main', $attr);
  return [ ] if ($self->{errno});

  return $self;
}


#**********************************************************
=head2 type_add($attr)

=cut
#**********************************************************
sub type_add {
  my $self = shift;
  my ($attr) = @_;

  $self->query_add('tasks_type', $attr);
  return [ ] if ($self->{errno});

  return $self;
}

#**********************************************************
=head2 type_info($attr)

=cut
#**********************************************************
sub type_info {
  my $self = shift;
  my ($attr) = @_;

  $self->query("SELECT *
      FROM tasks_type
      WHERE id= ?",
    undef,
    { Bind => [ ($attr->{ID} ? $attr->{ID} : '' ) ], COLS_NAME => 1, COLS_UPPER => 1 }
  );
  return [ ] if ($self->{errno});

  return $self->{list}->[0];
}

#**********************************************************
=head2 types_list($attr)

=cut
#**********************************************************
sub types_list {
  my $self = shift;
 
  $self->query("SELECT *
      FROM tasks_type",
    undef,
    { COLS_NAME => 1, COLS_UPPER => 1 }
  );
  return [ ] if ($self->{errno});

  return $self->{list};
}

#**********************************************************
=head2 admins_list($attr)

=cut
#**********************************************************
sub admins_list {
  my $self = shift;
  my ($attr) = @_;

  my $PG   = $attr->{PG} || '0';
  my $PAGE_ROWS = $attr->{PAGE_ROWS} || 25;
  my $SORT = ($attr->{SORT}) ? $attr->{SORT} : 1;
  my $DESC = ($attr->{DESC}) ? $attr->{DESC} : '';

  my $WHERE =  $self->search_former($attr, [
      ['AID',              'INT',         'a.aid',                    1 ],
      ['RESPOSIBLE',       'INT',         'ta.resposible',            1 ],
      ['ADMIN',            'INT',         'ta.admin',                 1 ],
      ['SYSADMIN',         'INT',         'ta.sysadmin',              1 ],
    ],
    { WHERE => 1 }
  );

  $self->query("SELECT 
      $self->{SEARCH_FIELDS}
      a.aid,
      a.name as a_name,
      a.id as a_login,
      ta.resposible,
      ta.admin,
      ta.sysadmin
      FROM admins a
      LEFT JOIN tasks_admins ta ON (ta.aid=a.aid)
      $WHERE;",
    undef,
    {%$attr, COLS_NAME => 1, COLS_UPPER => 1}
  );

  return [] if ($self->{errno});

  my $list = $self->{list};

  if ($self->{TOTAL} >= 0 && !$attr->{SKIP_TOTAL}) {
    $self->query("SELECT count( DISTINCT a.aid) AS total 
        FROM admins a
        LEFT JOIN tasks_admins ta ON (ta.aid=a.aid)
        $WHERE;",
      undef,
      { INFO => 1 }
    );
  }

  return $list;
}

#**********************************************************
=head2 admins_change($attr)

=cut
#**********************************************************
sub admins_change {
  my $self = shift;
  my ($attr) = @_;

  $self->changes(
    {
      CHANGE_PARAM => 'AID',
      TABLE        => 'tasks_admins',
      DATA         => $attr,
    } );

  return 1;
}


1;