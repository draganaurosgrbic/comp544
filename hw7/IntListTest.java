import junit.framework.TestCase;  // imported from the class files in junit.jar
/** A JUnit test case class.
  * Every method starting with the word "test" will be called when running this test class with JUnit.
  */
public class IntListTest extends TestCase {
  
  EmptyIntList e = IntList.empty();
  IntList l1 = e.cons(7).cons(5).cons(3);
  IntList l2 = e.cons(3).cons(7).cons(5);  // structurally equal to l5 below
  IntList l3 = IntList.countDown(50);
  IntList l4 = IntList.countUp(50);
  IntList l5 = e.cons(3).cons(7).cons(5);  // structurally equal to l2 above

  
  /** Tests Lisp-like toString() method */
  public void testToString() {
    assertEquals("empty list string", "()", e.toString());
    assertEquals("Non-empty list string", l1.toString(), l2.sort().toString());

    assertEquals("test toString on empty().cons(1).cons(2).cons(3)", "(3 2 1)", IntList.empty().cons(1).cons(2).cons(3).toString());
    assertEquals("test toString on empty().cons(4).cons(5)", "(5 4)", IntList.empty().cons(4).cons(5).toString());
  }
  
  /** Tests equals(Object o) method */
  public void testEquals() {
    assertTrue("empty list reflexivity", e.equals(e));
    assertTrue("Non-empty IntList", l2.equals(l5));

    assertEquals("test equals empty().cons(1) with empty().cons(1)", IntList.empty().cons(1), IntList.empty().cons(1));
    assertEquals("test equals empty().cons(1).cons(2) with empty().cons(1).cons(2)", IntList.empty().cons(1).cons(2), IntList.empty().cons(1).cons(2));
  }
  
  /** Tests sort() method */
  public void testSort() {
    assertEquals("empty sort", e, e.sort());
    assertEquals("sort inductive test", l1.toString(), l2.sort().toString());
    assertEquals("big sort test [toString]", l4.toString(), l3.sort().toString());  // toString() equality
    assertEquals("big sort test", l4, l3.sort());

    assertEquals("test sort empty().cons(1).cons(2).cons(3).cons(4)", IntList.empty().cons(1).cons(2).cons(3).cons(4).sort(), IntList.empty().cons(4).cons(3).cons(2).cons(1));
    assertEquals("test sort empty().cons(5).cons(6).cons(7).cons(8)", IntList.empty().cons(5).cons(6).cons(7).cons(8).sort(), IntList.empty().cons(8).cons(7).cons(6).cons(5));
  }
                 
  /** Tests LengthVisitor.  */
  public void testLength() {
    assertEquals("empty list test", e, EmptyIntList.ONLY );
    assertEquals("LengthVisitor empty test", 0, e.visit(LengthVisitor.ONLY));
    assertEquals("LengthVisitor inductive test", 3, l1.visit(LengthVisitor.ONLY));

    assertEquals("test length of empty().cons(1).cons(2).cons(3).cons(4)", 4, IntList.empty().cons(1).cons(2).cons(3).cons(4).visit(LengthVisitor.ONLY));
    assertEquals("test length of empty().cons(5).cons(6).cons(7).cons(8)", 4, IntList.empty().cons(5).cons(6).cons(7).cons(8).visit(LengthVisitor.ONLY));
  }
  
  /** Tests ScalarProductVisitor. */
  public void testScalaProduct() {
    assertEquals("ScalarProductVisitor empty test", 0, e.visit(new ScalarProductVisitor(e)));
    assertEquals("LengthVisitor inductive test", 71, l1.visit(new ScalarProductVisitor(l2)));

    assertEquals("test scalar product of empty().cons(1).cons(2) with empty().cons(3).cons(4)", 11, IntList.empty().cons(1).cons(2).visit(new ScalarProductVisitor(IntList.empty().cons(3).cons(4))));
    assertEquals("test scalar product of empty().cons(5).cons(6) with empty().cons(7).cons(8)", 83, IntList.empty().cons(5).cons(6).visit(new ScalarProductVisitor(IntList.empty().cons(7).cons(8))));
  }

