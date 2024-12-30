/** IntListVisitor class that implements the length method on IntLists. Given the IntList il, the expression 
   * il.visit(new LengthVisitor.ONLY) returns the length of il. */
class LengthVisitor implements ListVisitor {

    @Override
    public Object forEmptyList(EmptyList el) { return 0; }

    @Override
    public Object forConsList(ConsList cil) { return 1 + (Integer) cil.rest().visit(this); }
}