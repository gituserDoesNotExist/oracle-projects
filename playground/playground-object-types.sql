﻿DROP TYPE SHIT FORCE;
DROP TYPE TEST_OBJECT FORCE;

CREATE OR REPLACE TYPE SHIT AUTHID DEFINER
  AS
  OBJECT (SOME_TEXT NVARCHAR2(100),
          SOME_OTHER_TEXT NVARCHAR2(100),
          MEMBER PROCEDURE SET_SOME_TEXT(SELF IN OUT NOCOPY SHIT,
                                         NEW_TEXT           VARCHAR2),
          CONSTRUCTOR FUNCTION SHIT(P_TEXT NVARCHAR2)
            RETURN SELF AS RESULT);
/

CREATE OR REPLACE TYPE BODY SHIT
  AS

    CONSTRUCTOR FUNCTION SHIT(P_TEXT NVARCHAR2)
      RETURN SELF AS RESULT
      AS
      BEGIN
        SELF.SOME_TEXT := P_TEXT;
        RETURN;
      END;

    MEMBER PROCEDURE SET_SOME_TEXT(SELF IN OUT NOCOPY SHIT,
                                   NEW_TEXT           VARCHAR2)
      AS
      BEGIN
        SELF.SOME_TEXT := NEW_TEXT;
      END SET_SOME_TEXT;

  END;
/


CREATE OR REPLACE TYPE TEST_OBJECT AUTHID DEFINER
  AS
  OBJECT (FIELD1 NUMBER,
          SOME_SHIT SHIT,
          CONSTRUCTOR FUNCTION TEST_OBJECT(P_SHIT IN OUT NOCOPY SHIT) RETURN SELF AS RESULT,
          MEMBER FUNCTION GET_VALUE
            RETURN NUMBER,
          MEMBER FUNCTION GET_SOME_SHIT
            RETURN SHIT);
/

CREATE OR REPLACE TYPE BODY TEST_OBJECT
  AS
    CONSTRUCTOR FUNCTION TEST_OBJECT(P_SHIT IN OUT NOCOPY SHIT)
      RETURN SELF AS RESULT
      AS
      BEGIN
        SELF.SOME_SHIT := P_SHIT;
        RETURN;
      END;
    MEMBER FUNCTION GET_VALUE
      RETURN NUMBER
      AS
      BEGIN
        RETURN SELF.FIELD1;
      END GET_VALUE;

    MEMBER FUNCTION GET_SOME_SHIT
      RETURN SHIT
      AS
      BEGIN
        RETURN SELF.SOME_SHIT;
      END GET_SOME_SHIT;

  END;
/
