module ApplicationHelper

  # def v_value(obj, name, attr_name = nil, default = nil, safe = false)
  #   attr_name ||= "name"
  #   if !obj.nil? && obj.id? 
  #     if !obj["#{name}_id"].nil? && obj["#{name}_id"]>0
  #       val = obj["#{name}_id"]
  #       label = obj.try("#{name}_#{attr_name}")
  #     end
  #   elsif default.present?
  #       val = default.id
  #       label = default.name
  #   end
  #   h = val.present? ? {value: val, label: label} : []
  #   h = h.to_json.html_safe.to_s if safe
  #   h
  # end

  def submit_cancel(back_url, options = {})
    add_cls = options['modal'] ? ' update' : ''
    dd      = options['modal'] ? "modal" : ''

    submit_options = {}
    cls = "btn sub btn_a #{add_cls}"

    if options[:classValid] 
      submit_options[':class'] = "[{disabled: "+options[:classValid]+"}, '#{cls}']"
    else
      submit_options['class'] = cls
    end

    submit_options[':data-original-title'] = options[:tip] if options[:tip]
    # вернуть если нужен tooltip 
    # submit_options["data-toggle"] = 'tooltip' if options[:tip]
    submit_options["v-on:click"] = options[:click] if options[:click]
    
    s = submit_tag 'Сохранить', submit_options
    c = link_to 'Отмена', back_url, class: "sub btn_a btn_reset", "data-dismiss": dd
    content_tag :div, class: "actns" do
      c+s
    end
  end

  def v_value(obj, name, attr_name = nil, default = nil, safe = false)
    attr_name ||= "name"
    if !obj.nil? && obj.id? 
      if !obj["#{name}_id"].nil? && obj["#{name}_id"]>0
        val = obj["#{name}_id"]
        label = obj.try("#{name}_#{attr_name}")
      end
    elsif default.present?
        val = default.id
        label = default.name
    end
    h = val.present? ? {value: val, label: label} : []
    h = h.to_json.html_safe.to_s if safe
    h
  end


  def fill_vue_data(obj, data)
    if data[:booleans].present?
      data[:booleans].split(' ').each do |b|
        data[b] = obj[b].nil? ? eval("@#{b}") : obj[b]
        # puts "booleans", b, obj[b].nil?
      end
      data.delete(:booleans)
    end

    if data[:texts].present? 
      data[:texts].split(' ').each do |t|
        data[t] = obj[t].nil? ? '' : obj[t]
      end
      data.delete(:texts)
    end

    if data[:list_values].present? 
      data[:list_values].split(' ').each do |li| 
        # data[li] = v_value(nil, nil, nil, eval("@#{li}"))
        data[li] = v_value(obj, li) if data[li].nil?
      end
      data.delete(:list_values)
    end

    if data[:lists].present? # collection_name[:source_name][+field1,field2...]
      data[:lists].split(' ').each do |l|
        fields = nil
        if l.index('+').present? 
          lf = l.split('+')
          fields = lf[1]
          l = lf[0]
        end
        if l.index(':').nil?
          collection = eval("@#{l}")
        else
          la = l.split(':')
          collection = eval("#{la[1]}")
          l = la[0]
        end
        data[l] = select_src(collection, "name", false, fields) if collection.present?
        # puts "data[:lists]", data[:lists], collection, fields
      end
      data.delete(:lists)
    end

    return data.to_json.html_safe.to_s
  end

  def select_src(collection, attr_name = "name", safe = false, fields_str = nil)
    if fields_str.nil? 
      collection = collection.collect{|u| {label: u.try(attr_name), value: u.id}}
    else
      fields = fields_str.split(',')
      collection = collection.collect{|u| 
        c = {label: u.try(attr_name), value: u.id}
        fields.each {|f| c[f] = u.try(f)}
        c
      }
    end
    collection = collection.to_json.html_safe.to_s if safe
    collection
  end

  def tool_icons(element, params = {})

    all_icons = {} #['edit','delete','show'] tag='span',subcount=nil
    params[:tag] ||= 'href'
    params[:icons] ||= 'edit,delete'
    icons = params[:icons].split(',').map { |e| e == 'edit' ? 'icon_edit' : e}

    params[:subcount] ||= 0
    params[:class] ||= ''
    params[:content_class] ||= ''
    params[:content_tag] ||= :td
    add_cls = ' ' + params[:add_class] ||= ''
    content = params[:content_tag]
    dilable_cls = params[:subcount]>0 ? '_disabled' : ''
    
    modal     = params[:modal] ||= false
    datap     = modal ? { modal: true } : {}
    data_del  = modal ? { confirm: 'Действительно удалить?' } : { confirm: 'Действительно удалить?' }
    i_edit = (icons & ['icon_edit','inline_edit','modal_edit','basket']).first

    style = ""
    style = 'width: ' + params[:width] if params[:width] 

    if params[:tag] == 'span'

      all_icons[i_edit] = content_tag :span, "", {class: "icon #{i_edit}", item_id: element.id} if !i_edit.nil?
      all_icons['delete'] = content_tag( :span, "",{class: ['icon icon_remove',dilable_cls,' ',params[:class]].join, item_id: params[:subcount]>0 ? '' : element.id})
    else
      all_icons[i_edit] = link_to "", edit_polymorphic_path(element), class: "icon "+i_edit + params[:class], data: datap if !i_edit.nil?
      all_icons['show'] = link_to "", polymorphic_path(element), class: "icon icon_show", data: { modal: true }
      all_icons['delete'] = link_to "", polymorphic_url(element), 
      method: :delete, data: data_del, remote: modal,
      class: "icon icon_remove " + params[:class] if params[:subcount]==0
        all_icons['delete'] = content_tag(:span,"",{class: 'icon icon_remove_disabled'}) if params[:subcount]>0
    end

    content_tag content,{class: "edit_delete #{add_cls} #{params[:content_class]}", rowspan: params[:rowspan], style: style} do
      icons.collect{ |i| all_icons[i] }.join.html_safe
    end
  end


end
