/** IntListVistor that implements the subst "merge" on IntLists. */
class MergeVisitor implements ListVisitor {

    private final List other;

    public MergeVisitor(List other) {
        this.other = other;
    }

    @Override
    public Object forEmptyList(EmptyList host) {
        return other;
    }

    @Override
    public Object forConsList(ConsList host) {
        if (other instanceof EmptyList) {
            return host;
        }
        return host.visit(new MergeHelpVisitor((ConsList) other));
    }
}