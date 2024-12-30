import junit.framework.*;

public class InterpBoolSimpTest extends TestCase {
  
  public final static Variable x = Variable.makeVariable("X");
  public final static Variable y = Variable.makeVariable("Y");
  public final static Variable z = Variable.makeVariable("Z");
  
  public final static Form f1 = new And(x,y);
  public final static IfForm if1 = new IfIf(x, y, Constant.FALSE);
  
  public final static Form f2 = new Or(x,y);
  public final static IfForm if2 = new IfIf(x, Constant.TRUE, y);
  
  public final static Form f3 = new Implies(x,y);
  public final static IfForm if3 = new IfIf(x, y, Constant.TRUE);
  
  public final static Form f4 = new Not(z);
  public final static IfForm if4 = new IfIf(z, Constant.FALSE, Constant.TRUE);
  
  public final static Form f5 = new If(x, y, z);
  public final static IfForm if5 = new IfIf(x, y, z);
  
  public final static Form f6 = new Or(new And(x,y), new Or(y,z));
  public final static IfForm if6 = new IfIf(new IfIf(x, y, Constant.FALSE), 
                                            Constant.TRUE, 
                                            new IfIf(y, Constant.TRUE, z));
  
  public final static Form f7 = new And(new Or(x,y), new And(y,z));
  public final static IfForm if7 = new IfIf(new IfIf(x, Constant.TRUE, y),  
                                            new IfIf(y, z, Constant.FALSE),
                                            Constant.FALSE);
  
  public final static Form f8 = new Implies(new Implies(x,y), new And(y,z));
  public final static IfForm if8 = new IfIf(new IfIf(x, y, Constant.TRUE),
                                            new IfIf(y, z, Constant.FALSE),
                                            Constant.TRUE);
  
  public final static IfForm nif8 = new IfIf(x, 
                                             new IfIf(y, 
                                                      new IfIf(y, z, Constant.FALSE), 
                                                      Constant.TRUE),
                                             new IfIf(Constant.TRUE, 
                                                      new IfIf(y, z, Constant.FALSE), 
                                                      Constant.TRUE));
  public final static IfForm enif8 = new IfIf(x, 
                                              new IfIf(y, 
                                                       z, 
                                                       Constant.TRUE),
                                              new IfIf(y, z, Constant.FALSE));
  
  public final static IfForm if9 = new IfIf(if8, x, y);
  public final static IfForm nif9 = new IfIf(x,                         
                                             new IfIf(y, 
                                                      new IfIf(y, 
                                                               new IfIf(z, x, y), 
                                                               new IfIf(Constant.FALSE, x, y)),
                                                      new IfIf(Constant.TRUE, x, y)),                         
                                             new IfIf(Constant.TRUE, 
                                                      new IfIf(y, 
                                                               new IfIf(z, x, y), 
                                                               new IfIf(Constant.FALSE, x, y)),
                                                      new IfIf(Constant.TRUE, x, y)));
  
  public final static IfForm enif9 = new IfIf(x,                          
                                              Constant.TRUE,
                                              new IfIf(y, 
                                                       new IfIf(z, Constant.FALSE, Constant.TRUE), 
                                                       Constant.FALSE));
  
  public final static IfForm nif10 = new IfIf(x, y, y);
  public final static IfForm enif10 = y;
  
  public final static IfForm nif11 = new IfIf(x, Constant.TRUE, Constant.FALSE);
  public final static IfForm enif11 = x;
  
  public InterpBoolSimpTest(final String name) { super(name); }
  
  public void setup() { }
  
