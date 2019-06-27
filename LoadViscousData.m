clc;

%%
foldername_C = 'FrictionData';
AllFricData = dir(foldername_C);

AllFricData(1:2) = [];

foldernumber = length(AllFricData);

%% Go to the FrictionData\Viscous folder
folderPath = fullfile(AllFricData(3).folder, AllFricData(3).name);
ViscousData = dir(folderPath);
ViscousData(1:2) = [];
ciscousFileNumebr = length(ViscousData);

%% Go to the FrictionData\Coulomb\Joints folder
% Joint-1
    ViscousDataJoint_1 = dir(fullfile(ViscousData(1).folder, ViscousData(1).name));
    ViscousDataJoint_1(1:2) = [];
    viscousFileNumberJ1 = length(ViscousDataJoint_1);
% Joint-2
    ViscousDataJoint_2 = dir(fullfile(ViscousData(2).folder, ViscousData(2).name));
    ViscousDataJoint_2(1:2) = [];
    viscousFileNumberJ2 = length(ViscousDataJoint_2);
% Joint-3
    ViscousDataJoint_3 = dir(fullfile(ViscousData(3).folder, ViscousData(3).name));
    ViscousDataJoint_3(1:2) = [];
    viscousFileNumberJ3 = length(ViscousDataJoint_3);
% Joint-4
    ViscousDataJoint_4 = dir(fullfile(ViscousData(4).folder, ViscousData(4).name));
    ViscousDataJoint_4(1:2) = [];
    viscousFileNumberJ4 = length(ViscousDataJoint_4);
% Joint-5
    ViscousDataJoint_5 = dir(fullfile(ViscousData(5).folder, ViscousData(5).name));
    ViscousDataJoint_5(1:2) = [];
    viscousFileNumberJ5 = length(ViscousDataJoint_5);    
% Joint-6
    ViscousDataJoint_6 = dir(fullfile(ViscousData(6).folder, ViscousData(6).name));
    ViscousDataJoint_6(1:2) = [];
    viscousFileNumberJ6 = length(ViscousDataJoint_6);     
    
%%
if(viscousFileNumberJ1)
    data_VJ1 = ReadViscousData(fullfile(ViscousDataJoint_1(1).folder, ViscousDataJoint_1(1).name));
    Viscous(1).Torque = data_VJ1(7:end,3);
    Viscous(1).Velocity = data_VJ1(7:end,2)*pi/180;
    Viscous(1).Velocity_neg = Viscous(1).Velocity(Viscous(1).Velocity<0);
    Viscous(1).Torque_neg = Viscous(1).Torque(Viscous(1).Torque<0);
    Viscous(1).Torque_pos =  Viscous(1).Torque(Viscous(1).Torque>0);
    Viscous(1).Velocity_pos = Viscous(1).Velocity(Viscous(1).Velocity>0);
end

if(viscousFileNumberJ2)
    data_VJ2 = ReadViscousData515(fullfile(ViscousDataJoint_2.folder, ViscousDataJoint_2.name));
    Viscous(2).Torque = data_VJ2(7:end,3);
    Viscous(2).Velocity = data_VJ2(7:end,2)*pi/180;
    Viscous(2).Velocity_neg = Viscous(2).Velocity(Viscous(2).Velocity<0);
    Viscous(2).Torque_neg = Viscous(2).Torque(Viscous(2).Torque<0);
    Viscous(2).Torque_pos = Viscous(2).Torque_neg*-1; %  Viscous(3).Torque(Viscous(3).Torque>0);
    Viscous(2).Velocity_pos =Viscous(2).Velocity_neg*-1; % Viscous(3).Velocity(Viscous(3).Velocity>0);

end

if(viscousFileNumberJ3)
    data_VJ3 = ReadViscousData515(fullfile(ViscousDataJoint_3.folder, ViscousDataJoint_3.name));
    Viscous(3).Torque = data_VJ3(7:end,3);
    Viscous(3).Velocity = data_VJ3(7:end,2)*pi/180;
    
    Viscous(3).Velocity_neg = Viscous(3).Velocity(Viscous(3).Velocity<0);
    Viscous(3).Torque_neg = Viscous(3).Torque(Viscous(3).Torque<0);
    Viscous(3).Torque_pos = Viscous(3).Torque_neg*-1; %  Viscous(3).Torque(Viscous(3).Torque>0);
    Viscous(3).Velocity_pos =Viscous(3).Velocity_neg*-1; % Viscous(3).Velocity(Viscous(3).Velocity>0);

end
if(viscousFileNumberJ4)
    data_VJ4 = ReadViscousData(fullfile(ViscousDataJoint_4.folder, ViscousDataJoint_4.name));
    Viscous(4).Torque = data_VJ4(7:end,3);
    Viscous(4).Velocity = data_VJ4(7:end,2)*pi/180;
    Viscous(4).Velocity_neg = Viscous(4).Velocity(Viscous(4).Velocity<0);
    Viscous(4).Torque_neg = Viscous(4).Torque(Viscous(4).Torque<0);
    Viscous(4).Torque_pos =  Viscous(4).Torque(Viscous(4).Torque>0);
    Viscous(4).Velocity_pos = Viscous(4).Velocity(Viscous(4).Velocity>0);
end

if(viscousFileNumberJ5)
    data_VJ5 = ReadViscousData(fullfile(ViscousDataJoint_4.folder, ViscousDataJoint_4.name));
    Viscous(5).Torque = data_VJ5(7:end,3);
    Viscous(5).Velocity = data_VJ5(7:end,2)*pi/180;
    Viscous(5).Velocity_neg = Viscous(5).Velocity(Viscous(5).Velocity<0);
    Viscous(5).Torque_neg = Viscous(5).Torque(Viscous(5).Torque<0);
    Viscous(5).Torque_pos =  Viscous(5).Torque(Viscous(5).Torque>0);
    Viscous(5).Velocity_pos = Viscous(5).Velocity(Viscous(5).Velocity>0);
end
if(viscousFileNumberJ6)
    data_VJ6 = ReadViscousData(fullfile(ViscousDataJoint_6.folder, ViscousDataJoint_6.name));
    Viscous(6).Torque = data_VJ6(7:end,3);
    Viscous(6).Velocity = data_VJ6(7:end,2)*pi/180;
    Viscous(6).Velocity_neg = Viscous(6).Velocity(Viscous(6).Velocity<0);
    Viscous(6).Torque_neg = Viscous(6).Torque(Viscous(6).Torque<0);
    Viscous(6).Torque_pos =  Viscous(6).Torque(Viscous(6).Torque>0);
    Viscous(6).Velocity_pos = Viscous(6).Velocity(Viscous(6).Velocity>0);
end

