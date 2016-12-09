SimpleTrack::Admin.controllers :settings do
  get :index do
    @title = "Settings"
    @settings = Settings.all
    render 'settings/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'settings')
    @settings = Settings.new
    render 'settings/new'
  end

  post :create do
    @settings = Settings.new(params[:settings])
    if @settings.save
      @title = pat(:create_title, :model => "settings #{@settings.id}")
      flash[:success] = pat(:create_success, :model => 'Settings')
      params[:save_and_continue] ? redirect(url(:settings, :index)) : redirect(url(:settings, :edit, :id => @settings.id))
    else
      @title = pat(:create_title, :model => 'settings')
      flash.now[:error] = pat(:create_error, :model => 'settings')
      render 'settings/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "settings #{params[:id]}")
    @settings = Settings.find(params[:id])
    if @settings
      render 'settings/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'settings', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "settings #{params[:id]}")
    @settings = Settings.find(params[:id])
    if @settings
      if @settings.update_attributes(params[:settings])
        flash[:success] = pat(:update_success, :model => 'Settings', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:settings, :index)) :
          redirect(url(:settings, :edit, :id => @settings.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'settings')
        render 'settings/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'settings', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Settings"
    settings = Settings.find(params[:id])
    if settings
      if settings.destroy
        flash[:success] = pat(:delete_success, :model => 'Settings', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'settings')
      end
      redirect url(:settings, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'settings', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Settings"
    unless params[:settings_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'settings')
      redirect(url(:settings, :index))
    end
    ids = params[:settings_ids].split(',').map(&:strip)
    settings = Settings.find(ids)
    
    if settings.each(&:destroy)
    
      flash[:success] = pat(:destroy_many_success, :model => 'Settings', :ids => "#{ids.join(', ')}")
    end
    redirect url(:settings, :index)
  end
end
