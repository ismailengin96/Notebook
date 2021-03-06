class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]

  # GET /notes
  # GET /notes.json
  def index
    @notes = Note.all
  end

  # GET /notes/1
  # GET /notes/1.json
  def show
    @note_attachments = @note.note_attachments.all
  end

  # GET /notes/new
  def new
   if !session[:user]
    redirect_to notes_path, :alert => "You have to log in to create a new note "
    else
    @note = Note.new
    @note_attachment = @note.note_attachments.build
    end
  end

  # GET /notes/1/edit
  def edit
    @note = Note.find(params[:id])
    if @note.user.name != session[:user]
    redirect_to notes_path, :alert => "You cannot edit another user’s note!"
    else
    @note = Note.find(params[:id])
    end
  end

  # POST /notes
  # POST /notes.json
  def create
    @note = Note.new(note_params)
    @note.user = User.find_by name: session[:user]

    respond_to do |format|
      if @note.save
        params[:note_attachments]['avatar'].each do |a|
          @note_attachment = @note.note_attachments.create!(:avatar => a)
       end
        format.html { redirect_to notes_url, notice: 'Note was successfully created.' }
        format.json { render :show, status: :created, location: @note }
      else
        format.html { render :new }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notes/1
  # PATCH/PUT /notes/1.json
  def update
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to notes_path, notice: 'Note was successfully updated.' }
        format.json { render :show, status: :ok, location: @note }
      else
        format.html { render :edit }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy

    if @note.user.name != session[:user]
    redirect_to notes_path, :alert => "You cannot delete another user’s note!"
    else
     @note.destroy
       respond_to do |format|
       format.html { redirect_to notes_url }
       format.json { head :no_content }
       end
     end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def note_params
      params.require(:note).permit(:text, :user_id)
    end
end
