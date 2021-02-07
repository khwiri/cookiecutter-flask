from pathlib import Path


PROJECT_ROOT = Path('.')


if __name__ == '__main__':
    # Create instance configuration placeholder
    instance_path = PROJECT_ROOT / 'instance'
    instance_path.mkdir(exist_ok=True)
    with (instance_path / 'config.py').open(mode='w') as f:
        f.write('# Place secret configuration like database passwords and api keys here...\n')
