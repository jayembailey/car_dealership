create table salesperson (
	sales_id SERIAL primary key,
	first_name VARCHAR(100),
	last_name VARCHAR(100)
);

create table customer (
	customer_id SERIAL primary key,
	first_name VARCHAR(100),
	last_name VARCHAR(100)
);

create table sales_car (
	car_id SERIAL primary key,
	make VARCHAR(50),
	model VARCHAR(50),
	price numeric(8,2),
	condition_ VARCHAR(50)
);

create table mechanic (
	mech_id	SERIAL primary key,
	first_name VARCHAR(100),
	last_name VARCHAR(100)
);

create table part (
	part_id SERIAL primary key,
	part_name VARCHAR(100),
	price numeric(8,2)
);

create table car_invoice (
	invoice_id SERIAL primary key,
	car_id INTEGER not null,
	sales_id INTEGER not null,
	customer_id INTEGER not null,
	status VARCHAR(100),
	amount numeric(8,2),
	foreign key(car_id) references sales_car(car_id),
	foreign key(sales_id) references salesperson(sales_id),
	foreign key(customer_id) references customer(customer_id)
);

create table service_ticket (
	ticket_id SERIAL primary key,
	mech_id INTEGER not null,
	customer_id INTEGER not null,
	car_id INTEGER not null,
	part_id INTEGER,
	amount numeric(8,2),
	date_created TIMESTAMP,
	completed BOOL,
	foreign key(mech_id) references mechanic(mech_id),
	foreign key(customer_id) references customer(customer_id),
	foreign key(car_id) references service_car(car_id),
	foreign key(part_id) references part(part_id)
);

create table service_car (
	car_id SERIAL primary key,
	make VARCHAR(50),
	model VARCHAR(50),
	customer_id INTEGER not null,
	foreign key(customer_id) references customer(customer_id)
);

insert into customer (
	customer_id,
	first_name,
	last_name
) values (
	1,
	'Jacob',
	'Bailey'
);

insert into customer (
	customer_id,
	first_name,
	last_name
) values (
	2,
	'Jennifer',
	'Kearns'
);

insert into salesperson (
	sales_id,
	first_name,
	last_name
) values (
	10,
	'Tim',
	'Pickens'
);

insert into salesperson (
	sales_id,
	first_name,
	last_name
) values (
	11,
	'Slim',
	'Pickens'
);

create or replace function add_sales_car(_car_id INTEGER, _make VARCHAR, _model VARCHAR, _price numeric(8,2), _condition_ VARCHAR)
returns void
as $MAIN$
begin 
	insert into sales_car(car_id, make, model, price, condition_)
	values (_car_id, _make, _model, _price, _condition_);
end
$MAIN$
language plpgsql;

select add_sales_car(100, 'Ford', 'Ranger', 20000.00, 'Used');
select add_sales_car(101, 'Chrysler', 'Town & Country', 50000.00, 'New');

update sales_car
set price = 20000.00
where car_id = 100;

create or replace function add_mechanic(_mech_id INTEGER, _first_name VARCHAR, _last_name VARCHAR)
returns void
as $MAIN$
begin 
	insert into mechanic(mech_id, first_name, last_name)
	values (_mech_id, _first_name, _last_name);
end
$MAIN$
language plpgsql;

select add_mechanic(200, 'Danny', 'DeVito');
select add_mechanic(201, 'Mohammed', 'Ali');
select * from mechanic

insert into part (part_id, part_name, price) values (20, 'Tires', 100.00);
insert into part (part_id, part_name, price) values (21, 'Engine', 10000.00);
select * from part;

create or replace function add_car_invoice(_invoice_id INTEGER, _car_id INTEGER, _sales_id INTEGER, _customer_id INTEGER, _status VARCHAR, _amount numeric(8,2))
returns void
as $MAIN$ 
begin 
	insert into car_invoice(invoice_id, car_id, sales_id, customer_id, status, amount)
	values(_invoice_id, _car_id, _sales_id, _customer_id, _status, _amount);
end
$MAIN$
language plpgsql;

select add_car_invoice(30, 100, 10, 1, 'Pending', 15000.00);
select add_car_invoice(31, 101, 11, 2, 'Paid', 40000.00);
select * from car_invoice;

insert into service_car (car_id, make, model, customer_id) values (500, 'Ferrari', 'Enzo', 1);
insert into service_car (car_id, make, model, customer_id) values (501, 'Lambo', 'Gallardo', 2);


create or replace function add_service_ticket(_ticket_id INTEGER, _mech_id INTEGER, _customer_id INTEGER, _car_id INTEGER, _part_id INTEGER, _amount numeric(8,2), _date_created TIMESTAMP, _completed BOOL)
returns void
as $MAIN$ 
begin 
	insert into service_ticket(ticket_id, mech_id, customer_id, car_id, part_id, amount, date_created, completed)
	values(_ticket_id, _mech_id, _customer_id, _car_id, _part_id, _amount, _date_created, _completed);
end
$MAIN$
language plpgsql;

select add_service_ticket(40, 200, 2, 500,null, 10000.00, NOW()::TIMESTAMP, false);
select add_service_ticket(41, 201, 1, 501, 20, 200000.00, NOW()::TIMESTAMP, true);

select * from service_ticket ;
select * from customer;
select * from salesperson;
select * from part;
select * from service_ticket;
select * from mechanic;
select * from car_invoice;
select * from service_car;

