#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Author: Ethan
# @Date:   2015-11-29
# @Last Modified by:   Ethan
# @Last Modified time: 2016-01-07

import lldb
import commands
import os

def choose(debugger, command, result, internal_dict):
    cmd_result = lldb.SBCommandReturnObject()
    lldb.debugger.GetCommandInterpreter().HandleCommand("platform status", cmd_result)
    if "remote-ios" in cmd_result.GetOutput():
        choose_device(debugger, command, result, internal_dict)
    else:
        debugger.HandleCommand('expr (void *)dlopen("'+os.path.dirname(__file__)+'/choose.dylib", 0x2)')
        debugger.HandleCommand('po [choose choose:@"'+command+'"]')

def choose_device(debugger, command, result, internal_dict):
    cmd_result = lldb.SBCommandReturnObject()
    lldb.debugger.GetCommandInterpreter().HandleCommand("image list choose.dylib", cmd_result)
    if "error:" in cmd_result.GetError():
        print "loading choose.dylib"
        base64_dylib = os.popen("base64 '"+os.path.dirname(__file__)+"/choose-arm.dylib'").read().strip('\n')
        debugger.HandleCommand('expr NSString * $dylib_string = @"'+base64_dylib+'"')
        debugger.HandleCommand('expr NSString * $dylib_path = (NSString *)[NSTemporaryDirectory() stringByAppendingString:@"choose.dylib"]')
        debugger.HandleCommand('expr NSData * $dylib_data = (NSData *)[[NSData alloc] initWithBase64EncodedString:$dylib_string options:0]')
        debugger.HandleCommand('expr (BOOL)[$dylib_data writeToFile:$dylib_path atomically:YES]')
        debugger.HandleCommand('expr (void)printf("saved to %s, %d bytes..\\n", (char *)[$dylib_path cStringUsingEncoding:0x4], $dylib_data.length)')
        debugger.HandleCommand('expr (void *)dlopen((char *)[$dylib_path cStringUsingEncoding:0x4], 0x2)')
    debugger.HandleCommand('po [choose choose:@"'+command+'"]')

def __lldb_init_module(debugger, internal_dict):
    debugger.HandleCommand('command script add choose -f choose.choose')
    debugger.HandleCommand('command script add choose_dev -f choose.choose_device')
    print 'The "choose" python command has been installed and is ready for use.'
