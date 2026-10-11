section
variable (P Q : Prop)

theorem my_theorem : P ∧ Q → Q ∧ P := by
  rintro h : P ∧ Q
  apply And.intro
  . exact And.right h
  . exact And.left h
end

