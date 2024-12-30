/** IntListVistor that implements the subst "mergeHelp on IntLists. */
public class MergeHelpVisitor implements IntListVisitor {

    /** other is field storing the "argument" to the merge "method"; it doesn't have to have same length to the "host". */
    private ConsIntList other;

    public MergeHelpVisitor(ConsIntList other) {
        this.other = other;
    }

    @Override
    public Object forEmptyIntList(EmptyIntList host) {
        return other;
    }

    @Override
    public Object forConsIntList(ConsIntList host) {
        if (host.first < other.first) {     // check whether list item is less than item in the other list
            return new ConsIntList(host.first, (IntList) host.rest.visit(this));
        }
        return new ConsIntList(other.first, (IntList) other.rest.visit(new MergeHelpVisitor(host)));
    }
}
