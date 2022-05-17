ActiveAdmin.register Month do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :date, :sales_plan, :price_index
  #
  # or
  #
  # permit_params do
  #   permitted = [:date, :sales_plan, :price_index]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end


  permit_params :date, :sales_plan, :price_index

  form do |f|
    f.inputs do

      f.input :date, label: "Учетный месяц (день опционален)"
      f.input :sales_plan
      f.input :price_index
    end
    f.actions
  end

end
