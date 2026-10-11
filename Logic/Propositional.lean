/-!
# Propositional logic

These examples use Lean propositions as types and proofs as terms.
-/

namespace Logic.Propositional

theorem and_comm (P Q : Prop) (h : P ∧ Q) : Q ∧ P :=
  ⟨h.2, h.1⟩

theorem or_comm (P Q : Prop) (h : P ∨ Q) : Q ∨ P :=
  Or.elim h Or.inr Or.inl

theorem implication_trans (P Q R : Prop) (h₁ : P → Q) (h₂ : Q → R) : P → R :=
  fun hp => h₂ (h₁ hp)

theorem iff_iff_pair (P Q : Prop) : (P ↔ Q) ↔ (P → Q) ∧ (Q → P) :=
  ⟨fun h => ⟨h.mp, h.mpr⟩, fun h => ⟨h.1, h.2⟩⟩

end Logic.Propositional


