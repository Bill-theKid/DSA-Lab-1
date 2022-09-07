--with Ada.Text_IO; use Ada.Text_IO;

--
-- The software suite consists of ProductDistributionMain,
-- Food_DataStructures, Stats_FoodDistribution, GateKeeperService,
-- Distribution_Service, CircularQue and Food_SalesService.
--
-- With the exception of ProductDistributionMain this suite represents the software
-- to manage an "embedded" planetary system food receiving and distribution system.
-- The Distribution_Service module will be discarded once the embedded software required to
-- manage the physical system is complete and installed.
--

with Ada.Numerics.Float_Random, Ada.Text_IO, Ada.Float_Text_IO,
   Ada.Integer_Text_IO;
use Ada.Numerics.Float_Random, Ada.Text_IO, Ada.Float_Text_IO,
   Ada.Integer_Text_IO;

with Food_DataStructures; use Food_DataStructures;

package Stats_FoodDistribution is
--
-- Use 1.0 seconds of real time to simulate passage of 1 hour simulated time.
--
    my_Generator : Generator;

-- Exponential distribution using interpolation and famous data points from early IBM
-- Fortran statistical packages.
    function Next_Exponential return Float;

-- Time requried to arrange raw food packets for sale.
    function PrepareGrainVegetableFood_PackforSales return Duration;

    function PrepareMeatFood_PackforSales return Duration;

end Stats_FoodDistribution;
