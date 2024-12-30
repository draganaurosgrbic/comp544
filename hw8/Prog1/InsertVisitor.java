/** ListVisitor class that implements the insert(Comparable elt) method on the host List. */
class InsertVisitor implements ListVisitor {

    private final Comparable elt;

    public InsertVisitor(Comparable elt) {
        this.elt = elt;
    }

    @Override
    public Object forEmptyList(EmptyList host) {
        return host.cons(elt);
    }

    @Override
    public Object forConsList(ConsList host) {
        if (elt.compareTo(host.first) < 0) {
            return new ConsList(elt, host);
        }
        return new ConsList(host.first, (List) host.rest.visit(this));
    }
}
