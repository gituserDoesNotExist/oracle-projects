CREATE OR REPLACE PACKAGE "PLAYGROUND"."TEST_LIST_UTILS" AUTHID DEFINER
  AS

  -- %suite(test package for "LIST_UTILS" package)
  -- %test(test CREATE_INTEGER_ARRAY_FROM_TO - Passing 1,5; should create [1,2,3,4,5]
  PROCEDURE CREATE_INTEGER_ARRAY_FROM_TO;

    -- %test(test CREATE_EMPTY_INTEGER_MATRIX
  PROCEDURE CREATE_EMPTY_INTEGER_MATRIX;


END TEST_LIST_UTILS;
/