  public void testEquals() {
    assertEquals("Variable equals", x, Variable.makeVariable("X"));
    assertTrue("Variable x not equals Variable y", !(x.equals(y)));
    assertEquals("And equals", f1, new And(x,y));
    assertEquals("Or equals", f2, new Or(x,y));
    assertEquals("Implies equals", f3, new Implies(x,y));
    assertEquals("Not equals", f4, new Not(z));
    assertEquals("If equals", f5, new If(x, y, z));

    assertEquals("Constant equals TRUE", Constant.TRUE, Constant.TRUE);
    assertEquals("Constant equals FALSE", Constant.FALSE, Constant.FALSE);
    assertEquals("Variable equals A", Variable.makeVariable("A"), Variable.makeVariable("A"));
    assertEquals("Variable equals B", Variable.makeVariable("B"), Variable.makeVariable("B"));
    assertEquals("And equals A B", new And(Variable.makeVariable("A"), Variable.makeVariable("B")), new And(Variable.makeVariable("A"), Variable.makeVariable("B")));
    assertEquals("Or equals A B", new Or(Variable.makeVariable("A"), Variable.makeVariable("B")), new Or(Variable.makeVariable("A"), Variable.makeVariable("B")));
    assertEquals("Implies equals A B", new Or(Variable.makeVariable("A"), Variable.makeVariable("B")), new Or(Variable.makeVariable("A"), Variable.makeVariable("B")));
    assertEquals("Not equals A", new Not(Variable.makeVariable("A")), new Not(Variable.makeVariable("A")));
    assertEquals("If equals A B C", new If(Variable.makeVariable("A"), Variable.makeVariable("B"), Variable.makeVariable("C")), new If(Variable.makeVariable("A"), Variable.makeVariable("B"), Variable.makeVariable("C")));
  }
  
  public void testConvertToIf() {
    // ConvertToIf.ONLY is a static field in ConvertToIf that is bound to new ConvertToIf()
    assertEquals("Variable Conversion", x, x.convertToIf());
    assertEquals("And Conversion", if1, f1.convertToIf());
    assertEquals("Or Conversion", if2, f2.convertToIf());
    assertEquals("Implies Conversion", if3, f3.convertToIf());
    assertEquals("Not Conversion", if4, f4.convertToIf());
    assertEquals("If Conversion", if5, f5.convertToIf());
    assertEquals("Compound Or Conversion", if6, f6.convertToIf());
    assertEquals("Compound And Conversion", if7, f7.convertToIf());
    assertEquals("Compound Implies Conversion", if8, f8.convertToIf());

    assertEquals("Constant Conversion TRUE", Constant.TRUE, Constant.TRUE.convertToIf());
    assertEquals("Constant Conversion FALSE", Constant.FALSE, Constant.FALSE.convertToIf());
    assertEquals("Variable Conversion A", Variable.makeVariable("A"), Variable.makeVariable("A").convertToIf());
    assertEquals("Not Conversion A", new Not(Variable.makeVariable("A")).convertToIf(), new IfIf(Variable.makeVariable("A"), Constant.FALSE, Constant.TRUE));
    assertEquals("And Conversion A B", new And(Variable.makeVariable("A"), Variable.makeVariable("B")).convertToIf(), new IfIf(Variable.makeVariable("A"), Variable.makeVariable("B"), Constant.FALSE));
    assertEquals("Or Conversion A B", new Or(Variable.makeVariable("A"), Variable.makeVariable("B")).convertToIf(), new IfIf(Variable.makeVariable("A"), Constant.TRUE, Variable.makeVariable("B")));
    assertEquals("Implies Conversion A B", new Implies(Variable.makeVariable("A"), Variable.makeVariable("B")).convertToIf(), new IfIf(Variable.makeVariable("A"), Variable.makeVariable("B"), Constant.TRUE));
  }
  
