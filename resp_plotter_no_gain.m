clc;clear;close all;
resp= load ('exp_4l.mat');
response= resp.resp;
target= resp.tgt;
times= resp.times;
rise_time=[];
st_time=[];
os=[];
ss_err=[];
for i=1: length(target)
    time= cell2mat(times(i));
    res= cell2mat(response(i));
   
    tgt_vec=  target(i)+ zeros(length(time),1);
    x= stepinfo(res, time);
    rise_time=[rise_time x.RiseTime];
    st_time=[st_time x.SettlingTime];
    
    %overshoot needs to be recalculated
    if target(i)> 0
    overshoot= (max(res)- target(i))./(target(i));
    else
        overshoot= (min(res)- target(i))./(target(i));
    end
    os=[os overshoot]; 
    ss_err=[ss_err abs(target(i)-res(end))];
    figure
    set(gcf,'color','w');
    plot(time,tgt_vec,'b-', 'LineWidth',2)
    hold on
    plot(time,res,'r-', 'LineWidth',2)
    hold off
    grid on
    title('Target Value and Actual Response')
    xlabel('Time (seconds)')
    ylabel('Pitch Angle (radians)')
    legend('Target Value','Actual Response')
    set(gcf,'color','w');
   
end
%append all vectors
disp('Rise Time,Settling Time,Overshoot, Steady State Error')
transient_resp= [rise_time' st_time' os' ss_err']
