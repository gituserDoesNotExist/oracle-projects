CREATE OR REPLACE TYPE "PLAYGROUND"."TEST_OBJECT" AUTHID DEFINER
  AS
  OBJECT (FIELD1 NUMBER,
          SOME_SHIT SHIT,
          CONSTRUCTOR FUNCTION TEST_OBJECT(P_SHIT IN OUT NOCOPY SHIT) RETURN SELF AS RESULT,
          MEMBER FUNCTION GET_VALUE
            RETURN NUMBER,
          MEMBER FUNCTION GET_SOME_SHIT
            RETURN SHIT);
/
CREATE OR REPLACE TYPE BODY "PLAYGROUND"."TEST_OBJECT" 
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
