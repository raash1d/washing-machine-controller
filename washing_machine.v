`timescale 1ns/1ns
module washing_machine(clkorig, finalwater, finalfinalstate,power, door);

	input  power, clkorig, door;
	output reg[2:0]  finalfinalstate;
	reg[2:0] currentstate;
	reg increment;
	wire clk, door;
	// MSB = hot water, LSB = cold water
	output reg[1:0]  finalwater;
	reg[1:0] currentwater;

	//Off = 000s
	//Idle = 001
	//Wash_fill = 010
	//Wash_agitate = 011
	//Wash_spin = 100
	//Rinse_fill = 101
	//Rinse_agitate = 110
	//Rinse_spin = 111

	localparam Off = 3'h0;
	localparam Idle = 3'h1;
	localparam Wash_fill = 3'h2;
	localparam Wash_agitate = 3'h3;
	localparam Wash_spin = 3'h4;
	localparam Rinse_fill = 3'h5;
	localparam Rinse_agitate = 3'h6;
	localparam Rinse_spin = 3'h7;

	assign clk = clkorig&power;

	always@(posedge clk or negedge power or posedge door) begin// or negedge power or posedge door or posedge (~door))
		if(~power) begin
			increment <= 1'b0;
			finalfinalstate <= Off;
			finalwater <= 2'h0;
		end
		
		else begin
			if(door == 1'b0) begin
				case (increment)
					1'b1: begin
							case (finalfinalstate)
								Off: begin currentstate = Idle; currentwater = 2'h0; end
								Idle: begin currentstate = Wash_fill; currentwater = 2'h2; end
								Wash_fill: begin currentstate = Wash_agitate; currentwater = 2'h2; end
								Wash_agitate: begin currentstate = Wash_spin; currentwater = 2'h2; end
								Wash_spin: begin currentstate = Rinse_fill; currentwater = 2'h1; end
								Rinse_fill: begin currentstate = Rinse_agitate; currentwater = 2'h1; end 
								Rinse_agitate: begin currentstate = Rinse_spin; currentwater = 2'h1; end
								Rinse_spin: begin currentstate = Idle; currentwater = 2'h0; end
								default: begin currentstate = Idle; currentwater = 2'h0; end
							endcase
						end
					1'b0: begin
							case (finalfinalstate)
							  Off: begin currentstate = Idle; currentwater = 2'h0; end
								Idle: begin currentstate = Idle; currentwater = 2'h0; end
								Wash_fill: begin currentstate = Wash_fill; currentwater = 2'h2; end
								Wash_agitate: begin currentstate = Wash_agitate; currentwater = 2'h2; end
								Wash_spin: begin currentstate = Wash_spin; currentwater = 2'h2; end
								Rinse_fill: begin currentstate = Rinse_fill; currentwater = 2'h1; end
								Rinse_agitate: begin currentstate = Rinse_agitate; currentwater = 2'h1; end
								Rinse_spin: begin currentstate = Rinse_spin; currentwater = 2'h1; end
								default: begin currentstate = Idle; currentwater = 2'h0; end
							endcase
						end
					default: begin end
				endcase
				finalfinalstate <= currentstate;
				finalwater <= currentwater;
				increment <= 1'b1;
			end
			
			else begin
				finalfinalstate <= Idle;
			end
		end
	end
endmodule