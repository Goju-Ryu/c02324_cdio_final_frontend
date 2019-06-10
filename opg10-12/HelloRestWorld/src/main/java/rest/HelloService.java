package rest;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import com.google.gson.JsonObject;

@Path("hello")
@Consumes(MediaType.APPLICATION_JSON)
@Produces(MediaType.APPLICATION_JSON)
public class HelloService {

    @GET
    @Produces("Applications/json")
    public String helloWorld(){
        System.out.println("Got GET request!");
        JsonObject jsonObject = new JsonObject();
        jsonObject.addProperty("msg", "Hello, World!");
        return jsonObject.toString();
    }

}
