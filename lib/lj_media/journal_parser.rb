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

    element  :"lj:journalid",   as: :id, class: Integer

    element  :"lj:journaltype", as: :type, class: Symbol

    element  :"lj:journal",     as: :name

    element  :title

    element  :description

    element  :link do |link|
      URI(link)
    end

    element  :lastBuildDate,    as: :published, class: Time

    elements :item,             as: :posts,     class: Post
  end
end
