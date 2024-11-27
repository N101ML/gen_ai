class FineTunesController < ApplicationController
  def index
    @fine_tunes = FineTune.includes(:base_model)
  end
end
