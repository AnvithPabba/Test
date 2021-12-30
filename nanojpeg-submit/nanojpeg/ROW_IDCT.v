module ROW_IDCT( input clk,
                input signed [31:0] blk [0:7],
                output signed [31:0] outputdata [0:7]
               );
    
    integer W1 = 2841;
    integer W2 = 2676;
    integer W3 = 2408;
    integer W5 = 1609;
    integer W6 = 1108;
    integer W7 = 565;
    reg signed [31:0] x [0:8];
    //integer i;
    
    reg signed [31:0] out [0:7];
    assign outputdata [0:7] = out[0:7]; //assigning output
    
    
    
    always @(*)
        begin 
           
            
           
            if (!(blk[4]<<<11|blk[6]|blk[2]|blk[1]|blk[7]|blk[5]|blk[3]))
                begin 
                    out[0] = blk[0]<<<3;
                    out[1] = blk[0]<<<3;
                    out[2] = blk[0]<<<3;
                    out[3] = blk[0]<<<3;
                    out[4] = blk[0]<<<3;
                    out[5] = blk[0]<<<3;
                    out[6] = blk[0]<<<3;
                    out[7] = blk[0]<<<3;
                end
            else begin
                x[1] = blk[4] <<< 11;
                x[2] = blk[6];
                x[3] = blk[2];
                x[4] = blk[1];
                x[5] = blk[7];
                x[6] = blk[5];
                x[7] = blk[3];
    
                x[0] = (blk[0] <<< 11) + 128;
                x[8] = W7 * (x[4] + x[5]);
                x[4] = x[8] + (W1 - W7) * x[4];
                x[5] = x[8] - (W1 + W7) * x[5];
                x[8] = W3 * (x[6] + x[7]);
                x[6] = x[8] - (W3 - W5) * x[6];
                x[7] = x[8] - (W3 + W5) * x[7];
                x[8] = x[0] + x[1];
                x[0] = x[0]-x[1];
                x[1] = W6 * (x[3] + x[2]);
                x[2] = x[1] - (W2 + W6) * x[2];
                x[3] = x[1] + (W2 - W6) * x[3];
                x[1] = x[4] + x[6];
                x[4] = x[4]-x[6];
                x[6] = x[5] + x[7];
                x[5] = x[5]-x[7];
                x[7] = x[8] + x[3];
                x[8] = x[8]-x[3];
                x[3] = x[0] + x[2];
                x[0] = x[0]-x[2];
                x[2] = (181 * (x[4] + x[5]) + 128) >>> 8;
                x[4] = (181 * (x[4] - x[5]) + 128) >>> 8;
                out[0] = (x[7] + x[1]) >>> 8;
                out[1] = (x[3] + x[2]) >>> 8;
                out[2] = (x[0] + x[4]) >>> 8;
                out[3] = (x[8] + x[6]) >>> 8;
                out[4] = (x[8] - x[6]) >>> 8;
                out[5] = (x[0] - x[4]) >>> 8;
                out[6] = (x[3] - x[2]) >>> 8;
                out[7] = (x[7] - x[1]) >>> 8;
            end
        end
endmodule