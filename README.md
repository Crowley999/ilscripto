# ilscripto 0.0.1
[![License: GPL v2+](https://img.shields.io/badge/License-GPLv2-blue.svg)](COPYING)

Running your wikimedia modules locally with **pure Lua**. This is done by [src/php/](src/php/).

## Goal
* master branch: Back **all** wiktionary modules by pure Lua, producing 96% identical output. This should be as good as [bliki's backend](https://github.com/axkr/info.bliki.wikipedia_parser).
* cover branch: Additional support for mw.wikibase and mw.ext.* with Internet connection to provide 99% identical output.
* sup branch: Supplement pages from en.wiktionary involving `getContent`, etc. (CC-BY-SA)

## What can I do?
* Test the modules I use: [getting started](https://github.com/Crowley999/ilscripto/blob/sup/START.md)
* Improve [download](src/download) script, add Windows support
* Allowing both lcase and ucase pages using md5, like us.0b3b97fa.wiki, US.7516fd43.wiki, Us.85e8f233.wiki
* Improve `php.expandTemplate` in [src/php/mw.lua](src/php/mw.lua)

