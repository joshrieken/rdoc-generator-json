gem 'rdoc'

require 'pathname'
require 'erb'
require 'fileutils'
require 'json'
require 'rdoc/rdoc'

##
# Rjson turns rdoc data into json.
# Super handy for, ya know, that super secret thing I'm building.
class RDoc::Generator::Rjson

  RDoc::RDoc.add_generator(self)

  attr_reader :base_dir, :output_dir, :options, :store

  def self::setup_options(rdoc_options)
  end

  def initialize(store, options)
    @store = store
    @options = options
  end

  def generate
    generate_file
  end

  def generate_file
    output_file.dirname.mkpath
    output_file.open 'w', 0644 do |file|
      file.set_encoding @options.encoding if Object.const_defined? :Encoding
      file.write(json)
    end
  end

  def base_dir
    @base_dir ||= Pathname.pwd.expand_path
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

  def json
    representation_hash.to_json
  end

  def representation_hash
    @hash ||= { classes: classes_representation(classes) }
  end

  def classes_representation(classes)
    classes.map do |klass|
      class_representation(klass)
    end
  end

  def class_representation(klass)
    {
      full_name: klass.full_name,
      comment: comment_for(klass),
      methods: methods_representation(klass.method_list)
    }
  end

  def methods_representation(methods)
    methods.map do |method|
      method_representation(method)
    end
  end

  def method_representation(method)
    {
      arglists: method.arglists,
      block_params: method.block_params,
      comment: comment_for(method),
      full_name: method.full_name,
      name: method.name,
      params: method.params,
      is_alias_for: method.is_alias_for,
      visibility: method.visibility
    }
  end

  def comment_for(thing)
    if thing.comment.respond_to? (:text)
      thing.description.strip
    else
      thing.comment
    end
  end

  def output_file
    @output_file ||= Pathname(File.join(base_dir, options.op_dir, 'json.json'))
  end

  def title
    @title ||= options.title
  end

end
