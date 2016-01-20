class RedditSearcher
  def GetPartsDeals(parts)
    parts_with_deals = {}

    parts.each do |part_type, parts_of_type|
      parts_with_deals[part_type] = []

      parts_of_type.each do |part|
        search_text = part["model"].nil? ? (part["part_num"].nil? ? part["name"] : part["part_num"]) : part["model"]
        search_query = "subreddit:buildapcsales #{search_text}"
        links = RedditKit.search(search_query)
        
        parsed_links = []
        links.each do |link|
          parsed_links.push({
            "date" => link.created_at,
            "title" => link.title,
            "link" => link.permalink,
            "image" => link.thumbnail
          })
        end

        part_with_links = part
        part_with_links["deals"] = parsed_links
        parts_with_deals[part_type].push(part_with_links)
      end
    end

    parts_with_deals
  end
end