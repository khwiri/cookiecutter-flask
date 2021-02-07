from typing import Iterable
from pathlib import Path
from pathlib import PosixPath


PROJECT_ROOT = Path('.')


def lf_line_endings_required_files() -> Iterable[PosixPath]:
    yield PROJECT_ROOT / '.python-version'
    yield PROJECT_ROOT / '.nvmrc'
    yield from PROJECT_ROOT.glob('**/*.sh')


def translate_to_lf_line_endings(file :PosixPath) -> None:
    file_bytes_original_line_endings = file.read_bytes()
    file_bytes_lf_line_endings = file_bytes_original_line_endings.replace(b'\r\n', b'\n')
    file.write_bytes(file_bytes_lf_line_endings)


if __name__ == '__main__':
    # Create instance configuration placeholder
    instance_path = PROJECT_ROOT / 'instance'
    instance_path.mkdir(exist_ok=True)
    with (instance_path / 'config.py').open(mode='w') as f:
        f.write('# Place secret configuration like database passwords and api keys here...\n')

    # Ensure line endings for certain files
    for f in lf_line_endings_required_files():
        translate_to_lf_line_endings(f)
