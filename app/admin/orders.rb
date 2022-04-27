ActiveAdmin.register Order do
  permit_params :pst, :gst, :total, :user_id

  form do |f|
    f.inputs do
      f.input :user_id, :as => :select, :collection => User.all.collect {|user| [user.email, user.id] } # Shows email as default dropdown value
      f.input :pst
      f.input :gst
      f.input :total
    end
    f.actions
  end
end
