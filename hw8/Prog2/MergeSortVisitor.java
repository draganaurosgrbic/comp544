import javafx.util.Pair;
/** ListVisitor class that implements the mergeSort(List<T>) method on Lists. */
class MergeSortVisitor<T extends Comparable<T>> implements ListOrdVisitor<T,List<T>> {

    @Override
    public List<T> forEmptyList(EmptyList<T> host) {
        return host;
    }

    @Override
    public List<T> forConsList(ConsList<T> host) {
        if (host.visit(new LengthVisitor<>()) <= 1) {
            return host;
        }
        Pair<List<T>, List<T>> partition = host.visit(new PartitionVisitor<>());
        return (partition.getKey().visit(this)).visit(new MergeVisitor<>(partition.getValue().visit(this)));
    }
}
