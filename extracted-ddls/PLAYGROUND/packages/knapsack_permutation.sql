CREATE OR REPLACE PACKAGE "PLAYGROUND"."KNAPSACK_PERMUTATION" AUTHID DEFINER
  IS
  FUNCTION GET_ITEMS_OPTIMIZING_VALUE(P_ITEMS_IN_STORE IN PLAYGROUND.ITEMS,
                                      P_N_MAX_WEIGHT IN NUMBER)
    RETURN PLAYGROUND.ITEM_ASSORTMENT;

END KNAPSACK_PERMUTATION;
/
