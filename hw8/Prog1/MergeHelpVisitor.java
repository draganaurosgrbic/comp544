/** IntListVistor that implements the subst "mergeHelp on IntLists. */
class MergeHelpVisitor implements ListVisitor {

    private final ConsList other;

    public MergeHelpVisitor(ConsList other) {
        this.other = other;
    }

    @Override
    public Object forEmptyList(EmptyList host) {
        return other;
    }

    @Override
    public Object forConsList(ConsList host) {
        if (((Comparable) host.first).compareTo(other.first) < 0) {
            return new ConsList(host.first, (List) host.rest.visit(this));
        }
        return new ConsList(other.first, (List) other.rest.visit(new MergeHelpVisitor(host)));
    }
}