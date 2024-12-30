/** IntListVistor that implements the subst "partition on IntLists. */
public class PartitionVisitor implements IntListVisitor {

    /* Singleton binding for PartitionVisitor because the method takes no parameters */
    public static final PartitionVisitor ONLY = new PartitionVisitor();

    private PartitionVisitor() {}

    @Override
    public Object forEmptyIntList(EmptyIntList host) {
        return new IntList[] {host, host};
    }

    @Override
    public Object forConsIntList(ConsIntList host) {
        return divide(IntList.empty(), host);
    }

    /** Helper function for partitioning a list into two halves of almost the same size. */
    private IntList[] divide(IntList A, IntList B) {
        // function adds elements from list B to list A until they are almost the same size
        IntList first;
        IntList second;
        if (A instanceof EmptyIntList && B instanceof EmptyIntList) {       // both lists are empty
            first = A;
            second = B;
        } else if (A instanceof EmptyIntList) {     // only list A is empty
            ConsIntList consB = (ConsIntList) B;

            first = IntList.empty().cons(consB.first);      // move first element from list B to list A
            second = consB.rest;
        } else {
            if (B instanceof EmptyIntList) {        // list B is empty
                ConsIntList consA = (ConsIntList) A;

                first = IntList.empty().cons(consA.first);
                second = consA.rest;
            } else {
                ConsIntList consA = (ConsIntList) A;
                ConsIntList consB = (ConsIntList) B;

                first = consA.cons(consB.first);        // move first element from list B to list A
                second = consB.rest;
            }
        }


        int difference = Math.abs((int) first.visit(LengthVisitor.ONLY) - (int) second.visit(LengthVisitor.ONLY));
        if (difference <= 1) {      // lists are almost the same size
            return new IntList[] { first, second };
        }

        return divide(first, second);
    }

}
