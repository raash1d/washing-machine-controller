# Washing Machine Controller
- Design specification of a finite state machine (FSM) to control a fully automatic washing machine.
- The washing machine uses hot water to wash and cold water to rinse, this is handled in the FSM states to control the two water valves, accordingly.
- The FSM is robust and it has been designed to handle accidents such as power loss in the middle of a cycle.

    - The machine goes to an _idle_ stage in such situations.
    - Washing cycle is restarted from _idle_ once power is restored.

- __Future enhancements:__
    - Resume washing cycle from the state when the power was lost.
    - Handle situation when the door is opened in the middle of a cycle.
    - Resume washing cycle when the door is closed
> - Possible solution would be to store state into a memory as soon as it starts

## Language used
- ___Verilog:___ C like HDL is easier to comprehend and saves design time since the syntax is more concise that VHDL

## Tools used
- ___NCSim:___ To compile and check logic design
- ___Synopsys Design Compiler:___ To obtain the synthesized netlist from the design

## Washing cycle stages (FSM states)
The FSM states were defined as binary values using 3 bits since there were only 6 number of stages in this system. 3 bits allow the definition of 8 stages, hence 2 binary values are available for utilization in features introduced in future.
The stages are:
1. ___Idle___ `(0x000)`
2. ___Wash fill___ `(0x001)`
3. ___Wash agitate___ `(0x010)`
4. ___Wash spin___ `(0x011)`
5. ___Rinse fill___ `(0x100)`
6. ___Rinse agitate___ `(0x101)`
> - Planning to modify to gray code since it saves the number of transitioning bits and hence saves circuit from being glitchy
> - Possibility is that extra circuitry will increase size of system, but the size-to-glitch
