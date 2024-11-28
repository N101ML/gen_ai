class FineTunesController < ApplicationController
  before_action :set_fine_tune, only: [:edit, :update, :destroy]
  def index
    @fine_tunes = FineTune.includes(:base_model).order(created_at: :desc)
    @fine_tunes = @fine_tunes.where("name LIKE ?", "%#{params[:filter]}%")
  end

  def new
    @fine_tune = FineTune.new
  end

  def create
    @fine_tune = FineTune.new(fine_tune_params)

    if @fine_tune.save
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.append("fine_tunes", partial: "fine_tune", locals: { fine_tune: @fine_tune }),
          turbo_stream.replace("new-fine-tune-form", partial: "form", locals: { fine_tune: FineTune.new })
        ]
      end
      format.html { redirect_to fine_tunes_path, notice: "Fine tune was successfully created." }
    end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("new-fine-tune-form", partial: "form", locals: { fine_tune: @fine_tune })
        end
        format.html { render :index, status: :unprocessable_entity }
      end
    end
  end

  def edit
    respond_to do |format|
      format.turbo_stream do
        render partial: "edit", locals: { fine_tune: @fine_tune }
      end
      format.html
    end
  end

  def update
    if @fine_tune.update(fine_tune_params)
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(dom_id(@fine_tune), partial: "fine_tune", locals: { fine_tune: @fine_tune })
        end
        format.html { redirect_to fine_tunes_path, notice: "Fine tune was successfully updated." }
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(dom_id(@fine_tune), partial: "edit", locals: { fine_tune: @fine_tune })
        end
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @fine_tune.destroy
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.remove(dom_id(@fine_tune))
      end
      format.html { redirect_to fine_tunes_path, notice: "Fine tune was successfully deleted." }
    end
  end

  private

  def fine_tune_params
    params.require(:fine_tune).permit(:name, :base_model_id)
  end

  def set_fine_tune
    @fine_tune = FineTune.find(params[:id])
  end
end
