/-!
# Classical logic

`Logic.Propositional` uses intuitionistically valid reasoning. The results in
this module explicitly opt into classical reasoning.
-/

namespace Logic.Classical

theorem excluded_middle (P : Prop) : P ∨ ¬ P :=
  _root_.Classical.em P

theorem double_negation_elimination (P : Prop) (h : ¬ ¬ P) : P :=
  _root_.Classical.byContradiction h

end Logic.Classical
