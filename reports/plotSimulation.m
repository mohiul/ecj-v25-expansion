clear;
prob = '';

expSim1 = dlmread(strcat([prob, 'exp-simulation/ecj-pagie1-expSimulation1']), '\t');
expSim5 = dlmread(strcat([prob, 'exp-simulation/ecj-pagie1-expSimulation5']), '\t');
expSim10 = dlmread(strcat([prob, 'exp-simulation/ecj-pagie1-expSimulation10']), '\t');
expSim20 = dlmread(strcat([prob, 'exp-simulation/ecj-pagie1-expSimulation20']), '\t');
expSim40 = dlmread(strcat([prob, 'exp-simulation/ecj-pagie1-expSimulation40']), '\t');
expSim80 = dlmread(strcat([prob, 'exp-simulation/ecj-pagie1-expSimulation80']), '\t');
%expSim120 = dlmread(strcat([prob, 'exp-simulation/ecj-pagie1-expSimulation120']), '\t');


m_expSim1 = mean(expSim1,1);
m_expSim5 = mean(expSim5,1);
m_expSim10 = mean(expSim10,1);
m_expSim20 = mean(expSim20,1);
m_expSim40 = mean(expSim40,1);
m_expSim80 = mean(expSim80,1);
%m_expSim120 = mean(expSim120,1);

indices = 1:102;
plot(indices, m_expSim1,'-', ...
    indices, m_expSim5,'--', ...
    indices, m_expSim10, '-.', ...
    indices, m_expSim20, '-o', ...
    indices, m_expSim40, '-+', ...
    indices, m_expSim80, '-*'); %, ...
%    indices, m_expSim120, '-x');
title(prob);
xlabel('Number of Generations');
ylabel('Average of 30 executions (Best Fitness)');
legend('Sim: 1','Sim: 5', 'Sim: 10', 'Sim: 20', 'Sim: 40', 'Sim: 80');

%ylim([0 1.2]);
figure;
[mx_expSim1, I_expSim1] = max(expSim1, [], 1);
[mx_expSim5, I_expSim5] = max(expSim5, [], 1);
[mx_expSim10, I_expSim10] = max(expSim10, [], 1);
[mx_expSim20, I_expSim20] = max(expSim20, [], 1);
[mx_expSim40, I_expSim40] = max(expSim40, [], 1);
[mx_expSim80, I_expSim80] = max(expSim80, [], 1);
%[mx_expSim120, I_expSim120] = max(expSim120, [], 1);

plot(indices, expSim1(I_expSim1(end), :), '-', ...
    indices, expSim5(I_expSim5(end), :), '--', ...
    indices, expSim10(I_expSim10(end), :), '-.', ...
    indices, expSim20(I_expSim20(end), :), '-o', ...
    indices, expSim40(I_expSim40(end), :), '-+', ...
    indices, expSim80(I_expSim80(end), :), '-*');
    %indices, expSim120(I_expSim120(end), :), '-x');
title(prob);
xlabel('Number of Generations');
ylabel('Best Fitness');
legend('Sim: 1','Sim: 5', 'Sim: 10', 'Sim: 20', 'Sim: 40', 'Sim: 80');
%ylim([0 1.2]);