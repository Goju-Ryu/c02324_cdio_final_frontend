package rest;

import Technical_Services.ECategory;
import Technical_Services.ELocation;
import Technical_Services.FoodDTO;
import Technical_Services.IFoodDTO;
import com.google.gson.JsonObject;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.sql.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

@Path("food")
@Consumes(MediaType.APPLICATION_JSON)
@Produces(MediaType.APPLICATION_JSON)
public class FoodService {
    static Map<Integer, FoodDTO> foodDTOMap = new HashMap<>();
    static {
        FoodDTO food1 = new FoodDTO();
        food1.setID(1);
        food1.setName("Smør");
        food1.setExpDate(new Date(10/06/2019));
        food1.setCategory(ECategory.Dairy);
        food1.setLocation(ELocation.Fridge);
        foodDTOMap.put(1, food1);
    }


    //This method should return a specified food
    @GET
    @Path("{id}")
    public String getFood(@PathParam("id") int id){




        FoodDTO food = foodDTOMap.get(id);
        JsonObject jsonObject = new JsonObject();
        jsonObject.addProperty("id", food.getID());
        jsonObject.addProperty("name", food.getName());
        jsonObject.addProperty("expDate", DTS.dateToString(10, 06, 2019));
        String foodCat = food.getCategory().toString();
        String foodLoc = food.getLocation().toString();
        jsonObject.addProperty("category", foodCat);
        jsonObject.addProperty("location", foodLoc);
        System.out.println(jsonObject.toString());
        return jsonObject.toString();
    }
//Should be fine? not sure how to test it.
    @POST
    public Response createFood(FoodDTO foodDTO){
        if(foodDTOMap.putIfAbsent(foodDTO.getID(), foodDTO) == null){
            return Response.ok("Creation succeeded!").build();
        }else{
            Response response1 = Response.status(Response.Status.BAD_REQUEST)
                    .entity("ID: " + foodDTO.getID() + " already in use!")
                    .build();
            throw new WebApplicationException(response1);
        }
    }

}
