package Devel::Deanonymize;
use strict;
use warnings FATAL => 'all';

my $include_pattern;

sub import {
    # capture input parameters
    $include_pattern = $_[1];
}

UNITCHECK {
    unshift @INC, sub {
        my (undef, $filename) = @_;
        return () if ($filename !~ /$include_pattern/);
        if (my $found = (grep {-e $_} map {"$_/$filename"} grep {!ref} @INC)[0]) {
            local $/ = undef;
            open my $fh, '<', $found or die("Can't read module file $found\n");
            my $module_text = <$fh>;
            close $fh;

            # define everything in a sub, so Devel::Cover will DTRT
            # NB this introduces no extra linefeeds so D::C's line numbers
            # in reports match the file on disk
            $module_text =~ s/(.*?package\s+\S+)(.*)__END__/$1sub classWrapper {$2} classWrapper();/s;

            # unhide private methods to avoid "Variable will not stay shared"
            # warnings that appear due to change of applicable scoping rules
            # Note: not '\s*' in the start of string, to avoid matching and
            # removing blank lines before the private sub definitions.
            $module_text =~ s/^[ \t]*my\s+(\S+\s*=\s*sub.*)$/our $1/gm;

            # filehandle on the scalar
            open $fh, '<', \$module_text;

            # and put it into %INC too so that it looks like we loaded the code
            # from the file directly
            $INC{$filename} = $found;
            return $fh;
        }
        else {
            return ();
        }
    };
}


1;