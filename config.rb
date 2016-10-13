###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false
page '/static_md/*', layout: 'layouts/layout'

set :markdown_engine, :kramdown
set :markdown, parse_block_html: true


# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

# General configuration

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

###
# Helpers
###

# Methods defined in the helpers block are available in templates
 helpers do

    def txt_links(array, wrap_classes)
       return array.map{ |e| "[#{e.txt}](#{e.url}){: target=\"_blank\"}" }.join(' ')
     end

    def img_links(array, wrap_classes)
      links =  array.map{ |e|
        img="![#{e.img_alt}](#{e.img_url}){: class=\" #{e.img_class} \"}"
        "[  #{img}  ](  #{e.url}  ){: target=\"_blank\"} "
      }.join(' ')
      return links
    end

 end

 activate :blog do |blog|
   # Matcher for blog source files
   # blog.taglink = "tags/{tag}.html"
   blog.layout = "layouts/blog_layout"
   # blog.summary_separator = /(READMORE)/
   blog.summary_length = 250
   # blog.year_link = "{year}.html"
   # blog.month_link = "{year}/{month}.html"
   # blog.day_link = "{year}/{month}/{day}.html"

   blog.tag_template = "tag.html"
   blog.calendar_template = "calendar.html"

   #set up blog urls
   blog.prefix = "posts"# This will add a prefix to all links, template references and source paths
   blog.permalink = "{title}" #"{year}/{month}/{day}/{title}.html"
   blog.sources = "{year}-{month}-{day}-{title}.html" # define year-month-day in filename to make an organized dir
   blog.default_extension = ".markdown"

   # Enable pagination
   blog.paginate = true
   blog.per_page = 1
   blog.page_link = "#{blog.prefix}/page/{num}"
 end

 activate :deploy do |deploy|
   deploy.user = 'JTronLabs'
   deploy.deploy_method = :git
   deploy.remote   = 'deploy' #added a custom remote to the .git repo in the build/ folder
   deploy.branch = 'master'
   deploy.build_before = true
 end

# Build-specific configuration
configure :build do
  # Minify CSS and JS on build
  activate :minify_css
  activate :minify_javascript

  activate :relative_assets
  set :relative_links, true
end
