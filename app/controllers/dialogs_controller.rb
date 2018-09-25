class DialogsController < ApplicationController
  def index
    @q = Dialog.ransack(params[:q])
    @dialogs = @q.result(distinct: true).preload(:phrases).decorate
  end

  def show
    @dialog = Dialog.find(params[:id]).decorate
    @phrases = @dialog.phrases.decorate
  end
end
