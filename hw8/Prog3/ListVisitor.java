/** Visitor interface for the List type. */
interface ListVisitor<T,R> {
  R forEmptyList(EmptyList<T> host);
  R forConsList(ConsList<T> host);
}

/** OrdVisitor interface for the List type. */
interface ListOrdVisitor<TwO extends Comparable<TwO>, R> extends ListVisitor<TwO,R> { }

