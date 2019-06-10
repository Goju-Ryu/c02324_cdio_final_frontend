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
    public JsonObject helloWorld(){
        System.out.println("Hello world! This was a GET request!");
        JsonObject jsonObject = new JsonObject();
        jsonObject.addProperty("msg", "Hello World!");
        return jsonObject;
    }

}
