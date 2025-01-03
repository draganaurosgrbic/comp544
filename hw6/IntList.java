// Language Level Converter line number map: dj*->java. Entries: 149
//     1->21        2->22        3->23        4->24        5->25        6->26        7->27        8->28   
//     9->29       10->30       11->31       12->32       13->33       14->34       15->35       16->36   
//    17->37       18->38       19->39       20->40       21->41       22->42       23->43       24->44   
//    25->45       26->46       27->47       28->48       29->49       30->50       31->51       32->52   
//    33->53       34->54       35->55       36->56       37->57       38->58       39->59       40->60   
//    41->61       42->62       43->63       44->64       45->65       46->66       47->67       48->68   
//    49->69       50->70       51->71       52->72       53->73       54->74       55->75       56->76   
//    57->77       58->78       59->79       60->80       61->111      62->112      63->113      64->114  
//    65->115      66->116      67->117      68->118      69->119      70->120      71->121      72->122  
//    73->123      74->124      75->125      76->126      77->127      78->128      79->129      80->130  
//    81->131      82->132      83->133      84->134      85->135      86->136      87->137      88->138  
//    89->139      90->140      91->141      92->142      93->143      94->144      95->145      96->146  
//    97->177      98->178      99->179     100->180     101->181     102->182     103->183     104->184  
//   105->185     106->186     107->187     108->188     109->189     110->190     111->191     112->192  
//   113->193     114->194     115->195     116->196     117->197     118->198     119->199     120->200  
//   121->201     122->202     123->203     124->204     125->205     126->206     127->207     128->208  
//   129->209     130->210     131->211     132->212     133->213     134->214     135->215     136->216  
//   137->217     138->218     139->219     140->220     141->221     142->222     143->223     144->224  
//   145->225     146->226     147->227     148->228     149->229  
abstract class IntList {
  public static final IntList EMPTY = new EmptyIntList();
  public ConsIntList cons(final int n) { return new ConsIntList(n, this); }
  
  /**
   boolean contains(int key) returns true if key is in the list, false otherwise
   */
  public abstract boolean contains(final int key);
  
  /**
   int length() computes the length of the list
   */
  public abstract int length();
  
  /**
   int sum() computes the sum of the elements in the list 
   */
  public abstract int sum();
  
  /**
   double average() computes the average of the elements in the list; returns 0 if the list is empty
   */
  public abstract double average();
  
  /**
   IntList notGreaterThan(int bound) returns a list of elements in this list that are less or equal to bound 
   */
  public abstract IntList notGreaterThan(final int bound);
  
  /**
   IntList remove(int key) returns a list of all elements in this list that are not equal to key 
   */
  public abstract IntList remove(final int key);
  
  /**
    IntList subst(int oldN, int newN) returns a list of all elements in this list with oldN replaced by newN 
   */
  public abstract IntList subst(final int oldN, final int newN);
  
  /**
     IntList mergeHelp(ConsIntList other) merges this list with the input list other, assuming that this list and other are sorted in ascending order.
     Other list is not empty
   */
  public abstract IntList mergeHelp(final ConsIntList other);
  
  /**
     IntList merge(IntList other) merges this list with the input list other, assuming that this list and other are sorted in ascending order.
     Other list can be empty
   */
  public IntList merge(final IntList other) {
    if (this instanceof EmptyIntList) {
      return other;
    }
    if (other instanceof EmptyIntList) {
      return this;
    }
    return this.mergeHelp((ConsIntList) other);
  }


  /** This method is automatically generated by the Language Level Converter. */
  public IntList() {
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
      IntList cast = ((IntList) o);
      return true;
    }
  }

  /** This method is automatically generated by the Language Level Converter. */
  public int hashCode() {
    return getClass().hashCode();
  }
}

class EmptyIntList extends IntList {

  public boolean contains(final int key) {
    return false;
  }
  
  public int length() {
    return 0;
  }
  
  public int sum() {
    return 0;
  }
  
  public double average() {
    return 0;
  }
  
  public IntList notGreaterThan(final int bound) {
    return this;
  }
  
  public IntList remove(final int key) {
    return this;
  }
  
  public IntList subst(final int oldN, final int newN) {
    return this;
  }
  
  public IntList mergeHelp(final ConsIntList other) {
    return other;
  }


  /** This method is automatically generated by the Language Level Converter. */
  public EmptyIntList() {
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
      EmptyIntList cast = ((EmptyIntList) o);
      return true;
    }
  }

  /** This method is automatically generated by the Language Level Converter. */
  public int hashCode() {
    return getClass().hashCode();
  }
}

class ConsIntList extends IntList {
  private final int first;
  private final IntList rest;
  
  public boolean contains(final int key) {
    if (first == key) {
      return true;
    }
    return rest.contains(key);
  }
  
  public int length() {
    return 1 + rest.length();
  }
  
  public int sum() {
    return first + rest.sum();
  }
  
  public double average() {
    return sum() / length();
  }
  
  public IntList notGreaterThan(final int bound) {
    if (first <= bound) {
      return new ConsIntList(first, rest.notGreaterThan(bound));
    }
    return rest.notGreaterThan(bound);
  }
  
  public IntList remove(final int key) {
    if (first == key) {
      return rest.remove(key);
    }
    return new ConsIntList(first, rest.remove(key));
  }
  
  public IntList subst(final int oldN, final int newN) {
    if (first == oldN) {
      return new ConsIntList(newN, rest.subst(oldN, newN));
    }
    return new ConsIntList(first, rest.subst(oldN, newN));
  }
  
  public IntList mergeHelp(final ConsIntList other) {
    if (first < other.first) {
     return new ConsIntList(first, rest.mergeHelp(other));
    }
    return new ConsIntList(other.first, other.rest.mergeHelp(this));
  }


  /** This method is automatically generated by the Language Level Converter. */
  public ConsIntList(int first, IntList rest) {
    super();
    this.first = first;
    this.rest = rest;
  }

  /** This method is automatically generated by the Language Level Converter. */
  public int first() {
    return first;
  }

  /** This method is automatically generated by the Language Level Converter. */
  public IntList rest() {
    return rest;
  }

  /** This method is automatically generated by the Language Level Converter. */
  public java.lang.String toString() {
    return getClass().getName() + "(" + 
        first() + ", " + 
        rest() + 
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
      ConsIntList cast = ((ConsIntList) o);
      return (first() == cast.first()) && 
          (rest() != null && rest().equals(cast.rest()));
    }
  }

  /** This method is automatically generated by the Language Level Converter. */
  public int hashCode() {
    return getClass().hashCode() ^ 
        first() ^ 
        (rest() == null ? 0 : rest().hashCode());
  }
}
