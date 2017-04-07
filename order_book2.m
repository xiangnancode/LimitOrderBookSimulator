% buy_lob_depth
LOB = zeros(1,20);
for i = 1 : size(live_buy_orders_list, 1) - 1
    bid=live_buy_orders_list(i,3);
    depth_at_bid = live_buy_orders_list(i,4);
    LOB(bid) = LOB(bid) + depth_at_bid;
end
% sell_lob_depth
for i = 2 : size(live_sell_orders_list, 1) - 1
    ask=live_sell_orders_list(i,3);
    depth_at_ask = live_sell_orders_list(i,4);
    LOB(ask) = LOB(ask) + depth_at_ask;
end

