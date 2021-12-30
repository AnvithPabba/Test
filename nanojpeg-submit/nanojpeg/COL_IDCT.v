module COL_IDCT( input clk,
                input signed [31:0] col_idct_ip[0:7],
                output signed [31:0] col_idct_op[0:8]
                );
    reg signed [31:0] x [0:8];
    reg signed [31:0] y [0:8];
    integer W1 = 2841;
    integer W2 = 2676;
    integer W3 = 2408;
    integer W5 = 1609;
    integer W6 = 1108;
    integer W7 = 565;
    assign col_idct_op [0:8] = y[0:8];
    always @(*)
        begin
            x[0] = col_idct_ip[0];
            x[1] = col_idct_ip[1];
            x[2] = col_idct_ip[2];
            x[3] = col_idct_ip[3];
            x[4] = col_idct_ip[4];
            x[5] = col_idct_ip[5];
            x[6] = col_idct_ip[6];
            x[7] = col_idct_ip[7];
            x[0] = (x[0] <<< 8) + 8192;
            x[8] = W7 * (x[4] + x[5]) + 4;
            x[4] = (x[8] + (W1 - W7) * x[4]) >>> 3;
            x[5] = (x[8] - (W1 + W7) * x[5]) >>> 3;
            x[8] = W3 * (x[6] + x[7]) + 4;
            x[6] = (x[8] - (W3 - W5) * x[6]) >>> 3;
            x[7] = (x[8] - (W3 + W5) * x[7]) >>> 3;
            x[8] = x[0] + x[1];
            x[0] = x[0]-x[1];
            x[1] = W6 * (x[3] + x[2]) + 4;
            x[2] = (x[1] - (W2 + W6) * x[2]) >>> 3;
            x[3] = (x[1] + (W2 - W6) * x[3]) >>> 3;
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
            y[0] = x[0];
            y[1] = x[1];
            y[2] = x[2];
            y[3] = x[3];
            y[4] = x[4];
            y[5] = x[5];
            y[6] = x[6];
            y[7] = x[7];
            y[8] = x[8];
        end
endmodule