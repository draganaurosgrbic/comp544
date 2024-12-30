import javafx.util.Pair;
import junit.framework.TestCase;  // imported from the class files in junit.jar
/** A JUnit test case class.
  * Every method starting with the word "test" will be called when running this test class with JUnit.
  */
public class ListTest extends TestCase {
  
  EmptyList<Integer> e = new EmptyList<>();
  ConsList<Integer> l0 = e.cons(0);                   // (0)
  ConsList<Integer> l1 = e.cons(3).cons(5).cons(7);   // (7 5 3)
  ConsList<Integer> l2 = e.cons(10).cons(8).cons(4);  // (4 8 10)
  ConsList<Integer> l3 = e.cons(10).cons(8).cons(7).cons(5).cons(4).cons(3);
  List<Integer> l4 = countUp(100);
  List<Integer> l7 = countDown(100);
  ConsList<Integer> l5 = e.cons(3).cons(5).cons(7);   // (7 5 3)  [copy of l1]
  ConsList<Integer> l6 = e.cons(7).cons(5).cons(3);   // (3 5 7)  [reverse of l1]
  ConsList<Integer> l8 = e.cons(10).cons(9).cons(8).cons(4); // (4 8 9 10)
  ConsList<Integer> l9 = e.cons(8).cons(7).cons(5).cons(3);  // (3 5 7 8)
  ConsList<Integer> l10 = e.cons(10).cons(8).cons(6); // (6 8 10)
  ConsList<Integer> l11 = l10.cons(8);                // (8 6 8 10)
  ConsList<Integer> l12 = e.cons(10).cons(12).cons(6).cons(12);  // (12 6 12 10)
  ConsList<Integer> l13 = e.cons(10).cons(8).cons(7).cons(5).cons(4).cons(3); // (3 4 5 7 8 10)
  ConsList<Integer> l14 = e.cons(10).cons(10).cons(8).cons(8).cons(6).cons(4); // (4 6 8 8 10 10)
  List<Integer> l15 = countUp(10000);
  List<Integer> l16 = countDown(10000);
  
  EmptyList<String> s0 = new EmptyList<>();
  ConsList<String> s1 = s0.cons("Robert");
  ConsList<String> s2 = s0.cons("Hunena").cons("Barret");
  ConsList<String> s3 = s0.cons("Andrew").cons("David").cons("Kyle");
  ConsList<String> s4 = s3.cons("Sam").cons("Daniel");
  ConsList<String> s5 = s0.cons("Hunena").cons("Corky").cons("Barret");
  ConsList<String> s6 = s0.cons("Barret").cons("Corky").cons("Hunena");
  ConsList<String> s7 = s0.cons("Andrew").cons("David");
  ConsList<String> s8 = s0.cons("Kyle");
  
