with RP_Interrupts;

package Console is

    procedure Configure;

    procedure Get
        (Ch : out Character);

    procedure Put
        (Ch : Character);

private

    procedure Interrupt
        (Id : RP_Interrupts.Interrupt_ID);

end Console;
