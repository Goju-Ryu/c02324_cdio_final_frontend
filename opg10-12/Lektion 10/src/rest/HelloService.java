package rest;

import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;

@Path("hello")
public class HelloService {
	
	@GET
	public String getHello(){
		return "Hello";
	}
	
	@POST
	public String postHello(String name){
		return "Hello " + name;
		
	}

}
