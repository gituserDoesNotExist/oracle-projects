DECLARE
  FIRST_ITEM     PLAYGROUND.ITEM  := NEW PLAYGROUND.ITEM(10, 60);
  SECOND_ITEM    PLAYGROUND.ITEM  := NEW PLAYGROUND.ITEM(20, 100);
  THIRD_ITEM     PLAYGROUND.ITEM  := NEW PLAYGROUND.ITEM(30, 120);
  ITEMS_IN_STORE PLAYGROUND.ITEMS := PLAYGROUND.ITEMS(FIRST_ITEM, SECOND_ITEM, THIRD_ITEM);
  N_MAX_WEIGHT   NUMBER(19)       := 50;

  RES            PLAYGROUND.ITEM_ASSORTMENT;
  RES_ITEMS      PLAYGROUND.ITEMS;
  CURRENT_ITEM   PLAYGROUND.ITEM;

BEGIN
  DBMS_OUTPUT.PUT_LINE('finding best items');

  RES := KNAPSACK.GET_ITEMS_OPTIMIZING_VALUE(ITEMS_IN_STORE, N_MAX_WEIGHT);

  DBMS_OUTPUT.PUT_LINE('total weight is: ' || RES.GET_TOTAL_WEIGHT());
  DBMS_OUTPUT.PUT_LINE('total value is: ' || RES.GET_TOTAL_VALUE());
  DBMS_OUTPUT.PUT_LINE('took the following items:');
  RES_ITEMS := RES.GET_ASSORTMENTS();
  FOR IDX IN RES_ITEMS.first .. RES_ITEMS.last
  LOOP
    CURRENT_ITEM := RES_ITEMS(IDX);
    DBMS_OUTPUT.PUT_LINE('item with weight=' || CURRENT_ITEM.GET_WEIGHT() || ' and value=' || CURRENT_ITEM.GET_VALUE());
  END LOOP;

  DBMS_OUTPUT.PUT_LINE('finished');
END;