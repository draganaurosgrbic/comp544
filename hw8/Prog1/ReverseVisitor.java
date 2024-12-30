/** ListVisitor class that implements the reverse() method on the host List. */
class ReverseVisitor implements ListVisitor {
   
  /* Relying on the default constructor */ 
  public Object forEmptyList(EmptyList el) { return el; }
  public Object forConsList(ConsList cl)  { return cl.visit(new ReverseHelpVisitor(cl.empty())); }
}