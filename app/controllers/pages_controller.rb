class PagesController < ApplicationController

  layout 'admin'
  before_action 'get_object', only: [:show, :edit, :update, :destroy]
  before_action 'get_page_and_subjects_count', only: [:new, :edit, :update, :create]
  before_action 'logged_in?'
  before_action 'find_subject'

  def index
    @pages = @subject.pages.sorted
  end

  def show
  end

  def new
    @page = Page.new
    @page_count += 1
  end

  def create
    @page = Page.new(subject_params)
    if @page.save
      flash['notice'] = 'object created successfully'
      redirect_to action: 'show', id: @page.id, subject_id: @subject.id
    else
      @page_count += 1
      render 'new', subject_id: @subject.id
    end
  end

  def edit
  end

  def update
    if @page.update_attributes(subject_params)
      flash['notice'] = 'object updated successfully'
      redirect_to action: 'show', id: @page.id, subject_id: @subject.id
    else
      render 'edit', subject_id: @subject.id
    end
  end

  def delete
  end

  def destroy
    @page.destroy
    flash['notice'] = 'object destroyed successfully'
    redirect_to action: 'index', subject_id: @subject.id
  end

  private
  def subject_params
    params.require(:page).permit('subject_id', 'name', 'permalink', 'position', 'visible')
  end

  def get_object
    begin
      @page = Page.find(params[:id])
    rescue
      redirect_to action: 'index'
    end
  end

  def get_page_and_subjects_count
    @subjects = Subject.all
    @page_count = Page.all.count
  end

  def find_subject
    if params[:subject_id]
      @subject = Subject.find(params[:subject_id])
    end
  end

end
