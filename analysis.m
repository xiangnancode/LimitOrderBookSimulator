t_period = 1:t_max;
% 3 bid_ask_spread plot
bid_ask_spread = bid_ask_stor_mat(:,2) - bid_ask_stor_mat(:,1);
figure;
plot(bid_ask_spread');
% 4  mean bid-ask spread
mean_bid_ask_spread = mean( bid_ask_spread(burn_in_period:end) );
% 5 LOB plot
figure;
bar(LOB)
% 6 
figure;
plot(t_period, bid_ask_stor_mat);
figure;
plot(t_period(burn_in_period:end), bid_ask_stor_mat(burn_in_period:end,:));
% 7
figure;
plot(t_period, bid_ask_depth_stor_mat);

% 6 1
% robot 6
[row, col] = find(transaction_price_volume_stor_mat(:,6:7) == 6);
robot_6_transaction = sortrows([row col]);
robot_6_cash_position = zeros(1,t_max);
robot_6_inventory_value = zeros(1,t_max);
robot_6_inventory = zeros(1,t_max);
robot_6_total_trading_volume = 0;
current_cash_position = 0;
current_inventory = 0;
t = 1;
for i = 1 : size(robot_6_transaction)
    tran_No = robot_6_transaction(i,1);
    tran_t = transaction_price_volume_stor_mat(tran_No, 1);
    for j = t : tran_t - 1;
        robot_6_cash_position(j) = robot_6_cash_position(t);
        robot_6_inventory(j) = robot_6_inventory(t);
        robot_6_inventory_value(j) = robot_6_inventory_value(t);
    end
    P_A_index = robot_6_transaction(i, 2);
    tran_price = transaction_price_volume_stor_mat(tran_No, 3);
    tran_quantity = transaction_price_volume_stor_mat(tran_No, 4);
    robot_6_total_trading_volume = robot_6_total_trading_volume + tran_quantity;
    % correct the buy/sell sign
    b_s_sign = transaction_price_volume_stor_mat(tran_No, 2) * (P_A_index * 2 - 3);
    % cash position
    tran_cost = b_s_sign * tran_price * tran_quantity;
    current_cash_position = current_cash_position - tran_cost;
    robot_6_cash_position(tran_t) = current_cash_position;
    % inventory
    current_inventory = current_inventory + b_s_sign * tran_quantity;
    robot_6_inventory(tran_t) = current_inventory;
    % inventory value
    robot_6_inventory_value(tran_t) =  current_inventory * tran_price;
    t = tran_t;
end
for j =  tran_t : t_max;
    robot_6_cash_position(j) = robot_6_cash_position(tran_t);
    robot_6_inventory(j) = robot_6_inventory(tran_t);
    robot_6_inventory_value(j) = robot_6_inventory_value(tran_t);
end
% trading profits
robot_6_trading_profits = robot_6_cash_position + robot_6_inventory_value;

% 6.1
figure;
plot(t_period, robot_6_cash_position, t_period, robot_6_trading_profits, t_period, robot_6_inventory_value);
legend('cash position', 'trading profits', 'inventory value');
% 6.2
figure;
plot(t_period, robot_6_inventory);

    
    
