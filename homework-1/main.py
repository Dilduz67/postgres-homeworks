"""Скрипт для заполнения данными таблиц в БД Postgres."""
import psycopg2
from pathlib import Path

csv_name=Path(".\\north_data\\emloyees_data.csv").absolute()
print(csv_name)

conn = psycopg2.connect(host="localhost",database="north",user="postgres",password="postgres")


cursor=conn.cursor()

##########copy employees###############
with open('.\\north_data\\employees_data.csv','r') as f:
    sql_str = """
    COPY employees("first_name","last_name","title","birth_date","notes") FROM STDIN WITH
        CSV
        HEADER
        DELIMITER AS ','
    """

    cursor.copy_expert(sql=sql_str, file=f)

conn.commit()

#cursor.execute('SELECT * FROM employees')
#for row in cursor.fetchall():
#    print(row)

##########copy customers###############
with open('.\\north_data\\customers_data.csv','r') as f:
    sql_str = """
    COPY customers FROM STDIN WITH
        CSV
        HEADER
        DELIMITER AS ','
    """

    cursor.copy_expert(sql=sql_str, file=f)

conn.commit()

#cursor.execute('SELECT * FROM customers')
#for row in cursor.fetchall():
#    print(row)

##########copy orders###############
with open('.\\north_data\\orders_data.csv','r') as f:
    sql_str = """
    COPY orders FROM STDIN WITH
        CSV
        HEADER
        DELIMITER AS ','
    """

    cursor.copy_expert(sql=sql_str, file=f)

conn.commit()

#cursor.execute('SELECT * FROM orders')
#for row in cursor.fetchall():
#    print(row)

conn.close()