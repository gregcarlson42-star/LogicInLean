/-!
# Predicate logic

Quantifiers extend propositional reasoning to propositions about elements of a
type.
-/

namespace Logic.Predicate

theorem forall_and {α : Type} (P Q : α → Prop)
    (h : ∀ x : α, P x ∧ Q x) :
    (∀ x : α, P x) ∧ (∀ x : α, Q x) :=
  ⟨fun x => (h x).1, fun x => (h x).2⟩

theorem exists_or {α : Type} (P Q : α → Prop)
    (h : (∃ x : α, P x) ∨ (∃ x : α, Q x)) :
    ∃ x : α, P x ∨ Q x :=
  Or.elim h
    (fun hP => Exists.elim hP fun x hp => ⟨x, Or.inl hp⟩)
    (fun hQ => Exists.elim hQ fun x hq => ⟨x, Or.inr hq⟩)

end Logic.Predicate
