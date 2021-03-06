CREATE OR REPLACE PACKAGE BODY "PLAYGROUND"."KNAPSACK" 
  AS


  --#####################################################################

  FUNCTION DECIDE_TO_ADD_CUR_ITEM_OR_NOT(P_SUB_SOLUTION_MATRIX IN PLAYGROUND.INTEGER_MATRIX,
                                         P_CURRENT_ITEM        IN PLAYGROUND.ITEM,
                                         P_ROW_IDX             IN INTEGER,
                                         P_COL_IDX             IN INTEGER)
    RETURN INTEGER
    IS
      N_VALUE_WITHOUT_ITEM           INTEGER;
      N_CAPACITY_AFTER_ITEM_ADDED    INTEGER;
      N_MAX_VALUE_WITH_REST_CAPACITY INTEGER;
      VALUE_INCLUDING_CURRENT_ITEM   INTEGER;
      N_IMAGINARY_KNAPSACK_CAPACITY  INTEGER := P_COL_IDX - 1;
    BEGIN
      -- get value if current item is not added into knapsack
      N_VALUE_WITHOUT_ITEM := P_SUB_SOLUTION_MATRIX(P_ROW_IDX - 1)(P_COL_IDX);

      -- check value if current item is added to knapsack
      N_CAPACITY_AFTER_ITEM_ADDED := N_IMAGINARY_KNAPSACK_CAPACITY - P_CURRENT_ITEM.GET_WEIGHT();
      N_MAX_VALUE_WITH_REST_CAPACITY := P_SUB_SOLUTION_MATRIX(P_ROW_IDX - 1)(N_CAPACITY_AFTER_ITEM_ADDED + 1);-- add 1 to capacity as index of arrays start at 1 not 0
      VALUE_INCLUDING_CURRENT_ITEM := P_CURRENT_ITEM.GET_VALUE() + N_MAX_VALUE_WITH_REST_CAPACITY;




      RETURN GREATEST(N_VALUE_WITHOUT_ITEM, VALUE_INCLUDING_CURRENT_ITEM);
    END DECIDE_TO_ADD_CUR_ITEM_OR_NOT;

  --#################################################################################

  FUNCTION FIND_BEST_ITEMS_VIA_BACKTRCKNG(P_SUB_SOLUTIONS  IN PLAYGROUND.INTEGER_MATRIX,
                                          P_ITEMS_IN_STORE IN PLAYGROUND.ITEMS)
    RETURN PLAYGROUND.ITEMS
    AS
      NUMBER_OF_ROWS                 INTEGER          := P_SUB_SOLUTIONS.count;
      NUMBER_OF_COLUMNS              INTEGER          := P_SUB_SOLUTIONS(1).count;

    CURRENT_ROW_IDX INTEGER := NUMBER_OF_ROWS;
      CURRENT_COLUMN_IDX             INTEGER := NUMBER_OF_COLUMNS;
      MAX_VALUE_OF_ITEMS_IN_KNAPSACK INTEGER;
      ITEM_TO_ADD         PLAYGROUND.ITEM;
      ITEMS_ADDED_TO_KNAPSACK              PLAYGROUND.ITEMS := PLAYGROUND.ITEMS();
    BEGIN
      MAX_VALUE_OF_ITEMS_IN_KNAPSACK := P_SUB_SOLUTIONS(NUMBER_OF_ROWS)(NUMBER_OF_COLUMNS);
      CURRENT_COLUMN_IDX := NUMBER_OF_COLUMNS;
      WHILE CURRENT_ROW_IDX > 1 AND max_value_of_items_in_knapsack > 0
      LOOP
        IF MAX_VALUE_OF_ITEMS_IN_KNAPSACK > P_SUB_SOLUTIONS(CURRENT_ROW_IDX - 1)(CURRENT_COLUMN_IDX)
        THEN
          ITEMS_ADDED_TO_KNAPSACK.extend();
          ITEM_TO_ADD := P_ITEMS_IN_STORE(CURRENT_ROW_IDX - 1);
          ITEMS_ADDED_TO_KNAPSACK(ITEMS_ADDED_TO_KNAPSACK.last) := ITEM_TO_ADD;
          CURRENT_COLUMN_IDX := CURRENT_COLUMN_IDX - ITEM_TO_ADD.GET_WEIGHT();
          MAX_VALUE_OF_ITEMS_IN_KNAPSACK := MAX_VALUE_OF_ITEMS_IN_KNAPSACK - ITEM_TO_ADD.GET_VALUE();
        END IF;
        CURRENT_ROW_IDX := CURRENT_ROW_IDX - 1;
      END LOOP;
      RETURN ITEMS_ADDED_TO_KNAPSACK;
    END FIND_BEST_ITEMS_VIA_BACKTRCKNG;

  --##################################################################################

  FUNCTION GET_BEST_VALUE(P_ITEMS_IN_STORE IN     PLAYGROUND.ITEMS,
                          P_MAX_KNAPSACK_CAPACITY NUMBER)
    RETURN PLAYGROUND.ITEMS
    AS
      SUB_SOLUTIONS               PLAYGROUND.INTEGER_MATRIX;
      N_NUMBER_OF_REQ_ROWS        INTEGER;
      N_NUMBER_OF_REQ_COLUMNS     INTEGER;
      CURRENT_ITEM                PLAYGROUND.ITEM;
      CURRENT_SUB_SOLUTION        INTEGER;
      IMAGINARY_KNAPSACK_CAPACITY INTEGER;

      ITEMS_FOR_KNAPSACK          PLAYGROUND.ITEMS;
    BEGIN
      N_NUMBER_OF_REQ_ROWS := P_ITEMS_IN_STORE.count + 1;
      N_NUMBER_OF_REQ_COLUMNS := P_MAX_KNAPSACK_CAPACITY + 1;

      SUB_SOLUTIONS := PLAYGROUND.LIST_UTILS.CREATE_EMPTY_INTEGER_MATRIX(N_NUMBER_OF_REQ_ROWS, N_NUMBER_OF_REQ_COLUMNS);

      -- start at index 2, as first row in matrix corresponds to Item0 (without items no value in knapsack)
      FOR ROW_IDX IN 2 .. N_NUMBER_OF_REQ_ROWS
      LOOP
        CURRENT_ITEM := P_ITEMS_IN_STORE(ROW_IDX - 1);
        -- start at index 2, as first col in matrix corresponds to zero capacity (without knapsack capacity you can't put anything in it)
        FOR COL_IDX IN 2 .. N_NUMBER_OF_REQ_COLUMNS
        LOOP
          IMAGINARY_KNAPSACK_CAPACITY := COL_IDX - 1;
          IF IMAGINARY_KNAPSACK_CAPACITY >= CURRENT_ITEM.GET_WEIGHT()
          THEN
            SUB_SOLUTIONS(ROW_IDX)(COL_IDX) := KNAPSACK.DECIDE_TO_ADD_CUR_ITEM_OR_NOT(SUB_SOLUTIONS, CURRENT_ITEM, ROW_IDX, COL_IDX);
          ELSE
            SUB_SOLUTIONS(ROW_IDX)(COL_IDX) := SUB_SOLUTIONS(ROW_IDX - 1)(COL_IDX);-- add 1 to capacity as index of arrays start at 1 not 0
          END IF;
        END LOOP;
      END LOOP;
      PLAYGROUND.PRINT_MATRIX(SUB_SOLUTIONS);

      ITEMS_FOR_KNAPSACK := FIND_BEST_ITEMS_VIA_BACKTRCKNG(SUB_SOLUTIONS, P_ITEMS_IN_STORE);

      RETURN ITEMS_FOR_KNAPSACK;
    END GET_BEST_VALUE;




END KNAPSACK;
/
