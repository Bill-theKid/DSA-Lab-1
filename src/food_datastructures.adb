package body Food_DataStructures is

    package GenerateRandomFoodType is new Ada.Numerics.Discrete_Random(Food_Type);
    use GenerateRandomFoodType;

    G : GenerateRandomFoodType.Generator; -- uniformly distributed

    procedure PrintFood_Pack (foodIn : in Food_Pack) is
    begin
        Put (foodIn.aFoodType);
        Put (" ");
        Put (foodIn.aFoodShipment);
    end PrintFood_Pack;

    procedure PrintFood_PackType (FoodIn : in Food_Pack) is
    begin
        Put (FoodIn.aFoodType);
    end PrintFood_PackType;

    procedure PrintFood_PackShipment (FoodIn : in Food_Pack) is
    begin
        Put (FoodIn.aFoodShipment);
    end PrintFood_PackShipment;

    function getFood_PackFoodType (FoodIn : in Food_Pack) return Food_Type is
    begin
        return FoodIn.aFoodType;
    end getFood_PackFoodType;

    function getFood_PackFoodShipment (FoodIn : in Food_Pack) return Character
    is
    begin
        return FoodIn.aFoodShipment;
    end getFood_PackFoodShipment;

    procedure setFood_PackFoodType
       (FoodIn : in out Food_Pack; FoodType : Food_Type)
    is
    begin
        FoodIn.aFoodType := FoodType;
    end setFood_PackFoodType;

    procedure setFood_PackShipment
       (FoodIn : in out Food_Pack; FoodShipment : Character)
    is
    begin
        FoodIn.aFoodShipment := FoodShipment;
    end setFood_PackShipment;

    function RandomFoodType return Food_Type is
        aFood : Food_Type;
    begin
        aFood := GenerateRandomFoodType.Random (G);
        return aFood;
    end RandomFoodType;

end Food_DataStructures;
