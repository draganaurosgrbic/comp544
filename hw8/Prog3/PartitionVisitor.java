import javafx.util.Pair;
/** ListVisitor class that implements the reverseHelp(List<T>) method for List<T>. */
class PartitionVisitor<T extends Comparable<T>> implements ListVisitor<T,Pair<List<T>,List<T>>> {

    @Override
    public Pair<List<T>, List<T>> forEmptyList(EmptyList<T> host) {
        return new Pair<>(host, host);
    }

    @Override
    public Pair<List<T>, List<T>> forConsList(ConsList<T> host) {
        return divide(host.empty(), host);
    }

    /** Helper function for partitioning a list into two halves of almost the same size. */
    private Pair<List<T>, List<T>> divide(List<T> A, List<T> B) {
        // function adds elements from list B to list A until they are almost the same size
        List<T> first;
        List<T> second;
        if (A instanceof EmptyList && B instanceof EmptyList) {       // both lists are empty
            first = A;
            second = B;
        } else if (A instanceof EmptyList) {     // only list A is empty
            ConsList<T> consB = (ConsList<T>) B;

            first = A.empty().cons(consB.first);      // move first element from list B to list A
            second = consB.rest;
        } else {
            ConsList<T> consA = (ConsList<T>) A;
            if (B instanceof EmptyList) {        // list B is empty

                first = A.empty().cons(consA.first);
                second = consA.rest;
            } else {
                ConsList<T> consB = (ConsList<T>) B;

                first = consA.cons(consB.first);        // move first element from list B to list A
                second = consB.rest;
            }
        }


        int difference = Math.abs((int) first.visit(new LengthVisitor<>()) - second.visit(new LengthVisitor<>()));
        if (difference <= 1) {      // lists are almost the same size
            return new Pair<>(first, second);
        }

        return divide(first, second);
    }
}