  public void testNorm() {
    // Normalize.ONLY is a static field in Normalize that is bound to new Normalize()
    assertEquals("Normalize Variable", x, x.normalize());
    assertEquals("Normalize Constant.TRUE", Constant.TRUE, Constant.TRUE.normalize());
    assertEquals("Normalize Constant.FALSE", Constant.FALSE, Constant.FALSE.normalize());
    assertEquals("Normalize Trivial If", if5, if5.normalize());
    assertEquals("One-step Normalize", nif8, if8.normalize());
    assertEquals("Nested Normalize", nif9, if9.normalize());

    assertEquals("Normalize Constant TRUE", Constant.TRUE, Constant.TRUE.normalize());
    assertEquals("Normalize Constant FALSE", Constant.FALSE, Constant.FALSE.normalize());
    assertEquals("Normalize Variable A", Variable.makeVariable("A"), Variable.makeVariable("A").normalize());
    assertEquals("Normalize If A B C", new IfIf(Variable.makeVariable("A"), Variable.makeVariable("B"), Variable.makeVariable("C")).normalize(), new IfIf(Variable.makeVariable("A"), Variable.makeVariable("B"), Variable.makeVariable("C")));
    assertEquals("Normalize If (A B C) D E", new IfIf(new IfIf(Variable.makeVariable("A"), Variable.makeVariable("B"), Variable.makeVariable("C")), Variable.makeVariable("D"), Variable.makeVariable("E")).normalize(), new IfIf(Variable.makeVariable("A"), new IfIf(Variable.makeVariable("B"), Variable.makeVariable("D"), Variable.makeVariable("E")), new IfIf(Variable.makeVariable("C"), Variable.makeVariable("D"), Variable.makeVariable("E"))));
  }
  
  public void testEval() {
    Environment E = EmptyEnvironment.ONLY;
    assertEquals("Eval Variable", x, x.eval(E));
    assertEquals("Eval Trivial If", if5, if5.eval(E));
    assertEquals("Eval nif8", enif8, nif8.eval(E));
    assertEquals("Eval nif9", enif9, nif9.eval(E));
    assertEquals("Check (? x alpha alpha) => alpha", enif10, nif10.eval(E));
    assertEquals("Check (? x T F) => x", enif11, nif11.eval(E));

    assertEquals("Eval Constant TRUE", Constant.TRUE, Constant.TRUE.eval(E));
    assertEquals("Eval Constant FALSE", Constant.FALSE, Constant.FALSE.eval(E));
    assertEquals("Eval Variable A", Variable.makeVariable("A"), Variable.makeVariable("A").eval(E));
    assertEquals("Eval Variable A bound with Constant TRUE", Constant.TRUE, Variable.makeVariable("A").eval(E.bind(Variable.makeVariable("A"), Constant.TRUE)));
    assertEquals("Eval Not Operation TRUE", Constant.FALSE, new Not(Constant.TRUE).convertToIf().eval(E));
    assertEquals("Eval Not Operation FALSE", Constant.TRUE, new Not(Constant.FALSE).convertToIf().eval(E));
    assertEquals("Eval And Operation TRUE TRUE", Constant.TRUE, new And(Constant.TRUE, Constant.TRUE).convertToIf().eval(E));
    assertEquals("Eval And Operation TRUE FALSE", Constant.FALSE, new And(Constant.TRUE, Constant.FALSE).convertToIf().eval(E));
    assertEquals("Eval And Operation FALSE TRUE", Constant.FALSE, new And(Constant.FALSE, Constant.TRUE).convertToIf().eval(E));
    assertEquals("Eval And Operation FALSE FALSE", Constant.FALSE, new And(Constant.FALSE, Constant.FALSE).convertToIf().eval(E));
    assertEquals("Eval Or Operation TRUE TRUE", Constant.TRUE, new Or(Constant.TRUE, Constant.TRUE).convertToIf().eval(E));
    assertEquals("Eval Or Operation TRUE FALSE", Constant.TRUE, new Or(Constant.TRUE, Constant.FALSE).convertToIf().eval(E));
    assertEquals("Eval Or Operation FALSE TRUE", Constant.TRUE, new Or(Constant.FALSE, Constant.TRUE).convertToIf().eval(E));
    assertEquals("Eval Or Operation FALSE FALSE", Constant.FALSE, new Or(Constant.FALSE, Constant.FALSE).convertToIf().eval(E));
    assertEquals("Eval Implies Operation TRUE TRUE", Constant.TRUE, new Implies(Constant.TRUE, Constant.TRUE).convertToIf().eval(E));
    assertEquals("Eval Implies Operation TRUE FALSE", Constant.FALSE, new Implies(Constant.TRUE, Constant.FALSE).convertToIf().eval(E));
    assertEquals("Eval Implies Operation FALSE TRUE", Constant.TRUE, new Implies(Constant.FALSE, Constant.TRUE).convertToIf().eval(E));
    assertEquals("Eval Implies Operation FALSE FALSE", Constant.TRUE, new Implies(Constant.FALSE, Constant.FALSE).convertToIf().eval(E));

    assertEquals("Eval If Operation TRUE TRUE TRUE", Constant.TRUE, new IfIf(Constant.TRUE, Constant.TRUE, Constant.TRUE).eval(E));
    assertEquals("Eval If Operation TRUE TRUE FALSE", Constant.TRUE, new IfIf(Constant.TRUE, Constant.TRUE, Constant.FALSE).eval(E));
    assertEquals("Eval If Operation TRUE FALSE TRUE", Constant.FALSE, new IfIf(Constant.TRUE, Constant.FALSE, Constant.TRUE).eval(E));
    assertEquals("Eval If Operation TRUE FALSE FALSE", Constant.FALSE, new IfIf(Constant.TRUE, Constant.FALSE, Constant.FALSE).eval(E));
    assertEquals("Eval If Operation FALSE TRUE TRUE", Constant.TRUE, new IfIf(Constant.FALSE, Constant.TRUE, Constant.TRUE).eval(E));
    assertEquals("Eval If Operation FALSE TRUE FALSE", Constant.FALSE, new IfIf(Constant.FALSE, Constant.TRUE, Constant.FALSE).eval(E));
    assertEquals("Eval If Operation FALSE FALSE TRUE", Constant.TRUE, new IfIf(Constant.FALSE, Constant.FALSE, Constant.TRUE).eval(E));
    assertEquals("Eval If Operation FALSE FALSE FALSE", Constant.FALSE, new IfIf(Constant.FALSE, Constant.FALSE, Constant.FALSE).eval(E));
  }
  
