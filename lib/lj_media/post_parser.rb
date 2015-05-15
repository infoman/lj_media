module LJMedia
  class PostParser
    include SAXMachine
    include Feedjira::FeedEntryUtilities

    element  :guid,             as: :entry_id
    element  :pubDate,          as: :published
    element  :title
    element  :link
    element  :description,      as: :content
    elements :category,         as: :tags
    element  :"lj:security",    as: :access
    element  :"lj:poster",      as: :author_name
    element  :"lj:posterid",    as: :author_id,      class: Integer
    element  :"lj:reply_count", as: :comments_count, class: Integer
  end
end
