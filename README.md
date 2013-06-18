# [Bootplus v1.0.3](https://github.io/aozora/bootplus)

Bootplus is a front-end framework for faster and easier web development inspired by the lates Google+ look & feel, created and maintained by [Aozora](http://twitter.com/aozoralabs).

Bootplus is based on [Twitter Bootstrap](http://twitter.github.io/bootstrap)
To get started, check out [http://aozora.github.com/bootplus](http://aozora.github.io/bootplus)!



## Quick start

Three quick start options are available:

* [Download the latest release](http://aozora.github.io/bootplus/zipball/master).
* Clone the repo: `git clone git://github.com/aozora/bootplus.git`.

Read the [Getting Started page](http://aozora.github.io/bootplus/getting-started/) for information on the framework contents, templates and examples, and more.



## Versioning

For transparency and insight into our release cycle, and for striving to maintain backward compatibility, Bootplus will be maintained under the Semantic Versioning guidelines as much as possible.

Releases will be numbered with the following format:

`<major>.<minor>.<patch>`

And constructed with the following guidelines:

* Breaking backward compatibility bumps the major (and resets the minor and patch)
* New additions without breaking backward compatibility bumps the minor (and resets the patch)
* Bug fixes and misc changes bumps the patch

For more information on SemVer, please visit [http://semver.org/](http://semver.org/).



## Bug tracker

Have a bug or a feature request? [Please open a new issue](https://github.com/twitter/bootplus/issues). Before opening any issue, please search for existing issues and read the [Issue Guidelines](https://github.com/necolas/issue-guidelines), written by [Nicolas Gallagher](https://github.com/necolas/).



## Community

Keep track of development and community news.

* Follow [@aozoralabs on Twitter](http://twitter.com/aozoralabs).


## Compiling CSS and JavaScript

Bootplus includes a [makefile](Makefile) with convenient methods for working with the framework. Before getting started, be sure to install [the necessary local dependencies](package.json):

```
$ npm install
```

When completed, you'll be able to run the various make commands provided:

#### build - `make`
Runs the recess compiler to rebuild the `/less` files and compiles the docs. Requires recess and uglify-js.

#### test - `make test`
Runs jshint and qunit tests headlessly in [phantomjs](http://code.google.com/p/phantomjs/) (used for ci). Depends on having phantomjs installed.

#### watch - `make watch`
This is a convenience method for watching just Less files and automatically building them whenever you save. Requires the Watchr gem.

Should you encounter problems with installing dependencies or running the makefile commands, be sure to first uninstall any previous versions (global and local) you may have installed, and then rerun `npm install`.




## Authors

**Marcello Palmitessa**

+ [http://twitter.com/aozoralabs](http://twitter.com/aozoralabs)
+ [https://github.com/aozora](https://github.com/aozora)


## Copyright and license

Bootplus is dual licensed, GPL-2 and Apache-2; see the LICENSE file.
