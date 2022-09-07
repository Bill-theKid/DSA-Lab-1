--with Food_DataStructures;  use Food_DataStructures;
--with Stats_FoodDistribution;  use Stats_FoodDistribution;
with Food_DataStructures; use Food_DataStructures;
with GateKeeperService;   use GateKeeperService;

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Numerics.Float_Random, Ada.Text_IO, Ada.Float_Text_IO, Ada.Integer_Text_IO;
use Ada.Numerics.Float_Random, Ada.Text_IO, Ada.Float_Text_IO, Ada.Integer_Text_IO;

package body Distribution_Service is

    --package MyGateKeeper is new GateKeeperService( 4 );  use MyGateKeeper;

    task body Product_Generator is  -- task body
        RandFloatGenerator : Generator; -- Has own generator default seed.
        randFloat          : Float;

        newFood : Food_Pack;

        nextArrivalDelay : Float;

    begin
        -- Start the simulation with an arriving vessel.
        loop
            --put("In Product_Generator of DistributionServices."); new_line(2);

            setFood_PackFoodType (newFood, Food_DataStructures.RandomFoodType);
            if getFood_PackFoodType (newFood) in GrainVegetable then
                setFood_PackShipment
                   (newFood, 'B');  -- 'B' for basic Grain or vegetable.
            else
                setFood_PackShipment (newFood, 'M');  -- 'M' for meat.
            end if;

            if getFood_PackFoodType (newFood) in GrainVegetable then
                delay (PrepareGrainVegetableFood_PackforSales);
            else
                delay (PrepareMeatFood_PackforSales);
            end if;

            PrintFood_PackShipment (newFood);
            Put (" delivered. ");
            New_Line (2);

            -- Blocking request for service.  We are placed at the rear of the queue "Insert"
            -- associated with the task "GateKeeper" and moved from the run state to the waits
            -- state by the OS.  We will not be eligible for execution again until "Insert" exits
            -- the rendezvous.

            GateKeeper.acceptMessage (newFood);

            -- Schedule arrival of next star ship exponentially distributed over 1.534 seconds (hours).
            -- Time in Ada is of type "duration" defined in package Calendar.
            -- Cast/coerce floating calcultion "Random(RandFloatGenerator)* 3.534" to duration.
            nextArrivalDelay :=
               Next_Exponential; --Put("**** Next exp "); put(nextArrivalDelay);

            nextArrivalDelay :=
               nextArrivalDelay *
               1.534;  -- Food cargo vessels arrive every 1.534 hours
            Put ("Next grain shipment arrives ");
            Put (nextArrivalDelay);
            Put (" Time units!"); -- exponentially distributed.
            New_Line (2);

            -- Schedule the random arrival of the next cargo ship exponentially distributed (Poission Distribution).
            -- Sleep till next ship arrives by casting float to duration.
            delay Standard.Duration (nextArrivalDelay);

        end loop;

    end Product_Generator;

end Distribution_Service;
