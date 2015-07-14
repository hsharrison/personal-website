SOURCE = .
SITE = _site
GIT = git
JEKYLL = bundle exec jekyll
MV = mv
GREP = grep
RM = rm
CP = cp
SED = sed
TR = tr


all: site

update:
	$(GIT) submodule update

site: update cv harrison-davis-icpa2015 harrison-frank-icpa2015
	$(JEKYLL) build --source $(SOURCE) --destination $(SITE)

serve: site
	$(JEKYLL) serve --source $(SOURCE) --destination $(SITE) --watch

cv: update
	cd _repos/cv && $(MAKE) html pdf public-cv=true HTMLTOPDF=wkhtmltopdf
	$(MV) _repos/cv/dist/* publications/cv/
	$(GREP) -v DOCTYPE publications/cv/cv.html | $(TR) '\n' '\f' | \
	$(SED) 's#        <link rel="stylesheet" href="stylesheets/style.css">#        <link rel="stylesheet" href="stylesheets/style.css">\f        <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">#' \
    | $(TR) '\f' '\n' > _includes/cv.html
	$(RM) publications/cv/cv.html

harrison-davis-icpa2015: update
	$(CP) _repos/over-or-around-experiment/harrison-davis-icpa2015.pdf publications/harrison-davis-icpa2015/harrison-davis-icpa2015.pdf

harrison-frank-icpa2015: update
	$(CP) _repos/over-or-around-experiment/harrison-frank-icpa2015.pdf publications/harrison-frank-icpa2015/harrison-frank-icpa2015.pdf