gem 'rdoc'

require 'pathname'
require 'erb'
require 'fileutils'
require 'json'
require 'rdoc/rdoc'

class RDoc::Generator::Jacey

  RDoc::RDoc.add_generator(self)

  include ERB::Util

  attr_reader :base_dir, :template_dir, :output_dir, :options, :store

  def self::setup_options(rdoc_options)
  end

  def initialize(store, options)
    @store = store
    @options = options
  end

  def generate
    generate_file { |io| binding }
  end

  def generate_file
    output_file.dirname.mkpath
    output_file.open 'w', 0644 do |file|
      file.set_encoding @options.encoding if Object.const_defined? :Encoding
      context = yield file
      template.filename = template_file.to_s
      file.write(template.result(context))
    end
  end

  def template
    @template ||= ERB.new(File.read(template_file), nil, '<>')
  end

  def base_dir
    @base_dir ||= Pathname.pwd.expand_path
  end

  def template_dir
    @template_dir ||= Pathname(File.join(File.dirname(__FILE__), 'template'))
  end

  def output_dir
    @output_dir ||= Pathname(options.op_dir).expand_path(base_dir)
  end

  def class_dir
    nil
  end

  def file_dir
    nil
  end

  def files
    @files ||= store.all_files.sort
  end

  def classes
    @classes ||= store.all_classes_and_modules.sort
  end

  def methods
    @methods ||= classes.map { |m| m.method_list }.flatten.sort
  end

  def output_file
    @output_file ||= Pathname(File.join(base_dir, options.op_dir, 'json.json'))
  end

  def template_file
    @template_file ||= Pathname(File.join(template_dir, 'json.json.erb'))
  end

  def title
    @title ||= options.title
  end

end
