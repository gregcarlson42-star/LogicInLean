# Logic in Lean

A small Lean 4 project for learning propositional logic, classical logic, and
predicate logic through formal proofs.

## Read on GitHub

You can read the notebook directly on GitHub:
[`notebooks/chapters/01_PropositionalLogic.ipynb`](notebooks/chapters/01_PropositionalLogic.ipynb).
GitHub displays the notebook and its saved outputs, but does not run Lean code.

## Get started

Install Lean 4 and Lake using [elan](https://github.com/leanprover/elan), then
run:

```sh
lake update
lake exe cache get
lake build
```

The project currently targets Lean `v4.34.1` and uses
[mathlib](https://github.com/leanprover-community/mathlib4).

## Lean in Jupyter notebooks

The notebook uses a Jupyter kernel backed by the Lean REPL. The REPL is pinned
as a Lake dependency so it uses this project's Lean toolchain and can import
project modules and Mathlib. GitHub is for reading the notebook; to run its
cells, set up the kernel locally. VS Code is optional.

After installing Lean 4 with elan and Python 3.9 or later, run these commands
from the project root on macOS or Linux:

```sh
python3 -m venv .venv
.venv/bin/python -m pip install --upgrade pip
.venv/bin/python -m pip install notebook lean4_jupyter
lake exe cache get
lake build
lake build repl
.venv/bin/python -m lean4_jupyter.install
.venv/bin/python scripts/configure_lean_jupyter.py
```

Start Jupyter Notebook from the project root:

```sh
.venv/bin/jupyter notebook
```

Open a notebook in `notebooks/chapters/`, select the **Lean 4** kernel when
prompted, and run cells from top to bottom. The notebook kernel must start from
the project root so Lake can find `lakefile.toml`.

To use VS Code instead, install the **Jupyter** extension, open this project
folder, and open the notebook. The Lean kernel is registered separately by the
setup commands above; select **Lean 4**, not a Python kernel.

When the repository is opened in VS Code, it recommends the Lean 4, Jupyter,
and Python extensions. These editor extensions do not install the Lean
notebook kernel; the setup commands above do that.

The Lean Jupyter kernel is a community project, not part of Lean itself. The
REPL dependency is pinned, and Python packages are isolated in `.venv`; this
setup does not change elan's global Lean toolchain.

## Organizing notebook chapters

Keep one notebook per chapter in `notebooks/`, with a two-digit number so the
chapters appear in reading order. Keep the reusable template separate from
finished chapters:

```text
notebooks/
  ChapterTemplate.ipynb
  chapters/
    01_PropositionalLogic.ipynb
    02_ClassicalLogic.ipynb
    03_PredicateLogic.ipynb
```

Start a chapter by copying `ChapterTemplate.ipynb` into `notebooks/chapters/`
and giving the copy its number and topic. Each chapter notebook is standalone:
it has its own explanations, examples, exercises, imports, and glossary. Add
only terms newly introduced in that chapter to its glossary; link to earlier
chapters for terms already explained. Link a chapter from this README when it
is ready to share. Keep each notebook focused on one topic, explain ideas in
Markdown cells, and place Lean examples close to their explanations. Run cells
from top to bottom before sharing so saved outputs match the current notebook.
The template already selects the **Lean 4** kernel and imports Mathlib and this
project's `Logic` library.

## Learning path

1. Read `Logic/Propositional.lean`: prove conjunction, disjunction, implication,
   and equivalence results by constructing and unpacking proofs.
2. Add exercises such as `P ∧ Q → P`, `P → P ∨ Q`, and the transitivity of `↔`.
   Try term-style proofs first, then use tactics like `intro`, `rcases`,
   `constructor`, and `exact`.
3. Compare intuitionistically valid results with the explicit classical
   principles in `Logic/Classical.lean`. Try proving excluded middle without
   `classical`, and observe what Lean allows.
4. Work through `Logic/Predicate.lean`: practice moving quantifiers through
   connectives, and note where witness construction is needed for `∃`.
5. Extend the project with your own modules: relations, equality, finite
   truth tables, or a syntax-and-semantics model for propositional formulas.
6. Learn Kripke semantics: define worlds, an accessibility relation, and
   truth-at-a-world, then formalize and prove basic properties of necessity.
   See the Kripke and modal-logic repositories below for examples to study.

`Logic.lean` imports the learning modules and is the default library target.
Keep new proofs in appropriately named files under `Logic/`, then import them
from `Logic.lean`.

## Using other public repositories

The mathlib dependency is managed by Lake in `lakefile.toml` and locked in
`lake-manifest.json`. For a Lean library hosted on GitHub, add a Lake dependency
to `lakefile.toml` following the same `[[require]]` pattern as mathlib, pin it
to a tag or commit, and run:

```sh
lake update
lake build
```

This records the exact revision in the manifest. You can then import that
library's Lean modules. For a repository you only want to study, use a separate
clone rather than copying its files into this project's source tree.

## Suggested public resources

- [Mathematics in Lean](https://github.com/leanprover-community/mathematics_in_lean)
  is a maintained, hands-on Lean 4 tutorial. Its early logic chapters complement
  the proof patterns in this project.
- [Logic and Proof](https://github.com/leanprover-community/logic_and_proof)
  is a textbook and exercise resource focused on logic and Lean, with a web
  edition at [leanprover.github.io/logic_and_proof](https://leanprover.github.io/logic_and_proof).
  Its Lean materials have been updated to Lean 4. The older Python/LaTeX
  instructions in its repository are for building the book, not for using its
  Lean examples. Use it as a learning resource rather than as a Lake dependency.
- [Lean 4 Game](https://github.com/leanprover-community/lean4game) is the
  framework for interactive theorem-proving games; it is useful if you later
  want to build or contribute logic exercises in a game format.
- [Lean 4](https://github.com/leanprover/lean4) is the language and theorem
  prover source repository; use it when you want to explore core tactics,
  syntax, or the kernel.
- [mathlib4](https://github.com/leanprover-community/mathlib4) is the main
  community library and the dependency used here. Explore its logic modules
  after you are comfortable with basic Lean proof terms.
- [Foundation](https://github.com/FormalizedFormalLogic/Foundation) includes
  Kripke semantics for classical, intuitionistic, and first-order logic. This
  is a useful next reference for Kripke models.
- [NonClassicalModalLogic](https://github.com/FormalizedFormalLogic/NonClassicalModalLogic)
  focuses on non-classical modal logic.
- [BimodalLogic](https://github.com/benbrastmckie/BimodalLogic) formalizes a
  logic combining tense and modality, including results about soundness and
  completeness.
- [lean4-modallogic](https://github.com/SnO2WMaN/lean4-modallogic) is an
  archived Lean 4 modal-logic project. Use it as a reference, not as a current
  dependency.

These projects formalize different systems and semantics; treat them as
examples to compare rather than interchangeable libraries. Start by reading
their definitions and theorem statements, and only add one as a Lake dependency
if you have a specific need to import its code.

When adapting proofs or source from another repository, keep its license and
attribution requirements, and prefer pinned dependencies over copying code.
