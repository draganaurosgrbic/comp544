// Language Level Converter line number map: dj*->java. Entries: 131
//     1->19        2->21        3->22        4->23        5->24        6->25        7->26        8->27   
//     9->28       10->29       11->30       12->31       13->32       14->33       15->34       16->35   
//    17->36       18->37       19->38       20->39       21->40       22->41       23->42       24->43   
//    25->44       26->45       27->46       28->47       29->48       30->49       31->50       32->51   
//    33->52       34->53       35->54       36->55       37->56       38->57       39->58       40->59   
//    41->60       42->61       43->62       44->63       45->64       46->65       47->66       48->67   
//    49->68       50->69       51->70       52->71       53->72       54->73       55->74       56->75   
//    57->76       58->77       59->78       60->79       61->80       62->81       63->82       64->83   
//    65->84       66->85       67->86       68->87       69->88       70->89       71->90       72->91   
//    73->92       74->93       75->94       76->95       77->96       78->97       79->98       80->99   
//    81->100      82->101      83->102      84->103      85->104      86->105      87->106      88->107  
//    89->108      90->109      91->110      92->111      93->112      94->113      95->114      96->115  
//    97->116      98->117      99->118     100->119     101->120     102->121     103->122     104->123  
//   105->124     106->125     107->126     108->127     109->128     110->129     111->130     112->131  
//   113->132     114->133     115->134     116->135     117->136     118->137     119->138     120->139  
//   121->140     122->141     123->142     124->143     125->144     126->145     127->146     128->147  
//   129->148     130->149     131->150  
import junit.framework.TestCase;
public class IntListTest extends TestCase {

  /**
   test boolean contains(int key) function
   */
  public void testContains() {
    assertFalse("contains 0 = False", IntList.EMPTY.contains(0));
    assertFalse("contains 0 = False", IntList.EMPTY.cons(1).contains(0));
    assertTrue("contains 1 = True", IntList.EMPTY.cons(1).contains(1));
    assertFalse("contains 0 = False", IntList.EMPTY.cons(1).cons(2).contains(0));
    assertTrue("contains 1 = True", IntList.EMPTY.cons(1).cons(2).contains(1));
    assertTrue("contains 2 = True", IntList.EMPTY.cons(1).cons(2).contains(2));
  }
  
  /**
   test int length() function
   */
  public void testLength() {
    assertEquals("length = 0", IntList.EMPTY.length(), 0);
    assertEquals("length = 1", IntList.EMPTY.cons(1).length(), 1);
    assertEquals("length = 2", IntList.EMPTY.cons(1).cons(2).length(), 2);
    assertEquals("length = 3", IntList.EMPTY.cons(1).cons(2).cons(3).length(), 3);
  }
  
  /**
   test int sum() function
   */
  public void testSum() {
    assertEquals("sum = 0", IntList.EMPTY.sum(), 0);
    assertEquals("sum = 1", IntList.EMPTY.cons(1).sum(), 1);
    assertEquals("sum = 3", IntList.EMPTY.cons(1).cons(2).sum(), 3);
    assertEquals("sum = 6", IntList.EMPTY.cons(1).cons(2).cons(3).sum(), 6);
  }
  
  /**
   test double average() function
   */
  public void testAverage() {
    assertEquals("average = 0", (int) IntList.EMPTY.average(), 0);
    assertEquals("average = 1", (int) IntList.EMPTY.cons(1).average(), 1);
    assertEquals("average = 2", (int) IntList.EMPTY.cons(1).cons(3).average(), 2);
    assertEquals("average = 3", (int) IntList.EMPTY.cons(1).cons(2).cons(6).average(), 3);
  }
  
