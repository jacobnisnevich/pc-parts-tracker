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

      if component_type.empty?
        component_type = prev_type
      end

      if parts[component_type].nil?
        parts[component_type] = []
      end

      if !component_name.empty?
        parts[component_type].push(component_name)
      end

      prev_type = component_type
    end

    parts
  end
end