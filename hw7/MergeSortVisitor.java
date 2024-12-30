/** IntListVistor that implements the subst "mergeSort on IntLists. */
public class MergeSortVisitor implements IntListVisitor {

    /* Singleton binding for MergeSortVisitor because the method takes no parameters */
    public static final MergeSortVisitor ONLY = new MergeSortVisitor();

    private MergeSortVisitor() {}

    @Override
    public Object forEmptyIntList(EmptyIntList host) {
        return host;
    }

    @Override
    public Object forConsIntList(ConsIntList host) {
        if ((int) host.visit(LengthVisitor.ONLY) <= 1) {    // if the list is empty or contains single element, it is sorted
            return host;
        }
        IntList[] partition = (IntList[]) host.visit(PartitionVisitor.ONLY);    // divide list into two halves
        return ((IntList) partition[0].visit(this)).visit(new MergeVisitor((IntList) partition[1].visit(this)));
    }

}
