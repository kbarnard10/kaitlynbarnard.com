# Makefile
#
# This file contains some helper scripts for building / deploying this site.

build:
	rm -rf public
	#bower install
	-hugo

develop:
	rm -rf public
	#bower install
	hugo server --watch

deploy: build
	aws s3 sync public/ s3://www.kaitlynbarnard.com --acl public-read --delete
	aws configure set preview.cloudfront true
	aws cloudfront create-invalidation --distribution-id E26MB96QW7C2NE --paths '/*'
