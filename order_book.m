% bid
if size(live_buy_orders_list, 1) >= 2
    best_bid=live_buy_orders_list(1,3);
    depth_at_best_bid = live_buy_orders_list(1,4);
    i = 2;
    while best_bid == live_buy_orders_list(i,3)
        depth_at_best_bid = depth_at_best_bid + live_buy_orders_list(i,4);
        i = i + 1;
    end
    bid_ask_stor_mat(t,1)=best_bid;
    bid_ask_depth_stor_mat(t,1)=depth_at_best_bid;
end

% ask
if size(live_sell_orders_list, 1) >= 2
    best_ask=live_sell_orders_list(2,3);
    depth_at_best_ask = live_sell_orders_list(2,4);
    i = 3;
    while size(live_sell_orders_list, 1) >= i && best_ask == live_sell_orders_list(i,3)
        depth_at_best_ask = depth_at_best_ask + live_sell_orders_list(i,4);
        i = i + 1;
    end
    bid_ask_stor_mat(t,2)=best_ask;
    bid_ask_depth_stor_mat(t,2)=depth_at_best_ask;
end

