-- удаляем таблицы, если есть
DROP TABLE IF EXISTS public.orders;
DROP TABLE IF EXISTS public.customers;
DROP TABLE IF EXISTS public.employees;

-- SQL-команды для создания таблиц
------------------------------------------------
-- Table: public.customers
------------------------------------------------
CREATE TABLE IF NOT EXISTS public.customers
(
    customer_id character(5) COLLATE pg_catalog."default" NOT NULL,
    company_name character varying(300) COLLATE pg_catalog."default" NOT NULL,
    contact_name character varying(100) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_customers PRIMARY KEY (customer_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.customers
    OWNER to postgres;
-- Index: ix_customers

--DROP INDEX IF EXISTS public.ix_customers;

CREATE UNIQUE INDEX IF NOT EXISTS ix_customers
    ON public.customers USING btree
    (customer_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.customers
    CLUSTER ON ix_customers;

------------------------------------------------
-- Table: public.employees
------------------------------------------------
CREATE TABLE IF NOT EXISTS public.employees
(
    employee_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    first_name character varying(300) COLLATE pg_catalog."default" NOT NULL,
    last_name character varying(300) COLLATE pg_catalog."default" NOT NULL,
    title character varying(100) COLLATE pg_catalog."default" NOT NULL,
    birth_date date NOT NULL,
    notes character varying(1000) COLLATE pg_catalog."default",
    CONSTRAINT pk_employees PRIMARY KEY (employee_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.employees
    OWNER to postgres;
-- Index: ix_employees

-- DROP INDEX IF EXISTS public.ix_employees;

CREATE UNIQUE INDEX IF NOT EXISTS ix_employees
    ON public.employees USING btree
    (employee_id ASC NULLS LAST)
    TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.employees
    CLUSTER ON ix_employees;

------------------------------------------------
-- Table: public.orders
------------------------------------------------
CREATE TABLE IF NOT EXISTS public.orders
(
    order_id integer NOT NULL,
    customer_id character(5) COLLATE pg_catalog."default" NOT NULL,
    employee_id integer NOT NULL,
    order_date date NOT NULL,
    ship_city character varying(100) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_orders PRIMARY KEY (order_id),
    CONSTRAINT fk_orders_customers FOREIGN KEY (customer_id)
        REFERENCES public.customers (customer_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT fk_orders_employees FOREIGN KEY (employee_id)
        REFERENCES public.employees (employee_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.orders
    OWNER to postgres;
-- Index: fki_fk_orders_customers

-- DROP INDEX IF EXISTS public.fki_fk_orders_customers;

CREATE INDEX IF NOT EXISTS fki_fk_orders_customers
    ON public.orders USING btree
    (customer_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: fki_fk_orders_employees

-- DROP INDEX IF EXISTS public.fki_fk_orders_employees;

CREATE INDEX IF NOT EXISTS fki_fk_orders_employees
    ON public.orders USING btree
    (employee_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: ix_orders

-- DROP INDEX IF EXISTS public.ix_orders;

CREATE UNIQUE INDEX IF NOT EXISTS ix_orders
    ON public.orders USING btree
    (order_id ASC NULLS LAST)
    TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.orders
    CLUSTER ON ix_orders;
