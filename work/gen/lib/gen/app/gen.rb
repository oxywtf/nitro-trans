$NITRO_NO_ENVIRONMENT = true

require 'facet/dir/self/recurse'

require 'gen'
require 'nitro'

PROTO_DIR = File.join(Nitro::LibPath, '..', 'proto')

# gen app - Nitro application generator.
#
# This generator will create some basic files to get you 
# started fleshing out your Nitro web application.
# The proto directory structure in the standard Nitro 
# distribution is used as reference.
#    
# === Example
#
# gen app ~/my_application
#
# This will generate a new Nitro application in the 
# ~/my_application folder.

class AppGen < Gen

  def setup
    @path = ARGV[0] || usage()
    @path = File.expand_path(@path)
  end
  
  def run
    if File.exists? @path
      STDERR.puts "ERROR: Path #{@path} already exists! Aborting!"
      exit 1
    end

    puts "Copying proto dir to '#@path'"
    FileUtils.cp_r(PROTO_DIR, @path)
    
    Dir.recurse(@path) do |f| 
      FileUtils.rm_rf(f) if /\.svn$/ =~ f 
    end   
    
    puts 'Done'
  end
  
end

$generator = AppGen.new
