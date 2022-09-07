-- The software suite consists of ProductDistributionMain,
-- Food_DataStructures, Stats_FoodDistribution, GateKeeperService,
-- Distribution_Service, CircularQue and Food_SalesService.
--
-- With the exception of ProductDistributionMain this suite represents the software
-- to manage an "embedded" planetary system food receiving and distribution system.
-- The Distribution_Service module will be discarded once the embedded software required to
-- manage the physical system is complete and installed.
--

with Ada.Text_IO; use Ada.Text_IO;

with Ada.Numerics.Discrete_Random;

package Food_DataStructures is
--
-- Use 1.0 seconds of real time to simulate passage of 1 hour simulated time.
--
    type Food_Type is (Wheat, Corn, Rice, Potatoes, Squash, Tomato, Steak, Pork, Fish, Fowel);
    subtype GrainVegetable is Food_Type range Wheat .. Tomato;

    package Food_TypeIO is new Ada.Text_IO.Enumeration_IO (Food_Type);
    use Food_TypeIO;

    type Food_Pack is private;

    procedure PrintFood_Pack (foodIn : in Food_Pack);

    procedure PrintFood_PackType (FoodIn : in Food_Pack);

    procedure PrintFood_PackShipment (FoodIn : in Food_Pack);

    function getFood_PackFoodType (FoodIn : in Food_Pack) return Food_Type;

    function getFood_PackFoodShipment (FoodIn : in Food_Pack) return Character;

    procedure setFood_PackFoodType
       (FoodIn : in out Food_Pack; FoodType : Food_Type);

    procedure setFood_PackShipment
       (FoodIn : in out Food_Pack; FoodShipment : Character);

    function RandomFoodType return Food_Type;

private
    type Food_Pack is record
        aFoodType     : Food_Type := Fowel;
        aFoodShipment : Character := 'M';
    end record;

end Food_DataStructures;
