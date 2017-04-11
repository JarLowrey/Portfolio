###
# Page options, layouts, aliases and proxies
###
require 'html-proofer'

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

set :markdown_engine, :kramdown
set :markdown, parse_block_html: true
activate :syntax, :line_numbers => true
activate :emojifire

#Setup Config vars


# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

# General configuration

# Reload the browser automatically whenever files change
configure :development do
  config[:host] = "localhost:4567"
  activate :livereload
end

###
# Helpers
###

# Methods defined in the helpers block are available in templates
 helpers do
    def txt_links(array)
       return array.map{ |e|
         app.link_to e.txt, e.url, :target => "_blank"
       }.join(' ')
     end

    def img_alts(array)
      return array.map{ |e|
       e.img_alt
     }.join(', ')
    end

    def img_links(array)
      links =  array.map{ |e|
        link = img_link e.img_url,e.img_alt,e.url, "", e.img_class
      }.join(' ')

      return links
    end

    def img_links_from_hash(hash)
      links = ""

      hash.each do |k, v|
        if v.url
          link = img_link(v.img_url,v.img_alt,v.url, "", v.img_class)
          links = "#{links} #{link}"
        end
      end

      links
    end

    def img_link(img_url, img_alt, url, title, css_class,target = "_blank",id="")
      img = app.image_tag img_url, alt: img_alt
      link = app.link_to img, url, title: title,target: target, class: css_class, id: id
    end

    def capitalize(article_txt)
      first_letter_idx = 3 #<p>SOME TEXT = pattern to follow
      first_letter = article_txt[first_letter_idx]
      if first_letter === "<" # a link may be the first thing, find the links text
        first_letter_idx = article_txt.index(">",first_letter_idx) + 1
        first_letter = article_txt[first_letter_idx]
      end

      article_txt[first_letter_idx]="" #delete the first letter from the links text
      article_txt.chop!().chop!()#IDK why,  but there is a bunch of spacing and a '#' at the end of articles
      return "<span class=\"caps\">#{first_letter}</span>#{article_txt}"
    end
 end

 activate :blog do |blog|
   # Matcher for blog source files
   # blog.taglink = "tags/{tag}.html"
   blog.layout = "layouts/blog_layout"
   blog.generate_day_pages = false
   # blog.summary_separator = /(READMORE)/
   # blog.summary_length = 150
   # blog.year_link = "{year}.html"
   # blog.month_link = "{year}/{month}.html"
   # blog.day_link = "{year}/{month}/{day}.html"

   blog.tag_template = "tag.html"
   blog.calendar_template = "calendar.html"

   #set up blog urls - needs an '.html' on the end or GitHub will download the link instead of opening in browser
   blog.prefix = "blog"# This will add a prefix to all links, template references and source paths
   blog.permalink = "{title}.html" #"{year}/{month}/{day}/{title}.html"
   blog.sources = "{year}-{month}-{day}-{title}.html" # define year-month-day in filename to make an organized dir
   blog.default_extension = ".markdown"

   # Enable pagination
   blog.paginate = true
   blog.per_page = 10
   blog.page_link = "#{blog.prefix}/page/{num}"
 end

 # Documentation - https://github.com/middleman-contrib/middleman-deploy
 activate :deploy do |deploy|
   deploy.user = 'JTronLabs'
   deploy.deploy_method = :git
   deploy.remote   = 'https://github.com/JTronLabs/JTronLabs.github.io.git' #I recommend a URL over a 'remote' name, as those have broken on me
   deploy.branch = 'master'
   deploy.build_before = true
 end

# Build-specific configuration
configure :build do
  config[:host] = "http://jtronlabs.com"

  # Minify CSS and JS on build
  activate :minify_css
  activate :minify_javascript

  #TODO
  #What are these supposed to do (they broke /blog/404 pages when deployed by turning stylesheets relative)
  #why were they enabled by default?
  #activate :relative_assets
  #set :relative_links, true
end

after_build do |builder|
  begin
    HTMLProofer.check_directory(config[:build_dir], { :assume_extension => true }).run
  rescue RuntimeError => e
    puts e
  end
end
