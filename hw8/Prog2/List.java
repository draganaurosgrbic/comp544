import javafx.util.Pair;

/** The functional list type defined by List<T> := EmptyList<>() + ConsList(T, List<T>) */
interface List<T> {

  /** Visitor hooks */
  <R> R visit(ListVisitor<T,R> v);
                                                           
  /** Returns the empty list of type T, which is not unique. */
  default EmptyList<T> empty() { return new EmptyList<>(); }
  
  /** Adds i to the front of this. */
  default ConsList<T> cons(T t) { return new ConsList<>(t, this); }

  /* Overriding equals to implement structural equality */
  boolean equals(Object other);
    
  /* The List composite type overrides toString to provide a List-like string represenation. */
  
  /** A help function for producing a Lisp-like representation for List. Called by toString() and toStringHelp() */
  String toStringHelp();
  
  /* Interpreter pattern implementations of reverse, insert, insertSort, merge, partition, and mergeSort. */
  List<T> reverse();
  List<T> reverseHelp(List<T> accum);
  
  <TwO extends Comparable<TwO>> List<TwO> insert(TwO elt);

  <TwO extends Comparable<TwO>> List<TwO> insertSort();

  <TwO extends Comparable<TwO>> List<TwO> merge(List<TwO> right);

  <TwO extends Comparable<TwO>> List<TwO> mergeSort();

  <TwO extends Comparable<TwO>> Pair<List<TwO>,List<TwO>> partition();
}
 
/** Concrete empty list structure containing nothing. */
class EmptyList<T> implements List<T> {

  /* Relying on default constructor */
  
  /** Visitor hooks */
  public <R> R visit(ListVisitor<T,R> v) { return  v.forEmptyList(this); }

  private <TwO extends Comparable<TwO>,R extends List<TwO>> List<TwO> visit2(ListVisitor<TwO,R> v) {
    return v.forEmptyList((EmptyList<TwO>) this);
  }

  public boolean equals(Object o) { return o instanceof EmptyList; }
  
  /** Constructs a Lisp-like String representation. */
  public String toString() { return "()"; }
 
  public String toStringHelp() { return ")"; }
  
  public List<T> reverse() { return new EmptyList<>(); }
  public List<T> reverseHelp(List<T> accum) { return accum; }
  
  public <TwO extends Comparable<TwO>> List<TwO> insert(TwO elt) { return visit2(new InsertVisitor<>(elt)); }

  public <TwO extends Comparable<TwO>> List<TwO> insertSort() { return visit2(new InsertSortVisitor<TwO>()); }

  public <TwO extends Comparable<TwO>> List<TwO> mergeHelp(ConsList<TwO> right) { return visit2(new MergeHelpVisitor<>(right)); }

  public <TwO extends Comparable<TwO>> List<TwO> merge(List<TwO> right) { return visit2(new MergeVisitor<>(right)); }

  public <TwO extends Comparable<TwO>> Pair<List<TwO>,List<TwO>> partition() {
    EmptyList<TwO> temp = (EmptyList<TwO>) this;
    return temp.visit(new PartitionVisitor<>());
  }

  public <TwO extends Comparable<TwO>> List<TwO> mergeSort() { return visit2(new MergeSortVisitor<TwO>()); }
} 
  
/** Concrete non-empty list structure containing an element of T, called first, and a List<T> called rest. */
class ConsList<T> implements List<T> {
  
  /** Cons node fields */
  T first;
  List<T> rest;
  
  /** Data constructor for ConsList */
  ConsList(T f, List<T> r) { first = f; rest = r; }
  
  /** Accessors */
  public T first() { return first; }
  public List<T> rest() { return rest; }
  
  /** Visitor hook */
  public <R> R visit(ListVisitor<T,R> v) { return v.forConsList(this); }

  private <TwO extends Comparable<TwO>,R extends List<TwO>> List<TwO> visit2(ListVisitor<TwO,R> v) {
    return v.forConsList((ConsList<TwO>) this);
  }

  public boolean equals(Object o) { 
    if (o.getClass() != ConsList.class) return false;
    ConsList other = (ConsList) o;  // never fails
    return (other.first().equals(first)) && (other.rest().equals(rest));
  }
  
  /** Constructs a Lisp-like String representation. */
  public String toString() { return "(" + first + rest.toStringHelp(); }
  public String toStringHelp() { return " " + first + rest.toStringHelp(); }
    
  public List<T> reverse() { return reverseHelp(new EmptyList<>()); }
  
  public List<T> reverseHelp(List<T> accum) { return rest.reverseHelp(accum.cons(first)); }
  
  public <TwO extends Comparable<TwO>> List<TwO> insert(TwO elt) { return visit2(new InsertVisitor<>(elt)); }

  public <TwO extends Comparable<TwO>> List<TwO> insertSort() { return visit2(new InsertSortVisitor<TwO>()); }

  public <TwO extends Comparable<TwO>> List<TwO> mergeHelp(ConsList<TwO> right) { return visit2(new MergeHelpVisitor<>(right)); }

  public <TwO extends Comparable<TwO>> List<TwO> merge(List<TwO> right) { return visit2(new MergeVisitor<>(right)); }
    
  public <TwO extends Comparable<TwO>> Pair<List<TwO>,List<TwO>> partition() {
    ConsList<TwO> temp = (ConsList<TwO>) this;
    return temp.visit(new PartitionVisitor<>());
  }
  
  public <TwO extends Comparable<TwO>> List<TwO> mergeSort() { return visit2(new MergeSortVisitor<TwO>()); }
}




  