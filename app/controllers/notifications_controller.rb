class NotificationsController < ApplicationController
require 'httparty'
require 'json'

    def create 
        users = params[:users]      
        options = {
            headers: {
              "Content-Type": "application/json"
            },
            body: {
		"message": notification_params[:message],
		"users": users,
	        "sender_id": notification_params[:sender_id],
	        "chat_id": notification_params[:chat_id]
            }.to_json
          }

        @result = HTTParty.post("http://172.17.0.1:4001/notifications/create",options )
        puts @result
	render json: @result, status: 200
    end

    def get_users
        return params[:users]
    end
    
    def show 
        if !params[:user_id]
            return
        end
        chats =[]
        ans=[]
        notifications = Notification.where(user_id:params[:user_id])
        notifications.each do |notification|
            if !chats.include? (notification.chat_id)
                chats.push(notification.chat_id)
            end 
        end
        chats.each do |chat|
            aux=Notification.where(user_id:params[:user_id],chat_id:chat).order("created_at ASC")
            ans.push(aux)
        end
        render json: ans, status:200
    end

    def destroy
        notifications = Notification.where(user_id:params[:user_id])
        notifications.each do |notification|
            notification.destroy
        end
        render json:nil, status: 204
    end

    def notification_params
        params.require(:notification).permit(:id, :message, :user_id, :sender_id, :chat_id)
    end

 end
