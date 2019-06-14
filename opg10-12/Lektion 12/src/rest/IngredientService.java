package rest;

import dto.Ingredient;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.ResponseBuilder;
import javax.ws.rs.core.Response.Status;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@SuppressWarnings("unused")
@Path("ingredient")
@Consumes(MediaType.APPLICATION_JSON)
@Produces(MediaType.APPLICATION_JSON)
public class IngredientService {
	static Map<Integer, Ingredient> ingredients = new HashMap<>();
	//Insert some dummy data
	static {
		ingredients.put(1, new Ingredient(1, "flormelis", 60.0));
		ingredients.put(2, new Ingredient(2, "mel", 240.0));
		ingredients.put(3, new Ingredient(3, "smør", 185.0));
	} 
    

	
	
	@GET
    public List<Ingredient> getIngredientList() {
        return new ArrayList<>(ingredients.values());
    }

    
//	  http://localhost:8080/Lektion12/rest/ingredient/2 *** Postman GET
//    {
//        "id": 2,
//        "name": "mel",
//        "amount": 240
//    }
    
    
    @GET
    @Path("{id}")
    public Ingredient getIngredient(@PathParam("id") int id) {
        return ingredients.get(id);
    }
    
 
    
    
    @POST
    @Produces(MediaType.TEXT_PLAIN) // hvorfor
    public Response addIngredientJson(Ingredient ingredient) throws InvalidIdException {
        if (ingredients.putIfAbsent(ingredient.getId(), ingredient) == null)
        	return Response.ok("Det gik godt").build();
        else {
        	//3. custom exception
        	throw new InvalidIdException("ID " + ingredient.getId() + " er allerede i brug!!");        	
        	
        	//2. Throw WebApplicationException

//        	Response response1 = Response
//        			.status(Status.BAD_REQUEST)
//        			.entity("Id " + ingredient.getId() + " er i brug")
//        			.build();
//        	
//    		throw new WebApplicationException(response1); //fra jersy
//        	
        	//1. Return response
        	
//        	ResponseBuilder builder = Response.status(Status.BAD_REQUEST);
//        	builder.entity("Id " + ingredient.getId() + " er i brug");
//        	Response response = builder.build();
//        	return response;
        	
//        	Response response = Response
//        			.status(Status.BAD_REQUEST)
//        			.entity("Id " + ingredient.getId() + " er i brug")
//        			.build();
//        	
//        	return response;
        	
        	
        	
        	
        }
    }
    
    @DELETE
    @Path("{id}")
    public Response deleteIngredient(@PathParam("id") int id) {
        Ingredient existing = ingredients.get(id);
    	if (existing != null) {
    		ingredients.remove(id);
    		return Response.ok("Slettet").build();
    	} else {
    		return Response.status(Status.BAD_REQUEST).entity("Den findes ikke").build();
    	}
    }
}
