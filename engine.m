aggressor_account_id = robot_j_acct_id;
aggressor_sign = buy_sell_robot_j;

still_need_to_buy = quantity_robot_j;
still_need_to_sell = quantity_robot_j;
%  1        2                           3       4                   5
% time, aggressor_sign(buy+1/sell-1), price, executed quantity, passor order_id
%       6                   7
% passor_account_id, aggressor_account_id

% if is aggressor
if buy_sell_robot_j == 1 && size(live_sell_orders_list, 1) >= 2
    % new buyer in
    while price_robot_j >= live_sell_orders_list(2,3) && still_need_to_buy > 0
        % trade
        if still_need_to_buy >= live_sell_orders_list(2,4)
            % buy all
            transaction_price_volume_stor_mat = [transaction_price_volume_stor_mat;
            t aggressor_sign live_sell_orders_list(2,3) live_sell_orders_list(2,4) live_sell_orders_list(2,6) live_sell_orders_list(2,1) aggressor_account_id];
            still_need_to_buy = still_need_to_buy - live_sell_orders_list(2,4);
            live_sell_orders_list(2,:) = [];
            if size(live_sell_orders_list, 1) < 2
                % not enough, store buyer
                break;
            end
        else
            % didnt buy all
            transaction_price_volume_stor_mat = [transaction_price_volume_stor_mat;
            t aggressor_sign live_sell_orders_list(2,3) still_need_to_buy live_sell_orders_list(2,6) live_sell_orders_list(2,1) aggressor_account_id];
            live_sell_orders_list(2,4) = live_sell_orders_list(2,4) - still_need_to_buy;
            still_need_to_buy = 0;
        end
    end
elseif buy_sell_robot_j == -1 && size(live_buy_orders_list, 1) >= 2
    % new seller in
    while price_robot_j <= live_buy_orders_list(1,3) && still_need_to_sell > 0
        %trade
        if still_need_to_sell >= live_buy_orders_list(1,4)
            % sell all
            transaction_price_volume_stor_mat = [transaction_price_volume_stor_mat;
            t aggressor_sign live_buy_orders_list(1,3) live_buy_orders_list(1,4) live_buy_orders_list(1,6) live_buy_orders_list(1,1) aggressor_account_id];
            still_need_to_sell = still_need_to_sell - live_buy_orders_list(1,4);
            live_buy_orders_list(1,:) = [];
            if size(live_buy_orders_list, 1) < 2
                % not enough, store seller
                break;
            end
        else
            % didn't sell all
            transaction_price_volume_stor_mat = [transaction_price_volume_stor_mat;
            t aggressor_sign live_buy_orders_list(1,3) still_need_to_sell live_buy_orders_list(1,6) live_buy_orders_list(1,1) aggressor_account_id];
            live_buy_orders_list(1,4) = live_buy_orders_list(1,4) - still_need_to_sell;
            still_need_to_sell = 0;
        end
    end        
end
% not aggressor

%    1          2       3       4           5       6       7
% account_id, buy/sell, price, quantity, time, order_id, alive_indicator

if buy_sell_robot_j == 1 && still_need_to_buy > 0
    live_buy_orders_list = [live_buy_orders_list;
        robot_j_acct_id buy_sell_robot_j price_robot_j still_need_to_buy t order_id alive_indicator_robot_j];
    live_buy_orders_list = sortrows(live_buy_orders_list,[-3 5]);
elseif buy_sell_robot_j == -1 && still_need_to_sell > 0
    live_sell_orders_list = [live_sell_orders_list;
        robot_j_acct_id buy_sell_robot_j price_robot_j still_need_to_sell t order_id alive_indicator_robot_j];
    live_sell_orders_list = sortrows(live_sell_orders_list,[3 5]);
end




