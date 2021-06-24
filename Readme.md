# Devel::Deanonymize

A small tool to make anonymous sub visible to Devel::Coverage (and possibly similar Modules)

## Synopsys 

```bash
# delete old coverage data (optional)
cover -delete

# Perl scripts
perl -MDevel::Cover=-ignore,^t/,Deanonymize -MDevel::Deanonymize=<inculde_pattern> your_script.pl

# Perl tests
HARNESS_PERL_SWITCHES="-MDevel::Cover=-ignore,^t/,Deanonymize -MDevel::Deanonymize=<include_pattern"  prove t/

# generate report
cover -report html
```

## Coverage Reports

Per default, `Devel::Cover` creates a folder named `cover_db` inside the project root. To visualize the result, we have to
generate a report:

```bash
cover -report html
```

The html report (or any other report type) is then stored under `cover_db` as well.


## Examples

See separate subdirectory [examples/runit.sh](examples/runit.sh)

## Important notes

- Make sure your script (the one under test) always ends with `__END__`, otherwise the regex to modify it fails silently
- To debug if your script is "deanonymized" use `warn()` instead of `print()` print is somewhat unreliable in this early stage of compilation-
- [Devel::Cover](https://metacpan.org/pod/Devel::Cover) on cpan