# frozen_string_literal: true

class AstronautsController < ApplicationController
  def new
    @astronaut = Astronaut.new

    respond_to do |format|
      format.html
      format.turbo_stream { render turbo_stream: turbo_stream.update('modal', partial: "astronauts/form", locals: {astronaut: @astronaut}) }
    end
  end

  def index
    @pagy, @astronauts = pagy(Astronaut.all)

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def create
    @astronaut = Astronaut.new(astronaut_params)

    respond_to do |format|
      if @astronaut.save
        format.html { redirect_to astronauts_path, notice: "Astronaut was successfully created." }
      else
        format.html do
          flash.now[:error] = "Astronaut could not be created."
          render :new
        end
        format.turbo_stream { render turbo_stream: turbo_stream.update('modal', partial: "astronauts/form", locals: {astronaut: @astronaut}) }
      end
    end
  end

  def update
    @astronaut = Astronaut.find(params[:id])

    respond_to do |format|
      if @astronaut.update(astronaut_params)
        format.html { redirect_to astronauts_path, notice: "Astronaut was successfully updated." }
        format.turbo_stream { flash.now[:notice] = "Astronaut was successfully updated." }
      else
        format.html do
          flash.now[:error] = @astronaut.errors.full_messages.to_sentence
          render :edit
        end
        format.turbo_stream { flash.now[:error] = @astronaut.errors.full_messages.to_sentence }
      end
    end
  end

  def edit
    @astronaut = Astronaut.find(params[:id])

    respond_to do |format|
      format.html
      format.turbo_stream { render turbo_stream: turbo_stream.update('modal', partial: "astronauts/form", locals: {astronaut: @astronaut}) }
    end
  end

  def destroy
    astronaut = Astronaut.find(params[:id])
    astronaut.destroy

    respond_to do |format|
      format.html { redirect_to astronauts_path, notice: "Astronaut was successfully removed." }
      format.turbo_stream do
        flash.now[:alert] = "Astronaut was successfully sent to removed."
        pagy, astronauts = pagy(Astronaut.all)

        render turbo_stream: [
          turbo_stream.replace("astronauts", partial: "astronauts/table", locals: {astronauts: astronauts}),
          turbo_stream.replace("pagination", partial: "shared/pagination", locals: {pagy: pagy}),
          turbo_stream.prepend("flash", partial: "layouts/flash")
        ]
      end
    end
  end

  def search
    @pagy, @astronauts = pagy(Astronaut.search(params[:name_search]).all)

    respond_to do |format|
      format.html { render :index }
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.update("table_results"),
          turbo_stream.update("pagination", partial: "shared/pagination", locals: {pagy: @pagy})
        ]
      end
    end
  end

  private

  def astronaut_params
    params.require(:astronaut).permit(:first_name, :last_name, :position, :age, :country_code)
  end
end
