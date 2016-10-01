`timescale 1ns/1ns
module washing_machine_tb;

	reg power;
	reg clk, door;
	wire[1:0] water;
	wire[1:0] watersavedvalue;
	wire[2:0] currentstate;
	wire[2:0] statesaved;

	washing_machine w0(.clkorig(clk), .finalwater(water), .finalfinalstate(currentstate),.power(power), .door(door));

	initial begin
		power = 1'b0;
		#10
		power = 1'b1;
		clk = 1'b0;
		door = 1'b0;
		#10
		#100 
		#4
		door = 1'b1;
		#12
		door = 1'b0;
		#100
		power = 1'b0;
		#12
		power = 1'b1;
		#100 $finish;
	end

	always begin
		#5 clk = ~clk;
	end
endmodule