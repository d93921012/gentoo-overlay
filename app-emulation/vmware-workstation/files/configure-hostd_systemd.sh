#!/bin/bash

action="$1"

case $action in
  add)
    systemctl -q enable vmware-workstation-server.target
    systemctl -q start vmware-workstation-server.target
    ;;
  remove)
    systemctl -q disable vmware-workstation-server.target
    systemctl -q stop vmware-workstation-server.target
    ;;
  status)
    systemctl -q is-active vmware-workstation-server.target && echo on || echo off
    ;;
  *)
    exit 1
    ;;
esac
