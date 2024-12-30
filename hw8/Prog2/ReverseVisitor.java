/** ListVisitor class that implements the reverse() method for type List<T>. */
class ReverseVisitor<T extends Comparable<T>> implements ListVisitor<T,List<T>> {
  /* Relying on the default constructor */ 
  public List<T> forEmptyList(EmptyList<T> el) { return el; }
  public List<T> forConsList(ConsList<T> cl)  { return cl.visit(new ReverseHelpVisitor<>(cl.empty())); }
}