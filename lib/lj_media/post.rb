require 'lj_media/post_parser'
require 'lj_media/errors'
require 'forwardable'

module LJMedia
  class Post
    extend Forwardable

    attr_reader    :parser
    def_delegators :parser, :entry_id, :published, :title, :link, :content,
                            :tags, :access, :comments_count

    def initialize(parser)
      raise LJMedia::Error::InvalidPostData unless parser.is_a? LJMedia::PostParser

      @parser = parser
    end

    def inspect
      "#<#{self.class} #{parser.link}>"
    end
  end
end
