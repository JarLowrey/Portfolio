###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

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

    def txt_links(array)
       returnString = ""

       array.each_with_index do |element, i|
         if i < array.length - 1
           returnString += app.link_to(element.txt, element.url, target: "_blank")
           returnString += " , "
         end
       end

       last_element = array[array.length - 1]
       returnString += app.link_to(last_element.txt, last_element.url, target: "_blank")
       return returnString
     end

    def img_links(array)
      returnString = ""

      array.each_with_index do |element, i|
        if i < array.length - 1
          returnString += app.link_to app.image_tag(element.img_url, :class => element.img_class, :alt => element.img_alt), element.url, :target => "_blank"
          returnString += " , "
        end
      end

      last_element = array[array.length - 1]
      returnString += app.link_to app.image_tag(last_element.img_url, :class => last_element.img_class, :alt => last_element.img_alt), last_element.url, :target => "_blank"
      return returnString
    end

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
