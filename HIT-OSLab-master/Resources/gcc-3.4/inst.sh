#!/bin/sh

if [ "$1" = "i386" ]; then
    dpkg -i gcc-3.4_i386/gcc-3.4-base_3.4.6-8ubuntu2_i386.deb
    dpkg -i gcc-3.4_i386/cpp-3.4_3.4.6-8ubuntu2_i386.deb
    dpkg -i gcc-3.4_i386/gcc-3.4_3.4.6-8ubuntu2_i386.deb
else 
    if [ "$1" = "amd64" ]; then
        dpkg -i gcc-3.4_amd64/gcc-3.4-base_3.4.6-8ubuntu2_amd64.deb
        dpkg -i gcc-3.4_amd64/cpp-3.4_3.4.6-8ubuntu2_amd64.deb
        dpkg -i gcc-3.4_amd64/gcc-3.4_3.4.6-8ubuntu2_amd64.deb
    else
        echo "Use \"$0 i386\" or \"$0 amd64\""
    fi
fi
