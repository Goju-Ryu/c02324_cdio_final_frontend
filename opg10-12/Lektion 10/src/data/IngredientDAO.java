package data;

import java.util.ArrayList;
import java.util.List;

public class IngredientDAO {
    private static IngredientDAO instance;
    private List<IngredientDTO> list;

    private IngredientDAO(){
        list = new ArrayList<>();
        list.add(new IngredientDTO(1, "flormelis", 60));
        list.add(new IngredientDTO(2, "mel", 240));
        list.add(new IngredientDTO(3, "smør", 185));
    }

    public static IngredientDAO getInstance(){
        if (instance == null)
            instance = new IngredientDAO();
        return instance;
    }

    public List<IngredientDTO> getIngredientList() {
        return list;
    }

    public void addIngredient(IngredientDTO ingredient) {
        list.add(ingredient);
    }

    public IngredientDTO getIngredient(int id) {
        for (IngredientDTO i : list)
            if (i.getId() == id)
                return i;

        return null;
    }

    public void setIngredient(IngredientDTO ingredient) {
        IngredientDTO localObject = getIngredient(ingredient.getId());
        localObject.setAmount(ingredient.getAmount());
        localObject.setName(ingredient.getName());
    }

    public void deleteIngredient(int id) {
        IngredientDTO localObject = getIngredient(id);
        list.remove(localObject);
    }

}
