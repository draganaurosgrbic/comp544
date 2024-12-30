/** ListVisitor class that implements the merge(List<T>) method on Lists. */
class MergeVisitor<T extends Comparable<T>> implements ListOrdVisitor<T,List<T>> {

    private final List<T> other;

    public MergeVisitor(List<T> other) {
        this.other = other;
    }

    @Override
    public List<T> forConsList(ConsList<T> host) {
        if (other instanceof EmptyList) {
            return host;
        }
        ConsList<T> consOther = (ConsList<T>) other;
        return host.visit(new MergeHelpVisitor<>(consOther));
    }

    @Override
    public List<T> forEmptyList(EmptyList<T> host) {
        return other;
    }
}
