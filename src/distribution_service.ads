-- The software suite consists of Product Distribution Main,
-- Food_DataStructures, Stats_FoodDistribution, GateKeeperService,
-- Distribution_Service, CircularQue and Food_SalesService.
--
-- With the exception of ProductDistributionMain this suite represents the software
-- to manage an "embedded" planetary system food receiving and distribution system.
-- The Distribution_Service moduke will be discarded once the embedded software require to
-- manage the physical system is complete and installed.
--
-- This package simulates the arrival of food packets for the GateKeeper Service storage facility.
-- Food_Packs are removed from interplanetary shipping crates by the GateKeeper
-- and repacked into smaller Food_Packs more appropriate for handling at their final destination
-- planet. The GateKeepr provides the new Food_Packs Food_SalesService points-of-sale for
-- disbursement.
--
-- This task will be discarded in the final implementation as real cargo vessels will contact the
-- GateKeeper directly to take their loads.

with Food_DataStructures;    use Food_DataStructures;
with Stats_FoodDistribution; use Stats_FoodDistribution;

package Distribution_Service is

    task type Product_Generator;

end Distribution_Service;
