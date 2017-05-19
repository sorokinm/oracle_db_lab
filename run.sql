@create_tables;
@fill_tables;
@add_prod;
@client_info;
@create_client;
@create_order;
@delete_order;
@list_store_prod;
@order_info;
@prod_info;
@block_user;

--from check_list_prod.sql
select list_st_prod(1) from dual;

--from try_add_prod
begin
add_product('Гематоген', 20, 'Шоколадный батончик', 'Аптека№1', 15, 'Нижфарм');
add_product('Нурафен', 10, 'Жаропонижающее', 'Аптека№1', 15, 'Нижфарм');
add_product('Ношпа', 100, 'Спазмольгетик', 'Аптека№3', 15, 'Бабушка Агафья');
end;
/

--from try_client
BEGIN
create_client('Вася','Василий','Пупкин','Россия','Иваново','Столичная','4','554564');
END;
/

--from try order (prod_id, amount, store_id )
DECLARE
tmp order_items:=order_items(1,2,1);
BEGIN
create_order(1,tmp);

END;
/
