clear;
prob = '';

ex1xo99 = dlmread(strcat([prob, 'exp-xover-prop/ecj-pagie1-expansion1xover99']), '\t');
ex5xo95 = dlmread(strcat([prob, 'exp-xover-prop/ecj-pagie1-expansion5xover95']), '\t');
ex10xo90 = dlmread(strcat([prob, 'exp-xover-prop/ecj-pagie1-expansion10xover90']), '\t');
ex25xo75 = dlmread(strcat([prob, 'exp-xover-prop/ecj-pagie1-expansion25xover75']), '\t');
ex50xo50 = dlmread(strcat([prob, 'exp-xover-prop/ecj-pagie1-expansion50xover50']), '\t');

m_ex1xo99 = mean(ex1xo99,1);
m_ex5xo95 = mean(ex5xo95,1);
m_ex10xo90 = mean(ex10xo90,1);
m_ex25xo75 = mean(ex25xo75,1);
m_ex50xo50 = mean(ex50xo50,1);

indices = 1:102;
plot(indices, m_ex1xo99, indices, m_ex5xo95,'.', indices, m_ex10xo90,'-.', indices, m_ex25xo75, '--', indices, m_ex50xo50, '--o');
title(prob);
xlabel('Number of Generations');
ylabel('Average of 30 executions (Best Fitness)');
legend('Ex 1% - Xo 99%','Ex 5% - Xo 95%', 'Ex 10% - Xo 90%', 'Ex 25% - Xo 75%', 'Ex 50% - Xo 50%');

%ylim([0 1.2]);
figure;
[mx_ex1xo99, I_ex1xo99] = max(ex1xo99, [], 1);
[mx_ex5xo95, I_ex5xo95] = max(ex5xo95, [], 1);
[mx_ex10xo90, I_ex10xo90] = max(ex10xo90, [], 1);
[mx_ex25xo75, I_ex25xo75] = max(ex25xo75, [], 1);
[mx_ex50xo50, I_ex50xo50] = max(ex50xo50, [], 1);

plot(indices, ex1xo99(I_ex1xo99(end), :), '--',indices, ex5xo95(I_ex5xo95(end), :), '--', indices, ex10xo90(I_ex10xo90(end), :), '--', indices, ex25xo75(I_ex25xo75(end), :), '--', indices, ex50xo50(I_ex50xo50(end), :), '--o');
title(prob);
xlabel('Number of Generations');
ylabel('Best Fitness');
legend('Ex 1% - Xo 99%','Ex 5% - Xo 95%', 'Ex 10% - Xo 90%', 'Ex 25% - Xo 75%', 'Ex 50% - Xo 50%');
%ylim([0 1.2]);