  public void testConvertToBool() {
    // ConvertToBool.ONLY is a static field in ConvertToBool that is bound to new ConvertToBool()
    assertEquals("ConvertToBool variable", x.convertToBool(), x);

    assertEquals("Constant Conversion TRUE", Constant.TRUE, Constant.TRUE.convertToBool());
    assertEquals("Constant Conversion FALSE", Constant.FALSE, Constant.FALSE.convertToBool());
    assertEquals("Variable Conversion A", Variable.makeVariable("A"), Variable.makeVariable("A").convertToBool());
    assertEquals("First Case Conversion", new IfIf(Variable.makeVariable("A"), Constant.FALSE, Constant.TRUE).convertToBool(), new Not(Variable.makeVariable("A")));
    assertEquals("Second Case Conversion", new IfIf(Variable.makeVariable("A"), Variable.makeVariable("B"), Constant.FALSE).convertToBool(), new And(Variable.makeVariable("A"), Variable.makeVariable("B")));
    assertEquals("Third Case Conversion", new IfIf(Variable.makeVariable("A"), Constant.TRUE, Variable.makeVariable("B")).convertToBool(), new Or(Variable.makeVariable("A"), Variable.makeVariable("B")));
    assertEquals("Forth Case Conversion", new IfIf(Variable.makeVariable("A"), Variable.makeVariable("B"), Constant.TRUE).convertToBool(), new Implies(Variable.makeVariable("A"), Variable.makeVariable("B")));
    assertEquals("Fifth Case Conversion", new IfIf(Variable.makeVariable("A"), Variable.makeVariable("B"), Variable.makeVariable("C")).convertToBool(), new If(Variable.makeVariable("A"), Variable.makeVariable("B"), Variable.makeVariable("C")));
  }
  
  
  public void testPrint() {
    // Print.ONLY is a static field in Print that is bound to new Print()
    Form boolForm = new And(new Implies(x, y), new Or(z, new If(z, y, x)));
    assertEquals("ComplexBoolFormula", "(& (> X Y) (| Z (? Z Y X)))", boolForm.print());
    IfForm ifForm = new IfIf(new IfIf(x, y, Constant.TRUE), new IfIf(z, Constant.TRUE, new IfIf(z, y, x)), Constant.FALSE);
    assertEquals("ComplexIfFormula", "(? (? X Y T) (? Z T (? Z Y X)) F)", ifForm.print());
  }
}  
