$NITRO_NO_ENVIRONMENT = true

require 'facet/kernel/constant'
require 'facet/string/underscore'

require 'gen'
require 'nitro'
require 'nitro/helper/form'
require 'og'

# This generator generates xhtml forms for Ruby objects.
# This generator will create some a complete xhtml
# form for the given object. The scaffolding code
# uses the object annotations to create a useful form.
#
# === Example
#
# gen form model/user User
# gen form model/user

class FormGen < Gen
  include Nitro::FormHelper
  
  def setup
    @def_filename = ARGV[0] || usage()
    @klass = ARGV[1]
    @form_filename = ARGV[2] || "#{@klass.underscore}.html"
    require @def_filename
  rescue LoadError
    puts "Cannot load ruby file '#@def_filename'!"
  end
  
  def run
    @klass = constant(@klass)
    @klass.send(:define_method, :oid) { -1 }
    form = form_for(@klass.allocate, :skip_relations => true)
    File.open(@form_filename, 'w') do |f|
      f << form
    end
  end
end

$generator = FormGen.new
