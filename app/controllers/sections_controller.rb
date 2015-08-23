class SectionsController < ApplicationController
  layout 'admin'
  before_action 'find_page'
  before_action 'get_object', only: [:show, :edit, :update, :destroy]
  before_action 'get_sections_and_page_count', only: [:new, :edit, :update, :create]
  before_action 'logged_in?'

  def index
    @sections = @page.sections.sorted
  end

  def show
  end

  def new
    @section = Section.new
    @section_count += 1
  end

  def create
    @section = Section.new(subject_params)
    if @section.save
      flash['notice'] = 'object created successfully'
      redirect_to action: 'show', id: @section.id, page_id: @page.id
    else
      @section_count += 1
      render 'new', page_id: @page.id
    end
  end

  def edit
  end

  def update
    if @section.update_attributes(subject_params)
      flash['notice'] = 'object updated successfully'
      redirect_to action: 'show', id: @section.id, page_id: @page.id
    else
      render 'edit', page_id: @page.id
    end
  end

  def delete
  end

  def destroy
    @section.destroy
    flash['notice'] = 'object destroyed successfully'
    redirect_to action: 'index', page_id: @page.id
  end

  private
  def subject_params
    params.require(:section).permit('page_id', 'name', 'position', 'visible', 'content_type', 'content')
  end

  def get_object
    begin
      @section = Section.find(params[:id])
    rescue
      redirect_to action: 'index'
    end
  end

  def get_sections_and_page_count
    @pages = @page.subject.pages.sorted
    @section_count = @page.sections.size
  end

  def find_page
    if params[:page_id]
      @page = Page.find params[:page_id]
    end
  end

end