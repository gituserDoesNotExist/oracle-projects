CREATE USER playground IDENTIFIED BY playground;

GRANT CONNECT TO playground;

GRANT RESOURCE,DBA TO playground;

GRANT CREATE SESSION TO playground;

GRANT UNLIMITED TABLESPACE TO playground;