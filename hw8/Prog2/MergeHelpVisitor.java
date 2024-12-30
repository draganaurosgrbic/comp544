/** ListVisitor class that implements the merge(List<T>) method on Lists. */
class MergeHelpVisitor<T extends Comparable<T>> implements ListOrdVisitor<T,List<T>> {

    private final ConsList<T> other;

    public MergeHelpVisitor(ConsList<T> other) {
        this.other = other;
    }

    @Override
    public List<T> forConsList(ConsList<T> host) {
        if ((host.first).compareTo(other.first) < 0) {
            return new ConsList<>(host.first, host.rest.visit(this));
        }
        return new ConsList<>(other.first, other.rest.visit(new MergeHelpVisitor<>(host)));
    }

    @Override
    public List<T> forEmptyList(EmptyList<T> host) {
        return other;
    }
}
