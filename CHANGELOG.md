# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.2.5] – 2022-02-19
### Fixed
* Fix --vapidir in VALAFLAGS. Thanks to Lemures Lemniscati. Closes #1
* Use only one equal sign in test command for POSIX conformance. Closes #2
* Update project URL in libisocodes.pc.in

## [1.2.4] – 2021-08-26
### Fixed
* Fix failing test due to French translation update.
  Closes: #991647


## [1.2.3] – 2021-01-27
### Fixed
* Fix failing test due to French translation update.
  Closes: #963411


## [1.2.2] – 2015-06-02
### Fixed
* Fix GLib critical warning if the environment variable LANGUAGE
  is not set. Thanks to Paul Wise for the bug report.
  Closes: #787395


## [1.2.1] – 2014-07-08
### Changed
* Use newer libgee-0.8


## [1.2] – 2014-05-07
### Added
* Add new interface for ISO 639-5, recently added to iso-codes


## [1.1] – 2014-03-25
### Added
* Support NULL values and empty strings for filepath and locale
* Add new ISOCodesError if setup of libxml structures fail
* Add some more tests

### Changed
* Check that the specified XML file is really a file and not a
  directory
* Suppress errors and warnings from libxml directly to stderr
* Rename existing error FILE_DOES_NOT_EXIST to CANNOT_OPEN_FILE
* Translation updates for German, Russian, Portuguese, French,
  Danish


## [1.0] – 2013-12-13
### Added
* Initial release


[Unreleased]: https://github.com/toddy15/libisocodes/compare/libisocodes-1.2.4...HEAD
[1.2.5]: https://github.com/toddy15/libisocodes/compare/libisocodes-1.2.4...v1.2.5
[1.2.4]: https://github.com/toddy15/libisocodes/compare/libisocodes-1.2.3...libisocodes-1.2.4
[1.2.3]: https://github.com/toddy15/libisocodes/compare/libisocodes-1.2.2...libisocodes-1.2.3
[1.2.2]: https://github.com/toddy15/libisocodes/compare/libisocodes-1.2.1...libisocodes-1.2.2
[1.2.1]: https://github.com/toddy15/libisocodes/compare/libisocodes-1.2...libisocodes-1.2.1
[1.2]: https://github.com/toddy15/libisocodes/compare/libisocodes-1.1...libisocodes-1.2
[1.1]: https://github.com/toddy15/libisocodes/compare/libisocodes-1.0...libisocodes-1.1
[1.0]: https://github.com/toddy15/libisocodes/releases/tag/libisocodes-1.0
