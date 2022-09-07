-- The software suite consists of ProductDistributionMain,
-- Food_DataStructures, Stats_FoodDistribution, GateKeeperService,
-- Distribution_Service, CircularQue and Food_SalesService.
--
-- With the exception of ProductDistributionMain this suite
-- represents the software to manage an "embedded" planetary system
-- food receiving and distribution system. The Distribution_Service
-- module will be discarded once the embedded software required to
-- manage the physical system is complete and installed.
--
-- The GagteKeeper accepts Food_Packs frfom inter-galatic transports
-- and repacks them into Food_Packs suitable for Food_SalesService to
-- distribute to the planets in the system.  Food_Packs are removed
-- from the default FIFO queue associated with the "accept" statement
-- and stored in a circular queue for distribution.

with Food_DataStructures;    use Food_DataStructures;
with Stats_FoodDistribution; use Stats_FoodDistribution;
with CircularQue;

package GateKeeperService is

    task GateKeeper is
        -- accept Food_Packs from interplanetary vesssels.
        entry acceptMessage (newFood : in Food_Pack);

        --Allow sals to retrive the repackaged Food_Packs.
        entry retrieveMessage
           (newFood : out Food_Pack; availableForShipment : out Boolean);

    end GateKeeper;

end GateKeeperService;
