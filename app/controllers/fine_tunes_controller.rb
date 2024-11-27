class FineTunesController < ApplicationController
  def index
    @fine_tunes = FineTune.includes(:base_model).where("fine_tunes.name LIKE ?", "%#{params[:filter]}%")
  end

  def new
    @fine_tune = fine_tune.new
  end

  def create
    @fine_tune = fine_tune.new(fine_tune_params)

    if @fine_tune.save
      # Need a flash message here
      render turbo_stream: turbo_stream.append(
        dom_id(@fine_tunes),
        partial: "shared/resource_table",
        locals: { item: @fine_tune,
        headers: {
          "Fine Tune" => 'name',
          "Base Model" => "base_model.name"
          }
        }
      )
    else
      render turbo_stream: turbo_stream.replace(
        dom_id(@fine_tune, "form"),
        locals: { fine_tune: @fine_tune }
      )
    end
  end

  private

  def fine_tune_params
    params.require(:fine_tune).permit(:name, :base_model_id)
  end
end
