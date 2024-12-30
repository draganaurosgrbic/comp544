/** ListVisitor class that implements the insertSort() method on the host List.
  * interface. */
class InsertSortVisitor implements ListVisitor {

    @Override
    public Object forEmptyList(EmptyList host) {
        return host;
    }

    @Override
    public Object forConsList(ConsList host) {
        return ((List) host.rest.visit(this)).insert((Comparable) host.first);
    }
}
