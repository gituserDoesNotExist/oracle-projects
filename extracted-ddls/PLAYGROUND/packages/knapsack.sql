CREATE OR REPLACE PACKAGE "PLAYGROUND"."KNAPSACK" AUTHID DEFINER
  AS
  FUNCTION GET_BEST_VALUE(P_ITEMS_IN_STORE IN     PLAYGROUND.ITEMS,
                          P_MAX_KNAPSACK_CAPACITY NUMBER)
    RETURN PLAYGROUND.ITEMS;
END KNAPSACK;
/
