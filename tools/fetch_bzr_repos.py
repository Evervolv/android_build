#!/usr/bin/env python2.7
# This program is free software: you can redistribute it and/or modify it
# under the terms of the the GNU General Public License version 3, as
# published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranties of
# MERCHANTABILITY, SATISFACTORY QUALITY or FITNESS FOR A PARTICULAR
# PURPOSE.  See the applicable version of the GNU General Public
# License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# Copyright (C) 2013 Canonical, Ltd.

'''Fetch ubuntu bzr projects'''

import os
from os import path
from subprocess import check_call
from subprocess import CalledProcessError as CPE

ubuntu_dir = 'ubuntu'
branches = {
    'ubuntu/hybris': 'lp:phablet-extras/libhybris',
    'ubuntu/platform-api': 'lp:platform-api',
}

def branch_target(repo, target_directory):
    cmds = {
        'branch': 'bzr branch %s %s' % (repo, target_directory),
        'pull'  : 'bzr pull',
    }
    if not path.exists(target_directory):
        print('Branching %s into %s' % (repo, target_directory))
        try:
            check_call(cmds.get('branch'), shell=True)
        except CPE as e:
            print(e)
    else:
        print('Updating %s' % target_directory)
        prev_dir = os.getcwd()
        try:
            os.chdir(target_directory)
            check_call(cmds.get('pull'), shell=True)
        except CPE as e:
            print(e)
        except OSError as e:
            print(e)
        finally:
            os.chdir(prev_dir)

def setup_branches():
    print('\nSyncing bzr repos')
    if not path.exists(ubuntu_dir):
        try:
            os.mkdir(ubuntu_dir)
        except OSError as e:
            print('Fatal: %s' % e)
            exit()
    for branch in branches.keys():
        branch_target(branches.get(branch), branch)

if __name__ == "__main__":
    setup_branches()