  /**
   test IntList notGreaterThan(int bound) function
   */
  public void testNotGreaterThan() {
    assertEquals("not greater than 0 length = 0", IntList.EMPTY.notGreaterThan(0).length(), 0);
    assertEquals("not greater than 0 length = 0", IntList.EMPTY.cons(1).notGreaterThan(0).length(), 0);
    assertFalse("not greater than 0 contains 1 = False", IntList.EMPTY.cons(1).notGreaterThan(0).contains(1));
    assertEquals("not greater than 1 length = 1", IntList.EMPTY.cons(1).notGreaterThan(1).length(), 1);
    assertTrue("not greater than 1 contains 1 = True", IntList.EMPTY.cons(1).notGreaterThan(1).contains(1));
    assertEquals("not greater than 0 length = 0", IntList.EMPTY.cons(1).cons(2).notGreaterThan(0).length(), 0);
    assertFalse("not greater than 0 contains 1 = False", IntList.EMPTY.cons(1).cons(2).notGreaterThan(0).contains(1));
    assertFalse("not greater than 0 contains 2 = False", IntList.EMPTY.cons(1).cons(2).notGreaterThan(0).contains(2));
    assertEquals("not greater than 1 length = 1", IntList.EMPTY.cons(1).cons(2).notGreaterThan(1).length(), 1);
    assertTrue("not greater than 1 contains 1 = True", IntList.EMPTY.cons(1).cons(2).notGreaterThan(1).contains(1));
    assertFalse("not greater than 1 contains 2 = False", IntList.EMPTY.cons(1).cons(2).notGreaterThan(1).contains(2));
    assertEquals("not greater than 2 length = 2", IntList.EMPTY.cons(1).cons(2).notGreaterThan(2).length(), 2);
    assertTrue("not greater than 1 contains 1 = True", IntList.EMPTY.cons(1).cons(2).notGreaterThan(2).contains(1));
    assertTrue("not greater than 1 contains 2 = True", IntList.EMPTY.cons(1).cons(2).notGreaterThan(2).contains(2));
  }
  
  /**
   test IntList remove(int key) function
   */
  public void testRemove() {
    assertEquals("remove 0 length = 0", IntList.EMPTY.remove(0).length(), 0);
    assertEquals("remove 0 length = 1", IntList.EMPTY.cons(1).remove(0).length(), 1);
    assertTrue("remove 0 contains 1 = True", IntList.EMPTY.cons(1).remove(0).contains(1));
    assertEquals("remove 1 length = 0", IntList.EMPTY.cons(1).remove(1).length(), 0);
    assertFalse("remove 1 contains 1 = False", IntList.EMPTY.cons(1).remove(1).contains(1));
    assertEquals("remove 0 length = 2", IntList.EMPTY.cons(1).cons(2).remove(0).length(), 2);
    assertTrue("remove 0 contains 1 = True", IntList.EMPTY.cons(1).cons(2).remove(0).contains(1));
    assertTrue("remove 0 contains 2 = True", IntList.EMPTY.cons(1).cons(2).remove(0).contains(2));
    assertEquals("remove 1 length = 1", IntList.EMPTY.cons(1).cons(2).remove(1).length(), 1);
    assertFalse("remove 1 contains 1 = False", IntList.EMPTY.cons(1).cons(2).remove(1).contains(1));
    assertTrue("remove 1 contains 2 = True", IntList.EMPTY.cons(1).cons(2).remove(1).contains(2));
  }
  
  /**
   test IntList subst(int oldN, int newN) function
   */
  public void testSubst() {
    assertEquals("replace 0 with 1 length = 0", IntList.EMPTY.subst(0, 1).length(), 0);
    assertEquals("replace 0 with 1 length = 1", IntList.EMPTY.cons(1).subst(0, 1).length(), 1);
    assertTrue("replace 0 with 1 contains 1 = True", IntList.EMPTY.cons(1).subst(0, 1).contains(1));
    assertEquals("replace 1 with 2 length = 1", IntList.EMPTY.cons(1).subst(1, 2).length(), 1);
    assertTrue("replace 1 with 2 contains 2 = True", IntList.EMPTY.cons(1).subst(1, 2).contains(2));
    assertEquals("replace 0 with 1 length = 2", IntList.EMPTY.cons(1).cons(2).subst(0, 1).length(), 2);
    assertTrue("replace 0 with 1 contains 1 = True", IntList.EMPTY.cons(1).cons(2).subst(0, 1).contains(1));
    assertTrue("replace 0 with 1 contains 2 = True", IntList.EMPTY.cons(1).cons(2).subst(0, 1).contains(2));
    assertEquals("replace 1 with 3 length = 2", IntList.EMPTY.cons(1).cons(2).subst(1, 3).length(), 2);
    assertTrue("replace 1 with 3 contains 2 = True", IntList.EMPTY.cons(1).cons(2).subst(1, 3).contains(2));
    assertTrue("replace 1 with 3 contains 3 = True", IntList.EMPTY.cons(1).cons(2).subst(1, 3).contains(3));
  }
  
