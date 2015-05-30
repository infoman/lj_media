require 'sax-machine'
require 'feedjira'
require 'lj_media/author'

module LJMedia

  # Public: Represents the journal post
  class Post
    include SAXMachine
    include Feedjira::FeedEntryUtilities

    ##
    # Public: Unique post identifier from journal's RSS feed
    # :attr_reader: entry_id
    element  :guid,             as: :entry_id

    ##
    # Public: \Post publishing date
    # :attr_reader: published
    element  :pubDate,          as: :published

    ##
    # Public: \Post title
    # :attr_reader:
    element  :title

    ##
    # Public: Link to this post
    # :attr_reader:
    element  :link

    ##
    # Public: \Full post content as provided in RSS feed
    # :attr_reader: content
    element  :description,      as: :content

    ##
    # Public: Array of tags attached to this post
    # :attr_reader: tags
    elements :category,         as: :tags

    ##
    # Public: \Post access restrictions
    # :attr_reader: access
    element  :"lj:security",    as: :access, class: Symbol

    ##
    # Public: \Post comments count
    # :attr_reader: comments_count
    element  :"lj:reply_count", as: :comments_count, class: Integer

    element  :"lj:poster",      as: :author_username
    element  :"lj:posterid",    as: :author_id,      class: Integer

    # Public: \Post author
    #
    # Returns LJMedia::Author for post creator
    def author
      @author ||= Author.new(author_id, author_username)
    end

    # :stopdoc:
    def inspect
      "#<#{self.class} #{link}>"
    end
  end
end
