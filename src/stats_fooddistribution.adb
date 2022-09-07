--%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-- Generate exponentially distributed random deviates 0.0 <= x <= 1.0.
-- The function is used to generate random arrivals at the repair
-- facility by "Ship_Generator" multiplied by the average arrival time.
--
-- The data points used to generate the deviates became famous
-- due to their use in IBM's FORTRAN compilers in the 1960's.
--
-- The exponential distribution is used to predict random events (Poisson)
-- as the probability of the next event occurring increases the longer it
-- gets since the last event occured.  Examples: a) A car arriving at
-- an intersection. b) A shopper entering a store.

package body Stats_FoodDistribution is  -- Step function

    -- 33.3% of grain/vegetable food packs require 0.25 hours preparation for sales.
    -- 56.7% of grain/vegetable food packs require 0.66 hours preparation for sales.
    -- 10% of food packs are damaged and require 0.75 hours preparations for sales.
    --
    function PrepareGrainVegetableFood_PackforSales return Duration
    is -- Step function.
        randFloat : Float;
    begin
        randFloat := Random (my_Generator); -- 0.0 <= randFloat <= 1.0.
        if randFloat <= 0.333 then
            return Duration (0.25);
        else
            if randFloat <= 0.9 then
                return Duration (0.66);
            else
                return Duration (0.75); -- broken pallet of food.
            end if;
        end if;
    end PrepareGrainVegetableFood_PackforSales;

    --
    -- 33.3% of meat food packs require 0.25 hours preparation for sales.
    -- 53.4% of meat food packs require 0.4 hours preparation for sales.
    -- 13.3% of food packs are damaged and require 1.0 hours preparations for sales.
    --
    function PrepareMeatFood_PackforSales return Duration is -- Step function.
        randFloat : Float;
    begin
        randFloat := Random (my_Generator); -- 0.0 <= randFloat <= 1.0.
        if randFloat <= 0.333 then
            return Duration (0.25); --
        elsif randFloat <= 0.867 then
            return Duration (0.4);
        else
            return Duration (1.0); -- damaged shipment of meat
        end if;
    end PrepareMeatFood_PackforSales;

--&&&&&&&&&&  Plot of points (Xj, Yj) for j in range 0.0. to 1.0. with interpolation.
    function Next_Exponential return Float is
        x : Float;
    begin
        x :=
           Random (my_Generator); -- Return next exponential arrival interval.
        if x = 0.0 then -- Mean arrival time = 1.
            return 0.0;
        elsif x <= 0.1 then
            return ((x - 0.0) * 1.04 + 0.0);
        elsif x <= 0.2 then
            return ((x - 0.1) * 1.18 + 0.104);
        elsif x <= 0.3 then
            return ((x - 0.2) * 1.33 + 0.222);
        elsif x <= 0.4 then
            return ((x - 0.3) * 1.54 + 0.355);
        elsif x <= 0.5 then
            return ((x - 0.4) * 1.81 + 0.509);
        elsif x <= 0.6 then
            return ((x - 0.5) * 2.25 + 0.690);
        elsif x <= 0.7 then
            return ((x - 0.6) * 2.85 + 0.915);
        elsif x <= 0.75 then
            return ((x - 0.70) * 3.60 + 1.2);
        elsif x <= 0.8 then
            return ((x - 0.75) * 4.40 + 1.38);
        elsif x <= 0.84 then
            return ((x - 0.8) * 5.75 + 1.60);
        elsif x <= 0.88 then
            return ((x - 0.84) * 7.25 + 1.83);
        elsif x <= 0.9 then
            return ((x - 0.88) * 9.00 + 2.12);
        elsif x <= 0.92 then
            return ((x - 0.90) * 11.0 + 2.30);
        elsif x <= 0.94 then
            return ((x - 0.92) * 14.5 + 2.52);
        elsif x <= 0.95 then
            return ((x - 0.94) * 18.0 + 2.81);
        elsif x <= 0.97 then
            return ((x - 0.95) * 30.0 + 2.99);
        elsif x <= 0.97 then
            return ((x - 0.96) * 30.0 + 3.20);
        elsif x <= 0.98 then
            return ((x - 0.97) * 40.0 + 3.50);
        elsif x <= 0.99 then
            return ((x - 0.98) * 70.0 + 3.90);
        elsif x <= 0.995 then
            return ((x - 0.99) * 140.0 + 4.60);
        elsif x <= 0.998 then
            return ((x - 0.995) * 300.0 + 5.30);
        elsif x <= 0.999 then
            return ((x - 0.998) * 800.0 + 6.20);
        else
            return ((x - 0.999_7) * 1_000.0 + 8.0);
        end if;
    end Next_Exponential;

end Stats_FoodDistribution;
