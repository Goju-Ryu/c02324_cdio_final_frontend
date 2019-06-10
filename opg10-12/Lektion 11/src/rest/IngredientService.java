package rest;

import dto.Ingredient;

import org.json.JSONObject;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Path("ingredient")
@Consumes(MediaType.APPLICATION_JSON)
@Produces(MediaType.APPLICATION_JSON)
public class IngredientService {
	static Map<Integer, Ingredient> ingredients = new HashMap<>();
	//Insert some dummy data
	static {
		ingredients.put(1, new Ingredient(1, "flormelis", 60.0));
		ingredients.put(2, new Ingredient(2, "mel", 240.0));
		ingredients.put(3, new Ingredient(3, "smoer", 185.0));
	} 
    
    @GET
    public List<Ingredient> getIngredientList() {
        return new ArrayList<>(ingredients.values());
    }

    @GET
    @Path("{id}")
    public Ingredient getIngredient(@PathParam("id") int id) {
        return ingredients.get(id);
    }

    @POST
    public Ingredient addIngredientJson(String body) {
        JSONObject jsonObject = new JSONObject(body);
        Ingredient ingredient = new Ingredient(jsonObject.getInt("id"), jsonObject.getString("name"), jsonObject.getDouble("amount"));
        ingredients.put(ingredient.getId(), ingredient);

        return ingredient;
    }

    @DELETE
    @Path("{id}")
    public void deleteIngredient(@PathParam("id") int id) {
        ingredients.remove(id);
    }
}
