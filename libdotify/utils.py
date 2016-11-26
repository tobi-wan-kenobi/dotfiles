import os
import shlex
import logging
import subprocess
import contextlib

@contextlib.contextmanager
def cd(newdir):
    prevdir = os.getcwd()
    os.chdir(os.path.expanduser(newdir))
    try:
        yield
    finally:
        os.chdir(prevdir)

def execute(cmd):
    args = shlex.split(cmd)
    p = subprocess.Popen(args, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    out = p.communicate()

    for line in out:
        if not line: continue
        logging.info(line.rstrip())
    if p.returncode != 0:
        logging.error("{} failed with {}".format(cmd, p.returncode))

def git_update(dotmodule, dst, plugins):
    for plugin in plugins:
        name = os.path.basename(plugin).rpartition(".git")[0] # replace trailing ".git"
        path = "{}{}".format(dst, name)

        if os.path.exists(path):
            logging.debug("updating {} plugin {}".format(dotmodule, name))
            with cd(path):
                execute("git pull")
        else:
            logging.debug("cloning {} plugin {}".format(dotmodule, name))
            with cd(dst):
                execute("git clone {}".format(plugin))

# vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
