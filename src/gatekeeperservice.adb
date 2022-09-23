with Ada.Text_IO; use Ada.Text_IO;
with Ada.Calendar; use Ada.Calendar;

package body GateKeeperService is

    package IntegerIO is new Ada.Text_IO.Integer_IO(Integer);
    use IntegerIO;

    task body GateKeeper is

        package CircularQueue is new CircularQue(Food_Pack, 2); -- default size 10.
        use CircularQueue;

        rejected : Integer := 0;
        total_packs : Integer := 0;
        meat_packs : Integer := 0;
        other_packs : Integer := 0;
        -- Declare food packet counters here.

        Start_Time : Ada.Calendar.Time;
        End_Time : Ada.Calendar.Time;

    begin

        delay 0.5;  -- allow 1/2 hour to initialize facility.
        Start_Time := Ada.Calendar.Clock;
        End_Time := Start_Time + 1.0 * 8.0 * 5.0; 
        -- 1.0 sec./hour * 8 hours/days * 5 days

        -- Terminate after losing 5 customers or time to close has arrived.
        while rejected < 5 and Ada.Calendar.Clock < End_Time
        loop  -- Terminate after losing 5 customers

            -- In Ada, a "select" statement with multiple "or" options must uniformly
            -- process (randomly) the "accept" statements.  This prevents any single
            -- "accept" from starving the others from service.
            --
            -- Rules for "Select":
            -- 1) If no task are waiting for service, the task sleeps.  Wakes when any “accept” is requested.
            -- 2) If only one of the "accept" entries has a task waiting that task is served.
            -- 3) If sleeping and a task or tasks arrive simultaneously, awake a service the
            --    the first arrival.
            -- 4) If multiple "accepts" have task waiting, service them in random order
            --    to prevent starvation.
            --

            select
                -- new arrivals of food
                accept acceptMessage(newFood : in Food_Pack) do
                    if not (circularQueFull) then
                        -- if getFood_PackFoodType(newFood) in GrainVegetable then
                            CircularQueue.acceptMessage(newFood);
                            Put("GateKeeper insert accepted ");
                            PrintFood_Pack(newFood);
                            New_Line;
                        --  else 
                        --      CircularQueue.insertFront(newFood);
                        --      Put("Gatekeeper insertFront accepted ");
                        --      PrintFood_Pack(newFood);
                        --      New_Line;
                        --  end if;
                    else
                        rejected := rejected + 1;
                        Put(" Rejected by GateKeeper: ");
                        New_Line;
                        PrintFood_Pack(newFood);
                        New_Line;
                        Put(" Rejected = ");
                        Put(rejected);
                        Put(". Sent to another distribution facility!");
                        New_Line(3);
                    end if;
                end acceptMessage;
            or
                -- Accept request for distribution from sales
                accept retrieveMessage(newFood : out Food_Pack; availableForShipment : out Boolean)
                do
                    availableForShipment := False;
                    if not (CircularQueue.circularQueEmpty) then
                        availableForShipment := True;
                        CircularQueue.retrieveMessage(newFood);
                        PrintFood_Pack(newFood);
                        Put(" Removed by GateKeeper for shipment.");
                        New_Line;
                        if (getFood_PackFoodType(newFood) < Steak) then
                            other_packs := other_packs + 1;
                        elsif (getFood_PackFoodType(newFood) >= Steak) then
                            meat_packs := meat_packs + 1;
                        end if;
                        total_packs := total_packs + 1;
                    end if;
                end retrieveMessage;
            end select;

            delay 1.1; -- Complete overhead due to accepting or rejecting a request prior to new iteration.
        end loop;

        -- print time in service, statistics such as number of meat food packets processed , non-meat products processed,
        -- and number of arriving food vessels rejected.
        New_Line(2);
        Put("Hours of operation prior to closing: ");
        Ada.Text_IO.Put_Line(Duration'Image(Ada.Calendar.Clock - Start_Time));
        Put("Meat Packs Processed: ");
        Ada.Text_IO.Put_Line(Integer'Image(meat_packs));
        Put("Non-meat Packs Processed: ");
        Ada.Text_IO.Put_Line(Integer'Image(other_packs));
        Put("Total Packets Processed: ");
        Ada.Text_IO.Put_Line(Integer'Image(total_packs));
        New_Line (2);

    end GateKeeper;
end GateKeeperService;
