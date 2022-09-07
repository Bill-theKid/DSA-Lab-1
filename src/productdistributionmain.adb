-- The software suite consists of Product Distribution Main,
-- Food_DataStructures, Stats_FoodDistribution, GateKeeperService,
-- Distribution_Service and Food_SalesService.

-- With the exception of ProductDistributionMain this suite represents the software
-- to manage an "embedded" planetary system food receiving and distribution system.
-- The Distribution_Service moduke will be discarded once the embedded software require to
-- manage the physical system is complete and installed.

with Ada.Text_IO; use Ada.Text_IO;

with Food_DataStructures; use Food_DataStructures;

with Stats_FoodDistribution; use Stats_FoodDistribution;

with Distribution_Service; use Distribution_Service;

with Food_SalesService; use Food_SalesService;

with GateKeeperService; use GateKeeperService;

procedure ProductDistributionMain is

    package INt_IO is new Ada.Text_IO.Integer_IO (Integer);
    use INt_IO;

    numProductGenerators : Positive := 1; -- number product generators.
    numPOS : Positive := 2;               -- number points of sale.

    --SalesPerson: RetailSales; -- single sales center.

begin --body ProductDistributionMain

    Put ("How many Product Generators?  ");
    Get (numProductGenerators);  -- number receiving stations.
    New_Line;
    Put ("How many points of sale?  ");
    Get (numPOS);  -- number receiving stations.
    New_Line (2);

    declare
        FarmProducts : array (1 .. numProductGenerators) of Product_Generator;
        POS          : array (1 .. numPOS) of RetailSales;
    begin
        null;
    end;

end ProductDistributionMain;