  /** Tests ReverseVisitor. */
  public void testReverse() {
    assertEquals("test reverse empty()", IntList.empty().visit(ReverseVisitor.ONLY), IntList.empty());
    assertEquals("test reverse empty().cons(1)", IntList.empty().cons(1).visit(ReverseVisitor.ONLY), IntList.empty().cons(1));
    assertEquals("test reverse empty().cons(1).cons(2)", IntList.empty().cons(1).cons(2).visit(ReverseVisitor.ONLY), IntList.empty().cons(2).cons(1));
    assertEquals("test reverse empty().cons(1).cons(2).cons(3)", IntList.empty().cons(1).cons(2).cons(3).visit(ReverseVisitor.ONLY), IntList.empty().cons(3).cons(2).cons(1));
    assertEquals("test reverse empty().cons(1).cons(2).cons(3).cons(4)", IntList.empty().cons(1).cons(2).cons(3).cons(4).visit(ReverseVisitor.ONLY), IntList.empty().cons(4).cons(3).cons(2).cons(1));
    assertEquals("test reverse empty().cons(1).cons(2).cons(3).cons(4).cons(5)", IntList.empty().cons(1).cons(2).cons(3).cons(4).cons(5).visit(ReverseVisitor.ONLY), IntList.empty().cons(5).cons(4).cons(3).cons(2).cons(1));
  }

  /** Tests NotGreaterThanVisitor. */
  public void testNotGreaterThan() {
    assertEquals("test not greater than 0 on empty() = empty()", IntList.empty().visit(new NotGreaterThanVisitor(0)), IntList.empty());
    assertEquals("test not greater than 0 on empty().cons(1) = empty()", IntList.empty().cons(1).visit(new NotGreaterThanVisitor(0)), IntList.empty());
    assertEquals("test not greater than 1 on empty().cons(1) = empty().cons(1)", IntList.empty().cons(1).visit(new NotGreaterThanVisitor(1)), IntList.empty().cons(1));
    assertEquals("test not greater than 0 on empty().cons(1).cons(2) = empty()", IntList.empty().cons(1).cons(2).visit(new NotGreaterThanVisitor(0)), IntList.empty());
    assertEquals("test not greater than 1 on empty().cons(1).cons(2) = empty().cons(1)", IntList.empty().cons(1).cons(2).visit(new NotGreaterThanVisitor(1)), IntList.empty().cons(1));
    assertEquals("test not greater than 2 on empty().cons(1).cons(2) = empty().cons(1).cons(2)", IntList.empty().cons(1).cons(2).visit(new NotGreaterThanVisitor(2)), IntList.empty().cons(1).cons(2));
  }

  /** Tests RemoveVisitor. */
  public void testRemove() {
    assertEquals("test remove 0 from empty() = empty()", IntList.empty().visit(new RemoveVisitor(0)), IntList.empty());
    assertEquals("test remove 0 from empty().cons(1) = empty().cons(1)", IntList.empty().cons(1).visit(new RemoveVisitor(0)), IntList.empty().cons(1));
    assertEquals("test remove 1 from empty().cons(1) = empty()", IntList.empty().cons(1).visit(new RemoveVisitor(1)), IntList.empty());
    assertEquals("test remove 0 from empty().cons(1).cons(2) = empty().cons(1).cons(2)", IntList.empty().cons(1).cons(2).visit(new RemoveVisitor(0)), IntList.empty().cons(1).cons(2));
    assertEquals("test remove 1 from empty().cons(1).cons(2) = empty().cons(2)", IntList.empty().cons(1).cons(2).visit(new RemoveVisitor(1)), IntList.empty().cons(2));
    assertEquals("test remove 1 and 2 from empty().cons(1).cons(2) = empty()", ((IntList) IntList.empty().cons(1).cons(2).visit(new RemoveVisitor(1))).visit(new RemoveVisitor(2)), IntList.empty());
  }

  /** Tests SubstVisitor. */
  public void testSubst() {
    assertEquals("test replace 0 with 1 in empty() = empty()", IntList.empty().visit(new SubstVisitor(0, 1)), IntList.empty());
    assertEquals("test replace 0 with 1 in empty().cons(1) = empty().cons(1)", IntList.empty().cons(1).visit(new SubstVisitor(0, 1)), IntList.empty().cons(1));
    assertEquals("test replace 1 with 2 in empty().cons(1) = empty().cons(2)", IntList.empty().cons(1).visit(new SubstVisitor(1, 2)), IntList.empty().cons(2));
    assertEquals("test replace 0 with 1 in empty().cons(1).cons(2) = empty().cons(1).cons(2)", IntList.empty().cons(1).cons(2).visit(new SubstVisitor(0, 1)), IntList.empty().cons(1).cons(2));
    assertEquals("test replace 1 with 3 in empty().cons(1).cons(2) = empty().cons(3).cons(2)", IntList.empty().cons(1).cons(2).visit(new SubstVisitor(1, 3)), IntList.empty().cons(3).cons(2));
    assertEquals("test replace 2 with 3 in empty().cons(1).cons(2) = empty().cons(1).cons(3)", IntList.empty().cons(1).cons(2).visit(new SubstVisitor(2, 3)), IntList.empty().cons(1).cons(3));
  }

