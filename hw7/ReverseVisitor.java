/** IntListVistor that implements the reverse "method" on IntLists. */
public class ReverseVisitor implements IntListVisitor {

    /* Singleton binding for ReverseVisitor because the method takes no parameters */
    public static final ReverseVisitor ONLY = new ReverseVisitor();

    private ReverseVisitor() {}

    @Override
    public Object forEmptyIntList(EmptyIntList host) {
        return host;
    }

    @Override
    public Object forConsIntList(ConsIntList host) {
        return reverse(IntList.empty(), host);
    }

    /** Helper function that performs reverse of a list. */
    private IntList reverse(IntList before, ConsIntList list) {
        if ((int) list.visit(LengthVisitor.ONLY) <= 1) {    // we have encountered the last element in the list
            return new ConsIntList(list.first, before);     // we place the last element as the first element and merge with
                                                            // previous items in the list
        }

        return reverse(before.cons(list.first), (ConsIntList) list.rest);
    }


}
