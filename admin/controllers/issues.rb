SimpleTrack::Admin.controllers :issues do
  get :index do
    @title = "Issues"
    @issues = Issue.all
    render 'issues/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'issue')
    @issue = Issue.new
    render 'issues/new'
  end

  post :create do
    @issue = Issue.new(params[:issue])
    if @issue.save
      @title = pat(:create_title, :model => "issue #{@issue.id}")
      flash[:success] = pat(:create_success, :model => 'Issue')
      params[:save_and_continue] ? redirect(url(:issues, :index)) : redirect(url(:issues, :edit, :id => @issue.id))
    else
      @title = pat(:create_title, :model => 'issue')
      flash.now[:error] = pat(:create_error, :model => 'issue')
      render 'issues/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "issue #{params[:id]}")
    @issue = Issue.find(params[:id])
    if @issue
      render 'issues/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'issue', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "issue #{params[:id]}")
    @issue = Issue.find(params[:id])
    if @issue
      if @issue.update_attributes(params[:issue])
        flash[:success] = pat(:update_success, :model => 'Issue', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:issues, :index)) :
          redirect(url(:issues, :edit, :id => @issue.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'issue')
        render 'issues/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'issue', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Issues"
    issue = Issue.find(params[:id])
    if issue
      if issue.destroy
        flash[:success] = pat(:delete_success, :model => 'Issue', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'issue')
      end
      redirect url(:issues, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'issue', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Issues"
    unless params[:issue_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'issue')
      redirect(url(:issues, :index))
    end
    ids = params[:issue_ids].split(',').map(&:strip)
    issues = Issue.find(ids)
    
    if issues.each(&:destroy)
    
      flash[:success] = pat(:destroy_many_success, :model => 'Issues', :ids => "#{ids.join(', ')}")
    end
    redirect url(:issues, :index)
  end
end
