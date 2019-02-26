ActiveAdmin.register ExpenseType do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#

 menu label: "Виды расходов"
 permit_params :name, :parent_id, :expense_kind_id


 form title: 'Виды расходов' do |f|
    inputs 'Вид расхода (редактирование)' do
      input :name, label: "Имя"
      input :parent, label: "Входит в группу"
      input :expense_kind, label: "Тип"
    end
    actions
end
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

end
