CREATE OR REPLACE PACKAGE BODY "PLAYGROUND"."TEST_KNAPSACK" 
  AS



  -- #########################################################################################################


  PROCEDURE GET_BEST_VALUE
    AS
      N_MAX_KNAPSACK_CAPACITY    NUMBER           := 10;

      ITEM1                      PLAYGROUND.ITEM  := NEW PLAYGROUND.ITEM(5, 10);
      ITEM2                      PLAYGROUND.ITEM  := NEW PLAYGROUND.ITEM(4, 40);
      ITEM3                      PLAYGROUND.ITEM  := NEW PLAYGROUND.ITEM(6, 30);
      ITEM4                      PLAYGROUND.ITEM  := NEW PLAYGROUND.ITEM(3, 50);
      ITEMS_IN_STORE             PLAYGROUND.ITEMS := PLAYGROUND.ITEMS(ITEM1, ITEM2, ITEM3, ITEM4);
      EXPECTED_ITEMS_IN_KNAPSACK PLAYGROUND.ITEMS := PLAYGROUND.ITEMS(ITEM4, ITEM2);
      ACTUAL_ITEMS_IN_KNAPSACK   PLAYGROUND.ITEMS;
    BEGIN
      ACTUAL_ITEMS_IN_KNAPSACK := PLAYGROUND.KNAPSACK.GET_BEST_VALUE(ITEMS_IN_STORE, N_MAX_KNAPSACK_CAPACITY);

      FOR IDX IN 1 .. ACTUAL_ITEMS_IN_KNAPSACK.count
      LOOP
        UT.EXPECT(ACTUAL_ITEMS_IN_KNAPSACK(IDX).GET_VALUE()).to_equal(EXPECTED_ITEMS_IN_KNAPSACK(IDX).GET_VALUE());
      END LOOP;
    END GET_BEST_VALUE;


  -- #########################################################################################################


  PROCEDURE GET_BEST_VALUE_STORE_EMPTY
    AS
      ACTUAL_ITEMS_IN_KNAPSACK   PLAYGROUND.ITEMS;

      ITEMS PLAYGROUND.ITEMS := PLAYGROUND.ITEMS();
    BEGIN
      ACTUAL_ITEMS_IN_KNAPSACK := PLAYGROUND.KNAPSACK.GET_BEST_VALUE(ITEMS, 100);

      UT.EXPECT(ACTUAL_ITEMS_IN_KNAPSACK.COUNT).TO_EQUAL(0);
    END GET_BEST_VALUE_STORE_EMPTY;


  -- #########################################################################################################


  PROCEDURE GET_BEST_VALUE_NO_CAPACITY
    AS
      ACTUAL_ITEMS_IN_KNAPSACK PLAYGROUND.ITEMS;

      ITEM1 PLAYGROUND.ITEM  := NEW PLAYGROUND.ITEM(6, 30);
      ITEM2 PLAYGROUND.ITEM  := NEW PLAYGROUND.ITEM(3, 50);
      ITEMS PLAYGROUND.ITEMS := PLAYGROUND.ITEMS(ITEM1, ITEM2);
    BEGIN
      ACTUAL_ITEMS_IN_KNAPSACK := PLAYGROUND.KNAPSACK.GET_BEST_VALUE(ITEMS, 0);

      UT.EXPECT(ACTUAL_ITEMS_IN_KNAPSACK.COUNT).TO_EQUAL(0);
    END GET_BEST_VALUE_NO_CAPACITY;



END TEST_KNAPSACK;
/
