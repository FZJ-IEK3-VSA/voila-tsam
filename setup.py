import sys
import os
from setuptools import setup, find_packages
from setuptools.command.develop import develop

try:
    import jupyter_core.paths as jupyter_core_paths
except:
    jupyter_core_paths = None


pjoin = os.path.join


class DevelopCmd(develop):
    prefix_targets = [
        ("nbconvert/templates", 'fzj-template'),
        ("voila/templates", 'fzj-template'),
    ]
    def run(self):
        target_dir = os.path.join(sys.prefix, 'share', 'jupyter')
        if '--user' in sys.prefix:  # TODO: is there a better way to find out?
            target_dir = jupyter_core_paths.user_dir()
        target_dir = os.path.join(target_dir)

        for prefix_target, name in self.prefix_targets:
            source = os.path.join('share', 'jupyter', prefix_target, name)
            target = os.path.join(target_dir, prefix_target, name)
            target_subdir = os.path.dirname(target)
            if not os.path.exists(target_subdir):
                os.makedirs(target_subdir)
            rel_source = os.path.relpath(os.path.abspath(source), os.path.abspath(target_subdir))
            try:
                os.remove(target)
            except:
                pass
            print(rel_source, '->', target)
            os.symlink(rel_source, target)

        super(DevelopCmd, self).run()


data_files = []
for root, dirs, files in os.walk('share'):
    root_files = [os.path.join(root, i) for i in files]
    data_files.append((root, root_files))

dir_path = os.path.dirname(os.path.realpath(__file__))
with open( os.path.join(dir_path,'requirements.txt') ) as f:
    required_packages = f.read().splitlines()
with open(os.path.join(dir_path,'README.md'), "r") as fh:
    long_description = fh.read()

setup(
    name='voila-fzj',
    version="0.0.2",
    description="FZ Juelich template for voila",
    data_files=data_files,
    include_package_data=True,
    packages = find_packages(),
    long_description=long_description,
    long_description_content_type="text/markdown",
    author='Leander Kotzur, Anxhela Hyseni',
    author_email='l.kotzur@fz-juelich.de',
    install_requires = required_packages,
    setup_requires = ['setuptools-git'],
    url='https://gitlab.version.fz-juelich.de/metis/jupyter-dashboard',
    keywords=[
        'ipython',
        'jupyter',
        'widgets',
        'voila'
    ],
    cmdclass={
        'develop': DevelopCmd,
   },
)