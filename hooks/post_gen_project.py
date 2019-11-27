import os
from functools import partial


if __name__ == '__main__':
    instance_config_directory = os.path.join(os.path.abspath('.'), 'instance')
    instance_config_directory_exists = partial(os.path.exists, instance_config_directory)
    if not instance_config_directory_exists():
        os.mkdir(instance_config_directory)
        if not instance_config_directory_exists():
            raise FileNotFoundError(f'Failed while creating instance configuration directory ({instance_config_directory}).')
    else:
        print('Skip creating instance configuration directory because it already exists.')

    instance_config = os.path.join(instance_config_directory, 'config.py')
    if not os.path.exists(instance_config):
        with open(instance_config, 'wt') as f:
            f.write('# Place secret configuration like database passwords and api keys here...\n')
    else:
        print('Skip creating instance configuration because it already exists.')
