## Scipt.sql
create table cus_foods(
    cus_id int,
    foods_id int,
    foreign key(cus_id) references customers(cus_id),
    foreign key(foods_id) references favorite_foods(foods_id)
);

insert into cus_foods values
    (1, 2),
    (2, 3),
    (4, 5),
    (5, 2),
    (7, 4),
    (1, 3),
    (1, 1),
    (2, 2),
    (14, 1),
    (14, 2),
    (11, 1),
    (11, 3),
    (6, 4),
    (4, 1),
    (5, 5),
    (2, 5),
    (9, 1),
    (10 ,3),
    (15, 4),
    (13, 3);

select * from cus_foods;   

create table customers(
    cus_id int,
    firstname varchar(20),
    lastname varchar(20),
    gender varchar(10),
    phone varchar(20),
    invoice_id int,
    primary key(cus_id),
    foreign key(invoice_id) references invoice(invoice_id)
);

insert into customers values
    (1, 'jame', 'bond', 'male', +6682314456, 2041),
    (2, 'davin', 'diger', 'male', +6685643322, 2042),
    (3, 'sasa', 'monica', 'male', +6687234234, 2043),
    (4, 'vava', 'eiei', 'male',  +6691287671, 2044),
    (5, 'fala', 'xixi', 'female', +6687654673, 2045),
    (6, 'coco', 'nut', 'female', +6694575687, 2046),
    (7, 'bb', 'cc', 'male', +6689754563, 2047),
    (8, 'dd', 'aa', 'female', +6689784657, 2048),
    (9, 'xx', 'dd', 'female', +6687978976, 2049),
    (10, 'qq', 'wewe', 'female', +6697565747, 2050),
    (11, 'jnfe', 'wewpj', 'male', +6658973475, 2051),
    (12, 'erfew', 'ergwerg', 'male', +6689753745, 2052),
    (13, 'wefoiwf', 'wewueh', 'male', +6689757684, 2053),
    (14, 'wefwpp', 'omihet', 'female', +6697884567, 2054),
    (15, 'ergojerg', 'erpgijer', 'female', +6690857685, 2055);

select * from customers;

create table favorite_foods(
    foods_id int,
    type_of_foods varchar(20),
    primary key(foods_id)
);

insert into favorite_foods values
    (1, 'india foods'),
    (2, 'thai foods'),
    (3, 'japan foods'),
    (4, 'america foods'),
    (5, 'korean foods');

select * from favorite_foods;

create table invoice(
    invoice_id int,
    orderdate datetime,
    order_id int,
    primary key(invoice_id),
    foreign key(order_id) references order1(order_id)
);

insert into invoice values
    (2041, '2022-05-01 11:30:04',1),
    (2042,'2022-05-01 11:33:50',2),
    (2043, '2022-05-01 12:40:02',3),
    (2044, '2022-05-01 14:50:01',4),
    (2045, '2022-05-01 16:40:00',5),
    (2046, '2022-05-01 17:00:00',6),
    (2047, '2022-05-01 18:05:10',7),
    (2048, '2022-05-02 10:35:04',8),
    (2049, '2022-05-02 11:12:01',9),
    (2050, '2022-05-02 11:32:02',10),
    (2051, '2022-05-02 12:20:05',11),
    (2052, '2022-05-02 13:44:04',12),
    (2053, '2022-05-02 14:11:00',13),
    (2054, '2022-05-02 14:54:07',14),
    (2055, '2022-05-02 15:58:03',15);

select * from invoice;

create table menu(
    menu_id int,
    name_menu varchar(50),
    menu_price real,
    primary key(menu_id)
);

insert into menu values
    (1, "Pad-Thai Noodle", 40 ),
    (2, "Pad-Thai Noodle with Shrimp", 50),
    (3, "Pad-Thai Noodle with River Prawn", 60),
    (4, "Pad-Thai Noodle with Seafood", 60),
    (5, "Pad-Thai Glass Noodle", 50),
    (6, "Pad-Thai Glass Noodle with Shrimp", 45),
    (7, "Stir-Fried Rice Noodle with Pork & Black Sauce", 50),
    (8, "Stir-Fried Rice Noodle with Chicken & Black Sauce", 50),
    (9, "Stir-Fried Rice Noodle with Shrimp & Black Sauce", 60),
    (10, "Stir-Fried Rice Noodle with Squid & Black Sauce", 50);

select * from menu;

create table order1(
    order_id int,
    menu_id int,
    qauntity int,
    primary key(order_id),
    foreign key(menu_id) references menu(menu_id) 
);

insert into order1 values
    (1, 2, 2),
    (2, 3, 1),
    (3, 4, 2),
    (4, 5, 1),
    (5, 2, 2),
    (6, 9, 4),
    (7, 8, 1),
    (8, 5, 1),
    (9, 1, 1),
    (10, 2, 1),
    (11, 3, 2),
    (12, 4, 3),
    (13, 1, 2),
    (14, 2, 3),
    (15, 3, 3);

select * from order1;    

## select.sql
select 
    customers.firstname || " " || customers.lastname as fullname,
    menu.name_menu as menu,
    invoice.orderdate as orderdate,
    order1.qauntity as qauntity,
    sum(menu_price) as total_price
from menu 
join order1 on menu.menu_id = order1.menu_id
join invoice on order1.order_id = invoice.order_id
join customers on invoice.invoice_id = customers.invoice_id
join cus_foods on customers.cus_id = cus_foods.cus_id
join favorite_foods on cus_foods.foods_id = favorite_foods.foods_id
group by fullname
order by fullname desc limit 6;

## main.sql
.open HW_restaurant/restaurant.db
.mode table
.read HW_restaurant/select.sql
