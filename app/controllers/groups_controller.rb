class GroupsController < ApplicationController

  def index
    @groups = Group.all
    @book = Book.new
  end

  def show
    @group = Group.find(params[:id])
    @book = Book.new
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    @group.save
    redirect_to groups_path
  end

  def show
    @group = Group.find(params[:id])
    @book = Book.new
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.update(group_params)
    redirect_to groups_path
  end

  def join
    @group = Group.find(params[:group_id])
    current_user.group_users.create(group_id: @group.id)
    redirect_to groups_path
  end

  def withdrawal
    @group = Group.find(params[:group_id])
    current_user.group_users.find_by(group_id: @group.id).destroy
    redirect_to groups_path
  end

  private

  def group_params
    params.require(:group).permit(:name,:introduction,:group_image)
  end

end
