class ResultsController < ApplicationController
  before_action :set_result, only: %i[show edit update destroy]

  # GET /results or /results.json
  def index
    @character = Character.find(params[:character_id])
    @tasks = @character.tasks.order(created_at: :desc)
    @results = @tasks.map(&:results).flatten.sort_by(&:created_at).reverse
  end

  # GET /results/1 or /results/1.json
  def show
    logger.debug @result
  end

  # GET /results/new
  def new
    @result = Result.new
  end

  # GET /results/1/edit
  def edit; end

  # POST /results or /results.json
  def create
    @task = Task.find(params[:task_id])
    @character = Character.find(params[:character_id])

    client = OpenAI::Client.new

    content = "#{@character.personality} - based on this personality, complete this task, split every line with '\n' - #{@task.description}"

    response = client.chat(
      parameters: {
        model: 'gpt-4',
        messages: [{ role: 'user', content: }],
        temperature: 0.7
      }
    )

    content = response.dig('choices', 0, 'message', 'content')
    image_response = client.images.generate(parameters: {
                                              prompt: "A thumbnail for - #{@task.description}", model: 'dall-e-3', size: '1024x1024', quality: 'standard'
                                            })

    image_src = image_response.dig('data', 0, 'url')

    @result = @task.results.build(content:, image_src:)

    respond_to do |format|
      if @result.save
        format.html do
          redirect_to character_result_path(@character, @result), notice: 'Result was successfully created.'
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /results/1 or /results/1.json
  def update
    respond_to do |format|
      if @result.update(result_params)
        format.html do
          redirect_to character_result_path(@character, @result), notice: 'Result was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @result }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @result.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /results/1 or /results/1.json
  def destroy
    @result.destroy!

    respond_to do |format|
      format.html { redirect_to character_results_path(@character), notice: 'Result was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_result
    @result = Result.find(params[:id])
    @character = Character.find(params[:character_id])
  end
end
