class EditorController < ApplicationController
  layout '1col_layout'
  
  def index
    @page_title = session[:logged_in] ? "#{session[:user_shortname]}'s index" : t('editor.index.page title')
  end

end
