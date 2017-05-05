module MicropostsHelper

   def three_tag(a, b, c)
        collection_check_boxes(:micropost, :tag_ids, Tag.all, :id, :name,  html: {id: 'item_form', class: 'form-control check-color'}) do |t|
         if t.text[0] == "#{a}" || t.text[0] == "#{b}" || t.text[0] == "#{c}"
             content_tag(:span, :class => 'label label-primary') do
               t.label { t.check_box + "  " + t.text  }
             end
         end
        end
   end
   
   def seven_tag(a, b, c, d, e, f, g)
        collection_check_boxes(:micropost, :tag_ids, Tag.all, :id, :name,  html: {id: 'item_form', class: 'form-control check-color'}) do |t|
         if t.text[0] == "#{a}" || t.text[0] == "#{b}" || t.text[0] == "#{c}" || 
             t.text[0] == "#{d}" || t.text[0] == "#{e}" || t.text[0] == "#{f}" || t.text[0] == "#{g}"
             content_tag(:span, :class => 'label label-primary') do
               t.label { t.check_box + "  " + t.text  }
             end
         end
        end
    end
    
   def two_tag(a, b)
        collection_check_boxes(:micropost, :tag_ids, Tag.all, :id, :name,  html: {id: 'item_form', class: 'form-control check-color'}) do |t|
         if t.text[0] == "#{a}" || t.text[0] == "#{b}"
             content_tag(:span, :class => 'label label-primary') do
               t.label { t.check_box + "  " + t.text  }
             end
         end
        end
    end
    

    
end
