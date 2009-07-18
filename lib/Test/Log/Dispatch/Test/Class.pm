package Test::Log::Dispatch::Test::Class;
use Getopt::Long;
use strict;
use warnings;
use base qw(Test::Class);

sub runtests {
    my ($class) = @_;

    # Handle -m flag in case test script is being run directly.
    #
    GetOptions( 'm|method=s' => sub { $ENV{TEST_METHOD} = ".*" . $_[1] . ".*" },
    );

    # Check for internal_only
    #
    if ( $class->internal_only && !$class->is_internal ) {
        $class->skip_all('internal test only');
    }

    # Only run tests directly in $class.
    #
    my $test_obj = $class->new();
    Test::Class::runtests($test_obj);
}

sub is_internal {
    return $ENV{TEST_LOG_DISPATCH_INTERNAL_TESTS};
}

sub internal_only {
    return 0;
}

1;
