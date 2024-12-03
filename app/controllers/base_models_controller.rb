class BaseModelsController < ApplicationController
  def index
    filtered = BaseModel.where("name LIKE ?", "%#{params[:filter]}%")
    @pagy, @base_models = pagy(filtered)
  end

  def new
    @base_model = BaseModel.new
  end

  def create
    @base_model = BaseModel.new(base_model_params)

    if @base_model.save
      render turbo_stream: turbo_stream.append(
        dom_id(@base_models),
        partial: "shared/resource_table",
        locals: { item: @base_model, headers: { "Base Model" => 'name', "Company" => 'company' } }
      )
    else
      render turbo_stream: turbo_stream.replace(
        dom_id(@base_model, "form"),
        locals: { base_model: @base_model }
      )
    end
  end

  def edit
    @base_model = BaseModel.find(params[:id])

    respond_to do |format|
      format.turbo_stream
      format.html
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
