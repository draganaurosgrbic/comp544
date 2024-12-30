import javafx.util.Pair;

/** IntListVistor that implements the subst "partition on IntLists. */
class PartitionVisitor implements ListVisitor {

    @Override
    public Object forEmptyList(EmptyList host) {
        return new Pair<>(host, host);
    }

    @Override
    public Object forConsList(ConsList host) {
        return divide(host.empty(), host);
    }

    /** Helper function for partitioning a list into two halves of almost the same size. */
    private Pair<List, List> divide(List A, List B) {
        // function adds elements from list B to list A until they are almost the same size
        List first;
        List second;
        if (A instanceof EmptyList && B instanceof EmptyList) {       // both lists are empty
            first = A;
            second = B;
        } else if (A instanceof EmptyList) {     // only list A is empty
            ConsList consB = (ConsList) B;

            first = A.empty().cons(consB.first);      // move first element from list B to list A
            second = consB.rest;
        } else {
            ConsList consA = (ConsList) A;
            if (B instanceof EmptyList) {        // list B is empty

                first = A.empty().cons(consA.first);
                second = consA.rest;
            } else {
                ConsList consB = (ConsList) B;

                first = consA.cons(consB.first);        // move first element from list B to list A
                second = consB.rest;
            }
        }


        int difference = Math.abs((int) first.visit(new LengthVisitor()) - (int) second.visit(new LengthVisitor()));
        if (difference <= 1) {      // lists are almost the same size
            return new Pair<>(first, second);
        }

        return divide(first, second);
    }

}