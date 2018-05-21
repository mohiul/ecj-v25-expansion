clear;
prob = '';

expMaxDist3 = dlmread(strcat([prob, 'exp-max-dist/ecj-pagie1-expMaxDistance3']), '\t');
expMaxDist5 = dlmread(strcat([prob, 'exp-max-dist/ecj-pagie1-expMaxDistance5']), '\t');
expMaxDist8 = dlmread(strcat([prob, 'exp-max-dist/ecj-pagie1-expMaxDistance8']), '\t');
expMaxDist10 = dlmread(strcat([prob, 'exp-max-dist/ecj-pagie1-expMaxDistance10']), '\t');
expMaxDist12 = dlmread(strcat([prob, 'exp-max-dist/ecj-pagie1-expMaxDistance12']), '\t');
expMaxDist15 = dlmread(strcat([prob, 'exp-max-dist/ecj-pagie1-expMaxDistance15']), '\t');
expMaxDist20 = dlmread(strcat([prob, 'exp-max-dist/ecj-pagie1-expMaxDistance20']), '\t');
expMaxDist25 = dlmread(strcat([prob, 'exp-max-dist/ecj-pagie1-expMaxDistance25']), '\t');
expMaxDist40 = dlmread(strcat([prob, 'exp-max-dist/ecj-pagie1-expMaxDistance40']), '\t');

m_expMaxDist3 = mean(expMaxDist3,1);
m_expMaxDist5 = mean(expMaxDist5,1);
m_expMaxDist8 = mean(expMaxDist8,1);
m_expMaxDist10 = mean(expMaxDist10,1);
m_expMaxDist12 = mean(expMaxDist12,1);
m_expMaxDist15 = mean(expMaxDist15,1);
m_expMaxDist20 = mean(expMaxDist20,1);
m_expMaxDist25 = mean(expMaxDist25,1);
m_expMaxDist40 = mean(expMaxDist40,1);

indices = 1:102;
plot(indices, m_expMaxDist3,'-', ...
    indices, m_expMaxDist5,'--', ...
    indices, m_expMaxDist8,':', ...
    indices, m_expMaxDist10, '-.', ...
    indices, m_expMaxDist12, '-o', ...
    indices, m_expMaxDist15, '-+', ...
    indices, m_expMaxDist20, '-*', ...
    indices, m_expMaxDist25, '-x', ...
    indices, m_expMaxDist40, '--o');
title(prob);
xlabel('Number of Generations');
ylabel('Average of 30 executions (Best Fitness)');
legend('Dist: 3','Dist: 5', 'Dist: 8', 'Dist: 10', 'Dist: 12', 'Dist: 15', 'Dist: 20', 'Dist: 25', 'Dist: 40');

%ylim([0 1.2]);
figure;
[mx_expMaxDist3, I_expMaxDist3] = max(expMaxDist3, [], 1);
[mx_expMaxDist5, I_expMaxDist5] = max(expMaxDist5, [], 1);
[mx_expMaxDist8, I_expMaxDist8] = max(expMaxDist8, [], 1);
[mx_expMaxDist10, I_expMaxDist10] = max(expMaxDist10, [], 1);
[mx_expMaxDist12, I_expMaxDist12] = max(expMaxDist12, [], 1);
[mx_expMaxDist15, I_expMaxDist15] = max(expMaxDist15, [], 1);
[mx_expMaxDist20, I_expMaxDist20] = max(expMaxDist20, [], 1);
[mx_expMaxDist25, I_expMaxDist25] = max(expMaxDist25, [], 1);
[mx_expMaxDist40, I_expMaxDist40] = max(expMaxDist40, [], 1);

plot(indices, expMaxDist3(I_expMaxDist3(end), :), '-', ...
    indices, expMaxDist5(I_expMaxDist5(end), :), '--', ...
    indices, expMaxDist8(I_expMaxDist8(end), :), ':', ...
    indices, expMaxDist10(I_expMaxDist10(end), :), '-.', ...
    indices, expMaxDist12(I_expMaxDist12(end), :), '-o', ...
    indices, expMaxDist15(I_expMaxDist15(end), :), '-+', ...
    indices, expMaxDist20(I_expMaxDist20(end), :), '-*', ...
    indices, expMaxDist25(I_expMaxDist25(end), :), '-x', ...
    indices, expMaxDist40(I_expMaxDist40(end), :), '--o');
title(prob);
xlabel('Number of Generations');
ylabel('Best Fitness');
legend('Dist: 3','Dist: 5', 'Dist: 8', 'Dist: 10', 'Dist: 12', 'Dist: 15', 'Dist: 20', 'Dist: 25', 'Dist: 40');
%ylim([0 1.2]);