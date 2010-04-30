# = Gen 
#
# A flexible code generation system.
#
# Copyright (c) 2005-2006, George Moschovitis (http://www.gmosx.com)
#
# Gen (http://www.nitroproject.org) is copyrighted free software 
# created and maintained by George Moschovitis (mailto:george.moschovitis@gmail.com) 
# and released under the standard BSD Licence. For details 
# consult the file doc/LICENCE.

class Gen
  
  # The version.

  Version = '0.41.0'

  # Library path.

  LibPath = File.dirname(__FILE__)
  
end

# The base generator class.
#--
# TODO: add support for facets command.
#++

class Gen
  attr_accessor :generator_dir

  # Dump usage information for this controller.
  
  def usage
    filename = File.join(@generator_dir, 'USAGE')
    puts "\n#{File.read(filename)}"
    exit 1
  end

  # Setup the generator.
  
  def setup
  end

  # Perform the generator actions.
    
  def run
  end

  # Shutdown the generator.
    
  def teardown
  end
end
