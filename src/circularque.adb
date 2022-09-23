package body CircularQue is

    package IntIO is new Ada.Text_IO.Integer_IO (Integer);
    use IntIO;

    subtype slotindex is Natural range 0 .. (capacity - 1);  -- Natural implies >= 0.
    front, rear, pt : slotindex := 0;  -- insert at front, remove from rear.
    mesnum      : Natural range 0 .. (capacity - 1) := 0; -- number in buff
    box         : array (slotindex) of message; -- circular buffer
    maxMessages : Natural := capacity - 1; -- Integers >= 0.

    procedure acceptMessage (msg : in message) is
    begin
        if mesnum < maxMessages then  -- reserve space and insert msg.
            rear       := (rear + 1) mod capacity;  -- implement wrap-around.
            box (rear) := msg;
            mesnum     := mesnum + 1;
        else
            Put ("ERROR - Message rejected - queue is full!");
            New_Line (2);
        end if;
    end acceptMessage;

    procedure retrieveMessage (msg : out message) is
    begin
        if mesnum > 0 then  -- remove message if buff not empty
            front  := (front + 1) mod capacity;  -- front trails the next message by 1.  rear is the actual last msg.
            msg    := box (front);
            mesnum := mesnum - 1;
        else
            Put ("ERROR - No message in the queue to retrieve!");
            New_Line (2);
        end if;
    end retrieveMessage;

    function CircularQueEmpty return Boolean is
    begin
        if mesnum > 0 then
            return False;
        else
            return True;
        end if;
    end CircularQueEmpty;

    function CircularQueFull return Boolean is
    begin
        if mesnum < maxMessages then
            return False;
        else
            return True;
        end if;
    end CircularQueFull;

    procedure insertFront(msg : in message) is
    begin
        if mesnum < maxMessages then
            box(front) := msg;
            if front = 0 then
                front := maxMessages;
            else    
                front := front - 1;
            end if;
            mesnum := mesnum + 1;
        else
            Put ("ERROR - Message rejected - queue is full!");
            New_Line (2);
        end if;
    end insertFront;

end CircularQue;
