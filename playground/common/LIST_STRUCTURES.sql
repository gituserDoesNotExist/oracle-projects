﻿DROP TYPE INTEGER_ARRAY FORCE;
DROP TYPE INTEGER_MATRIX FORCE;

CREATE TYPE INTEGER_ARRAY AS VARRAY(1000) OF NUMBER(19);
/
CREATE TYPE INTEGER_MATRIX IS VARRAY (100000000) OF INTEGER_ARRAY;