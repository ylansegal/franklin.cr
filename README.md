# franklin

Franklin is a command line utility, written in crystal, that allows searching public libraries powered by Overdrive. It supports multiple library searching for those that have accounts in more than one library (city, county, state, etc.)

I previously wrote a version of this library [in ruby][https://github.com/ylansegal/franklin].

## Installation

In order to use, this program must be compiled from source. A working `crystal` compiler with version `0.23.1` or above is needed.

To install, clone this git repo:

```shell
$ git clone git@github.com:ylansegal/franklin.cr.git
```

Run tests:

```shell
$ make test
```

To build a binary:

```shell
$ make build_for_release
```

**Note**: If you are using a Mac and homebrew, and you are getting errors related to `libssl`, it's likely that you need to set an environment variable to let crystal know where `openssl` is located. See [crystal-lang issue #4745](https://github.com/crystal-lang/crystal/issues/4745) for more information.

## Configuration

Franklin needs to be configured with information about the Overdrive libraries it will search. It expects a file in YAML format to exist in your home directory called `.franklin`. The contents of the file should look like:

``` yml
---
libraries:
  - name: San Francisco Public Library
    url: https://sfpl.overdrive.com
  - name: San Diego County Library
    url: https://sdcl.overdrive.com
default_type: eBook # Optional, will show all types if not set.
```

There needs to be a minimum of one library, but there is no maximum. The `name` can be anything and will be included when the search results are presented. The `url` should point to the domain of the public library. It can be obtained by visiting Overdrive's site for each library, copying the url and stripping everything after the domain name.

## Usage

Once the library has been installed and configured, the `franklin` executable will be available. It can be called from the command line with the list of terms to be searched for:

```
$ bin/franklin chamber of secrets
Searched for: chamber of secrets
======================================================
Harry Potter and the Chamber of Secrets
By J.K. Rowling
Format: Audiobook
Availability:
  2.8 people/copy @ San Francisco Public Library
  15.5 people/copy @ San Diego Public Library
  1.3 people/copy @ San Diego County Library
  5.4 people/copy @ Los Angeles County Library
======================================================
Harry Potter and the Chamber of Secrets
By J.K. Rowling
Format: eBook
Availability:
  0.9 people/copy @ San Francisco Public Library
  Available @ San Diego Public Library
  0.6 people/copy @ San Diego County Library
  0.0 people/copy @ Los Angeles County Library
======================================================
Harry Potter
By Chris Peacock
Format: eBook
Availability:
  2.5 people/copy @ San Francisco Public Library
  1.0 people/copy @ San Diego Public Library
======================================================
Room at Heron's Inn
By Ginger Chambers
Format: eBook
Availability:
  Available @ San Francisco Public Library
======================================================
The Secret of the Fiery Chamber
By Carolyn Keene
Format: eBook
Availability:
  Available @ San Diego County Library
```

Franklin supports using a different path for the configuration file and filtering results by type (ie,  eBook, Audiobook, etc).

See `franklin --help` for more information.

## Contributing

1. Fork it ( https://github.com/[your-github-name]/franklin/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [[ylansegal]](https://github.com/ylansegal) Ylan Segal - creator, maintainer
