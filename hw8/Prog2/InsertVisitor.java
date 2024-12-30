/** ListVisitor class that implements the length() method on type List<T>. */
class InsertVisitor<TwO extends Comparable<TwO>> implements ListOrdVisitor<TwO, List<TwO>> {

    private final TwO elt;

    public InsertVisitor(TwO elt) {
        this.elt = elt;
    }

    @Override
    public List<TwO> forConsList(ConsList<TwO> host) {
        if (elt.compareTo(host.first) < 0) {
            return new ConsList<>(elt, host);
        }
        return new ConsList<>(host.first, host.rest.visit(this));
    }

    @Override
    public List<TwO> forEmptyList(EmptyList<TwO> host) {
        return host.cons(elt);
    }
}
