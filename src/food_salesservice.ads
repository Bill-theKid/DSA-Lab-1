-- The software suite consists of Product Distribution Main,
-- Food_DataStructures, Stats_FoodDistribution, GateKeeperService,
-- Distribution_Service, CircularQue and Food_SalesService.
--
-- The specification require the ability to create multiple points of sale.
--

with Food_DataStructures;  --use Food_DataStructures;
with Stats_FoodDistribution; use Stats_FoodDistribution;

package Food_SalesService is
    task type RetailSales;
    --task RetailSales;  -- May used if only a single point of sales is required.
end Food_SalesService;
