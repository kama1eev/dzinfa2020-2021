--1
select model,speed,hd
from PC
where price<500
--2
SELECT DISTINCT maker
    FROM Product
    WHERE type = 'Printer'
--3
SELECT model, ram, screen
    FROM Laptop
    WHERE price > CAST('1000' AS MONEY)
--4
Select *
from printer
where color = 'y'
--5
Select model,speed,hd
from pc
where (cd = '12x' or cd='24x') and price<600
--6
SELECT distinct Product.maker, Laptop.speed
    FROM Product, Laptop
    WHERE Product.model = Laptop.model
     AND Laptop.hd >= 10
--7
SELECT model, price
    FROM PC
    WHERE model IN (SELECT model
     FROM Product
     WHERE maker = 'B' AND
     type = 'PC'
     )
union
    SELECT model, price
    FROM Laptop
    WHERE model IN (SELECT model
     FROM Product
     WHERE maker = 'B' AND
     type = 'Laptop'
     )
    UNION
    SELECT model, price
    FROM Printer
    WHERE model IN (SELECT model
     FROM Product
     WHERE maker = 'B' AND
     type = 'Printer'
    )
    --8
    select distinct product.maker
    from product
    where product.type= 'PC' and
    product.maker not in (
    select product.maker
    from product
    where product.type = 'Laptop')
--9
SELECT DISTINCT maker
FROM product p,PC
WHERE p.model=pc.model
AND pc.speed>449
--10
SELECT model, price
    FROM Printer pr, (SELECT MAX(price) AS maxprice
                      FROM Printer
                      ) AS mp
    WHERE price = mp.maxprice
--11
SELECT SUM(speed)/COUNT(speed)
    FROM PC
--12
SELECT SUM(speed)/COUNT(speed)
    FROM laptop
where price>1000
--13
select sum(pc.speed) / count(*)
from pc
where pc.model in (select product.model from product
where product.maker = 'a')
--15
SELECT DISTINCT hd
    FROM PC
    WHERE (SELECT COUNT(hd)
           FROM PC pc2
           WHERE pc2.hd = pc.hd
           ) > 1
--16
SELECT DISTINCT a.model, b.model, a.speed, a.ram
FROM pc a, pc b
WHERE a.ram = b.ram
AND a.speed = b.speed
AND a.model > b.model
--17
SELECT DISTINCT p.type, l.model, l.speed
FROM laptop l, product p
WHERE speed < ALL (SELECT speed FROM PC)
AND l.model=p.model
--18
select distinct product.maker, printer.price
from product, printer
where product.model = printer.model
and printer.color = 'y'
and printer.price = (select min(p.price)
from printer p
where p.color = 'y')
--19
select product.maker, sum(laptop.screen) / count(laptop.model)
from product, laptop
where product.type = 'Laptop'
and product.model = laptop.model
group by product.maker
--20
select product.maker,count(*)
from product
where type='pc' group by product.maker
having count(*) >= 3
--21
select product.maker, max(pc.price)
from product, pc
where product.model = pc.model
and product.type = 'pc'
group by product.maker
--22
Select speed,avg(price)
from pc
group by speed
having speed>600
--23
select distinct product.maker
from product, pc
where product.model = pc.model
and product.type = 'pc'
and pc.speed >= 750
and exists(select 'x' from laptop, product p
where p.model = laptop.model
and p.type = 'Laptop'
and p.maker = product.maker
and laptop.speed >= 750)
--24
select distinct product.model
from product, pc, laptop, printer
where /*product.model in(pc.model, laptop.model, printer.model)
and*/ pc.price = (select max(pcc.price) from pc pcc)
and laptop.price = (select max(l.price) from laptop l)
and printer.price = (select max(pr.price) from printer pr)
and (
(pc.price >= laptop.price and pc.price >= printer.price
and product.model = pc.model)
or
(laptop.price >= pc.price and laptop.price >= printer.price
and product.model = laptop.model)
or
(printer.price >= laptop.price and printer.price >= pc.price
and product.model = printer.model)
)
--25
select distinct product.maker
from product, pc
where product.type = 'pc'
and product.model = pc.model
and pc.ram = (select min(pcc.ram) from pc pcc where pcc.ram <> 0)
and pc.speed = (select max(pccc.speed) from pc pccc
where pccc.ram = (select min(pcc.ram) from pc pcc where pcc.ram <> 0))
and exists(select 'x' from product p
where p.type = 'Printer'
and p.maker = product.maker)
--26
SELECT AVG(price) FROM (
SELECT price FROM pc WHERE model IN
(SELECT model FROM product WHERE maker='a' AND type='pc')
UNION ALL
SELECT price FROM laptop WHERE model IN
(SELECT model FROM product WHERE maker='a' AND type='Laptop')
) as prod
--27
select product.maker, sum(pc.hd) / count(*)
from product, pc
where product.type = 'pc'
and product.model = pc.model
and exists(select 'x' from product p
where p.maker = product.maker
and p.type = 'Printer')
group by product.maker
--29
SELECT Income_o.point, Income_o.date, SUM(inc),SUM(out)
FROM Income_o LEFT JOIN
Outcome_o ON Income_o.point = Outcome_o.point AND
Income_o.date = Outcome_o.date
GROUP BY Income_o.point, Income_o.date
UNION
SELECT Outcome_o.point, Outcome_o.date, SUM(inc),SUM(out)
FROM Outcome_o LEFT JOIN
Income_o ON Income_o.point = Outcome_o.point AND
Income_o.date = Outcome_o.date
GROUP BY Outcome_o.point, Outcome_o.date
--30
SELECT DISTINCT point,date,SUM(out) AS out, SUM(inc) AS inc FROM (
SELECT Income.point, Income.date, out, inc
FROM Income LEFT JOIN
Outcome ON Income.point = Outcome.point AND
Income.date = Outcome.date AND Income.code= Outcome.code
UNION ALL
SELECT Outcome.point, Outcome.date, out, inc
FROM Outcome LEFT JOIN
Income ON Income.point = Outcome.point AND
Income.date = Outcome.date AND Income.code=Outcome.code) AS t1
GROUP BY point, date
--31
SELECT class, country
FROM Classes
WHERE bore>=16
--33
SELECT ship
FROM Outcomes
WHERE battle='North Atlantic'
AND result='sunk'