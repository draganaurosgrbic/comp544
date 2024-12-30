/** ListVisitor class that implements the reverseHelp(List<T>) method for type List<T>. */
class ReverseHelpVisitor<T extends Comparable<T>> implements ListVisitor<T,List<T>> {
  List<T> accum;
  ReverseHelpVisitor(List<T> a) { accum = a; }
  public List<T> forEmptyList(EmptyList<T> el) { return accum; }
  public List<T> forConsList(ConsList<T> cl)  { 
    return cl.rest().visit(new ReverseHelpVisitor<>(accum.cons(cl.first())));
  }
}