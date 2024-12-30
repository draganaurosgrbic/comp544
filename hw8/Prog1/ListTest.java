import javafx.util.Pair;
import junit.framework.TestCase;  // imported from the class files in junit.jar
/** A JUnit test case class.
  * Every method starting with the word "test" will be called when running this test class with JUnit.
  */
public class ListTest extends TestCase {
  
  static EmptyList e = EmptyList.ONLY;
  ConsList l0 = e.cons(0);                   // (0)
  ConsList l1 = e.cons(3).cons(5).cons(7);   // (7 5 3)
  ConsList l2 = e.cons(10).cons(8).cons(4);  // (4 8 10)
  // ConsList l3 = e.cons(10).cons(8).cons(7).cons(5).cons(4).cons(3);
  List l4 = countUp(100);
  List l7 = countDown(100);
  ConsList l5 = e.cons(3).cons(5).cons(7);   // (7 5 3)  [copy of l1]
  ConsList l6 = e.cons(7).cons(5).cons(3);   // (3 5 7)  [reverse of l1]
  ConsList l8 = e.cons(10).cons(9).cons(8).cons(4); // (4 8 9 10)
  ConsList l9 = e.cons(8).cons(7).cons(5).cons(3);  // (3 5 7 8)
  ConsList l10 = e.cons(10).cons(8).cons(6); // (6 8 10)
  // ConsList l11 = l10.cons(8);                // (8 6 8 10)
  // ConsList l12 = e.cons(10).cons(12).cons(6).cons(12);  // (12 6 12 10)
  ConsList l13 = e.cons(10).cons(8).cons(7).cons(5).cons(4).cons(3); // (3 4 5 7 8 10)
  ConsList l14 = e.cons(10).cons(10).cons(8).cons(8).cons(6).cons(4); // (4 6 8 8 10 10)
  List l15 = countUp(10000);
  List l16 = countDown(10000);
  
  // ConsList s1 = e.cons("Robert");
  ConsList s2 = e.cons("Hunena").cons("Barret");
  ConsList s3 = e.cons("Andrew").cons("David").cons("Kyle");
  ConsList s4 = s3.cons("Sam").cons("Daniel");
  ConsList s5 = e.cons("Hunena").cons("Corky").cons("Barret");
  ConsList s6 = e.cons("Barret").cons("Corky").cons("Hunena");
  ConsList s7 = e.cons("Andrew").cons("David");
  ConsList s8 = e.cons("Kyle");
  
  /** Utility functions for testing */
  static List countDown(int n) {
    if (n <= 0) return e;
    else return countDown(n-1).cons(n);
  }
  static List countUpHelp(int m, int n) {
    if (m > n) return e;
    else return countUpHelp(m+1,n).cons(m);
  }
  static List countUp(int n) { return countUpHelp(1,n); }


  /** Tests Lisp-like toString() method */
  public void testToString() {
    assertEquals("empty list string", "()", e.toString());
    assertEquals("Non-empty list string", "(7 5 3)", l1.toString());
  }
  
