/** IntListVistor that implements the remove "method" on IntLists. */
public class RemoveVisitor implements IntListVisitor {

    /** bound field stores the number which each occurrence should be removed from the list. */
    private int key;

    public RemoveVisitor(int key) {
        this.key = key;
    }

    @Override
    public Object forEmptyIntList(EmptyIntList host) {
        return host;
    }

    @Override
    public Object forConsIntList(ConsIntList host) {
        if (host.first == key) {        // check whether list item is equal to the key
            return host.rest.visit(this);
        }
        return new ConsIntList(host.first, (IntList) host.rest.visit(this));
    }
}
