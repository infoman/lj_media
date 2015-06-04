require 'sax-machine'
require 'feedjira'
require 'uri'
require 'lj_media/post'

module LJMedia

  # Feedjira parser for LJ Journal feed.
  #
  # @note **Warning**: This class is not intended for direct usage.
  # @note Use {LJMedia::Journal} instead.
  class JournalParser
    include SAXMachine
    include Feedjira::FeedUtilities

    # @return [Integer] journal ID as reported by LiveJournal
    # @!attribute [r] id
    element  :"lj:journalid",   as: :id, class: Integer

    # @return [Symbol] journal type.
    # Journal type (`:personal` or `:community`)
    # @!attribute [r] type
    element  :"lj:journaltype", as: :type, class: Symbol

    # @return [String] journal name
    # @!attribute [r] name
    element  :"lj:journal",     as: :name

    # @return [String] journal title
    # @!attribute [r] title
    element  :title

    # @return [String] journal description set by it's author
    # @!attribute [r] description
    element  :description

    # @return [URI::HTTP] link to this journal
    # @!attribute [r] link
    element  :link do |link|
      URI(link)
    end

    # @return [Time] journal last updated time
    # @!attribute [r] published
    element  :lastBuildDate,    as: :published, class: Time

    # @return [Array] array of {LJMedia::Post} entries parsed from journal's feed
    # @!attribute [r] posts
    elements :item,             as: :posts,     class: Post
  end
end
