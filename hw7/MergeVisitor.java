/** IntListVistor that implements the subst "merge" on IntLists. */
public class MergeVisitor implements IntListVisitor {

    /** other is field storing the "argument" to the merge "method"; it doesn't have to have same length to the "host". */
    private IntList other;

    public MergeVisitor(IntList other) {
        this.other = other;
    }

    @Override
    public Object forEmptyIntList(EmptyIntList host) {
        return other;
    }

    @Override
    public Object forConsIntList(ConsIntList host) {
        if (other instanceof EmptyIntList) {
            return host;
        }
        return host.visit(new MergeHelpVisitor((ConsIntList) other));       // call helper mergeHelp function
    }
}
