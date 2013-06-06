## Ammeter release history

### 0.2.9 / 2013-06-06

[full changelog](https://github.com/alexrothenberg/ammeter/compare/v0.2.8...v0.2.9)

* Improves `contain` matcher for generated file contents
* Adds `ensure_current_path` method to GeneratorExampleGroup

### 0.2.8 / 2012-07-06

[full changelog](https://github.com/alexrothenberg/ammeter/compare/v0.2.7...v0.2.8)

Fixes regression with initialization for gems that create a test Rails.application (problem since 0.2.6)

### 0.2.7 / 2012-07-05

[full changelog](https://github.com/alexrothenberg/ammeter/compare/v0.2.6...v0.2.7)

* Fixed issue #13 - Railtie initializer preventing devise from loading
* Fixed issue #12 - Only load_generators if we Rails is available. Regression introduced in 0.2.6

### 0.2.6 / 2012-06-28

[full changelog](https://github.com/alexrothenberg/ammeter/compare/v0.2.5...v0.2.6)

* Fixed issue #11 - testing generators that depend on other generators using `hook_for`

### 0.2.5 / 2012-05-03

[full changelog](https://github.com/alexrothenberg/ammeter/compare/v0.2.4...v0.2.5)

* Fixed issue #9 with for rails 4

### 0.2.4 / 2012-04-06

[full changelog](https://github.com/alexrothenberg/ammeter/compare/v0.2.3...v0.2.4)

* Fixed issue #8 with migration_file and be_a_migration [@EppO]

### 0.2.3 / 2012-03-05

[full changelog](https://github.com/alexrothenberg/ammeter/compare/v0.2.2...v0.2.3)

* Fix Rails 3.2 deprecation warning [@yabawock]
