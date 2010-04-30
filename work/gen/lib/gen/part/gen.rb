$NITRO_NO_ENVIRONMENT = true

require 'facet/dir/self/recurse'

require 'gen'
require 'nitro'

# gen part - Nitro part generator.
#
# This generator copies a part into your
# existing Nitro application.
# Be sure to be in it's main directory
# when calling this generator.
#
# === Example
#
# gen part partname

class PartGen < Gen

  def setup
    @partname = ARGV[0] || usage()
    @lib_path = File.expand_path(File.join("lib", "part"))
    @public_path = File.expand_path(File.join("public", "part"))
  end

  def part_directory(partname)
    part_paths = Array.new

    $:.each do |in_load_path|
      dir=Dir.new(in_load_path) rescue next
      dir.each do |a|
        part_paths << File.expand_path(File.join("#{in_load_path}","#{a}")) if a.to_s == "part"
      end
    end

    if part_paths.size < 1
      STDERR.puts "ERROR: part not found! Aborting!"
      exit 1
    end

    part_paths.each do |p|
      Dir.new(p).each do |name|
        return "#{p}/#{name}" if name == partname
      end
    end

    STDERR.puts "ERROR: part not found! Aborting!"
    exit 1
  end

  def run
    if File.exists?(File.join(@lib_path, @partname))
      STDERR.puts "ERROR: Path #{@lib_path} already exists! Aborting!"
      exit 1
    end

    # Copying Part to current directory /lib
    puts "Copying #{@partname} dir to '#{@lib_path}/#{@partname}'"
    FileUtils.mkdir_p(@lib_path)
    part_src = part_directory(@partname)
    FileUtils.cp_r(part_src, @lib_path)
    FileUtils.cp("#{part_src}.rb", @lib_path)

    # Moving public stuff to apps public/ dir if present
    if File.directory?(File.join("#{@lib_path}", "#{@partname}", "public"))
      puts "Moving #{@partname} public dir to #{@public_path}/#{@partname}"
      FileUtils.mkdir_p(File.join(@public_path, @partname))
      FileUtils.mv(Dir.glob(File.join(@lib_path, @partname, "public", "*")), File.join(@public_path, @partname))
    else
      puts "Part doesn't have public/ directory, skipping."
    end

    puts 'Done'
  end

end

$generator = PartGen.new
