% Mohammad Asif Zaman
% Hesselink research group
% Part of iLabs 
% Sept-Oct 2020


% Matlab code for driving Thorlabs MTS25-Z8 25mm stage with Thorlabs TDC001
% DC servo controller
% MTS25-Z8: https://www.thorlabs.com/thorproduct.cfm?partnumber=MTS25-Z8
% TDC001: https://www.thorlabs.com/thorproduct.cfm?partnumber=TDC001

% References: https://www.mathworks.com/matlabcentral/fileexchange/66497-driver-for-thorlabs-motorized-stages


clear all;
close all;
clc;
timeout_val=60000;

% Serial number on the TDC controller
serial_num='83840854';


% Create motor object
motor1 = motor_init(serial_num, timeout_val);


% Sample forward motion loop code

%Move to unit 25mm with steps of 5mm
for m = 0:5:25
    motor1.MoveTo(m, timeout_val);
    pause(1);
    pos = System.Decimal.ToDouble(motor1.Position);
    fprintf('The motor position is %d.\n',pos);
    
end

% Move in the reverse direction with steps of 5mm
for m = 0:5:25
    motor1.MoveTo(25-m, timeout_val);
    pause(1);
    pos = System.Decimal.ToDouble(motor1.Position);
    fprintf('The motor position is %d.\n',pos);
    
end



%Disconnect motor

motor1.StopPolling()
motor1.Disconnect()