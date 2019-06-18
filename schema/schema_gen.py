#!/usr/bin/env python3
# -*- coding: utf-8 -*-


# AFIS Database Create
import sys, os, re
import pymysql
import config

# Database connection function
def connect_db(dbif):
    try:
        conn = pymysql.connect(host=dbif.HOST, 
                               port=dbif.PORT, 
                               user=dbif.USER, 
                               passwd=dbif.PASSWORD,
                               db=dbif.DBNAME,
                               charset=dbif.CHARSET,
                               autocommit=dbif.AUTOCOMMIT)
        curs = conn.cursor()

        curs.execute("SELECT VERSION()")
        ver = curs.fetchone()
        print("Database version: %s" % ver)
    except pymysql.Error as e:
        print("Error %d: %s" % (e.args[0],e.args[1]))
        sys.exit(1)
    else:
        print(dbif.DBNAME + " Database connect with " + dbif.USER + " user.")
    return conn, curs


# Drop Database function
def drop_database(cur, db_tar):
    try:
        cur.execute("DROP DATABASE {}".format(db_tar.DBNAME))
    except pymysql.Error as e:
        print("Error %d: %s" % (e.args[0], e.args[1]))
        print("Skip.")
    else:
        print(db_tar.DBNAME + " Database was droped!")


# Drop User function
def drop_user(cur, db_tar):
    try:
        cur.execute("DROP USER {}@'%'".format(db_tar.USER))
    except pymysql.Error as e:
        print("Error %d: %s" % (e.args[0],e.args[1]))
        print("Skip.")
    else:
        print(db_tar.USER + " user was droped!")


# Create Database function
def create_database(cur, db_tar):
    try:
        cur.execute("CREATE DATABASE {} DEFAULT CHARACTER SET UTF8".format(db_tar.DBNAME))
    except pymysql.Error as e:
        print("Error %d: %s" % (e.args[0],e.args[1]))
        sys.exit(1)
    else:
        print(db_tar.DBNAME + " Database was created!")


# Create User function
def create_user(cur, db_tar):
    try:
        cur.execute("CREATE USER '{}'@'%' IDENTIFIED BY '{}'".format(db_tar.USER, db_tar.PASSWORD))
    except pymysql.Error as e:
        print("Error %d: %s" % (e.args[0],e.args[1]))
        sys.exit(1)
    else:
        print(db_tar.USER + " user was created!")


# allow external connect function
def allow_ext_connection(cur, db_tar):
    try:
        cur.execute("GRANT ALL PRIVILEGES ON {}.* TO '{}'@localhost IDENTIFIED BY '{}' WITH GRANT OPTION".format(db_tar.DBNAME, db_tar.USER, db_tar.PASSWORD))
    except pymysql.Error as e:
        print("Error %d: %s" % (e.args[0],e.args[1]))
        sys.exit(1)
    else:
        print("External connection GRANT command executed!")


# allow internal connect function
def allow_int_connection(cur, db_tar):
    try:
        cur.execute("GRANT ALL PRIVILEGES ON {}.* TO '{}'@'%' IDENTIFIED BY '{}' WITH GRANT OPTION".format(db_tar.DBNAME, db_tar.USER, db_tar.PASSWORD))
    except pymysql.Error as e:
        print("Error %d: %s" % (e.args[0],e.args[1]))
        sys.exit(1)
    else:
        print("Local connection GRANT command executed!")


# database object grant to user
def grant_to_user(cur, db_tar):
    try:
        cur.execute("GRANT ALL PRIVILEGES ON {}.* TO {}@'%' IDENTIFIED BY '{}' WITH GRANT OPTION".format(db_tar.DBNAME, db_tar.USER, db_tar.PASSWORD))
    except pymysql.Error as e:
        print("Error %d: %s" % (e.args[0],e.args[1]))
        sys.exit(1)
    else:
        print("GRANT command executed!")

    try:
        cur.execute("GRANT ALL PRIVILEGES ON {}.* TO {}@'localhost' IDENTIFIED BY '{}' WITH GRANT OPTION".format(db_tar.DBNAME, db_tar.USER, db_tar.PASSWORD))
    except pymysql.Error as e:
        print("Error %d: %s" % (e.args[0],e.args[1]))
        sys.exit(1)
    else:
        print("GRANT command executed!")

    try:
        cur.execute("GRANT USAGE ON {}.* TO '{}'@'%'".format(db_tar.DBNAME, db_tar.USER))
    except pymysql.Error as e:
        print("Error %d: %s" % (e.args[0],e.args[1]))
        sys.exit(1)
    else:
        print("GRANT command executed!")


# =============================================
# Main process
# =============================================
db_root = config.Root
db_redspush = config.RedsPush

# root사용자로 연결하여 신규 데이터베이스를 생성한다.
con, cur = connect_db(db_root)          # 01. Database connection 
drop_database(cur, db_redspush)         # 02. Drop User Database
drop_user(cur, db_redspush)             # 03. Drop User
create_database(cur, db_redspush)       # 04. Create User Database
create_user(cur, db_redspush)           # 05. Create User
allow_ext_connection(cur, db_redspush)  # 06. allow external connect 
allow_int_connection(cur, db_redspush)  # 07. allow internal connect 
grant_to_user(cur, db_redspush)         # 08. database object grant to user
cur.execute("FLUSH PRIVILEGES")
cur.close()
con.close()

# 생성된 새 계정으로 접속하여 schema object를 생성한다.
con, cur = connect_db(db_redspush)

cur_path = os.path.dirname(os.path.realpath(__file__))
#print(cur_path)

# 생성할 db object query가 있는 디렉토리명
db_obj_dir = ["table", "proc"]
for directory in db_obj_dir:
    qry_path = os.path.join(cur_path, "query", directory)
    #print(qry_path)
    files = os.listdir(qry_path)
    #print(files)

    for file in files:
        fn = os.path.join(qry_path, file)
        f = open(fn, mode='r', buffering=1, encoding='utf-8')
        
        query = ''
        for line in f:
            line = line.strip()
            
            if directory == 'table':  # table, view, DML
                if line[:2] in ['--'] or line == '': continue
                if line.startswith('/*') and (line.endswith('*/') or line.endswith('*/;')): continue
                
                query += line + '\n'
                if line[-1] == ';':
                    rtn = cur.execute(query)
                    print(rtn, fn)
                    query = ''
            else:                   # procedure 생성
                if line[:2] in ['--'] or line == '': continue
                if line.startswith('/*') and (line.endswith('*/') or line.endswith('*/;')): continue
                
                if line.startswith('DELIMITER'):
                    delimiter = line[10:]
                else:
                    query += line + '\n'
                    if line.endswith(delimiter):
                        query = query.strip().strip(delimiter)
                        rtn = cur.execute(query)
                        print(rtn, fn)
                        query = ''
                    
        f.close()

  
