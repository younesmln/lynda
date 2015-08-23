class SubjectsController < ApplicationController
  layout 'admin'
  before_action 'get_object', only: [:show, :edit, :update, :destroy]
  before_action 'get_subject_count', only: [:new, :edit, :update, :create]
  before_action 'logged_in?'

  def index
    @subjects = Subject.sorted
  end

  def show
  end

  def new
    @subject = Subject.new unless @subject
    @subjects_count += 1
  end

  def create
    @subject = Subject.new(subject_params)
    if @subject.save
      flash['notice'] = 'object created successfully'
      redirect_to action: 'show', id: @subject.id
    else
      @subjects_count += 1
      render :new
    end
  end

  def edit
  end

  def update
    if @subject.update_attributes(subject_params)
      flash['notice'] = 'object updated successfully'
      redirect_to action: 'show', id: @subject.id
    else
      render :edit, id: @subject.id
    end
  end

  def delete
  end

  def destroy
    @subject.destroy
    flash['notice'] = 'object destroyed successfully'
    redirect_to action: 'index'
  end

  private
  def subject_params
    params.require(:subject).permit('name', 'position', 'visible', 'created_at')
  end

  def get_object
    begin
      @subject = Subject.find(params[:id])
    rescue
      redirect_to action: 'index'
    end
  end

  def get_subject_count
    @subjects_count = Subject.all.count
  end

end
