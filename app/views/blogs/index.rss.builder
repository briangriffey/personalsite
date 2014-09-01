xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Your Blog Title"
    xml.description "A blog about software and chocolate"
    xml.link "http://www.briangriffey.com/#/blog"

    for post in @posts
      xml.item do
        xml.title post.title
        xml.description post.content
        xml.pubDate post.created_at.to_s(:rfc822)
        xml.link "http://www.briangriffey.com/#/blog/" + post.id.to_s
        xml.guid "http://www.briangriffey.com/#/blog/" + post.id.to_s
      end
    end
  end
end