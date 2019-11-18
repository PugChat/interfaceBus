class SoapfController < ApplicationController
   attr_reader :id, :materia, :descripcion, :cupos, :idtutor, :idtoken

   def getbyid 
        users = params[:id]
        client = Savon.client(wsdl: "http://146.148.107.218:3007/wsdl?wsdl")
	response = client.call(:tutoria_by_id, message: {'id' => params[:id]})
	if response.success?
      	   data =response.to_array()
           render json: data, status: 200
        end  
	#render json: "error", status: :unprocessable_entity
    end
    
    def getbymateria 
        users = params[:materia]
	client = Savon.client(wsdl: "http://146.148.107.218:3007/wsdl?wsdl")
	response = client.call(:tutoria_by_materia, message: {'materia' => params[:materia]})
	if response.success?
      	   data =response.to_array()
           render json: data, status: 200
        end  
	#render json: "error", status: :unprocessable_entity
    end

end
