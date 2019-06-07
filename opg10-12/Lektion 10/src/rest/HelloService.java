package rest;

import com.google.gson.JsonObject;

import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;



@Path("hello")
public class HelloService {
	
	@GET
	public JsonObject getHello(){
		return get();
	}
	
	@POST
	public String postHello(String name){
		return "Hello " + name;
		
	}

	private JsonObject get () {
		JsonObject hello = new JsonObject();
		hello.addProperty("Message", "Hello World!");
		return hello;
	}
}