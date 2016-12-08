require 'active_support'
require 'active_support/core_ext'
require 'fileutils'

module Rubstone
  class TaggedDirectoryMap
    attr_reader :tag_dir_map

    def initialize(hash)
      raise "hash is nil" if hash.nil?
      @tag_dir_map = {}
      hash.each do |key, value|
        @tag_dir_map[key] = TaggedDirectory.new(key, value)
      end
    end

    def tags
      @tag_dir_map.keys
    end

    def directory(tag)
      @tag_dir_map[tag].path
    end

    def ignore_delete(tag)
      @tag_dir_map[tag].ignore_delete
    end

    def tagged_directory(tag)
      @tag_dir_map[tag]
    end
  end

  class TaggedDirectory
    attr_reader :tag
    attr_reader :path
    attr_reader :ignore_lib_name
    attr_reader :ignore_delete
    attr_reader :exclusions

    def initialize(tag, value)
      @tag = tag
      if(value.kind_of?(String))
        @path = value
        @ignore_lib_name = false
        @ignore_delete = false
        @exclusions = []
      else
        @path = value["path"]
        @ignore_lib_name = value["ignore_lib_name"]
        @ignore_delete = value["ignore_delete"]
        @exclusions = value["exclusions"]
      end
    end
  end
end
