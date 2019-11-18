class InterfaceController < ApplicationController
    soap_service namespace: 'urn:WashOutNotifications' , camelize_wsdl: :lower
    # create notification case
    soap_action "createNotification",
	:args => { :message => :string, :senderid => :integer, :chatid => :integer, :userid => :integer},
	:return => :string
    def createNotification
	options = {
            headers: {
              "Content-Type": "application/json"
            },
            body: {
		"message": params[:message],
		"users": params[:userid],
	        "sender_id": params[:senderid],
	        "chat_id": params[:chatid]
            }.to_json
          }

        @result = HTTParty.post("http://172.17.0.1:4001/notifications/create",options )
        puts @result
        render :soap => "Succesfull created"
    end

    # show notification case	
    soap_action "showNotification",
	:args => { :userid => :integer},
	:return => :string
    def showNotification
	headers = {"Content-Type": "application/json"}
	options = {"user_id" => params[:userid]}
        @result = HTTParty.get("http://172.17.0.1:4001/notifications/show", query: options, headers: headers)
        puts @result
        render :soap => @result
    end

    # delete notification case
    soap_action "deleteNotification",
	:args => { :userid => :integer},
	:return => :string
    def deleteNotification
	headers = {"Content-Type": "application/json"}
	options = {"user_id" => params[:userid]}
        @result = HTTParty.delete("http://172.17.0.1:4001/notifications/destroy", query: options, headers: headers)
        puts @result
        render :soap => "Succesfull deleted"
    end
end
