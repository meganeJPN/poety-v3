module PoeetsHelper
  def choose_new_or_edit
    @poeet.id ? confirm_poeet_path : confirm_poeets_path
  end

  def confirm_new_or_edit
    if @poeet.id?
      poeet_path
    else
      poeets_path
    end
  end

  def confirm_form_method
    @poeet.id ? 'patch' : 'post'
  end
end