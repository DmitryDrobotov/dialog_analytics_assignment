class DialogsController < ApplicationController
  def index
    # check https://github.com/activerecord-hackery/ransack for details
    # check https://github.com/drapergem/draper for details
    @q = Dialog.ransack(params[:q])
    @dialogs = @q.result(distinct: true).preload(:phrases).decorate
  end

  def show
    @dialog = Dialog.find(params[:id]).decorate
    @phrases = @dialog.phrases.decorate
  end
end
