import json
import os
import subprocess
from pathlib import Path

from jupyter_client.kernelspec import KernelSpecManager


PROJECT_ROOT = Path(__file__).resolve().parents[1]
VENV_BIN = PROJECT_ROOT / ".venv" / "bin"


def main():
    result = subprocess.run(
        ["lake", "env", "which", "repl"],
        cwd=PROJECT_ROOT,
        check=True,
        capture_output=True,
        text=True,
    )
    repl_path = Path(result.stdout.strip()).resolve()
    repl_link = VENV_BIN / "repl"

    if repl_link.is_symlink():
        if repl_link.resolve() != repl_path:
            repl_link.unlink()
    elif repl_link.exists():
        raise FileExistsError(f"Refusing to replace existing file: {repl_link}")

    if not repl_link.exists():
        repl_link.symlink_to(repl_path)

    kernel = KernelSpecManager().get_kernel_spec("lean4")
    kernel_file = Path(kernel.resource_dir) / "kernel.json"
    spec = json.loads(kernel_file.read_text())
    env = spec.setdefault("env", {})
    path = env.get("PATH", os.environ.get("PATH", ""))
    path_entries = [entry for entry in path.split(os.pathsep) if entry != str(VENV_BIN)]
    env["PATH"] = os.pathsep.join([str(VENV_BIN), *path_entries])
    spec["argv"] = [
        "/usr/bin/env",
        f"PATH={env['PATH']}",
        str(VENV_BIN / "python"),
        "-m",
        "lean4_jupyter",
        "-f",
        "{connection_file}",
    ]
    kernel_file.write_text(json.dumps(spec, indent=2) + "\n")

    print(f"Configured Lean Jupyter kernel at {kernel_file}")


if __name__ == "__main__":
    main()
