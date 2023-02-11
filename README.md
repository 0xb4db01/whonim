Yesterday I was in a good mood for nim-learning and told to myself: why not pick up a simple project such as a whois output normalizer? This would be perfect to practice some good ol' Nim.

Then I went through a couple of RFCs, some searches and a couple of random TLD tests and said no.

No is no.

But I already had wrote the code for a whois query with raw output so what, rm -rf? Felt bad, so here it is, in case someone does needs it fast on some Windows VM that doesn't have it you can cross-compile it.

# Notes

Whonim assumes there is a _whois.nic.TLD_ registered for each TLDs. Obviously this is absolutely false so there's a Table for TLD reference. Whonim first checks that table and if there's not it will return a _whois.nic.TLD_ domain and hope for the best.

Feel free to add some TLDs in the table since I have not tested them all.

# Compile

```
nim -d:release -d:strip c whonim.nim
```

# Mingw cross-compile

```
nim -d:release -d:mingw -d:strip c whonim.nim
```

# Usage

Well...

```
./whonim github.com
```
