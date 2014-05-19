module ApplicationHelper

  def link_to_add_fields(f, type, &block)
    new_object = f.object.send "build_#{type}"
    id = "new_#{type}"
    fields = f.send("#{type}_fields", new_object, child_index: id) do |builder|
      render(type.to_s + "_fields", f: builder)
    end
    link_to '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")} do
      yield if block_given?
    end
  end


end
