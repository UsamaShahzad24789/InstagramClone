class AdminsController < ApplicationController
    before_action :authenticate_account!

    layout 'flow'
    def index
        @profiles=Profile.all
        @posts=Post.all.order(created_at: :desc)
        @accounts= Account.where.not(role:1)
    end
end
