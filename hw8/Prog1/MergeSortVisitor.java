import javafx.util.Pair;

/** IntListVistor that implements the subst "mergeSort on IntLists. */
class MergeSortVisitor implements ListVisitor {

    @Override
    public Object forEmptyList(EmptyList host) {
        return host;
    }

    @Override
    public Object forConsList(ConsList host) {
        if ((int) host.visit(new LengthVisitor()) <= 1) {
            return host;
        }
        Pair<List, List> partition = (Pair<List, List>) host.visit(new PartitionVisitor());
        return ((List) partition.getKey().visit(this)).visit(new MergeVisitor((List) partition.getValue().visit(this)));
    }

}