/** Visitor interface for the List type. */
interface ListVisitor {
  Object forEmptyList(EmptyList host);
  Object forConsList(ConsList host);
}
