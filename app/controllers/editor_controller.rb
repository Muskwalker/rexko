class EditorController < ApplicationController
  layout '1col_layout'
  
  def index
    @page_title = session[:logged_in] ? t('editor.index.page title with name', name: session[:user_shortname]) : t('editor.index.page title')
  end

end
