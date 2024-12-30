/** ListVisitor class that implements the insert(T) method on type List<T>. */
class InsertSortVisitor<TwO extends Comparable<TwO>> implements ListOrdVisitor<TwO,List<TwO>> {

    @Override
    public List<TwO> forConsList(ConsList<TwO> host) {
        return host.rest.visit(this).insert(host.first);
    }

    @Override
    public List<TwO> forEmptyList(EmptyList<TwO> host) {
        return host;
    }
}