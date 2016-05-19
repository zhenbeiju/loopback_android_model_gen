require 'fileutils'
require 'json'
require 'erb'

class BaseModel
  attr_accessor :name
  def initialize(options={})
    @name = options.delete("name")
    @filename = @name
    @parent_class = options.delete("base") if options["base"]
    @attributes = options.delete("properties") || {}
    @relations = options.delete("relations") || {}
    puts @attributes
    puts @relations
  end

  def get_binding
    binding()
  end

  def type_convery str
    if str.is_a?(Array)
      key_name = str[0]
    else
      key_name = str
    end
    result_name = {
      "string" => "String",
      "number" => "int",
      "date" => "Date",
      "object" => "Object",
      "Object" => "Object",
      "boolean" => "boolean",
      "any" => "Object",
    }[key_name]


    return 'Object' if result_name.nil?

    str.is_a?(Array) ? "ArrayList<#{result_name}>" : result_name
  end

  def class_relation_conv (str)
    result ={
      "hasMany" =>'[]'
    }[str]
    return '' if result.nil?
    result
  end

end

class CodeGen
  attr_accessor :model_files

  def initialize(options={})
    @options = options
    @basedir = './models'
    @model_files = []
    @models = []
    @build_path = File.join('_build', 'java', 'com','weflex', 'www')
    @erb = ERB.new(File.read('./model.java.erb'))
  end

  def load_model
    Dir.foreach(@basedir) do |filename|
      @model_files << filename if filename.include?('.json')
    end

    @model_files.each do |filename|
      model = BaseModel.new(JSON.parse(IO.read(@basedir + '/' + filename)))
      @models << model
      @erb.result(model.get_binding)
    end
  end

  def build_java_package
    FileUtils.mkdir_p @build_path
  end

  def build
    @models.each do |model|
      File.open(File.join(@build_path, "#{model.name}.java"), 'w+') do |file|
        file.write(@erb.result(model.get_binding))
      end
    end
  end
end


gen = CodeGen.new
gen.build_java_package
gen.load_model
gen.build