  /** Utility functions for testing */
  static List<Integer> countDown(int n) {
    if (n <= 0) return new EmptyList<>();
    else return countDown(n-1).cons(n);
  }
  static List<Integer> countUpHelp(int m, int n) {
    if (m > n) return new EmptyList<>();
    else return countUpHelp(m+1,n).cons(m);
  }
  static List<Integer> countUp(int n) { return countUpHelp(1,n); }


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
    assertTrue("empty list reflexivity 2", e.equals(new EmptyList<Integer>()));
    assertTrue("Non-empty List<Integer>", l1.equals(l5));
    assertTrue("Medium list", l15.equals(l15));
    assertTrue("String list", s3.equals(s3));
  }

  /** Tests the reverseHelp method */
  public void testReverseHelp() {
    assertEquals("empty reverse", e, e.reverseHelp(e));
    assertEquals("empty receiver, non-empty accum", l1, e.visit(new ReverseHelpVisitor<>(l1)));
    assertEquals("three-element reverseHelp from top-level", l1, l6.visit(new ReverseHelpVisitor<>(e)));
    assertEquals("string list reverse", s3, s8.reverseHelp(s7));
  }

  /** Tests the ReverseHelpVisitor */
  public void testReverseHelpVisitor() {
    assertEquals("empty reverse", e, e.visit(new ReverseHelpVisitor<>(e)));
    assertEquals("empty arg, non-empty accum", l1, e.visit(new ReverseHelpVisitor<>(l1)));
    assertEquals("top-level reverseHelp", l1, l6.visit(new ReverseHelpVisitor<>(e)));
    assertEquals("string list reverse", s3, s8.visit(new ReverseHelpVisitor<>(s7)));
  }

  /** Tests the reverse method */
  public void testReverse() {
    assertEquals("empty reverse", e, e.reverse());
    assertEquals("singleton reverse", l0, l0.reverse());
    assertEquals("three element reverse", l1, l6.reverse());
    assertEquals("string reverse", s5, s6.reverse());
  }

  /** Tests the ReverseVisitor */
  public void testReverseVisitor() {
    assertEquals("empty reverse", e, e.visit(new ReverseVisitor<>()));
    assertEquals("singleton reverse", l0, l0.reverse());
    assertEquals("three element reverse", l1, l6.visit(new ReverseVisitor<>()));
    assertEquals("string reverse", s6, s5.visit(new ReverseVisitor<>()));
  }

  /** Tests the insert method */
  public void testInsert() {
    assertEquals("empty insert", l0, e.insert(0));
    assertEquals("pre insert test", l6.cons(0), l6.insert(0));
    assertEquals("general insert 1", l9, l6.insert(8));
    assertEquals("general insert 2", l8, l2.insert(9));
    assertEquals("post insert test", l9, l6.insert(8));
    assertEquals("s2 insert", s5, s2.insert("Corky"));
  }

  /** Tests the InsertVisitor */
  public void testInsertVisitor() {
    assertEquals("empty insert", l0, e.visit(new InsertVisitor<>(0)));
    assertEquals("general insert 1", l9, l6.visit(new InsertVisitor<>(8)));
    assertEquals("general insert 2", l8, l2.visit(new InsertVisitor<>(9)));
    assertEquals("post insert test", l9, l6.visit(new InsertVisitor<>(8)));
    assertEquals("string insert 3", s5, s2.visit(new InsertVisitor<>("Corky")));
  }

  /** Tests the insertSort method */
  public void testInsertSort() {
    assertEquals("empty sort", e, e.insertSort());
    assertEquals("trivial sort", l0, l0.insertSort());
    assertEquals("sort inductive test", l6, l1.insertSort());
    assertEquals("medium sort test", l4, l7.insertSort());
    assertEquals("string sort test", s5, s6.insertSort());
  }

  /** Tests the InsertSortVisitor */
  public void testInsertSortVisitor() {
    assertEquals("empty sort", e, e.visit(new InsertSortVisitor<>()));
    assertEquals("trivial sort", l0, l0.visit(new InsertSortVisitor<>()));
    assertEquals("sort inductive test", l6, l1.visit(new InsertSortVisitor<>()));
    assertEquals("medium sort test", l4, l7.visit(new InsertSortVisitor<>()));
    assertEquals("string sort test", s5, s6.visit(new InsertSortVisitor<>()));
  }

  /** Tests the mergeHelp method */
  public void testMergeHelp() {
    assertEquals("empty receiver", l0, e.mergeHelp(l0));
    assertEquals("trivial merge 1", l2.cons(0), l2.mergeHelp(l0));
    assertEquals("trivial merge 2", l6.cons(0), l0.mergeHelp(l6));
    assertEquals("nodup merge", l13, l2.mergeHelp(l6));
    assertEquals("merge with dup", l14, l10.mergeHelp(l2));
  }

  /** Tests the MergeHelpVisitor */
  public void testMergeHelpVisitor() {
    assertEquals("empty receiver", l0, e.visit(new MergeHelpVisitor<>(l0)));
    assertEquals("trivial merge 1", l2.cons(0), l2.visit(new MergeHelpVisitor<>(l0)));
    assertEquals("trivial merge 2", l6.cons(0), l0.visit(new MergeHelpVisitor<>(l6)));
    assertEquals("nodup merge", l13, l2.visit(new MergeHelpVisitor<>(l6)));
    assertEquals("merge with dup", l14, l10.visit(new MergeHelpVisitor<>(l2)));
  }

  /** Tests the merge method */
  public void testMerge() {
    assertEquals("empty both", e, e.merge(e));
    assertEquals("trivial merge 1", l0, e.merge(l0));
    assertEquals("trivial merge 2", l0, l0.merge(e));
    assertEquals("nodup merge", l13, l2.merge(l6));
    assertEquals("merge with dup", l14, l10.merge(l2));
  }

  /** Tests the MergeVisitor */
  public void testMergeVisitor() {
    assertEquals("empty both", e, e.visit(new MergeVisitor<>(e)));
    assertEquals("trivial merge 1", l0, e.visit(new MergeVisitor<>(l0)));
    assertEquals("trivial merge 2", l0, l0.visit(new MergeVisitor<>(e)));
    assertEquals("nodup merge", l13, l2.visit(new MergeVisitor<>(l6)));
    assertEquals("merge with dup", l14, l10.visit(new MergeVisitor<>(l2)));
  }

  /** Tests the partition method */
  public void testPartition() {
    assertEquals("empty case", new Pair<List<Integer>,List<Integer>>(e, e), e.partition());
    assertEquals("partially empty case 1",  new Pair<List<Integer>,List<Integer>>(l0, e), l0.partition());
    assertEquals("partially empty case 2",  new Pair<List<Integer>,List<Integer>>(l0, e), l0.partition());
    assertEquals("trivial case",  new Pair<List<Integer>,List<Integer>>(e.cons(8),e.cons(10)), l2.rest().partition());
    assertEquals("general case", new Pair<List<Integer>,List<Integer>>(e.cons(3),e.cons(7).cons(5)), l6.partition());
    // assertEquals("big case", new Pair<List,List>(e,e), l7.partition());
  }

  /** Tests the PartitionVisitor */
  public void testPartitionVisitor() {
    assertEquals("empty case", new Pair<List<Integer>,List<Integer>>(e, e), e.visit(new PartitionVisitor<>()));
    assertEquals("partially empty case 1",  new Pair<List<Integer>,List<Integer>>(l0, e), l0.visit(new PartitionVisitor<>()));
    assertEquals("partially empty case 2",  new Pair<List<Integer>,List<Integer>>(l0, e), l0.visit(new PartitionVisitor<>()));
    assertEquals("trivial case",  new Pair<List<Integer>,List<Integer>>(e.cons(8),e.cons(10)), l2.rest().visit(new PartitionVisitor<>()));
    assertEquals("general case", new Pair<List<Integer>,List<Integer>>(e.cons(3),e.cons(7).cons(5)), l6.visit(new PartitionVisitor<>()));
    // assertEquals("big case", new Pair<List,List>(e,e), l7.visit(new PartitionVisitor<Integer>()));
  }

  /** Tests the mergeSort method */
  public void testMergeSort() {
    assertEquals("empty sort", e, e.mergeSort());
    assertEquals("trivial sort", l0, l0.mergeSort());
    assertEquals("sort inductive test", l6, l1.mergeSort());
    assertEquals("medium sort test", l4, l7.mergeSort());
    assertEquals("big sort test", l15, l16.mergeSort());
    assertEquals("Competing sorts", s4.mergeSort(), s4.insertSort());
  }

  /** Tests the MergeSortVisitor */
  public void testMergeSortVisitor() {
    assertEquals("empty sort", e, e.visit(new MergeSortVisitor<>()));
    assertEquals("trivial sort", l0, l0.visit(new MergeSortVisitor<>()));
    assertEquals("sort inductive test", l6.toString(), l1.visit(new MergeSortVisitor<>()).toString());
    assertEquals("medium sort test [toString]", l4.toString(), l7.visit(new MergeSortVisitor<>()).toString());
    assertEquals("big sort test", l15, l16.visit(new MergeSortVisitor<>()));
    assertEquals("Competing sorts", s4.visit(new MergeSortVisitor<>()), s4.visit(new MergeSortVisitor<>()));
  }

  /** Tests the LengthVisitor */
  public void testLengthVisitor() {
    assertEquals("test length of e", 0, (int) e.visit(new LengthVisitor<>()));
    assertEquals("test length of l0", 1, (int) l0.visit(new LengthVisitor<>()));
    assertEquals("test length of l1", 3, (int) l1.visit(new LengthVisitor<>()));
    assertEquals("test length of l2", 3, (int) l2.visit(new LengthVisitor<>()));
    assertEquals("test length of l3", 6, (int) l3.visit(new LengthVisitor<>()));
    assertEquals("test length of l4", 100, (int) l4.visit(new LengthVisitor<>()));
    assertEquals("test length of l5", 3, (int) l5.visit(new LengthVisitor<>()));
    assertEquals("test length of l6", 3, (int) l6.visit(new LengthVisitor<>()));
    assertEquals("test length of l7", 100, (int) l7.visit(new LengthVisitor<>()));
    assertEquals("test length of l8", 4, (int) l8.visit(new LengthVisitor<>()));
    assertEquals("test length of l9", 4, (int) l9.visit(new LengthVisitor<>()));
    assertEquals("test length of l10", 3, (int) l10.visit(new LengthVisitor<>()));
    assertEquals("test length of l11", 4, (int) l11.visit(new LengthVisitor<>()));
    assertEquals("test length of l12", 4, (int) l12.visit(new LengthVisitor<>()));
    assertEquals("test length of l13", 6, (int) l13.visit(new LengthVisitor<>()));
    assertEquals("test length of l14", 6, (int) l14.visit(new LengthVisitor<>()));
    assertEquals("test length of l15", 10000, (int) l15.visit(new LengthVisitor<>()));
    assertEquals("test length of l16", 10000, (int) l16.visit(new LengthVisitor<>()));
    assertEquals("test length of s0", 0, (int) s0.visit(new LengthVisitor<>()));
    assertEquals("test length of s1", 1, (int) s1.visit(new LengthVisitor<>()));
    assertEquals("test length of s2", 2, (int) s2.visit(new LengthVisitor<>()));
    assertEquals("test length of s3", 3, (int) s3.visit(new LengthVisitor<>()));
    assertEquals("test length of s4", 5, (int) s4.visit(new LengthVisitor<>()));
    assertEquals("test length of s5", 3, (int) s5.visit(new LengthVisitor<>()));
    assertEquals("test length of s6", 3, (int) s6.visit(new LengthVisitor<>()));
    assertEquals("test length of s7", 2, (int) s7.visit(new LengthVisitor<>()));
    assertEquals("test length of s8", 1, (int) s8.visit(new LengthVisitor<>()));
  }

}
