class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]
  before_action :set_character
  # GET /tasks or /tasks.json
  def index
    @character = Character.find(params[:character_id])
    @tasks = @character.tasks.order(created_at: :desc)
  end

  # GET /tasks/1 or /tasks/1.json
  def show; end

  # GET /tasks/new
  def new
    @task = @character.tasks.build
  end

  # GET /tasks/1/edit
  def edit; end

  # POST /tasks or /tasks.json
  def create
    @task = @character.tasks.build(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to character_task_path(@character, @task), notice: 'Task was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to character_task_path(@character, @task), notice: 'Task was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy!

    respond_to do |format|
      format.html { redirect_to character_tasks_path, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_character
    @character = Character.find(params[:character_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = Task.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def task_params
    params.require(:task).permit(:name, :generate_image, :description, :character_id)
  end
end
