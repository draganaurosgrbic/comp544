import javafx.util.Pair;

/** The functional list type defined by List<T> := EmptyList<>() + ConsList(T, List<T>) */
interface List {

  /** Visitor hooks */
  Object visit(ListVisitor v);
                                                           
  /** Returns the empty list of type T, which is unique across all types. */
  default EmptyList empty() { return EmptyList.ONLY; }
  
  /** Adds i to the front of this. */
  default ConsList cons(Object o) { return new ConsList(o, this); }
  
  /* Overriding equals to implement structural equality */
  boolean equals(Object other);
    
  /* The List composite type overrides toString to provide a List-like string represenation. */
  
  /** A help function for producing a Lisp-like representation for List. Called by toString() and toStringHelp() */
  String toStringHelp();
  
  /* Interpreter pattern implementations of reverse, insert, insertSort, merge, partition, and mergeSort. */
  
  /** returns the elements of this in reverse order. */
  List reverse();
  /** helper method used to implement reverse() */
  List reverseHelp(List accum);
  
  /** Assuming that this is a list of elements of type T supporting Comparable<T>, returns this collection of elements
    * in ascending (non-descending) order */
  List insert(Comparable elt);
  
  /** Assuming that this is a list of elements of type T supporting Comparable<T>, mergeSort() returns a list 
    * containing exactly the same collection of elements in ascending (non-descending) order. */
  List insertSort();
  
  /** Assuming that this and right are both ascending (non-descending) lists of elements of type T supporting Comparable<T>,
    * merge(right) merges the two lists, i.e. returns the list containing the same collection of elements as this and right
    * in ascending order. */  
  List merge(List right);
  
  /** Paritions this by returning a pair (left, right) such that this and union(left,right) [generalized to multi-sets]
    * contain the same multi-sets of elements and the length [size] of left and right differ by at most 1. */
  Pair<List, List> partition();
  
  /** Assuming that this is a list of elements of type T supporting Comparable<T>, mergeSort() returns a list 
    * containg exactly the same collection of elements in ascending (non-descending) order. */
  List mergeSort();
}
 
/** Concrete empty list structure containing nothing. */
class EmptyList implements List {
  public static final EmptyList ONLY = new EmptyList();

  /* private constructor */
  private EmptyList() { }
  
  /** Visitor hooks */
  public Object visit(ListVisitor v) { return v.forEmptyList(this); }
  
  public boolean equals(Object o) { return o == ONLY; }
  
  /** Constructs a Lisp-like String representation. */
  public String toString() { return "()"; }
  /** Helper method for toString() that outputs the final closing paren of the Lisp string representation. */
  public String toStringHelp() { return ")"; }
  
  public List reverse() { return ONLY; }
  public List reverseHelp(List accum) { return accum; }
  
  public List insert(Comparable elt) { return (List) visit(new InsertVisitor(elt)); }
  
  public List insertSort() { return (List) visit(new InsertSortVisitor()); }

  public List mergeHelp(ConsList other) { return (List) visit(new MergeHelpVisitor(other)); }

  public List merge(List right) { return (List) visit(new MergeVisitor(right)); }
  
  public Pair<List, List> partition() { return (Pair<List, List>) visit(new PartitionVisitor()); }
  
  public List mergeSort() { return (List) visit(new MergeSortVisitor()); }
}   
  
/** Concrete non-empty list structure containing an element of T, called first, and a List<T> called rest. */
class ConsList implements List {
  
  /** Cons node fields */
  Object first;
  List rest;
  
  /** Data constructor for ConsList */
  ConsList(Object f, List r) { first = f; rest = r; }
  
  /** Accessors */
  public Object first() { return first; }
  public List rest() { return rest; }
  
  /** Visitor hooks */
  public Object visit(ListVisitor v) { return v.forConsList(this); }
  
  public boolean equals(Object o) { 
    if (o.getClass() != ConsList.class) return false;
    ConsList other = (ConsList) o;  // never fails
    return (other.first().equals(first)) && (other.rest().equals(rest));
  }
  
  /** Constructs a Lisp-like String representation. */
  public String toString() { return "(" + first + rest.toStringHelp(); }
  /** Help function for toString that formats every element with a preceding space */
  public String toStringHelp() { return " " + first + rest.toStringHelp(); }
    
  public List reverse() { return reverseHelp(EmptyList.ONLY); }

  public List reverseHelp(List accum) { return rest.reverseHelp(accum.cons(first)); }
  
  public List insert(Comparable elt) { return (List) visit(new InsertVisitor(elt)); }
  
  public List insertSort() { return (List) visit(new InsertSortVisitor()); }

  public List mergeHelp(ConsList other) { return (List) visit(new MergeHelpVisitor(other)); }

  public List merge(List right) { return (List) visit(new MergeVisitor(right)); }

  public Pair<List, List> partition() { return (Pair<List, List>) visit(new PartitionVisitor()); }

  public List mergeSort() { return (List) visit(new MergeSortVisitor()); }
}




  