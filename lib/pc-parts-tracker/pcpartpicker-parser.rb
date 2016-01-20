class PCPartPickerParser
  def initialize(parts_id)
    @document = Nokogiri::HTML(open("http://pcpartpicker.com/p/#{parts_id}"))
  end

  def list_parts
    parts = {}
    prev_type = ""

    @document.css(".part-list tbody tr").each do |part|
      component_type = part.css(".component-type a").text
      component_name = part.css(".component-name a").text
      component_price = part.css(".price a").text
      component_merchant = part.css(".merchant a").text

      if component_type.empty?
        component_type = prev_type
      end

      if parts[component_type].nil?
        parts[component_type] = []
      end

      if !component_name.empty?
        component_link = "https://pcpartpicker.com#{part.css(".component-name a")[0].attributes["href"].value}"
        part_page = Nokogiri::HTML(open(component_link))
        part_specs_text = part_page.css(".specs").to_html

        component_model = nil
        component_part_num = nil
        
        part_model_match = part_specs_text.match(/<h4>Model<\/h4>(.*?)<h4>/m)
        if !part_model_match.nil?
          component_model = part_model_match[1].strip
        else
          part_num_match = part_specs_text.match(/<h4>Part #<\/h4>(.*?)<h4>/m)
          if !part_num_match.nil?
            component_part_num = part_num_match[1].strip
          end
        end

        parts[component_type].push({
          "name" => component_name,
          "price" => component_price,
          "merchant" => component_merchant,
          "model" => component_model,
          "part_num" => component_part_num
        })
      end

      prev_type = component_type
    end

    parts
  end
end