  /** Tests MergeHelpVisitor. */
  public void testMergeHelp() {
    assertEquals("test merge help empty() and empty().cons(5).cons(3).cons(1)", IntList.empty().visit(new MergeHelpVisitor(IntList.empty().cons(5).cons(3).cons(1))), IntList.empty().cons(5).cons(3).cons(1));
    assertEquals("test merge help empty() and empty().cons(6).cons(4).cons(2)", IntList.empty().visit(new MergeHelpVisitor(IntList.empty().cons(6).cons(4).cons(2))), IntList.empty().cons(6).cons(4).cons(2));
    assertEquals("test merge help empty().cons(5).cons(3).cons(1) and empty().cons(6).cons(4).cons(2)", IntList.empty().cons(5).cons(3).cons(1).visit(new MergeHelpVisitor(IntList.empty().cons(6).cons(4).cons(2))), IntList.empty().cons(6).cons(5).cons(4).cons(3).cons(2).cons(1));
    assertEquals("test merge help empty().cons(7).cons(5).cons(3).cons(1) and empty().cons(8).cons(6).cons(4).cons(2)", IntList.empty().cons(7).cons(5).cons(3).cons(1).visit(new MergeHelpVisitor(IntList.empty().cons(8).cons(6).cons(4).cons(2))), IntList.empty().cons(8).cons(7).cons(6).cons(5).cons(4).cons(3).cons(2).cons(1));
  }

  /** Tests MergeVisitor. */
  public void testMerge() {
    assertEquals("test merge empty() and empty().cons(5).cons(3).cons(1)", IntList.empty().visit(new MergeVisitor(IntList.empty().cons(5).cons(3).cons(1))), IntList.empty().cons(5).cons(3).cons(1));
    assertEquals("test merge empty() and cons(6).cons(4).cons(2)", IntList.empty().visit(new MergeVisitor(IntList.empty().cons(6).cons(4).cons(2))), IntList.empty().cons(6).cons(4).cons(2));
    assertEquals("test merge empty().cons(5).cons(3).cons(1) and empty()", IntList.empty().cons(5).cons(3).cons(1).visit(new MergeVisitor(IntList.empty())), IntList.empty().cons(5).cons(3).cons(1));
    assertEquals("test merge empty().cons(6).cons(4).cons(2) and empty()", IntList.empty().cons(6).cons(4).cons(2).visit(new MergeVisitor(IntList.empty())), IntList.empty().cons(6).cons(4).cons(2));
    assertEquals("test merge empty().cons(5).cons(3).cons(1) and empty().cons(6).cons(4).cons(2)", IntList.empty().cons(5).cons(3).cons(1).visit(new MergeVisitor(IntList.empty().cons(6).cons(4).cons(2))), IntList.empty().cons(6).cons(5).cons(4).cons(3).cons(2).cons(1));
    assertEquals("test merge empty().cons(7).cons(5).cons(3).cons(1) and empty().cons(8).cons(6).cons(4).cons(2)", IntList.empty().cons(7).cons(5).cons(3).cons(1).visit(new MergeVisitor(IntList.empty().cons(8).cons(6).cons(4).cons(2))), IntList.empty().cons(8).cons(7).cons(6).cons(5).cons(4).cons(3).cons(2).cons(1));
  }

