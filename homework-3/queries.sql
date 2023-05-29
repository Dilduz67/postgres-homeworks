-- Напишите запросы, которые выводят следующую информацию:
-- 1. Название компании заказчика (company_name из табл. customers) и ФИО сотрудника, работающего над заказом этой компании (см таблицу employees),
-- когда и заказчик и сотрудник зарегистрированы в городе London, а доставку заказа ведет компания United Package (company_name в табл shippers)
select c.company_name as customer, concat(e.first_name, ' ',  e.last_name) as emloyee
from public.customers c
join public.orders o on o.customer_id=c.customer_id
join public.employees e on e.employee_id=o.employee_id
join public.shippers s on s.shipper_id=o.ship_via
where c.city='London' and e.city='London' and s.company_name='United Package'

-- 2. Наименование продукта, количество товара (product_name и units_in_stock в табл products),
-- имя поставщика и его телефон (contact_name и phone в табл suppliers) для таких продуктов,
-- которые не сняты с продажи (поле discontinued) и которых меньше 25 и которые в категориях Dairy Products и Condiments.
-- Отсортировать результат по возрастанию количества оставшегося товара.
select p.product_name, p.units_in_stock, s.contact_name, s.phone
from public.products p
join public.suppliers s on s.supplier_id=p.supplier_id
join public.categories c on c.category_id=p.category_id
where p.discontinued=0 and p.units_in_stock < 25
and c.category_name in ('Dairy Products', 'Condiments')
order by p.units_in_stock

-- 3. Список компаний заказчиков (company_name из табл customers), не сделавших ни одного заказа
select company_name from public.customers c
left join public.orders o on c.customer_id=o.customer_id
where o.customer_id is null

-- 4. уникальные названия продуктов, которых заказано ровно 10 единиц (количество заказанных единиц см в колонке quantity табл order_details)
-- Этот запрос написать именно с использованием подзапроса.
select product_name from public.products p
where p.product_id in (
						select product_id
						from order_details o
						where o.quantity=10
						)