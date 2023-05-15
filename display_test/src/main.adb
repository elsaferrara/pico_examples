with HAL;        use HAL;
with HAL.GPIO;   use HAL.GPIO;
with RP.GPIO;    use RP.GPIO;
with RP.Clock;
with Pico;
with Pico.Pimoroni.Display;
with Pico.Pimoroni.Display.Buttons;
with RP.Device;

procedure Main is

begin
   RP.Clock.Initialize (Pico.XOSC_Frequency);
   RP.Device.Timer.Enable;
   Pico.Pimoroni.Display.Initialize;




   Pico.Pimoroni.Display.Set_Color (Pico.Pimoroni.Display.Red);
   Pico.Pimoroni.Display.Fill_Circle ((55,15), 5);

      Pico.Pimoroni.Display.Set_Color (Pico.Pimoroni.Display.Gold);
   Pico.Pimoroni.Display.Fill_Circle ((200,40), 15);

      Pico.Pimoroni.Display.Set_Color (Pico.Pimoroni.Display.Pink);
   Pico.Pimoroni.Display.Fill_Circle ((60,60), 30);

         Pico.Pimoroni.Display.Set_Color (Pico.Pimoroni.Display.Turquoise);
   Pico.Pimoroni.Display.Fill_Circle ((150,90), 35);

   --     for Pxl in Pico.Pimoroni.Display.Pixel range 0 .. 10_799 loop
   --     Pico.Pimoroni.Display.Set (Pxl, 16#ff#, 16#00#, 16#d4#);
   --     end loop;
   --
   --     for Pxl in Pico.Pimoroni.Display.Pixel range 10_800 .. 21_599 loop
   --     Pico.Pimoroni.Display.Set (Pxl, 16#ff#, 16#00#, 16#aa#);
   --     end loop;
   --
   --      for Pxl in Pico.Pimoroni.Display.Pixel range 21_600 .. 32_399 loop
   --        Pico.Pimoroni.Display.Set (Pxl, 16#ff#, 16#00#, 16#7c#);
   --     end loop;
   --
   --     Pico.Pimoroni.Display.Petit_Carre (15_801, 16#00#, 16#00#, 16#00#);
   loop
   --     if Pico.Pimoroni.Display.Buttons.Just_Pressed (Pico.Pimoroni.Display.Buttons.A) then
   --        for Pxl in Pico.Pimoroni.Display.Pixel range 10_800 .. 21_599 loop
   --           Pico.Pimoroni.Display.Set (Pxl, 16#00#, 16#00#, 16#00#);
   --        end loop;
   --     end if;
      --  Pico.GP12.Get (Result);
      --  if Result then
      --     for Pxl in Pico.Pimoroni.Display.Pixel range 10_800 .. 21_599 loop
      --        Pico.Pimoroni.Display.Set (Pxl, 16#00#, 16#00#, 16#00#);
      --     end loop;
      --     end if;
      --  if Pico.Pimoroni.Display.Buttons.Just_Released (Pico.Pimoroni.Display.Buttons.A) then
      --     for Pxl in Pico.Pimoroni.Display.Pixel range 10_800 .. 21_599 loop
      --        Pico.Pimoroni.Display.Set (Pxl, 16#ff#, 16#00#, 16#aa#);
      --     end loop;
      --  end if;

      Pico.Pimoroni.Display.Update;
      Pico.Pimoroni.Display.Buttons.Poll_Buttons;
      RP.Device.Timer.Delay_Milliseconds (100);

      --  RP.Device.Timer.Delay_Milliseconds (100);
   end loop;
end Main;