  /** Tests equals(Object o) method */
  public void testEquals() {
    assertTrue("empty list reflexivity", e.equals(e));
    assertFalse("Unequal lists 1", e.equals(e.cons(5)));
    assertFalse("Unequal lists 1", e.cons(5).equals(e));
    assertTrue("empty list reflexivity 2", e.equals(e));
    assertTrue("Non-empty List", l1.equals(l5));
    assertTrue("Medium list", l15.equals(l15));
    assertTrue("String list", s3.equals(s3));
  }
  
/** Tests insert method */
public void testInsert() {
    assertEquals("empty insert", l0, e.insert(0));
    assertEquals("pre insert test", l6.cons(0), l6.insert(0));
    assertEquals("general insert 1", l9, l6.insert(8));
    assertEquals("general insert 2", l8, l2.insert(9));
    assertEquals("post insert test", l9, l6.insert(8));
    assertEquals("s2 insert", s5, s2.insert("Corky"));
}

/** Tests InsertVisitor */
public void testInsertVisitor() {
    assertEquals("empty insert", l0, e.visit(new InsertVisitor(0)));
    assertEquals("general insert 1", l9, l6.visit(new InsertVisitor(8)));
    assertEquals("general insert 2", l8, l2.visit(new InsertVisitor(9)));
    assertEquals("post insert test", l9, l6.visit(new InsertVisitor(8)));
    assertEquals("string insert 3", s5, s2.visit(new InsertVisitor("Corky")));
}

/** Tests the insertSort method */
public void testInsertSort() {
    assertEquals("empty sort", e, e.insertSort());
    assertEquals("trivial sort", l0, l0.insertSort());
    assertEquals("sort inductive test", l6, l1.insertSort());
    assertEquals("medium sort test", l4, l7.insertSort());
    assertEquals("string sort test", s5, s6.insertSort());
}

/** Tests the insertSortVisitor */
public void testInsertSortVisitor() {
    assertEquals("empty sort", e, e.visit(new InsertSortVisitor()));
    assertEquals("trivial sort", l0, l0.visit(new InsertSortVisitor()));
    assertEquals("sort inductive test", l6, l1.visit(new InsertSortVisitor()));
    assertEquals("medium sort test", l4, l7.visit(new InsertSortVisitor()));
    assertEquals("string sort test", s5, s6.visit(new InsertSortVisitor()));
}
  
  /** Tests reverseHelp method */
  public void testReverseHelp() {
    assertEquals("empty reverse", e, e.reverseHelp(e));
    assertEquals("empty receiver, non-empty accum", l1, e.reverseHelp(l1));
    assertEquals("three-element reverseHelp from top-level", l1, l6.reverseHelp(e));
    assertEquals("string list reverse", s3, s8.reverseHelp(s7));
  }
  
  /** Tests reverseHelpVisitor */
  public void testReverseHelpVisitor() {
    assertEquals("empty reverse", e, e.visit(new ReverseHelpVisitor(e)));
    assertEquals("empty arg, non-empty accum", l1, e.visit(new ReverseHelpVisitor(l1)));
    assertEquals("top-level reverseHelp", l1, l6.visit(new ReverseHelpVisitor(e)));
    assertEquals("string list reverse", s3, s8.visit(new ReverseHelpVisitor(s7)));
  }
  
   /** Tests reverse method */
  public void testReverse() {
    assertEquals("empty reverse", e, e.reverse());
    assertEquals("singleton reverse", l0, l0.reverse());
    assertEquals("three element reverse", l1, l6.reverse());
    assertEquals("string reverse", s5, s6.reverse());
  }
  
  /** Tests ReverseVisitor */
  public void testReverseVisitor() {
    assertEquals("empty reverse", e, e.visit(new ReverseVisitor()));
    assertEquals("singleton reverse", l0, l0.reverse());
    assertEquals("three element reverse", l1, l6.visit(new ReverseVisitor()));
    assertEquals("string reverse", s6, s5.visit(new ReverseVisitor()));
  }

  /** Tests mergeHelp method */
  public void testMergeHelp() {
    assertEquals("empty receiver", l0, e.mergeHelp(l0));
    assertEquals("trivial merge 1", l2.cons(0), l2.mergeHelp(l0));
    assertEquals("trivial merge 2", l6.cons(0), l0.mergeHelp(l6));
    assertEquals("nodup merge", l13, l2.mergeHelp(l6));
    assertEquals("merge with dup", l14, l10.mergeHelp(l2));
  }

  /** Tests MergeHelpVisitor */
  public void testMergeHelpVisitor() {
    assertEquals("empty receiver", l0, e.visit(new MergeHelpVisitor(l0)));
    assertEquals("trivial merge 1", l2.cons(0), l2.visit(new MergeHelpVisitor(l0)));
    assertEquals("trivial merge 2", l6.cons(0), l0.visit(new MergeHelpVisitor(l6)));
    assertEquals("nodup merge", l13, l2.visit(new MergeHelpVisitor(l6)));
    assertEquals("merge with dup", l14, l10.visit(new MergeHelpVisitor(l2)));
  }

