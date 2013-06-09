BOOTPLUS = ./docs/assets/css/bootplus.css
BOOTPLUS_LESS = ./less/bootplus/bootplus.less
BOOTPLUS_RESPONSIVE = ./docs/assets/css/bootplus-responsive.css
BOOTPLUS_RESPONSIVE_LESS = ./less/bootplus/responsive.less
DATE=$(shell date +%I:%M%p)
CHECK=\033[32m✔ Done\033[39m
HR=\033[37m--------------------------------------------------\033[39m
PATH := ./node_modules/.bin:$(PATH)


#
# BUILD DOCS
#

build:
	@echo "\n${HR}"
	@echo "Building Bootplus..."
	@echo "${HR}\n"
#	@printf "Running JSHint on JavaScript..."
#	@./node_modules/.bin/jshint js/*.js --config js/.jshintrc
#	@./node_modules/.bin/jshint js/tests/unit/*.js --config js/.jshintrc
#	@echo "             ${CHECK}"
	@printf "Compiling LESS with Recess..."
	@recess --compile ${BOOTPLUS_LESS} > ${BOOTPLUS}
	@recess --compile ${BOOTPLUS_RESPONSIVE_LESS} > ${BOOTPLUS_RESPONSIVE}
	@echo "             ${CHECK}"
	@printf "Prepping documentation assets..."
	@node docs/build
#	@cp img/* docs/assets/img/
	@cp js/*.js docs/assets/js/
	@cp js/tests/vendor/jquery.js docs/assets/js/
	@echo "             ${CHECK}"
	@printf "Compiling and minifying JavaScript..."
	@cat js/bootstrap-transition.js js/bootstrap-alert.js js/bootstrap-button.js js/bootstrap-carousel.js js/bootstrap-collapse.js js/bootstrap-dropdown.js js/bootstrap-modal.js js/bootstrap-tooltip.js js/bootstrap-popover.js js/bootstrap-scrollspy.js js/bootstrap-tab.js js/bootstrap-typeahead.js js/bootstrap-affix.js > docs/assets/js/bootstrap.js
	@uglifyjs docs/assets/js/bootstrap.js -nc > docs/assets/js/bootstrap.min.tmp.js
	@echo "/**\n* Bootstrap.js v2.3.2 by @fat & @mdo\n* Copyright 2012 Twitter, Inc.\n* http://www.apache.org/licenses/LICENSE-2.0.txt\n*/" > docs/assets/js/copyright.js
	@cat docs/assets/js/copyright.js docs/assets/js/bootstrap.min.tmp.js > docs/assets/js/bootstrap.min.js
	@rm docs/assets/js/copyright.js docs/assets/js/bootstrap.min.tmp.js
	@echo "             ${CHECK}"
	@echo "\n${HR}"
	@echo "Bootplus successfully built at ${DATE}."
	@echo "${HR}\n"
	@echo "Thanks for using Bootplus"

#
# RUN JSHINT & QUNIT TESTS IN PHANTOMJS
#

test:
	./node_modules/.bin/jshint js/*.js --config js/.jshintrc
	./node_modules/.bin/jshint js/tests/unit/*.js --config js/.jshintrc
	node js/tests/server.js &
	phantomjs js/tests/phantom.js "http://localhost:3000/js/tests"
	kill -9 `cat js/tests/pid.txt`
	rm js/tests/pid.txt

#
# CLEANS THE ROOT DIRECTORY OF PRIOR BUILDS
#

clean:
	rm -r bootplus

#
# BUILD SIMPLE BOOTPLUS DIRECTORY
# recess & uglifyjs are required
#

bootplus: bootplus-css bootplus-js


#
# JS COMPILE
#
bootplus-js: bootplus/js/*.js

bootplus/js/*.js: js/*.js
	mkdir -p bootplus/js
	cat js/bootstrap-transition.js js/bootstrap-alert.js js/bootstrap-button.js js/bootstrap-carousel.js js/bootstrap-collapse.js js/bootstrap-dropdown.js js/bootstrap-modal.js js/bootstrap-tooltip.js js/bootstrap-popover.js js/bootstrap-scrollspy.js js/bootstrap-tab.js js/bootstrap-affix.js > bootplus/js/bootstrap.js
	uglifyjs bootplus/js/bootstrap.js -nc > bootplus/js/bootstrap.min.tmp.js
	echo "/*!\n* Bootstrap.js by @fat & @mdo\n* Copyright 2012 Twitter, Inc.\n* http://www.apache.org/licenses/LICENSE-2.0.txt\n*/" > bootplus/js/copyright.js
	cat bootplus/js/copyright.js bootplus/js/bootstrap.min.tmp.js > bootplus/js/bootstrap.min.js
	rm bootplus/js/copyright.js bootplus/js/bootstrap.min.tmp.js

#
# CSS COMPILE
#

bootplus-css: bootplus/css/*.css

bootplus/css/*.css: less/*.less
	mkdir -p bootplus/css
	./node_modules/.bin/recess --compile ${BOOTPLUS_LESS} > bootplus/css/bootplus.css
	./node_modules/.bin/recess --compress ${BOOTPLUS_LESS} > bootplus/css/bootplus.min.css
	./node_modules/.bin/recess --compile ${BOOTPLUS_RESPONSIVE_LESS} > bootplus/css/bootplus-responsive.css
	./node_modules/.bin/recess --compress ${BOOTPLUS_RESPONSIVE_LESS} > bootplus/css/bootplus-responsive.min.css
	cp docs/assets/css/font-awesome*.* bootplus/css/

#
# IMAGES
#
#
#bootplus-img: bootplus/img/*
#
#bootplus/img/*: img/*
#	mkdir -p bootplus/img
#	cp img/* bootplus/img/


#
# MAKE FOR GH-PAGES 4 FAT & MDO ONLY (O_O  )
#

gh-pages: bootplus docs
	rm -f docs/assets/bootplus.zip
	zip -r docs/assets/bootplus.zip bootplus
	rm -r bootplus
	rm -f ../bootplus-gh-pages/assets/bootplus.zip
	mkdir -p ../bootplus-gh-pages
	node docs/build production
	cp -r docs/* ../bootplus-gh-pages

#
# WATCH LESS FILES
#

watch:
	echo "Watching less files..."; \
	watchr -e "watch('less/.*\.less') { system 'make' }"


.PHONY: docs watch gh-pages bootplus-css bootplus-js