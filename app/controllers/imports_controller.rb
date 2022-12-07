# frozen_string_literal: true

class ImportsController < ApplicationController
  def index
    @import = Import.new

    @pagy, @imports = pagy(Import.last_5_imports)
  end

  def create
    @import = current_user.imports.build(import_params)
    @import.file_name = @import.file.metadata["filename"] if @import.file

    respond_to do |format|
      if @import.save
        format.html { redirect_to imports_path, success: "Import was added to the queqe for processing. Please, wait." }
        format.turbo_stream do
          flash.now[:notice] = "Import was added to the queqe for processing. Please, wait."
          render turbo_stream: [
            turbo_stream.replace("import_form", partial: "imports/form", locals: {import: Import.new}),
            # turbo_stream.replace("imports", partial: "imports/import", locals: {import: Import.last_5_imports}),
            turbo_stream.prepend("flash", partial: "layouts/flash"),
          ]
        end
      else
        format.html do
          flash.now[:error] = @import.errors.full_messages.to_sentence
          render :index
        end
        format.turbo_stream do
          flash.now[:error] = @import.errors.full_messages.to_sentence
          render turbo_stream: [
            turbo_stream.replace("import_form", partial: "imports/form", locals: {import: @import}),
            turbo_stream.replace("imports", partial: "imports/import", locals: {import: Import.last_5_imports}),
            turbo_stream.replace("flash", partial: "layouts/flash"),
          ]
        end
      end
    end
  end

  private

  def import_params
    params.require(:import).permit(:file)
  end
end
