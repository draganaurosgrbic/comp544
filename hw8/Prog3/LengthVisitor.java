/** IntListVisitor class that implements the length method on IntLists. Given the IntList il, the expression 
   * il.visit(new LengthVisitor.ONLY) returns the length of il. */
class LengthVisitor<T extends Comparable<T>> implements ListVisitor<T,Integer> {

    public Integer forEmptyList(EmptyList<T> el) { return 0; }
    public Integer forConsList(ConsList<T> cl)  { return 1 + cl.rest().visit(this); }

}