  /** Tests PartitionVisitor. */
  public void testPartition() {
    IntList[] partitionResult;
    partitionResult = (IntList[]) IntList.empty().visit(PartitionVisitor.ONLY);
    assertEquals("test first partition empty()", partitionResult[0], IntList.empty());
    assertEquals("test second partition empty()", partitionResult[1], IntList.empty());

    partitionResult = (IntList[]) IntList.empty().cons(1).visit(PartitionVisitor.ONLY);
    assertEquals("test first partition empty().cons(1)", partitionResult[0], IntList.empty().cons(1));
    assertEquals("test second partition empty().cons(1)", partitionResult[1], IntList.empty());

    partitionResult = (IntList[]) IntList.empty().cons(1).cons(2).visit(PartitionVisitor.ONLY);
    assertEquals("test first partition empty().cons(1).cons(2)", partitionResult[0], IntList.empty().cons(2));
    assertEquals("test second partition empty().cons(1).cons(2)", partitionResult[1], IntList.empty().cons(1));

    partitionResult = (IntList[]) IntList.empty().cons(1).cons(2).cons(3).visit(PartitionVisitor.ONLY);
    assertEquals("test first partition empty().cons(1).cons(2).cons(3)", partitionResult[0], IntList.empty().cons(3));
    assertEquals("test second partition empty().cons(1).cons(2).cons(3)", partitionResult[1], IntList.empty().cons(1).cons(2));

    partitionResult = (IntList[]) IntList.empty().cons(1).cons(2).cons(3).cons(4).visit(PartitionVisitor.ONLY);
    assertEquals("test first partition empty().cons(1).cons(2).cons(3).cons(4)", partitionResult[0], IntList.empty().cons(4).cons(3));
    assertEquals("test second partition empty().cons(1).cons(2).cons(3).cons(4)", partitionResult[1], IntList.empty().cons(1).cons(2));

    partitionResult = (IntList[]) IntList.empty().cons(1).cons(2).cons(3).cons(4).cons(5).visit(PartitionVisitor.ONLY);
    assertEquals("test first partition empty().cons(1).cons(2).cons(3).cons(4).cons(5)", partitionResult[0], IntList.empty().cons(5).cons(4));
    assertEquals("test second partition empty().cons(1).cons(2).cons(3).cons(4).cons(5)", partitionResult[1], IntList.empty().cons(1).cons(2).cons(3));

    partitionResult = (IntList[]) IntList.empty().cons(1).cons(2).cons(3).cons(4).cons(5).cons(6).visit(PartitionVisitor.ONLY);
    assertEquals("test first partition empty().cons(1).cons(2).cons(3).cons(4).cons(5).cons(6)", partitionResult[0], IntList.empty().cons(6).cons(5).cons(4));
    assertEquals("test second partition empty().cons(1).cons(2).cons(3).cons(4).cons(5).cons(6)", partitionResult[1], IntList.empty().cons(1).cons(2).cons(3));
  }

  /** Tests MergeSortVisitor. */
  public void testMergeSort() {
    assertEquals("test merge sort empty()", IntList.empty().visit(MergeSortVisitor.ONLY), IntList.empty());
    assertEquals("test merge sort empty().cons(1)", IntList.empty().cons(1).visit(MergeSortVisitor.ONLY), IntList.empty().cons(1));
    assertEquals("test merge sort empty().cons(1).cons(2)", IntList.empty().cons(1).cons(2).visit(MergeSortVisitor.ONLY), IntList.empty().cons(2).cons(1));
    assertEquals("test merge sort empty().cons(2).cons(1)", IntList.empty().cons(2).cons(1).visit(MergeSortVisitor.ONLY), IntList.empty().cons(2).cons(1));

    assertEquals("test merge sort empty().cons(1).cons(2).cons(3)", IntList.empty().cons(1).cons(2).cons(3).visit(MergeSortVisitor.ONLY), IntList.empty().cons(3).cons(2).cons(1));
    assertEquals("test merge sort empty().cons(1).cons(3).cons(2)", IntList.empty().cons(1).cons(3).cons(2).visit(MergeSortVisitor.ONLY), IntList.empty().cons(3).cons(2).cons(1));
    assertEquals("test merge sort empty().cons(2).cons(1).cons(3)", IntList.empty().cons(2).cons(1).cons(3).visit(MergeSortVisitor.ONLY), IntList.empty().cons(3).cons(2).cons(1));
    assertEquals("test merge sort empty().cons(2).cons(3).cons(1)", IntList.empty().cons(2).cons(3).cons(1).visit(MergeSortVisitor.ONLY), IntList.empty().cons(3).cons(2).cons(1));
    assertEquals("test merge sort empty().cons(3).cons(1).cons(2)", IntList.empty().cons(3).cons(1).cons(2).visit(MergeSortVisitor.ONLY), IntList.empty().cons(3).cons(2).cons(1));
    assertEquals("test merge sort empty().cons(3).cons(2).cons(1)", IntList.empty().cons(3).cons(2).cons(1).visit(MergeSortVisitor.ONLY), IntList.empty().cons(3).cons(2).cons(1));

    assertEquals("test merge sort empty().cons(1).cons(2).cons(3).cons(4)", IntList.empty().cons(1).cons(2).cons(3).cons(4).visit(MergeSortVisitor.ONLY), IntList.empty().cons(4).cons(3).cons(2).cons(1));
    assertEquals("test merge sort empty().cons(1).cons(2).cons(3).cons(4).cons(5)", IntList.empty().cons(1).cons(2).cons(3).cons(4).cons(5).visit(MergeSortVisitor.ONLY), IntList.empty().cons(5).cons(4).cons(3).cons(2).cons(1));
    assertEquals("test merge sort empty().cons(1).cons(2).cons(3).cons(4).cons(5).cons(6)", IntList.empty().cons(1).cons(2).cons(3).cons(4).cons(5).cons(6).visit(MergeSortVisitor.ONLY), IntList.empty().cons(6).cons(5).cons(4).cons(3).cons(2).cons(1));
  }

}