  /**
   test IntList mergeHelp(ConsIntList other) function
   */
  public void testMergeHelp() {
    assertEquals("test merge help", IntList.EMPTY.mergeHelp(IntList.EMPTY.cons(5).cons(3).cons(1)), 
                 IntList.EMPTY.cons(5).cons(3).cons(1));
    assertEquals("test merge help", IntList.EMPTY.mergeHelp(IntList.EMPTY.cons(6).cons(4).cons(2)), 
                 IntList.EMPTY.cons(6).cons(4).cons(2));
    assertEquals("test merge help", IntList.EMPTY.cons(5).cons(3).cons(1).mergeHelp(IntList.EMPTY.cons(6).cons(4).cons(2)), 
                 IntList.EMPTY.cons(6).cons(5).cons(4).cons(3).cons(2).cons(1));
    assertEquals("test merge help", IntList.EMPTY.cons(7).cons(5).cons(3).cons(1).mergeHelp(IntList.EMPTY.cons(8).cons(6).cons(4).cons(2)), 
                 IntList.EMPTY.cons(8).cons(7).cons(6).cons(5).cons(4).cons(3).cons(2).cons(1));
  }
  
  /**
   test IntList merge(IntList other) function
   */
  public void testMerge() {
    assertEquals("test merge", IntList.EMPTY.merge(IntList.EMPTY.cons(5).cons(3).cons(1)), 
                 IntList.EMPTY.cons(5).cons(3).cons(1));
    assertEquals("test merge", IntList.EMPTY.merge(IntList.EMPTY.cons(6).cons(4).cons(2)), 
                 IntList.EMPTY.cons(6).cons(4).cons(2));
    assertEquals("test merge", IntList.EMPTY.cons(5).cons(3).cons(1).merge(IntList.EMPTY), 
                 IntList.EMPTY.cons(5).cons(3).cons(1));
    assertEquals("test merge", IntList.EMPTY.cons(6).cons(4).cons(2).merge(IntList.EMPTY), 
                 IntList.EMPTY.cons(6).cons(4).cons(2));
    assertEquals("test merge", IntList.EMPTY.cons(5).cons(3).cons(1).merge(IntList.EMPTY.cons(6).cons(4).cons(2)), 
                 IntList.EMPTY.cons(6).cons(5).cons(4).cons(3).cons(2).cons(1));
    assertEquals("test merge", IntList.EMPTY.cons(7).cons(5).cons(3).cons(1).merge(IntList.EMPTY.cons(8).cons(6).cons(4).cons(2)), 
                 IntList.EMPTY.cons(8).cons(7).cons(6).cons(5).cons(4).cons(3).cons(2).cons(1));
  }


  /** This method is automatically generated by the Language Level Converter. */
  public IntListTest() {
    super();
  }

  /** This method is automatically generated by the Language Level Converter. */
  public java.lang.String toString() {
    return getClass().getName() + "(" + 
        ")";
  }

  /** This method is automatically generated by the Language Level Converter. */
  public boolean equals(java.lang.Object o) {
    if (this == o) {
      return true;
    }
    else if ((o == null) || (! o.getClass().equals(getClass()))) {
      return false;
    }
    else {
      IntListTest cast = ((IntListTest) o);
      return true;
    }
  }

  /** This method is automatically generated by the Language Level Converter. */
  public int hashCode() {
    return getClass().hashCode();
  }
}
