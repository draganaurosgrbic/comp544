/** IntListVistor that implements the notGreaterThan "method" on IntLists. */
public class NotGreaterThanVisitor implements IntListVisitor {

    /** bound field stores the number with which each item in the list is compared when performing the <= comparison. */
    private int bound;

    public NotGreaterThanVisitor(int bound) {
        this.bound = bound;
    }

    @Override
    public Object forEmptyIntList(EmptyIntList host) {
        return host;
    }

    @Override
    public Object forConsIntList(ConsIntList host) {
        if (host.first <= bound) {      // check whether list item is less or equal to the bound
            return new ConsIntList(host.first, (IntList) host.rest.visit(this));
        }
        return host.rest.visit(this);
    }
}
