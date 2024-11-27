class BaseModelsController < ApplicationController
  def index
    @base_models = BaseModel.where("name LIKE ?", "%#{params[:filter]}%")
  end

  def new
    @base_model = BaseModel.new
  end

  def create
    @base_model = BaseModel.new(base_model_params)

    if @base_model.save
      flash.now[:notice] = "base_model was successfully created."
      render turbo_stream: [
        turbo_stream.prepend("base_models", @base_model),
        turbo_stream.replace(
          "form_base_model",
          partial: "form",
          locals: { base_model: BaseModel.new }
        ),
        turbo_stream.replace("notice", partial: "layouts/flash")
      ]
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @base_model.update(base_model_params)
      flash.now[:notice] = "Base Model was successfully updated."
      render turbo_stream: [
        turbo_stream.replace(@base_model, @base_model),
        turbo_stream.replace("notice", partial: "layouts/flash")
      ]
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @base_model.destroy
    flash.now[:notice] = "Base Model was successfully destroyed."
    render turbo_stream: [
      turbo_stream.remove(@base_model),
      turbo_stream.replace("notice", partial: "layouts/flash")
    ]
  end

  private

  def set_base_model
    @base_model = BaseModel.find(params[:id])
  end

  def base_model_params
    params.require(:base_model).permit(:name, :company)
  end
end