    /** Tests merge method */
  public void testMerge() {
    assertEquals("empty both", e, e.merge(e));
    assertEquals("trivial merge 1", l0, e.merge(l0));
    assertEquals("trivial merge 2", l0, l0.merge(e));
    assertEquals("nodup merge", l13, l2.merge(l6));
    assertEquals("merge with dup", l14, l10.merge(l2));
  }

    /** Tests MergeVisitor */
  public void testMergeVisitor() {
    assertEquals("empty both", e, e.visit(new MergeVisitor(e)));
    assertEquals("trivial merge 1", l0, e.visit(new MergeVisitor(l0)));
    assertEquals("trivial merge 2", l0, l0.visit(new MergeVisitor(e)));
    assertEquals("nodup merge", l13, l2.visit(new MergeVisitor(l6)));
    assertEquals("merge with dup", l14, l10.visit(new MergeVisitor(l2)));
  }

  /** Tests partition method */
  public void testPartition() {
    assertEquals("empty case", new Pair<List,List>(e, e), e.partition());
    assertEquals("partially empty case 1",  new Pair<List,List>(l0, e), l0.partition());
    assertEquals("partially empty case 2",  new Pair<List,List>(l0, e), l0.partition());
    assertEquals("trivial case",  new Pair<List,List>(e.cons(8),e.cons(10)), l2.rest().partition());
    assertEquals("general case", new Pair<List,List>(e.cons(3),e.cons(7).cons(5)), l6.partition());
    // assertEquals("big case", new Pair<List,List>(e,e), l7.visit(new PartitionVisitor()));
  }

    /** Tests PartitionVisitor */
  public void testPartitionVisitor() {
    assertEquals("empty case", new Pair<List,List>(e, e), e.visit(new PartitionVisitor()));
    assertEquals("partially empty case 1",  new Pair<List,List>(l0, e), l0.visit(new PartitionVisitor()));
    assertEquals("partially empty case 2",  new Pair<List,List>(l0, e), l0.visit(new PartitionVisitor()));
    assertEquals("trivial case",  new Pair<List,List>(e.cons(8),e.cons(10)), l2.rest().visit(new PartitionVisitor()));
    assertEquals("general case", new Pair<List,List>(e.cons(3),e.cons(7).cons(5)), l6.visit(new PartitionVisitor()));
    // assertEquals("big case", new Pair<List,List>(e,e), l7.visit(new PartitionVisitor()));
  }

  /** Tests mergeSort method */
  public void testMergeSort() {
    assertEquals("empty sort", e, e.mergeSort());
    assertEquals("trivial sort", l0, l0.mergeSort());
    assertEquals("sort inductive test", l6.toString(), l1.mergeSort().toString());
    assertEquals("medium sort test [toString]", l4.toString(), l7.mergeSort().toString());
    assertEquals("big sort test", l15, l16.visit(new MergeSortVisitor()));
    assertEquals("Competing sorts", s4.mergeSort(), s4.insertSort());
  }

  /** Tests MergeSortVisitor */
  public void testMergeSortVisitor() {
    assertEquals("empty sort", e, e.visit(new MergeSortVisitor()));
    assertEquals("trivial sort", l0, l0.visit(new MergeSortVisitor()));
    assertEquals("sort inductive test", l6.toString(), l1.visit(new MergeSortVisitor()).toString());
    assertEquals("medium sort test [toString]", l4.toString(), l7.visit(new MergeSortVisitor()).toString());
    assertEquals("big sort test", l15, l16.visit(new MergeSortVisitor()));
    assertEquals("Competing sorts", s4.mergeSort(), s4.insertSort());
  }
}
