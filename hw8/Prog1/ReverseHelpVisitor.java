/** ListVisitor class that implements the reverseHelp(List accum) method on the host List. */
class ReverseHelpVisitor implements ListVisitor {
  List accum;
  ReverseHelpVisitor(List a) { accum = a; }
  public Object forEmptyList(EmptyList el) { return accum; }
  public Object forConsList(ConsList cl)  { 
    return cl.rest().visit(new ReverseHelpVisitor(accum.cons(cl.first()))); 
  }
}