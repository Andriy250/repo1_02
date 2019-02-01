USE labor_sql;

#1.1
/*select DISTINCT maker, type
from product
where maker not in (select maker from product where type = 'laptop') and type = 'PC'; */

#2
/*select DISTINCT maker, type
from product
where maker <> all (select maker from product where type = 'laptop') and type = 'PC'; */


#3
/*select DISTINCT maker, type
from product
where not (maker = any  (select maker from product where type = 'laptop')) and type = 'PC'; */

#4
/*select DISTINCT maker, type
from product
where maker in (select maker from product where type = 'laptop') and type = 'PC'; */

#5
/*select DISTINCT maker, type
from product as p
where maker = all (select maker from product where type = 'laptop' and p.maker = maker) and type = 'PC'; */

#6
/*select DISTINCT maker, type
from product as p
where not (maker <> any (select maker from product where type = 'laptop' and p.maker = maker)) and type = 'PC';*/

#7
/*select distinct maker
from product
where model in (select distinct model from PC);*/

#8
/*select country, class
from classes
where ((  country = all (select country from classes where country = 'Ukraine') and country = 'Ukraine') or true);*/

#9
/*select ship, battle, b.date
from outcomes
join battles as b on b.name = battle
where ship in (select ship from outcomes where result = 'damaged') and result <> 'damaged';*/

#10
/*select count(*)
from product
where maker = 'A';*/

#11
/*select DISTINCT maker, model
from product
where model not in (select model from PC); */

#12
/*select model, price
from laptop
where price > all (select price from pc); */


#2.1
/*select DISTINCT maker
from product as p
where exists (select * from PC where model = p.model); */

#2
/*select maker 
from product as p
where exists (select * from pc where speed >= 750 and model = p.model); */

#3
/*select maker
from product as p
where maker in (select maker from product as pr where exists (select * from laptop where speed >= 750 
		and model = pr.model)) and exists (select * from pc where speed >= 750 and model = p.model); */
        
#4
/*select DISTINCT maker
from product as p
where maker in (select maker from product as pr where exists (select * from pc where speed = (select max(speed) from pc)
		and pr.model = model)) and type = 'Printer';*/


#6
/*select distinct class
from ships
where exists (select * from outcomes where name = ship);*/

#5
/*select name, launched, displacement
from ships as s
join classes as c on c.class = s.class
where exists (select * from ships where launched > 1922 and s.name = name) and displacement > 35; */

#7
/*select distinct maker
from product as p
where exists (select * from product where p.maker = maker and type = 'laptop') 
		and exists (select * from product where p.maker = maker and type = 'Printer'); */


#8
/*select distinct maker
from product as p
where exists (select * from product where p.maker = maker and type = 'laptop') 
		and not exists (select * from product where p.maker = maker and type = 'Printer'); 	*/

#3.1
/*select (sum(price) / count(*)) as median
from laptop; */

#2
/*select concat('model: ', model) as model , concat('price: ', price) as price
from pc; */


#3
/*select date_format(income.date, '%Y_%M,%D') as date
from income; */

#4
/*select ship, battle,
	case
		when result = 'sunk' then 'потомлений'
        when result = 'OK' then 'всьо окей'
        when result = 'damaged' then 'фарбу поцарапав ги'
	END as result
from outcomes; */

#5
/*select concat('PRD: ', substring(place,1,1)) as PRD, concat('MICLljE: ', substring(place,2,1)) as MICLljE
from pass_in_trip;*/

#6
/*select concat('from ', town_from, ' to ', town_to) as full_trip
from trip; */


#4.1
/*select model,price
from printer
where price in (select MAX(price) from printer); */

#2
/*select model, speed
from laptop 
where speed > all (select min(speed) from pc); */

#3
/*select maker, price
from product as p
join printer on printer.model = p.model
where price in (select min(price) from printer where color = 'y'); */

#4
/*select maker
from product
where type = 'PC'
group by maker
having count(*) >= 2; */

#5
/*select (max(hd) + min(hd)) / count(*) as middle
from product as p
join pc on pc.model = p.model
where maker in (select maker from product where type = 'printer') and type = 'PC'; */

#6
/*select p.date, count(p.date)
from pass_in_trip as p
join trip on trip.trip_no = p.trip_no
where town_from = 'London'
group by p.date; */

#7
/*select p.date, count(p.date)
from pass_in_trip as p
join trip on trip.trip_no = p.trip_no
where town_from = 'Moscow'
group by p.date
having count(p.date) = all (select max(col) from (select count(pas.date) as col
												from pass_in_trip as pas
                                                join trip on trip.trip_no = pas.trip_no
                                                where town_from = 'Moscow'
                                                group by pas.date) as c);*/
                                                
#5.1
/*select maker, (select count(*)
				from product
                where p.maker = maker and type = 'PC') as pc,
				(select count(*)
				from product
                where p.maker = maker and type = 'laptop') as laptop,
                (select count(*)
				from product
                where p.maker = maker and type = 'printer') as printer
from product as p
group by maker; */

#2
/*select maker, (select (max(screen) + min(screen))/ count(*)
				from laptop as l
                join product as p on p.model = l.model
                where p.maker = product.maker) as middle_screen
from product
group by maker; */


#3
/*select maker, (select max(price)
				from pc
                join product as p on p.model = pc.model
                where product.maker = p.maker) as max_price
from product
group by maker; */

#4
/*select maker, (select min(price)
				from pc
                join product as p on p.model = pc.model
                where product.maker = p.maker) as min_price
from product
group by maker; */

#5
/*select speed, (select (max(price) + min(price)) / count(*)
				from pc
                where speed = p.speed) as middle_price
from pc as p
group by speed
having speed >= 600; */

#6.1
/*select product.maker ,
			case
				when p2.pc > 0 then concat('yes(',p2.pc,')')
                else 'no' end as production
from product
join (select maker, (select count(*)
						from product as p
						where p.maker = join_product.maker and type = 'PC') as pc
		from product as join_product
        group by join_product.maker) as p2 on p2.maker=product.maker
group by product.maker; */

#7.1
/*select maker, product.model, type, price
from product
join pc on pc.model = product.model
union
select maker, product.model, type, price
from product
join laptop as l on l.model = product.model
union
select maker, product.model, product.type, price
from product
join printer as p on p.model = product.model;*/


#2
/*select p.type, p.model, price 
from product as p
join pc on pc.model = p.model
where price in (select max(price) from pc)
union
select p.type, p.model, price 
from product as p
join laptop as l on l.model = p.model
where price in (select max(price) from laptop)
union
select p.type, p.model, price 
from product as p
join printer as pr on pr.model = p.model
where price in (select max(price) from printer); */

#3
/*select (max(middle_price) + min(middle_price) )/ count(*) as middle_price
from
(select (max(price) + min(price)) / count(*) as middle_price
from product as p
join pc on pc.model = p.model
where p.maker= 'A'
union
select (max(price) + min(price)) / count(*) as middle_price
from product as p
join laptop as l on l.model = p.model
where p.maker= 'A') as something;*/

#4
/*select name, class
from ships as s
where exists ((select * from ships where name = s.name and name = class) union
				(select * from outcomes where ship in (select class from ships where class = s.class)));*/
                
#5
select class, count(class)
from ships
group by class;

#select * from product;