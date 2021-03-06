def item_xml(options = {})
  <<-ITEM
  <item arg="#{options[:arg]}" uid="#{options[:uid]}">
    <title>#{options[:title]}</title>
    <subtitle>#{options[:subtitle]}</subtitle>
    <subtitle mod="cmd">Show in Finder</subtitle>
    <icon>#{options[:icon]}</icon>
    <quicklookurl>#{options[:icon]}</quicklookurl>
  </item>
  ITEM
end

def output(items)
  items = [items] unless items.is_a?(Array)
  items = items.map {|item| item_xml(item)}.join
  puts "<?xml version='1.0'?>\n<items>\n#{items}</items>"
  exit
end

def match?(word, query)
  word.match(/#{query.gsub(/\\ /, '').split('').join('.*')}/i)
end

def get_relative_path(roots, file)
  relative_path = file.clone

  for path in roots
    text = path
    if relative_path.include? path
      relative_path.slice! path
    end
  end

  return relative_path
end
