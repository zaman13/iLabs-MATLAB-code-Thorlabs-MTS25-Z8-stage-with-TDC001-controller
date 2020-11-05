% Mohammad Asif Zaman
% Hesselink research group
% Part of iLabs 
% Sept-Oct 2020
% Code for initializing motor for Thorlabs TDC001 controller
% for Thorlabs MTS25-Z8 stage

function yout = motor_init(serial_num, timeout_val)


% Install Kinesis before running the code
% (https://www.thorlabs.com/newgrouppage9.cfm?objectgroup_id=10285)


%Example for programming the Thorlabs TDC001 with Kinesis in MATLAB, with PRM1-Z8 stage.

%Load assemblies
%Point to appropriate directory/folder if the driver is installed on a
%different location

NET.addAssembly('C:\Program Files\Thorlabs\Kinesis\Thorlabs.MotionControl.DeviceManagerCLI.dll');
NET.addAssembly('C:\Program Files\Thorlabs\Kinesis\Thorlabs.MotionControl.GenericMotorCLI.dll');
NET.addAssembly('C:\Program Files\Thorlabs\Kinesis\Thorlabs.MotionControl.TCube.DCServoCLI.dll');

%Initialize Device List
import Thorlabs.MotionControl.DeviceManagerCLI.*
import Thorlabs.MotionControl.GenericMotorCLI.*
import Thorlabs.MotionControl.TCube.DCServoCLI.*

%Initialize Device List
DeviceManagerCLI.BuildDeviceList();
DeviceManagerCLI.GetDeviceListSize();

%Should change the serial number below to the one being used.
% serial_num='83840854';


%Set up device and configuration
device = Thorlabs.MotionControl.TCube.DCServoCLI.TCubeDCServo.CreateTCubeDCServo(serial_num);
% device = TCubeDCServo.CreateTCubeDCServo(serial_num);
device.Connect(serial_num);
device.WaitForSettingsInitialized(5000);

% configure the stage
motorSettings = device.LoadMotorConfiguration(serial_num);
motorSettings.DeviceSettingsName = 'Z825B';
% update the RealToDeviceUnit converter
motorSettings.UpdateCurrentConfiguration();

% push the settings down to the device
MotorDeviceSettings = device.MotorDeviceSettings;
device.SetSettings(MotorDeviceSettings, true, false);

device.StartPolling(250);

pause(1); %wait to make sure device is enabled

device.Home(timeout_val);
fprintf('Motor homed.\n');

yout = device;   % return motor object
end

