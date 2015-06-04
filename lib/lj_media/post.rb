require 'sax-machine'
require 'feedjira'
require 'loofah'
require 'uri'
require 'contracts'
require 'lj_media/author'

module LJMedia

  # Represents the journal post
  class Post
    include SAXMachine
    include Feedjira::FeedEntryUtilities
    include Contracts

    # @return [String] unique post identifier from journal's RSS feed
    # @!attribute [r] entry_id
    element  :guid,             as: :entry_id

    # @return [Time] post publishing time
    # @!attribute [r] published
    element  :pubDate,          as: :published

    # @return [String] the post title
    # @!attribute [r] title
    element  :title

    # @return [URI::HTTP] link to this post
    # @!attribute [r] link
    element  :link do |link|
      URI(link)
    end

    # @return [Loofah::HTML::DocumentFragment] full post content as provided in RSS feed
    # @!attribute [r] content
    element  :description,      as: :content do |content|
      Loofah.fragment(content)
    end

    # @return [Array] array of tags attached to this post
    # @!attribute [r] tags
    elements :category,         as: :tags

    # @return [Symbol] post access restrictions
    # @!attribute [r] access
    element  :"lj:security",    as: :access, class: Symbol

    # @return [Integer] post comments count
    # @!attribute [r] comments_count
    element  :"lj:reply_count", as: :comments_count, class: Integer

    # @!group Internal attributes used to initialize LJMedia::Author instance

    # Internal attribute used to initialize {LJMedia::Author} instance
    # @return [String] the author's username
    # @!attribute [r] author_username
    # @api private
    # @note not to be used directly
    element  :"lj:poster",      as: :author_username

    # Internal attribute used to initialize {LJMedia::Author} instance
    # @return [Integer] the author's user id
    # @!attribute [r] author_id
    # @api private
    # @note not to be used directly
    element  :"lj:posterid",    as: :author_id,      class: Integer

    # @!endgroup

    # @return the post author
    Contract None => LJMedia::Author
    def author
      @author ||= Author.new(author_id, author_username)
    end

    # @private
    def inspect
      "#<#{self.class} #{link}>"
    end
  end
end
