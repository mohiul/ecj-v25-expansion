clear;
prob = '';

mu5xo95 = dlmread(strcat([prob, 'mu_xo/ecj-pagie1-mu5xo95']), '\t');
mu10xo90 = dlmread(strcat([prob, 'mu_xo/ecj-pagie1-mu10xo90']), '\t');
mu15xo85 = dlmread(strcat([prob, 'mu_xo/ecj-pagie1-mu15xo85']), '\t');
mu20xo80 = dlmread(strcat([prob, 'mu_xo/ecj-pagie1-mu20xo80']), '\t');
mu25xo75 = dlmread(strcat([prob, 'mu_xo/ecj-pagie1-mu25xo75']), '\t');

generation = 1002;

mu5xo95 = mu5xo95(:, 1:generation);
mu10xo90 = mu10xo90(:, 1:generation);
mu15xo85 = mu15xo85(:, 1:generation);
mu20xo80 = mu20xo80(:, 1:generation);
mu25xo75 = mu25xo75(:, 1:generation);

m_mu5xo95 = mean(mu5xo95(:, 1:generation),1);
m_mu10xo90 = mean(mu10xo90(:, 1:generation),1);
m_mu15xo85 = mean(mu15xo85(:, 1:generation),1);
m_mu20xo80 = mean(mu20xo80(:, 1:generation),1);
m_mu25xo75 = mean(mu25xo75(:, 1:generation),1);

indices = 1:generation;
plot(indices, m_mu5xo95, ...
    indices, m_mu10xo90,'-', ...
    indices, m_mu15xo85,'-.', ...
    indices, m_mu20xo80, '--', ...
    indices, m_mu25xo75, ':');
title(prob);
xlabel('Number of Generations');
ylabel('Average of 50 executions');
legend('Mutation:5%-Crossover:85%',...
    'Mutation:10%-Crossover:80%',...
    'Mutation:15%-Crossover:75%',...
    'Mutation:20%-Crossover:70%',...
    'Mutation:23%-Crossover:67%');
title('Varying Mutaion and Crossover Ratio. Problem: $$ {1 \over 1+x^{-4}} + {1 \over 1+y^{-4}} $$','Interpreter','latex');

%ylim([0 1.2]);
figure;
[mx_mu5xo95, I_mu5xo95] = max(mu5xo95, [], 1);
[mx_mu10xo90, I_mu10xo90] = max(mu10xo90, [], 1);
[mx_mu15xo85, I_mu15xo85] = max(mu15xo85, [], 1);
[mx_mu20xo80, I_mu20xo80] = max(mu20xo80, [], 1);
[mx_mu25xo75, I_mu25xo75] = max(mu25xo75, [], 1);

plot(indices, mu5xo95(I_mu5xo95(end), :),...
    indices, mu10xo90(I_mu10xo90(end), :), '-',...
    indices, mu15xo85(I_mu15xo85(end), :), '-.',...
    indices, mu20xo80(I_mu20xo80(end), :), '--',...
    indices, mu25xo75(I_mu25xo75(end), :), ':');
title(prob);
xlabel('Number of Generations');
ylabel('Best Fitness');
legend('Mutation:5%-Crossover:85%',...
    'Mutation:10%-Crossover:80%',...
    'Mutation:15%-Crossover:75%',...
    'Mutation:20%-Crossover:70%',...
    'Mutation:23%-Crossover:67%');
title('Varying Mutaion and Crossover Ratio. Problem: $$ {1 \over 1+x^{-4}} + {1 \over 1+y^{-4}} $$','Interpreter','latex');
%ylim([0 1.2]);