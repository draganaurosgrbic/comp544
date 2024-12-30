/** IntListVistor that implements the subst "method" on IntLists. */
public class SubstVisitor implements IntListVisitor {

    /** oldN field stores the number which each occurrence should be replaced with the newN number. */
    private int oldN;

    /** newN field stores the number with which oldN number is being replaced. */
    private int newN;

    public SubstVisitor(int oldN, int newN) {
        this.oldN = oldN;
        this.newN = newN;
    }

    @Override
    public Object forEmptyIntList(EmptyIntList host) {
        return host;
    }

    @Override
    public Object forConsIntList(ConsIntList host) {
        if (host.first == oldN) {       // check whether list item is equal to the oldN
            return new ConsIntList(newN, (IntList) host.rest.visit(this));
        }
        return new ConsIntList(host.first, (IntList) host.rest.visit(this));
    }
}
