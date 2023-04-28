--
--  Copyright 2021 (C) Jeremy Grosser
--
--  SPDX-License-Identifier: BSD-3-Clause
--
with RP.Device;
with RP.Clock;
with RP.GPIO; use RP.GPIO;
with Pico;
with RP_Interrupts;

procedure Main with SPARK_Mode is

   subtype Pin_Type is Natural range 0 .. 29;

   procedure Lemma (a : Pin_Type)
     with Pre => a >= 0 and then a < 30,
     Post => (2 ** a) <= (2 ** 30) - 1,
   Ghost;

   procedure Lemma (a : Pin_Type) is
      begin
   null;
   end Lemma;

begin
   RP.Clock.Initialize (Pico.XOSC_Frequency);
   pragma Assert (GPIO_Pin'Pos (Pico.GP25.Pin) < 30);
   pragma Assert (2 ** GPIO_Pin'Pos (Pico.GP25.Pin) > 0);
   pragma Assert (2 ** (30 - GPIO_Pin'Pos (Pico.GP25.Pin)) > 1);
   --  pragma Assert ((2 ** 30) / (2 ** GPIO_Pin'Pos (Pico.GP25.Pin)) > 1);
   Lemma (GPIO_Pin'Pos (Pico.GP25.Pin));
   Pico.LED.Configure (RP.GPIO.Output);
   RP.Device.Timer.Enable;
   loop
      Pico.LED.Toggle;
      RP.Device.Timer.Delay_Milliseconds (100);
   end loop;
end Main;
