# Perl tests with coverage statistics

A quick guide on capturing coverage statistics in perl programs

## Synopsys

```bash
# delete old coverage data (optional)
cover -delete

# Perl scripts
perl -I lib/ -MDevel::Cover=-ignore,^t/,Deanonymize -MDevel::Deanonymize=Fancy runit.pl

# Perl tests
HARNESS_PERL_SWITCHES="-MDevel::Cover=-ignore,^t/,Deanonymize -MDevel::Deanonymize=Fancy"  prove -I lib/ t

# generate report
cover -report html
```

## Anonymous subs

Unfortunately, anonymous subs are invisible to the Coverage package. The solution for this problem is `Devel::Deanoymize` (available in this repo)

```bash
# perl scripts
perl -I lib/ -MDevel::Cover=<options> -MDevel::Deanonymize=<include_pattern> your_script.pl

# perl tests
HARNESS_PERL_SWITCHES="-MDevel::Cover=<options> -MDevel::Deanonymize=<include_pattern>" prove -I lib/ t
```

## Reports

Per default, `Devel::Cover` creates a folder named `cover_db` inside the project root. To visualize the result, we have to
generate a report:

```bash
cover -report html
```

The html report (or any other report type) is then stored under `cover_db` as well.


## Important notes

- Make sure your script (the one under test) always ends with `__END__`, otherwise the regex to modify it fails silently
- To debug if your script is "deanonymized" use `warn()` instead of `print()` print is somewhat unreliable in this early stage of compilation-
- [Devel::Cover](https://metacpan.org/pod/Devel::Cover) on cpan