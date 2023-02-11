##
# Whonim, a stupid whois command line tool in Nim.
#
# Author: 0xb4db01
# Date  : 10/02/2023
#

import os
import std/net
import std/strutils
import std/tables

proc helpUsage() =
    echo "add a domain"

    quit(-1)

let WHOIS_SERVERS = {
    "com": "whois.markmonitor.com"
}.toTable

##
# We assume that all TLDs have a whois.nic.TLD registered. When this is not the
# case we will have checked in WHOIS_SERVERS[TLD] table for a direct reference.
#
proc getWhoisServer(domain: string): string =
    let tmp = split(domain, ".")
    let tld = tmp[tmp.high]

    if tld in WHOIS_SERVERS:
        return WHOIS_SERVERS[tld]

    return "whois.nic." & tld

proc whois(domain: string): string =
    let server = getWhoisServer(domain)
    let s = newSocket()

    try:
        s.connect(server, Port(43))
    except:
        echo "Can't reach " & server

        quit(-1)

    echo "Querying " & server & " for " & domain

    s.send(domain & "\r\n")

    var r: string = ""

    while true:
        let tmp = s.recv(1024)

        if tmp == "":
            break

        r &= tmp

    return r

##
# No need for fancy command line flags, it's just the domain anyways...
#
try:
    let domain = commandLineParams()[0]

    echo whois(domain)
except:
    helpUsage()
