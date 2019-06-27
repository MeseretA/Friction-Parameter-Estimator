%%
clear all;
close all;
clc;
% clearvars -except data

%%
windowWidth = 50; % Whatever you want.
kernel = ones(windowWidth,1) / windowWidth;
% out = filter(kernel, 1, yourInputSignal);
%%
foldername = 'RealtimeData_joint1_secondtrial\';
myfile = dir(foldername);
myfile(1:2) = [];

myfilenumber = length(myfile);

for n = 1:myfilenumber
    for j = 1:6
       mydata = READcsvDATA(fullfile(myfile(n).folder, myfile(n).name));
        joint(n,j).q = filter(kernel, 1, mydata(:,j+2)*180/pi);
        joint(n,j).qd = filter(kernel, 1, mydata(:,j+8)*180/pi);
        joint(n,j).qdot = filter(kernel, 1, mydata(:,j+14)*180/pi);
        joint(n,j).qdotd = filter(kernel, 1, mydata(:,j+20)*180/pi);
        joint(n,j).tau = filter(kernel, 1, mydata(:,j+26));
        joint(n,j).time = linspace(1,2,length(joint(n,j).qdot));
    end
    
       for j = 1:6
       mydata = READcsvDATA(fullfile(myfile(n).folder, myfile(n).name));
        joint(n,j).q = filter(kernel, 1, mydata(:,j+2)*180/pi);
        joint(n,j).qd = filter(kernel, 1, mydata(:,j+8)*180/pi);
        joint(n,j).qdot = filter(kernel, 1, mydata(:,j+14)*180/pi);
        joint(n,j).qdotd = filter(kernel, 1, mydata(:,j+20)*180/pi);
        joint(n,j).tau = filter(kernel, 1, mydata(:,j+26));
        joint(n,j).time = linspace(1,2,length(joint(n,j).qdot));
    end
    
    
end

%% plot
% for i = 1:6
%     subplot(3,2,double(i))
%     hold on
%     for n = 1:myfilenumber
%         plot(joint(n,i).qdot, joint(n,i).tau)        
%         maxtor(n,i) = max(joint(n,i).tau);
%         mintor(n,i) = min(joint(n,i).tau);
%     end
%     
% end

figure(4)
hold on
for i = 1:5
    plot(joint(i,1).qdot, joint(i,1).tau)
%     plot(joint(i,1).time, joint(i,1).qdot)
    legend('torque','velocity')
end


%%
% data = load('RealtimeData_joint1\Indy7RTData_20190506224229.csv');

%%
% t = data(:,1);
% isconstVel = data(:,2);
% for j=1:6
%     joint(j).q = data(:,j+2)*180/pi;
%     joint(j).qd = data(:,j+8)*180/pi;
%     joint(j).qdot = data(:,j+14)*180/pi;
%     joint(j).qdotd = data(:,j+20)*180/pi;
%     joint(j).tau = data(:,j+26);
% 
% end
% 9947 - 9862
%%
% figure;
% for n=1:6
%     subplot(3,2,double(n))
% %     plot(joint(n).qd*180/pi, 'k', 'linewidth',2)
% %     plot(joint(n).qdot, 'k', 'linewidth',2)
% %     plot(joint(n).qdotd, 'k', 'linewidth',2)
%     plot(joint(n).tau, 'k', 'linewidth',2)
%     hold on;    
% %     plot(isconstVel.*joint(n).qd*180/pi, 'ro')    
% %     plot(isconstVel.*joint(n).qdot, 'ro')    
% %     plot(isconstVel.*joint(n).qdotd, 'ro')    
% %     plot(isconstVel.*joint(n).tau, 'ro')    
%     
%     title(sprintf('Joint %d', n))
% end
%%
% figure;
% plot(joint(1).qdot, joint(1).tau, 'k-o', 'linewidth',2)

%%
% close all;
% figure;
% qdotd = joint(1).qdotd;
% qdotd_ = qdotd;
% qdotd_(2:end) = qdotd(1:end-1);
% tmp = qdotd-qdotd_;
% idx = find(tmp==0);
% plot(tmp, 'k', 'linewidth',2)
% hold on;
% plot(idx, 'ro')












