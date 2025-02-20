--
--  Copyright 2021 (C) Jeremy Grosser
--
--  SPDX-License-Identifier: BSD-3-Clause
--
with HAL.GPIO;   use HAL.GPIO;
with HAL.UART;   use HAL.UART;
with HAL.Time;
with RP.Device;  use RP.Device;
with RP.GPIO;    use RP.GPIO;
with RP.UART;
with RP.Clock;
with RP.Timer.Interrupts;
with Pico;

procedure Main with SPARK_Mode is
   Test_Error : exception;
   UART    : RP.UART.UART_Port renames RP.Device.UART_0;
   UART_TX : RP.GPIO.GPIO_Point renames Pico.GP16;
   UART_RX : RP.GPIO.GPIO_Point renames Pico.GP17;
   Buffer  : UART_Data_8b (1 .. 1) with Relaxed_Initialization;
   Status  : UART_Status;

   procedure Send_Break is new RP.UART.Send_Break (RP.Timer.Interrupts.Delay_Microseconds);

   procedure Send_Hello is
      Hello       : constant String := "Hello Pico !" & ASCII.CR & ASCII.LF;
      Hello_Bytes : UART_Data_8b (1 .. Hello'Length);
   begin
      for I in Hello'Range loop
         Hello_Bytes (I) := Character'Pos (Hello (I));
      end loop;

      UART.Transmit (Hello_Bytes, Status);
      if Status /= Ok then
         raise Test_Error with "Send_Hello transmit failed with status " & Status'Image;
         pragma Annotate (GNATprove, Intentional,"exception might be raised", "Ignoring exception for now");
      end if;
   end Send_Hello;

   procedure Echo is
   begin
      loop
         UART.Receive (Buffer, Status, Timeout => 0);
         case Status is
            when Err_Error =>
               raise Test_Error with "Echo receive failed with status " & Status'Image;
               pragma Annotate (GNATprove, Intentional,"exception might be raised", "Ignoring exception for now");
            when Err_Timeout =>
               raise Test_Error with "Unexpected Err_Timeout with timeout disabled!";
               pragma Annotate (GNATprove, Intentional,"exception might be raised", "Ignoring exception for now");
            when Busy =>
               raise Test_Error with "Unexpected Busy status in UART receive";
               pragma Annotate (GNATprove, Intentional,"exception might be raised", "Ignoring exception for now");
            when Ok =>
               UART.Transmit (Buffer, Status);
               if Status /= Ok then
                  raise Test_Error with "Echo transmit failed with status " & Status'Image;
                  pragma Annotate (GNATprove, Intentional,"exception might be raised", "Ignoring exception for now");
               end if;
               Pico.LED.Toggle;
         end case;
      end loop;
   end Echo;
begin
   RP.Clock.Initialize (Pico.XOSC_Frequency);
   RP.Clock.Enable (RP.Clock.PERI);
   RP.Device.Timer.Enable;
   RP.GPIO.Enable;
   Pico.LED.Configure (Output);
   Pico.LED.Set;

   --  I don't know if the pull up is needed, but it doesn't hurt?
   UART_TX.Configure (Output, Pull_Up, RP.GPIO.UART);
   UART_RX.Configure (Input, Floating, RP.GPIO.UART);
   UART.Configure
      (Config =>
         (Baud      => 115_200,
          Word_Size => 8,
          Parity    => False,
          Stop_Bits => 1,
          others    => <>));

   Send_Hello;
   Send_Break (UART, UART.Frame_Time * 2);
   Echo;
end Main;
