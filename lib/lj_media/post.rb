require 'sax-machine'
require 'feedjira'
require 'lj_media/author'

module LJMedia
  class Post
    include SAXMachine
    include Feedjira::FeedEntryUtilities

    element  :guid,             as: :entry_id
    element  :pubDate,          as: :published
    element  :title
    element  :link
    element  :description,      as: :content
    elements :category,         as: :tags
    element  :"lj:security",    as: :access
    element  :"lj:poster",      as: :author_username
    element  :"lj:posterid",    as: :author_id,      class: Integer
    element  :"lj:reply_count", as: :comments_count, class: Integer

    def author
      @author ||= Author.new(author_id, author_username)
    end

    def inspect
      "#<#{self.class} #{link}>"
    end
  end
end
