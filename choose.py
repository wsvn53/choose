#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Author: Ethan
# @Date:   2015-11-29
# @Last Modified by:   Ethan
# @Last Modified time: 2015-11-29

import lldb
import commands
import os

def choose(debugger, command, result, internal_dict):
    debugger.HandleCommand('expr (void *)dlopen("'+os.path.dirname(__file__)+'/choose.dylib", 0x2)')
    debugger.HandleCommand('po [choose choose:@"'+command+'"]')

def __lldb_init_module(debugger, internal_dict):
    debugger.HandleCommand('command script add choose -f choose.choose')
    print 'The "choose" python command has been installed and is ready for use.'
