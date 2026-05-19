# Nim Language Cheat Sheet

> Comprehensive, well-organized reference for Nim developers.
> Sections grouped by topic. Some content intentionally duplicated across
> related sections so you can find what you need without jumping around.

---

## Table of Contents

### Getting Started
- [Imports Quick Reference](#imports-quick-reference)
- [Project Setup & Build](#project-setup--build)
- [Comments](#comments)

### Core Language
- [Variables & Constants](#variables--constants)
- [Data Types](#data-types)
- [Operators](#operators)
- [Indexing & Slicing](#indexing--slicing)

### Collections & Data Structures
- [Strings](#strings)
- [Sequences (Dynamic Arrays)](#sequences-dynamic-arrays)
- [Arrays (Fixed Size)](#arrays-fixed-size)
- [Tables (Hash Maps)](#tables-hash-maps)
- [Sets](#sets)
- [Enums](#enums)
- [Tuples](#tuples)
- [Objects (Structs)](#objects-structs)

### Functions & Code Organization
- [Procs (Functions)](#procs-functions)
- [Generics](#generics)
- [Templates](#templates)
- [Macros](#macros)
- [Methods (Dynamic Dispatch)](#methods-dynamic-dispatch)
- [Iterators](#iterators)
- [Pragmas](#pragmas)
- [Public Exports & Modules](#public-exports--modules)

### Control Flow & Error Handling
- [Control Flow (if, case, for, while)](#control-flow)
- [Error Handling (try/except/raise)](#error-handling)
- [Options (Maybe Types)](#options-maybe-types)
- [Discard](#discard)
- [Defer](#defer)
- [When (Compile-Time If)](#when-compile-time-if)

### I/O & System
- [File I/O](#file-io)
- [Environment Variables](#environment-variables)
- [Subprocess Execution](#subprocess-execution)
- [Command Line Arguments](#command-line-arguments)
- [Read User Input (CLI)](#read-user-input-cli)

### Data Formats
- [JSON](#json)
- [YAML](#yaml)

### Networking & Web
- [HTTP Client](#http-client)
- [HTTP Server (Jester)](#http-server-jester)
- [HTTP Server (Prologue)](#http-server-prologue)

### Databases
- [PostgreSQL (db_connector)](#postgresql-db_connector)
- [PostgreSQL: norm ORM](#postgresql-norm-orm)

### Concurrency & Async
- [Async & Futures (chronos)](#async--futures-chronos)
- [Async (stdlib asyncdispatch)](#async-stdlib-asyncdispatch)
- [Scheduler (Periodic Tasks)](#scheduler-periodic-tasks)
- [Pub/Sub & Event System](#pubsub--event-system)

### Terminal & UI
- [Colored Terminal Output](#colored-terminal-output)
- [Terminal Control (Cursor, Redraw)](#terminal-control)
- [Arrow Key Input (Raw Terminal)](#arrow-key-input)
- [TUI (No Framework)](#tui-no-framework)
- [TUI Frameworks (illwill)](#tui-frameworks)
- [Cross-Platform GUI (nigui)](#cross-platform-gui)

### Testing & Patterns
- [Writing Tests](#writing-tests)
- [Logging](#logging)
- [Random Numbers](#random-numbers)
- [Functional Patterns](#functional-patterns)
- [Useful Patterns & Idioms](#useful-patterns--idioms)
- [Quick Reference (Python → Nim)](#quick-reference-python--nim)

---

## Imports Quick Reference

> **Start here.** This section tells you which module to import for any task.
> Nim uses `import` to bring modules into scope. Standard library is under `std/`.
> Third-party packages are installed with `nimble install <pkg>`.

### Standard Library — By Category

```nim
# ─── STRINGS & TEXT ───────────────────────────────────────────
import std/strutils       # split, strip, parseInt, contains, replace, toLower, join
import std/strformat      # fmt"..." interpolation (like Python f-strings)
import std/re             # regular expressions (PCRE)
import std/unicode        # Unicode-aware string ops
import std/parseutils     # low-level parseInt, parseFloat
import std/strscans       # scanf-style string scanning

# ─── COLLECTIONS ─────────────────────────────────────────────
import std/sequtils       # map, filter, foldl, zip, toSeq, deduplicate
import std/tables         # Table, OrderedTable, CountTable (hash maps)
import std/sets           # HashSet, OrderedSet
import std/algorithm      # sort, sorted, reverse, binarySearch
import std/sugar          # => (lambda shorthand), collect (comprehensions)
import std/options        # Option[T], some(), none(), get(), isSome
import std/deques         # double-ended queue
import std/heapqueue      # priority queue (min-heap)

# ─── FILE SYSTEM & OS ────────────────────────────────────────
import std/os             # file/dir ops, env vars, paths, sleep, walkDir
import std/streams        # file/string streams (read/write)
import std/dirs           # directory operations (Nim 2.0+)
import std/files          # file operations (Nim 2.0+)
import std/paths          # path manipulation (Nim 2.0+)

# ─── PROCESSES & SYSTEM ──────────────────────────────────────
import std/osproc         # execCmdEx, startProcess, execProcess
import std/parseopt       # basic CLI option parsing (--flag, -f)
import std/terminal       # colors, cursor control, getch, terminal size
import std/rdstdin        # readLineFromStdin (with prompt), readPasswordFromStdin

# ─── DATA FORMATS ────────────────────────────────────────────
import std/json           # JSON parsing/generation (JsonNode, %*, parseJson)
import std/jsonutils      # JSON ↔ object serialization (Nim 2.0+)
import std/xmltree        # XML parsing/generation
import std/htmlparser     # HTML parsing
import std/parsecfg       # INI/config file parsing

# ─── NETWORKING ──────────────────────────────────────────────
import std/httpclient     # HTTP client (sync + async)
import std/uri            # URL parsing and encoding
import std/net            # low-level sockets
import std/asyncnet       # async sockets
import std/asynchttpserver # async HTTP server (stdlib)

# ─── ASYNC & CONCURRENCY ─────────────────────────────────────
import std/asyncdispatch  # async/await (stdlib event loop)
import std/locks          # Lock, Condition for thread sync
import std/threadpool     # spawn, FlowVar (thread pool)
import std/atomics        # atomic operations

# ─── TIME & DATE ─────────────────────────────────────────────
import std/times          # DateTime, Duration, now(), format, parse
import std/monotimes      # monotonic clock (for benchmarking)

# ─── MATH & RANDOM ───────────────────────────────────────────
import std/math           # sqrt, pow, ceil, floor, round, PI, E
import std/random         # rand, sample, shuffle, randomize

# ─── TESTING & DEBUGGING ─────────────────────────────────────
import std/unittest       # test framework (suite, test, check, expect)
import std/logging        # Logger, ConsoleLogger, FileLogger, log levels

# ─── MISC ────────────────────────────────────────────────────
import std/hashes         # custom hash functions for tables/sets
import std/enumerate      # enumerate iterator
import std/with           # with statement (method chaining helper)
import std/typetraits     # type introspection at compile time
```

### Third-Party Packages

```nim
# Install with: nimble install <package-name>
# Then import normally (no std/ prefix)

# ─── CLI FRAMEWORKS ──────────────────────────────────────────
import cligen              # nimble install cligen — auto-generates CLI from proc signature
import docopt              # nimble install docopt — CLI from usage string

# ─── ASYNC (PRODUCTION) ──────────────────────────────────────
import chronos             # nimble install chronos — production async (better than stdlib)

# ─── LOGGING ─────────────────────────────────────────────────
import chronicles           # nimble install chronicles — structured logging (JSON output)

# ─── JSON ────────────────────────────────────────────────────
import jsony               # nimble install jsony — fast JSON with custom hooks

# ─── YAML ────────────────────────────────────────────────────
import yaml                # nimble install yaml — NimYAML parser/emitter

# ─── DATABASES ───────────────────────────────────────────────
import db_connector/db_postgres  # nimble install db_connector — PostgreSQL
import db_connector/db_sqlite    # nimble install db_connector — SQLite
import norm/[model, postgres]    # nimble install norm — ORM

# ─── WEB SERVERS ─────────────────────────────────────────────
import jester              # nimble install jester — Sinatra-like HTTP server
import prologue            # nimble install prologue — full-featured web framework

# ─── TUI ─────────────────────────────────────────────────────
import illwill             # nimble install illwill — terminal UI (non-blocking input)
import noise               # nimble install noise — readline alternative (history, completion)

# ─── GUI ─────────────────────────────────────────────────────
import nigui               # nimble install nigui — cross-platform native GUI

# ─── CRYPTO ──────────────────────────────────────────────────
import bearssl             # nimble install bearssl — TLS/crypto
import nimSHA2             # nimble install nimSHA2 — SHA-256/512
```

### Import Patterns

```nim
# Import everything from a module
import std/os

# Import specific symbols only (keeps namespace clean)
from std/strutils import split, strip, toLowerAscii

# Import multiple stdlib modules at once (bracket syntax)
import std/[os, strutils, strformat, sequtils, tables, options]

# Qualified import (must prefix all uses with module name)
from std/math import nil
echo math.PI   # must say math.PI, not just PI

# Re-export (users who import YOUR module also get this)
import std/json
export json
```

---

## Project Setup & Build

```bash
# ─── INSTALLATION ────────────────────────────────────────────
# macOS
brew install nim

# Linux (choosenim recommended)
curl https://nim-lang.org/choosenim/init.sh -sSf | sh

# Verify
nim --version
nimble --version

# ─── CREATE A NEW PROJECT ────────────────────────────────────
nimble init myproject                    # interactive setup
nimble init myproject --type:binary      # binary (executable)
nimble init myproject --type:library     # library

# Project structure:
# myproject/
# ├── myproject.nimble    ← package manifest (deps, metadata)
# ├── src/
# │   ├── myproject.nim   ← main entry point
# │   └── myproject/      ← submodules
# │       ├── utils.nim
# │       └── config.nim
# ├── tests/
# │   └── test_main.nim
# └── README.md

# ─── BUILD & RUN ─────────────────────────────────────────────
nimble build                            # compile
nimble run                              # compile + run
nimble run -- --flag value              # pass args to your program
nim c -r src/myproject.nim              # compile + run directly
nim c -d:release src/myproject.nim      # optimized release build
nim c -d:danger src/myproject.nim       # max speed (no runtime checks)
nim c --threads:on src/myproject.nim    # enable multi-threading

# ─── DEPENDENCIES ────────────────────────────────────────────
nimble install <package>                # install a package
nimble install <package>@#head          # install latest from git main
nimble install -d                       # install all deps from .nimble
nimble list --installed                 # list installed packages
nimble search <query>                   # search packages
nimble uninstall <package>              # remove a package
```

### Nimble File Example (myproject.nimble)

```nim
version       = "0.1.0"
author        = "Your Name"
description   = "My project"
license       = "MIT"
srcDir        = "src"
bin           = @["myproject"]           # executables to build

requires "nim >= 2.0.0"
requires "cligen >= 1.7.0"              # with version constraint
requires "chronos"                       # any version
requires "yaml >= 2.0.0 & < 3.0.0"     # version range

task test, "Run tests":
  exec "nim c -r tests/test_main.nim"

task docs, "Generate documentation":
  exec "nim doc --project src/myproject.nim"
```

---

## Comments

```nim
# Single-line comment — ignored by compiler

## Documentation comment — used by `nim doc` to generate HTML docs
## Place above procs, types, fields you want documented

#[
  Block comment. Can be nested: #[ inner ]#
  Useful for temporarily disabling code blocks.
]#

discard """
  Discard string — acts as multi-line comment.
  Common Nim idiom for module-level docs or disabling code.
"""
```

---

## Variables & Constants

```nim
# ─── THREE WAYS TO BIND A VALUE ──────────────────────────────

var x = 10        # MUTABLE — can be reassigned
let y = 20        # IMMUTABLE — set once at runtime, cannot change
const z = 30      # COMPILE-TIME — must be computable at compile time, inlined

# When to use:
#   var   → value will change (counters, accumulators, state)
#   let   → default choice — safer, signals "won't change"
#   const → true constants (versions, config, magic numbers)

# ─── TYPE ANNOTATIONS (optional — Nim infers types) ──────────
var name: string = "hello"
var count = 42                     # inferred as int
var items: seq[int] = @[1, 2, 3]

# ─── MULTIPLE DECLARATIONS ───────────────────────────────────
var
  a = 1
  b = "hello"
  c: seq[int] = @[]     # empty seq needs type annotation

let
  host = "localhost"
  port = 8080

const
  Version = "1.0.0"
  MaxRetries = 3
  Timeout = 30_000       # underscores for readability

# ─── TUPLE UNPACKING ─────────────────────────────────────────
let (x1, y1) = (10, 20)
var (first, second) = ("a", "b")

proc getCoords(): (int, int) = (100, 200)
let (cx, cy) = getCoords()
```

---

## Data Types

```nim
# ─── INTEGERS ────────────────────────────────────────────────
var i: int = 42            # platform-sized (64-bit on 64-bit OS)
var i8: int8 = 127         # 1 byte: -128 to 127
var i16: int16 = 32_000    # 2 bytes
var i32: int32 = 2_000_000 # 4 bytes
var i64: int64 = 9_000_000_000_000

# ─── UNSIGNED INTEGERS ───────────────────────────────────────
var u: uint = 42
var u8: uint8 = 255        # 0 to 255 (same as `byte`)
var u16: uint16 = 65535
var u32: uint32 = 4_000_000_000
var u64: uint64 = 18_000_000_000_000_000_000'u64

# ─── FLOATS ──────────────────────────────────────────────────
var f: float = 3.14        # 64-bit (alias for float64)
var f32: float32 = 3.14'f32
var f64: float64 = 3.14159265358979

# ─── BOOLEAN, CHAR, STRING, BYTE ─────────────────────────────
var flag: bool = true      # true or false
var ch: char = 'A'         # single ASCII char (1 byte)
var s: string = "hello"    # mutable, growable UTF-8 string
var b: byte = 0xFF         # alias for uint8

# ─── SPECIAL TYPES ───────────────────────────────────────────
# Range — restricts values (checked at runtime)
type Percentage = range[0..100]
var score: Percentage = 85

# Distinct — type-safe wrapper (prevents accidental mixing)
type Meters = distinct float
type Seconds = distinct float

# Ref object — heap-allocated, GC'd (for inheritance, linked structures)
type Node = ref object
  value: int
  next: Node

# Proc type — function as a value (callbacks)
type Callback = proc(x: int): string
type EventHandler = proc(event: string) {.closure.}

# ─── TYPE SUMMARY ────────────────────────────────────────────
# | Type       | Size     | Use case                          |
# |------------|----------|-----------------------------------|
# | int        | 8 bytes  | General integers                  |
# | int8/16/32 | 1/2/4 B  | Memory-constrained, FFI           |
# | uint8/byte | 1 byte   | Bytes, binary data                |
# | float      | 8 bytes  | Decimal math (= float64)          |
# | float32    | 4 bytes  | Graphics, GPU                     |
# | bool       | 1 byte   | Flags, conditions                 |
# | char       | 1 byte   | Single ASCII character            |
# | string     | dynamic  | Text                              |
# | seq[T]     | dynamic  | Dynamic arrays / lists            |
# | array[N,T] | fixed    | Fixed-size, stack-allocated       |
# | tuple      | fixed    | Lightweight grouped values        |
# | object     | fixed    | Structs, records                  |
# | ref object | heap     | Heap-allocated, GC'd, inheritance |
# | enum       | int-size | Named constants, state machines   |
# | set[T]     | bitfield | Fast membership for small ordinals|
# | distinct   | varies   | Type-safe wrappers                |
```

---

## Operators

```nim
# ─── ARITHMETIC ──────────────────────────────────────────────
# +  -  *  /  (float division)
# div (integer division)   mod (remainder)
echo 10 div 3    # 3
echo 10 mod 3    # 1
echo 10 / 3      # 3.333...

# ─── COMPARISON (return bool) ────────────────────────────────
# ==  !=  <  >  <=  >=

# ─── LOGICAL ─────────────────────────────────────────────────
# and  or  not  xor
if x > 0 and x < 100: echo "in range"

# ─── BITWISE ─────────────────────────────────────────────────
# and  or  xor  not  shl  shr
echo 0b1010 shl 1   # 0b10100 (20)
echo 0b1010 shr 1   # 0b0101 (5)

# ─── STRING ──────────────────────────────────────────────────
let msg = "Hello" & " " & "World"   # & concatenates strings

# ─── ASSIGNMENT ──────────────────────────────────────────────
var n = 10
n += 5; n -= 3; n *= 2   # compound assignment

# ─── RANGE ───────────────────────────────────────────────────
for i in 0..5:   echo i   # 0,1,2,3,4,5 (inclusive)
for i in 0..<5:  echo i   # 0,1,2,3,4   (exclusive end)
for i in countdown(5, 0): echo i  # 5,4,3,2,1,0

# ─── TYPE CHECK ──────────────────────────────────────────────
if x is int: echo "int"
if x isnot string: echo "not string"

# ─── MEMBERSHIP ──────────────────────────────────────────────
if 3 in @[1, 2, 3]: echo "found"
if "key" notin myTable: echo "missing"

# ─── ADDRESS / DEREFERENCE (rarely needed) ───────────────────
var val = 42
var p = addr val   # raw pointer
echo p[]           # dereference: 42
```

---

## Indexing & Slicing

```nim
let s = @[10, 20, 30, 40, 50]
let str = "Hello, World!"

# ─── INDEXING (0-based) ──────────────────────────────────────
echo s[0]      # 10 — first
echo s[^1]     # 50 — last (^ counts from end)
echo s[^2]     # 40 — second to last

# ─── SLICING ─────────────────────────────────────────────────
echo s[1..3]     # @[20, 30, 40]  inclusive both ends
echo s[0..<3]    # @[10, 20, 30]  exclusive end
echo s[2..^1]    # @[30, 40, 50]  index 2 to end
echo str[0..4]   # "Hello"
echo str[7..^1]  # "World!"

# ─── MUTABLE SLICING ─────────────────────────────────────────
var ms = @[1, 2, 3, 4, 5]
ms[1..2] = @[20, 30]   # @[1, 20, 30, 4, 5]

# NOTE: string[i] → char, string[a..b] → string
```

---

## Strings

```nim
import std/[strutils, strformat]

# ─── CREATING STRINGS ────────────────────────────────────────
var s = "Hello, World!"
let multiline = """
  Multi-line string. Indentation preserved.
  No escape needed for "quotes".
"""
let raw = r"C:\Users\name\file"  # raw string — no escapes

# ─── INTERPOLATION (fmt) ─────────────────────────────────────
# import std/strformat
let name = "Nim"
echo fmt"Hello {name}!"              # "Hello Nim!"
echo fmt"Result: {2 + 2}"           # "Result: 4"
echo fmt"Pi: {3.14159:.2f}"         # "Pi: 3.14"
echo &"Also works: {name}"          # & is alias for fmt

# ─── COMMON OPERATIONS ───────────────────────────────────────
# import std/strutils
echo s.len                    # 13
echo s.toLowerAscii()        # "hello, world!"
echo s.toUpperAscii()        # "HELLO, WORLD!"
echo s.strip()               # trim whitespace
echo s.split(", ")           # @["Hello", "World!"]
echo s.contains("World")     # true
echo s.startsWith("Hello")   # true
echo s.endsWith("!")         # true
echo s.replace("World", "Nim")  # "Hello, Nim!"
echo s.find("World")         # 7 (index, -1 if not found)
echo @["a","b","c"].join(", ")  # "a, b, c"

# ─── BUILDING STRINGS ────────────────────────────────────────
let full = "Hello" & " " & "World"  # & concatenates (new string)
var buf = ""
buf.add("Hello")    # in-place append (efficient for loops)
buf.add(" World")

# ─── CONVERSION ──────────────────────────────────────────────
echo $42                # "42" — $ converts anything to string
echo parseInt("42")     # 42 (raises ValueError if invalid)
echo parseFloat("3.14") # 3.14
```

---

## Sequences (Dynamic Arrays)

```nim
import std/[sequtils, algorithm, sugar]

# ─── CREATING ────────────────────────────────────────────────
# seq = dynamic array (like Python list, Rust Vec<T>)
var nums = @[1, 2, 3, 4, 5]
var empty: seq[string] = @[]
var zeros = newSeq[int](10)            # 10 zeros
var filled = newSeqWith(5, "hi")       # 5 copies of "hi"

# ─── BASIC OPS ───────────────────────────────────────────────
echo nums.len        # 5
echo nums[0]         # 1 (first)
echo nums[^1]        # 5 (last)
nums.add(6)          # append
nums.insert(99, 0)   # insert at index
nums.delete(0)       # remove at index
let last = nums.pop()  # remove & return last
echo 3 in nums       # membership check

# ─── ITERATION ───────────────────────────────────────────────
for item in nums: echo item
for i, item in nums: echo i, ": ", item

# ─── FUNCTIONAL (import std/sequtils, std/sugar) ─────────────
let doubled = nums.map(x => x * 2)
let evens = nums.filter(x => x mod 2 == 0)
let total = nums.foldl(a + b)

# collect = list comprehension (import std/sugar)
let squares = collect:
  for x in 1..10: x * x
# @[1, 4, 9, 16, 25, 36, 49, 64, 81, 100]

let evenSquares = collect:
  for x in 1..10:
    if x mod 2 == 0: x * x

# ─── SORTING (import std/algorithm) ──────────────────────────
var data = @[5, 2, 8, 1, 9]
data.sort()                    # in-place ascending
data.sort(order = Descending)  # in-place descending
let sc = data.sorted()         # new sorted copy

# ─── OTHER ───────────────────────────────────────────────────
echo nums.deduplicate()   # remove duplicates
echo nums.reversed()      # reversed copy
echo @[1,2] & @[3,4]     # concatenate: @[1,2,3,4]
echo zip(@[1,2], @["a","b"])  # @[(1,"a"), (2,"b")]
```

---

## Arrays (Fixed Size)

```nim
# Fixed size, stack-allocated, bounds-checked at compile time
var arr: array[5, int] = [1, 2, 3, 4, 5]
var grid: array[3, array[3, int]]   # 2D array

echo arr.len     # 5
echo arr[0]      # 1
echo arr[^1]     # 5

for i, item in arr: echo i, ": ", item

# Convert to seq when you need dynamic operations
import std/sequtils
let s = arr.toSeq()

# Non-zero starting index
var oneIndexed: array[1..5, string] = ["a", "b", "c", "d", "e"]
echo oneIndexed[1]   # "a"
```

---

## Tables (Hash Maps)

```nim
import std/[tables, strformat]

# ─── CREATING (like Python dict) ─────────────────────────────
var ages = {"Alice": 30, "Bob": 25}.toTable
var config = initTable[string, string]()

# OrderedTable — preserves insertion order
var ordered = {"first": 1, "second": 2}.toOrderedTable

# CountTable — for counting occurrences
var counter = initCountTable[string]()

# ─── BASIC OPS ───────────────────────────────────────────────
ages["Carol"] = 28           # set
echo ages["Alice"]           # get (raises KeyError if missing)
echo ages.getOrDefault("X", 0)  # safe get with default
ages.del("Bob")              # delete
echo ages.len                # size
echo "Alice" in ages         # true
echo "Dave" notin ages       # true

# ─── ITERATION ───────────────────────────────────────────────
for key, val in ages:
  echo fmt"{key}: {val}"

for key in ages.keys: echo key
for val in ages.values: echo val

# ─── USEFUL PATTERNS ─────────────────────────────────────────
# Check and insert in one step
if not ages.hasKeyOrPut("Dave", 40):
  echo "Dave was just added"

# CountTable for word counting
for word in "the cat sat on the mat".split():
  counter.inc(word)
echo counter   # {"the": 2, "cat": 1, ...}
```

---

## Sets

```nim
import std/sets

# ─── HASH SETS (any hashable type) ───────────────────────────
var fruits = ["apple", "banana", "cherry"].toHashSet
fruits.incl("date")       # add
fruits.excl("banana")     # remove
echo "apple" in fruits    # true
echo fruits.len           # size

# ─── SET OPERATIONS ──────────────────────────────────────────
let a = [1, 2, 3, 4].toHashSet
let b = [3, 4, 5, 6].toHashSet
echo a + b     # union: {1,2,3,4,5,6}
echo a * b     # intersection: {3,4}
echo a - b     # difference: {1,2}

# ─── BUILT-IN SETS (bitfield, for char/enum/small ranges) ────
let vowels: set[char] = {'a', 'e', 'i', 'o', 'u'}
echo 'a' in vowels   # true

type Permission = enum read, write, execute
var perms: set[Permission] = {read, write}
perms.incl(execute)
echo read in perms   # true
```

---

## Enums

```nim
# ─── BASIC ───────────────────────────────────────────────────
type Color = enum red, green, blue

var c = red
echo c        # "red"
echo ord(c)   # 0

for color in Color: echo color   # iterate all values

# ─── CUSTOM VALUES ───────────────────────────────────────────
type HttpStatus = enum
  ok = 200, notFound = 404, serverError = 500

# ─── STRING VALUES ───────────────────────────────────────────
type Direction = enum
  north = "N", south = "S", east = "E", west = "W"

# ─── CASE STATEMENT (compiler checks all cases) ──────────────
proc describe(c: Color): string =
  case c
  of red: "warm"
  of green: "natural"
  of blue: "cool"

# ─── ENUM SETS (fast bitfield membership) ────────────────────
type Perm = enum read, write, execute, admin
var userPerms: set[Perm] = {read, write}
if admin notin userPerms: echo "not admin"
```

---

## Tuples

```nim
# Lightweight, fixed-size grouped values

# ─── NAMED TUPLE ─────────────────────────────────────────────
var point: tuple[x, y: float] = (x: 1.0, y: 2.0)
echo point.x   # 1.0

# ─── POSITIONAL ──────────────────────────────────────────────
var pair = (42, "hello")
echo pair[0]   # 42

# ─── UNPACKING ───────────────────────────────────────────────
let (name, age) = ("Alice", 30)

let pairs = @[(1, "one"), (2, "two")]
for (num, word) in pairs:
  echo num, " = ", word

# ─── RETURNING MULTIPLE VALUES ────────────────────────────────
proc divmod(a, b: int): (int, int) =
  (a div b, a mod b)

let (q, r) = divmod(17, 5)   # q=3, r=2
```

---

## Objects (Structs)

```nim
import std/strformat

# ─── BASIC OBJECT (value type, stack-allocated) ──────────────
type Person = object
  name: string
  age: int

var alice = Person(name: "Alice", age: 30)
echo alice.name   # "Alice"
alice.age = 31    # mutable if declared with var

# ─── REF OBJECT (heap, GC'd, supports inheritance) ───────────
type
  Animal = ref object of RootObj
    name: string
  Dog = ref object of Animal
    breed: string
  Cat = ref object of Animal
    indoor: bool

let dog = Dog(name: "Rex", breed: "Lab")

# ─── OBJECT VARIANTS (tagged unions) ─────────────────────────
type
  ShapeKind = enum circle, rectangle
  Shape = object
    case kind: ShapeKind
    of circle: radius: float
    of rectangle: width, height: float

let c = Shape(kind: circle, radius: 5.0)

proc area(s: Shape): float =
  case s.kind
  of circle: 3.14159 * s.radius * s.radius
  of rectangle: s.width * s.height

# ─── METHODS (procs with object as first param + UFCS) ───────
proc greet(p: Person): string =
  fmt"Hi, I'm {p.name}"

echo alice.greet()   # UFCS: same as greet(alice)

proc birthday(p: var Person) =
  p.age += 1

alice.birthday()
```

---

## Procs (Functions)

```nim
import std/strformat

# ─── BASIC PROC ──────────────────────────────────────────────
proc greet(name: string): string =
  ## Returns a greeting. (This is a doc comment)
  fmt"Hello, {name}!"

echo greet("World")   # "Hello, World!"

# ─── MULTIPLE PARAMS, DEFAULT VALUES ─────────────────────────
proc connect(host: string, port: int = 8080, ssl: bool = false): string =
  let scheme = if ssl: "https" else: "http"
  fmt"{scheme}://{host}:{port}"

echo connect("localhost")              # http://localhost:8080
echo connect("api.com", 443, true)     # https://api.com:443
echo connect("api.com", ssl = true)    # named arg

# ─── VOID PROC (no return value) ─────────────────────────────
proc log(msg: string) =
  echo "[LOG] " & msg

# ─── RESULT VARIABLE (implicit return) ───────────────────────
# Every proc with a return type has an implicit `result` variable
proc double(x: int): int =
  result = x * 2   # no explicit return needed

# ─── EXPLICIT RETURN ─────────────────────────────────────────
proc findFirst(items: seq[int], target: int): int =
  for i, item in items:
    if item == target: return i
  return -1

# ─── OVERLOADING (same name, different param types) ──────────
proc add(a, b: int): int = a + b
proc add(a, b: string): string = a & b
echo add(1, 2)        # 3
echo add("hi", " there")  # "hi there"

# ─── VARARGS ─────────────────────────────────────────────────
proc sum(nums: varargs[int]): int =
  for n in nums: result += n

echo sum(1, 2, 3, 4)   # 10

# ─── PROC AS VALUE (first-class functions) ───────────────────
import std/sugar

# Lambda with sugar's => shorthand
let double = (x: int) => x * 2
echo double(5)   # 10

# Proc type
type MathOp = proc(a, b: int): int
let multiply: MathOp = proc(a, b: int): int = a * b

# Passing procs as arguments
proc apply(x: int, op: proc(n: int): int): int = op(x)
echo apply(5, (n: int) => n * n)   # 25

# ─── UFCS (Uniform Function Call Syntax) ─────────────────────
# Any proc can be called as a method on its first argument
proc double(x: int): int = x * 2
echo 5.double()       # same as double(5)
echo "hello".len      # same as len("hello")
# This enables chaining:
echo @[1,2,3].map(x => x * 2).filter(x => x > 2)
```

---

## Generics

```nim
# ─── GENERIC PROC ────────────────────────────────────────────
# T is a type parameter — works with any type
proc first[T](items: seq[T]): T =
  items[0]

echo first(@[10, 20, 30])     # 10
echo first(@["a", "b", "c"])  # "a"

# ─── GENERIC WITH CONSTRAINTS ────────────────────────────────
proc max[T: SomeNumber](a, b: T): T =
  if a > b: a else: b

echo max(3, 7)       # 7
echo max(3.14, 2.71) # 3.14

# ─── GENERIC OBJECT ──────────────────────────────────────────
type
  Stack[T] = object
    items: seq[T]

proc push[T](s: var Stack[T], item: T) =
  s.items.add(item)

proc pop[T](s: var Stack[T]): T =
  s.items.pop()

var intStack: Stack[int]
intStack.push(1)
intStack.push(2)
echo intStack.pop()   # 2
```

---

## Templates

```nim
# Templates are compile-time code substitution (like hygienic macros).
# The body is literally pasted at the call site. Zero runtime cost.

# ─── BASIC TEMPLATE ──────────────────────────────────────────
template times(n: int, body: untyped) =
  for _ in 0..<n:
    body

3.times:
  echo "hello"   # prints "hello" 3 times

# ─── TEMPLATE WITH PARAMS ────────────────────────────────────
template withFile(f: untyped, filename: string, mode: FileMode, body: untyped) =
  var f: File
  if open(f, filename, mode):
    try:
      body
    finally:
      close(f)

withFile(myFile, "test.txt", fmRead):
  echo myFile.readAll()

# ─── TEMPLATE vs PROC ────────────────────────────────────────
# Templates: code substitution, no function call overhead, access caller's scope
# Procs: actual function call, own scope, can be recursive
# Use templates for: DSLs, control flow abstractions, zero-cost wrappers
```

---

## Macros

```nim
import std/macros

# Macros operate on the AST (Abstract Syntax Tree) at compile time.
# They can generate, transform, or inspect code.

# ─── SIMPLE CODE GENERATION ──────────────────────────────────
macro debug(args: varargs[untyped]): untyped =
  result = newStmtList()
  for arg in args:
    let str = arg.repr  # get string representation of expression
    result.add quote do:
      echo `str`, " = ", `arg`

var x = 42
var name = "Nim"
debug(x, name)
# Output:
#   x = 42
#   name = Nim

# ─── WHEN TO USE MACROS ──────────────────────────────────────
# Use macros when templates aren't powerful enough:
# - Generating repetitive code (serialization, ORM fields)
# - Creating DSLs (HTML builders, test frameworks)
# - Compile-time code analysis
# Prefer templates or generics when possible — macros are harder to debug
```

---

## Methods (Dynamic Dispatch)

```nim
# `method` uses dynamic dispatch (virtual functions).
# Use when you need runtime polymorphism with ref objects.

type
  Shape = ref object of RootObj
  Circle = ref object of Shape
    radius: float
  Rect = ref object of Shape
    w, h: float

# method = dispatched at runtime based on actual type
method area(s: Shape): float {.base.} =
  0.0   # base implementation

method area(c: Circle): float =
  3.14159 * c.radius * c.radius

method area(r: Rect): float =
  r.w * r.h

let shapes: seq[Shape] = @[
  Circle(radius: 5.0),
  Rect(w: 3.0, h: 4.0)
]

for s in shapes:
  echo s.area()   # dispatches to correct implementation
# 78.5397...
# 12.0

# NOTE: Use `proc` (static dispatch) by default.
# Only use `method` when you need polymorphism on ref object hierarchies.
```

---

## Iterators

```nim
# Iterators produce values one at a time (like Python generators).

# ─── INLINE ITERATOR (default, zero-cost) ────────────────────
iterator countUp(a, b: int): int =
  var i = a
  while i <= b:
    yield i
    inc i

for x in countUp(1, 5):
  echo x   # 1, 2, 3, 4, 5

# ─── CLOSURE ITERATOR (can be stored, passed around) ─────────
proc makeCounter(start, stop: int): iterator(): int =
  return iterator(): int =
    var i = start
    while i <= stop:
      yield i
      inc i

let counter = makeCounter(1, 3)
echo counter()   # 1
echo counter()   # 2
echo counter()   # 3

# ─── ITERATOR ON CUSTOM TYPE ─────────────────────────────────
type IntList = object
  data: seq[int]

iterator items(list: IntList): int =
  for item in list.data:
    yield item

let myList = IntList(data: @[10, 20, 30])
for item in myList:
  echo item   # 10, 20, 30
```

---

## Pragmas

```nim
# Pragmas are annotations that modify proc/type behavior.
# Syntax: {.pragmaName.} or {.pragma: value.}

# ─── COMMON PRAGMAS ──────────────────────────────────────────
proc fastCalc(x: int): int {.inline.} = x * 2
  # inline: suggests compiler inline this proc

proc noReturn() {.noReturn.} =
  quit(1)
  # noReturn: proc never returns (always exits/raises)

proc cFunc(x: cint): cint {.importc: "abs", header: "<stdlib.h>".}
  # importc: import a C function

proc myProc() {.deprecated: "use newProc instead".} =
  discard
  # deprecated: warn users this proc is going away

# ─── EFFECT PRAGMAS ──────────────────────────────────────────
proc pureCalc(x: int): int {.noSideEffect.} = x * 2
  # noSideEffect: guarantees no side effects (same as `func`)

func pureCalc2(x: int): int = x * 2
  # `func` is shorthand for proc {.noSideEffect.}

proc riskyOp() {.raises: [IOError, ValueError].} =
  # raises: declares which exceptions this proc may raise
  discard

# ─── THREAD PRAGMAS ──────────────────────────────────────────
proc threadSafe() {.gcsafe.} =
  # gcsafe: safe to call from any thread
  discard

# ─── EXPORT PRAGMA (alternative to * for visibility) ─────────
proc helper() {.exportc.} =
  # exportc: export to C (for FFI)
  discard
```

---

## Public Exports & Modules

```nim
# ─── VISIBILITY (* = public) ─────────────────────────────────
# By default, everything is PRIVATE to the module.
# Add * after the name to make it public (exported).

type
  Config* = object        # public type
    host*: string         # public field
    port*: int            # public field
    secret: string        # PRIVATE field — only this module can access

proc connect*(c: Config): bool =   # public proc
  true

proc internalHelper(c: Config) =   # private proc
  discard

# ─── IMPORTING MODULES ───────────────────────────────────────
# In another file:
import mymodule              # import everything public from mymodule
from mymodule import Config  # import only Config
import mymodule except connect  # import all except connect

# ─── MODULE ORGANIZATION ─────────────────────────────────────
# src/
# ├── myapp.nim              ← main, imports submodules
# ├── myapp/
# │   ├── config.nim         ← Config type, loadConfig
# │   ├── database.nim       ← DB connection, queries
# │   └── handlers.nim       ← request handlers

# In myapp.nim:
import myapp/[config, database, handlers]

# ─── RE-EXPORTING ────────────────────────────────────────────
# If you want users to get a dependency automatically:
import std/json
export json   # anyone importing YOUR module also gets json
```

---

## Control Flow

```nim
# ─── IF / ELIF / ELSE ────────────────────────────────────────
if x > 10:
  echo "big"
elif x > 5:
  echo "medium"
else:
  echo "small"

# if as expression (returns a value)
let size = if x > 10: "big" elif x > 5: "medium" else: "small"

# ─── CASE (like switch — exhaustive for enums) ───────────────
case command
of "start": startServer()
of "stop": stopServer()
of "status": showStatus()
else: echo "unknown command"

# Case with ranges
case score
of 90..100: echo "A"
of 80..89: echo "B"
of 70..79: echo "C"
else: echo "F"

# ─── FOR LOOPS ───────────────────────────────────────────────
for i in 0..<10: echo i          # 0 to 9
for i in 0..10: echo i           # 0 to 10 (inclusive)
for i in countdown(10, 0): echo i  # 10 to 0
for ch in "hello": echo ch       # iterate chars
for item in @[1, 2, 3]: echo item
for i, item in @["a", "b", "c"]:  # with index
  echo i, ": ", item

# ─── WHILE ───────────────────────────────────────────────────
var count = 0
while count < 5:
  echo count
  inc count

# ─── BREAK & CONTINUE ────────────────────────────────────────
for i in 0..100:
  if i == 5: break       # exit loop
  if i mod 2 == 0: continue  # skip to next iteration
  echo i   # 1, 3

# ─── BLOCK (named scope, can break out of) ───────────────────
block outer:
  for i in 0..10:
    for j in 0..10:
      if i + j == 15:
        break outer   # breaks out of BOTH loops
```

---

## Error Handling

```nim
# ─── TRY / EXCEPT / FINALLY ──────────────────────────────────
try:
  let f = open("missing.txt")
  defer: f.close()
  echo f.readAll()
except IOError as e:
  echo "File error: " & e.msg
except ValueError:
  echo "Value error"
except CatchableError as e:
  echo "Any error: " & e.msg
finally:
  echo "always runs"

# ─── RAISING EXCEPTIONS ──────────────────────────────────────
proc divide(a, b: int): int =
  if b == 0:
    raise newException(DivByZeroDefect, "cannot divide by zero")
  a div b

# ─── CUSTOM EXCEPTIONS ───────────────────────────────────────
type
  AppError* = object of CatchableError
  NotFoundError* = object of AppError
  ValidationError* = object of AppError

proc findUser(id: int): string =
  if id < 0:
    raise newException(ValidationError, "invalid id")
  if id > 1000:
    raise newException(NotFoundError, "user not found")
  "User " & $id

# ─── EXCEPTION HIERARCHY ─────────────────────────────────────
# Exception (base — don't catch this directly)
# ├── CatchableError (catch these)
# │   ├── IOError, OSError
# │   ├── ValueError, KeyError, IndexDefect
# │   └── Your custom errors
# └── Defect (bugs — usually don't catch)
#     ├── AssertionDefect
#     ├── IndexDefect, FieldDefect
#     └── DivByZeroDefect
```

---

## Options (Maybe Types)

```nim
import std/options

# Options represent a value that may or may not exist.
# Use instead of nil checks or sentinel values.

# ─── CREATING ────────────────────────────────────────────────
let found = some(42)        # Option containing 42
let missing = none(int)     # Empty Option[int]

# ─── CHECKING & ACCESSING ────────────────────────────────────
if found.isSome:
  echo found.get()   # 42

if missing.isNone:
  echo "no value"

# get with default (no exception if empty)
echo missing.get(0)   # 0

# ─── IN PROCS ────────────────────────────────────────────────
proc findUser(name: string): Option[int] =
  if name == "Alice": some(1)
  elif name == "Bob": some(2)
  else: none(int)

let userId = findUser("Alice")
if userId.isSome:
  echo "Found user: ", userId.get()

# ─── MAP / FLATMAP ───────────────────────────────────────────
let doubled = found.map(proc(x: int): int = x * 2)
echo doubled   # some(84)

let empty = missing.map(proc(x: int): int = x * 2)
echo empty   # none(int)
```

---

## Discard

```nim
# Nim requires you to use return values. If you intentionally
# want to ignore a return value, use `discard`.

discard someProc()          # ignore return value
discard "unused string"     # acts as comment

# Mark a proc's return as discardable:
proc log(msg: string): bool {.discardable.} =
  echo msg
  true

log("hi")   # no discard needed — marked discardable
```

---

## Defer

```nim
# `defer` runs code when the current scope exits (like Go's defer).
# Great for cleanup (closing files, releasing resources).

proc readConfig(): string =
  let f = open("config.txt")
  defer: f.close()   # runs when proc exits, even on exception
  f.readAll()

# Multiple defers execute in LIFO order (last defer runs first)
proc example() =
  defer: echo "third"
  defer: echo "second"
  defer: echo "first"
  echo "body"
# Output: body, first, second, third
```

---

## When (Compile-Time If)

```nim
# `when` is evaluated at COMPILE TIME. Dead branches are not compiled.
# Use for: platform-specific code, feature flags, debug-only code.

when defined(windows):
  proc getPlatform(): string = "Windows"
elif defined(macosx):
  proc getPlatform(): string = "macOS"
elif defined(linux):
  proc getPlatform(): string = "Linux"

when defined(release):
  # Only compiled in release builds (-d:release)
  proc debugLog(msg: string) = discard
else:
  proc debugLog(msg: string) = echo "[DEBUG] " & msg

# Compile-time checks
when sizeof(int) == 8:
  echo "64-bit platform"

when compileOption("threads"):
  echo "threading enabled"

# Use with custom flags: nim c -d:myFlag src/app.nim
when defined(myFlag):
  echo "custom flag is set"
```

---

## File I/O

```nim
import std/[os, streams, strutils]

# ─── READ ENTIRE FILE ────────────────────────────────────────
let content = readFile("config.txt")
echo content

# ─── WRITE ENTIRE FILE ───────────────────────────────────────
writeFile("output.txt", "Hello, World!\n")

# ─── READ LINES ──────────────────────────────────────────────
for line in lines("data.txt"):
  echo line.strip()

# As a sequence:
let allLines = readFile("data.txt").splitLines()

# ─── APPEND TO FILE ──────────────────────────────────────────
let f = open("log.txt", fmAppend)
defer: f.close()
f.writeLine("new entry")

# ─── FILE/DIR CHECKS (import std/os) ─────────────────────────
echo fileExists("config.txt")     # true/false
echo dirExists("src/")            # true/false
echo getFileSize("big.bin")       # size in bytes

# ─── DIRECTORY OPERATIONS ─────────────────────────────────────
createDir("output/subdir")        # mkdir -p equivalent
removeDir("temp")                 # rm -rf
copyFile("a.txt", "b.txt")
moveFile("old.txt", "new.txt")
removeFile("trash.txt")

# ─── WALK DIRECTORY ──────────────────────────────────────────
for kind, path in walkDir("src/"):
  case kind
  of pcFile: echo "File: ", path
  of pcDir: echo "Dir: ", path
  else: discard

# Recursive walk
for path in walkDirRec("src/"):
  if path.endsWith(".nim"):
    echo path

# ─── PATH MANIPULATION (import std/os) ───────────────────────
echo "src/app.nim".splitFile()     # (dir: "src", name: "app", ext: ".nim")
echo "src" / "app.nim"             # "src/app.nim" (OS-aware join)
echo expandFilename("~/file.txt")  # absolute path
echo getAppDir()                   # directory of the executable
echo getCurrentDir()               # working directory
```

---

## Environment Variables

```nim
import std/os

# ─── READ ────────────────────────────────────────────────────
let home = getEnv("HOME")                    # "" if not set
let port = getEnv("PORT", "8080")            # with default value
echo existsEnv("DATABASE_URL")              # true/false

# ─── SET (current process only) ──────────────────────────────
putEnv("MY_VAR", "hello")

# ─── DELETE ──────────────────────────────────────────────────
delEnv("MY_VAR")

# ─── COMMON PATTERN: config from env with defaults ───────────
let config = (
  host: getEnv("HOST", "localhost"),
  port: parseInt(getEnv("PORT", "8080")),
  debug: getEnv("DEBUG", "false") == "true",
  dbUrl: getEnv("DATABASE_URL")   # required — check below
)

if config.dbUrl.len == 0:
  echo "ERROR: DATABASE_URL not set"
  quit(1)
```

---

## Subprocess Execution

```nim
import std/[osproc, strutils, streams]

# ─── SIMPLE: run and get output ──────────────────────────────
let (output, exitCode) = execCmdEx("ls -la")
echo "Exit: ", exitCode
echo output

# ─── JUST RUN (no output capture) ────────────────────────────
let code = execCmd("echo hello")   # prints to stdout directly

# ─── EXEC WITH ARGS (safer, no shell injection) ──────────────
let result = execProcess(
  "git",
  args = ["log", "--oneline", "-5"],
  options = {poUsePath}
)
echo result

# ─── STREAMING OUTPUT (for long-running processes) ────────────
let process = startProcess("ping", args = ["-c", "3", "google.com"],
                           options = {poUsePath, poStdErrToStdOut})
let stream = process.outputStream()
while not stream.atEnd():
  echo stream.readLine()
process.close()

# ─── CHECK EXIT CODE PATTERN ─────────────────────────────────
proc run(cmd: string): bool =
  let (output, code) = execCmdEx(cmd)
  if code != 0:
    echo "FAILED: ", cmd
    echo output
    return false
  true
```

---

## Command Line Arguments

```nim
import std/os

# ─── BASIC: raw args from std/os ─────────────────────────────
# paramCount() = number of args (not counting program name)
# paramStr(i) = get arg at index (1-based)
echo "Program: ", paramStr(0)
for i in 1..paramCount():
  echo "Arg ", i, ": ", paramStr(i)

# commandLineParams() = all args as seq[string]
let args = commandLineParams()
echo args   # @["--verbose", "input.txt"]
```

```nim
# ─── PARSEOPT: stdlib flag parsing ────────────────────────────
import std/parseopt

var
  verbose = false
  output = "out.txt"
  files: seq[string]

var p = initOptParser(commandLineParams())
for kind, key, val in p.getopt():
  case kind
  of cmdLongOption, cmdShortOption:
    case key
    of "verbose", "v": verbose = true
    of "output", "o": output = val
    else: echo "Unknown option: ", key
  of cmdArgument:
    files.add(key)
  of cmdEnd: break
```

```nim
# ─── CLIGEN: auto-generate CLI from proc (RECOMMENDED) ───────
# nimble install cligen
import cligen

proc build(output: string = "app", verbose = false, files: seq[string]) =
  ## Build the project from source files.
  if verbose: echo "Verbose mode"
  echo "Output: ", output
  for f in files: echo "File: ", f

dispatch(build)
# Automatically generates:
#   myapp build --output=app --verbose file1.nim file2.nim
#   myapp build --help  (auto-generated help text)
```

---

## Read User Input (CLI)

```nim
import std/rdstdin

# ─── BASIC PROMPT ────────────────────────────────────────────
let name = readLineFromStdin("Enter your name: ")
echo "Hello, ", name

# ─── PASSWORD (hidden input) ─────────────────────────────────
let password = readPasswordFromStdin("Password: ")

# ─── LOOP UNTIL VALID ────────────────────────────────────────
import std/strutils
var age: int
while true:
  let input = readLineFromStdin("Age: ")
  try:
    age = parseInt(input.strip())
    break
  except ValueError:
    echo "Please enter a number"

# ─── YES/NO CONFIRMATION ─────────────────────────────────────
proc confirm(prompt: string): bool =
  let answer = readLineFromStdin(prompt & " [y/N]: ")
  answer.strip().toLowerAscii() in ["y", "yes"]

if confirm("Delete all files?"):
  echo "Deleting..."
```

---

## JSON

```nim
import std/json

# ─── PARSE JSON STRING ───────────────────────────────────────
let data = parseJson("""{"name": "Alice", "age": 30, "tags": ["nim", "dev"]}""")
echo data["name"].getStr()     # "Alice"
echo data["age"].getInt()      # 30
echo data["tags"][0].getStr()  # "nim"

# ─── BUILD JSON ──────────────────────────────────────────────
let obj = %* {
  "name": "Bob",
  "age": 25,
  "active": true,
  "scores": [95, 87, 92]
}
echo obj.pretty()   # formatted JSON string

# ─── JSON ↔ OBJECTS ──────────────────────────────────────────
type User = object
  name: string
  age: int

# Object → JSON
let user = User(name: "Alice", age: 30)
let j = %* user   # or: let j = %user
echo j   # {"name":"Alice","age":30}

# JSON → Object
let parsed = """{"name":"Bob","age":25}""".parseJson()
let bob = parsed.to(User)
echo bob.name   # "Bob"

# ─── READ/WRITE JSON FILES ───────────────────────────────────
# Write
writeFile("data.json", obj.pretty())

# Read
let fileData = parseJson(readFile("data.json"))
```

```nim
# ─── JSONY (faster, custom hooks) ────────────────────────────
# nimble install jsony
import jsony

type Config = object
  host: string
  port: int

let cfg = Config(host: "localhost", port: 8080)
let jsonStr = cfg.toJson()       # serialize
let parsed = jsonStr.fromJson(Config)  # deserialize
```

---

## YAML

```nim
# nimble install yaml
import yaml

# ─── PARSE YAML STRING ───────────────────────────────────────
type Config = object
  host: string
  port: int
  debug: bool

let yamlStr = """
host: localhost
port: 8080
debug: true
"""

var cfg: Config
load(yamlStr, cfg)
echo cfg.host   # "localhost"
echo cfg.port   # 8080

# ─── DUMP TO YAML ────────────────────────────────────────────
var output: string
dump(cfg, output)
echo output

# ─── READ YAML FILE ──────────────────────────────────────────
var fileCfg: Config
load(readFile("config.yaml"), fileCfg)
```

---

## HTTP Client

```nim
import std/[httpclient, json]

# ─── SYNC HTTP ───────────────────────────────────────────────
let client = newHttpClient()
defer: client.close()

# GET
let resp = client.getContent("https://api.example.com/users")
echo resp   # response body as string

# GET with headers
client.headers = newHttpHeaders({"Authorization": "Bearer token123"})
let resp2 = client.get("https://api.example.com/me")
echo resp2.status   # "200 OK"
echo resp2.body

# POST JSON
client.headers = newHttpHeaders({"Content-Type": "application/json"})
let body = $(%* {"name": "Alice", "email": "alice@example.com"})
let postResp = client.post("https://api.example.com/users", body = body)
echo postResp.status

# ─── ASYNC HTTP ──────────────────────────────────────────────
import std/asyncdispatch

proc fetchAsync() {.async.} =
  let client = newAsyncHttpClient()
  defer: client.close()
  let resp = await client.getContent("https://api.example.com/data")
  echo resp

waitFor fetchAsync()

# ─── DOWNLOAD FILE ───────────────────────────────────────────
let dl = newHttpClient()
defer: dl.close()
dl.downloadFile("https://example.com/file.zip", "local.zip")
```

---

## HTTP Server (Jester)

```nim
# nimble install jester
# Sinatra-like micro web framework — great for APIs and small apps

import jester, json

routes:
  get "/":
    resp "Hello, World!"

  get "/api/users/@id":
    let userId = @"id"
    resp Http200, $(%* {"id": userId, "name": "Alice"}),
         contentType = "application/json"

  post "/api/users":
    let body = parseJson(request.body)
    echo "Creating user: ", body["name"].getStr()
    resp Http201, $(%* {"status": "created"})

  error Http404:
    resp Http404, $(%* {"error": "not found"})

# Run: nim c -r server.nim
# Listens on port 5000 by default
```

---

## HTTP Server (Prologue)

```nim
# nimble install prologue
# Full-featured web framework (like Flask/Express)

import prologue
import std/json

proc hello(ctx: Context) {.async.} =
  resp "Hello, World!"

proc getUser(ctx: Context) {.async.} =
  let id = ctx.getPathParams("id")
  resp $(%* {"id": id, "name": "Alice"}),
       Http200,
       {"Content-Type": "application/json"}

proc createUser(ctx: Context) {.async.} =
  let body = parseJson(ctx.request.body)
  resp $(%* {"status": "created"}), Http201

var app = newApp()
app.get("/", hello)
app.get("/api/users/{id}", getUser)
app.post("/api/users", createUser)
app.run()
```

---

## PostgreSQL (db_connector)

```nim
# nimble install db_connector
import db_connector/db_postgres

# ─── CONNECT ─────────────────────────────────────────────────
let db = open("localhost", "myuser", "mypass", "mydb")
defer: db.close()

# ─── QUERY ───────────────────────────────────────────────────
# Always use parameterized queries (prevents SQL injection)
let rows = db.getAllRows(sql"SELECT id, name FROM users WHERE active = ?", "true")
for row in rows:
  echo row[0], ": ", row[1]   # row is seq[string]

# Single row
let row = db.getRow(sql"SELECT name, email FROM users WHERE id = ?", "1")
echo row[0]   # name

# ─── INSERT / UPDATE / DELETE ─────────────────────────────────
db.exec(sql"INSERT INTO users (name, email) VALUES (?, ?)", "Alice", "a@b.com")
db.exec(sql"UPDATE users SET name = ? WHERE id = ?", "Bob", "1")
db.exec(sql"DELETE FROM users WHERE id = ?", "1")

# Get last insert ID
let id = db.insertID(sql"INSERT INTO users (name) VALUES (?)", "Carol")

# ─── TRANSACTIONS ────────────────────────────────────────────
db.exec(sql"BEGIN")
try:
  db.exec(sql"UPDATE accounts SET balance = balance - 100 WHERE id = ?", "1")
  db.exec(sql"UPDATE accounts SET balance = balance + 100 WHERE id = ?", "2")
  db.exec(sql"COMMIT")
except:
  db.exec(sql"ROLLBACK")
  raise
```

---

## PostgreSQL: norm ORM

```nim
# nimble install norm
import norm/[model, postgres]

# ─── DEFINE MODELS ────────────────────────────────────────────
type
  User* = ref object of Model
    name*: string
    email*: string
    age*: int

# ─── CONNECT ─────────────────────────────────────────────────
let db = open("localhost", "user", "pass", "mydb")
defer: db.close()

# Create table from model
db.createTables(User())

# ─── CRUD ────────────────────────────────────────────────────
# Create
var user = User(name: "Alice", email: "alice@example.com", age: 30)
db.insert(user)
echo user.id   # auto-assigned

# Read
var found = User()
db.select(found, "name = ?", "Alice")
echo found.email

# Read all
var users: seq[User]
db.selectAll(users)

# Update
found.age = 31
db.update(found)

# Delete
db.delete(found)
```

---

## Async & Futures (chronos)

```nim
# nimble install chronos
# chronos is the RECOMMENDED async library for production Nim.
# It's faster and more robust than std/asyncdispatch.

import chronos

# ─── BASIC ASYNC PROC ────────────────────────────────────────
proc fetchData(url: string): Future[string] {.async.} =
  # simulate async work
  await sleepAsync(100.milliseconds)
  return "data from " & url

proc main() {.async.} =
  let data = await fetchData("https://api.example.com")
  echo data

waitFor main()

# ─── PARALLEL ASYNC (wait for multiple) ──────────────────────
proc fetchAll() {.async.} =
  let
    fut1 = fetchData("url1")
    fut2 = fetchData("url2")
    fut3 = fetchData("url3")

  # Wait for all concurrently
  let results = await allFutures(fut1, fut2, fut3)
  echo fut1.read()
  echo fut2.read()
  echo fut3.read()

waitFor fetchAll()

# ─── ASYNC WITH TIMEOUT ──────────────────────────────────────
proc withTimeout() {.async.} =
  let fut = fetchData("slow-api")
  if not await fut.withTimeout(5.seconds):
    echo "timed out!"
  else:
    echo fut.read()

# ─── ERROR HANDLING IN ASYNC ─────────────────────────────────
proc riskyAsync() {.async.} =
  try:
    let data = await fetchData("bad-url")
    echo data
  except CatchableError as e:
    echo "Error: ", e.msg
```

---

## Async (stdlib asyncdispatch)

```nim
# Standard library async — simpler but less performant than chronos.
# Fine for scripts and simple apps.

import std/[asyncdispatch, httpclient]

proc fetchPage(url: string): Future[string] {.async.} =
  let client = newAsyncHttpClient()
  defer: client.close()
  return await client.getContent(url)

proc main() {.async.} =
  let content = await fetchPage("https://example.com")
  echo content.len, " bytes"

waitFor main()
```

---

## Scheduler (Periodic Tasks)

```nim
import chronos

# ─── SIMPLE PERIODIC TASK ────────────────────────────────────
proc periodicTask() {.async.} =
  while true:
    echo "tick"
    await sleepAsync(1.seconds)

# ─── MULTIPLE SCHEDULED TASKS ────────────────────────────────
proc healthCheck() {.async.} =
  while true:
    echo "health: ok"
    await sleepAsync(30.seconds)

proc cleanup() {.async.} =
  while true:
    echo "cleaning up..."
    await sleepAsync(5.minutes)

proc main() {.async.} =
  # Start all tasks concurrently
  await allFutures(
    periodicTask(),
    healthCheck(),
    cleanup()
  )

waitFor main()
```

---

## Pub/Sub & Event System

```nim
import std/[tables, sequtils]

# ─── SIMPLE EVENT EMITTER ────────────────────────────────────
type
  EventHandler = proc(data: string)
  EventBus = object
    listeners: Table[string, seq[EventHandler]]

proc newEventBus(): EventBus =
  EventBus(listeners: initTable[string, seq[EventHandler]]())

proc on(bus: var EventBus, event: string, handler: EventHandler) =
  if event notin bus.listeners:
    bus.listeners[event] = @[]
  bus.listeners[event].add(handler)

proc emit(bus: var EventBus, event: string, data: string) =
  if event in bus.listeners:
    for handler in bus.listeners[event]:
      handler(data)

# Usage:
var bus = newEventBus()
bus.on("user.created", proc(data: string) = echo "New user: ", data)
bus.on("user.created", proc(data: string) = echo "Send welcome email to: ", data)
bus.emit("user.created", "Alice")
# Output:
#   New user: Alice
#   Send welcome email to: Alice
```

---

## Colored Terminal Output

```nim
import std/terminal

# ─── FOREGROUND COLORS ────────────────────────────────────────
stdout.styledWriteLine(fgRed, "Error: something failed")
stdout.styledWriteLine(fgGreen, "Success!")
stdout.styledWriteLine(fgYellow, "Warning: check config")
stdout.styledWriteLine(fgCyan, "Info: server started")

# ─── STYLES ──────────────────────────────────────────────────
stdout.styledWriteLine(styleBright, "Bold text")
stdout.styledWriteLine(styleDim, "Dim text")
stdout.styledWriteLine(styleUnderscore, "Underlined")

# ─── COMBINED ────────────────────────────────────────────────
stdout.styledWriteLine(styleBright, fgRed, "CRITICAL ERROR")
stdout.styledWriteLine(fgWhite, bgBlue, " STATUS OK ")

# ─── MANUAL CONTROL ──────────────────────────────────────────
stdout.setForegroundColor(fgGreen)
stdout.write("green text")
stdout.resetAttributes()   # always reset after!
echo ""

# ─── HELPER PROC PATTERN ─────────────────────────────────────
proc error(msg: string) =
  stdout.styledWriteLine(fgRed, styleBright, "✗ ", resetStyle, msg)

proc success(msg: string) =
  stdout.styledWriteLine(fgGreen, "✓ ", resetStyle, msg)

proc warn(msg: string) =
  stdout.styledWriteLine(fgYellow, "⚠ ", resetStyle, msg)

error("Build failed")
success("All tests passed")
warn("Deprecated API used")
```

---

## Terminal Control

```nim
import std/terminal

# ─── CURSOR CONTROL ──────────────────────────────────────────
hideCursor()
showCursor()
setCursorPos(0, 0)         # move to top-left
cursorUp(3)                # move up 3 lines
cursorDown(1)
cursorForward(5)
cursorBackward(2)

# ─── CLEAR ───────────────────────────────────────────────────
eraseScreen()              # clear entire screen
eraseLine()                # clear current line

# ─── TERMINAL SIZE ───────────────────────────────────────────
let (w, h) = terminalSize()
echo "Terminal: ", w, "x", h

# ─── REDRAW PATTERN (no scrolling) ───────────────────────────
import std/os

proc drawUI() =
  eraseScreen()
  setCursorPos(0, 0)
  echo "╔══════════════════╗"
  echo "║  My Application  ║"
  echo "╚══════════════════╝"
  echo ""
  echo "Status: running"

hideCursor()
try:
  while true:
    drawUI()
    sleep(1000)
finally:
  showCursor()
```

---

## Arrow Key Input

```nim
import std/terminal

# ─── RAW KEY INPUT (non-blocking style) ──────────────────────
proc readKey(): int =
  ## Read a keypress. Returns special codes for arrow keys.
  result = getch().int
  if result == 27:   # ESC sequence
    if getch() == '[':
      case getch()
      of 'A': return 1000  # Up
      of 'B': return 1001  # Down
      of 'C': return 1002  # Right
      of 'D': return 1003  # Left
      else: discard

proc main() =
  echo "Use arrow keys (q to quit)"
  while true:
    let key = readKey()
    case key
    of 1000: echo "UP"
    of 1001: echo "DOWN"
    of 1002: echo "RIGHT"
    of 1003: echo "LEFT"
    of ord('q'): break
    else: echo "Key: ", key

main()
```

---

## TUI (No Framework)

```nim
import std/[terminal, os]

# ─── SIMPLE MENU ─────────────────────────────────────────────
proc menu(items: seq[string]): int =
  ## Interactive menu. Returns selected index.
  var selected = 0
  hideCursor()
  defer: showCursor()

  while true:
    # Draw
    eraseScreen()
    setCursorPos(0, 0)
    echo "Select an option (↑↓ Enter):\n"
    for i, item in items:
      if i == selected:
        stdout.styledWriteLine(fgCyan, styleBright, " > ", item)
      else:
        echo "   ", item

    # Input
    let ch = getch()
    case ch
    of '\e':  # arrow keys
      discard getch()  # skip [
      case getch()
      of 'A': selected = max(0, selected - 1)
      of 'B': selected = min(items.high, selected + 1)
      else: discard
    of '\r', '\n':  # Enter
      return selected
    of 'q':
      return -1
    else: discard

let choice = menu(@["Build", "Test", "Deploy", "Quit"])
if choice >= 0:
  echo "You chose: ", choice
```

---

## TUI Frameworks

```nim
# nimble install illwill
# illwill provides non-blocking input and a drawing buffer.

import illwill

proc exitProc() {.noconv.} =
  illwillDeinit()
  showCursor()
  quit(0)

proc main() =
  illwillInit(fullscreen = true)
  setControlCHook(exitProc)
  hideCursor()

  var tb = newTerminalBuffer(terminalWidth(), terminalHeight())

  while true:
    tb.clear()
    tb.write(2, 1, "illwill TUI Demo", styleBright)
    tb.write(2, 3, "Press 'q' to quit")
    tb.drawRect(0, 0, 40, 5)
    tb.display()

    let key = getKey()
    case key
    of Key.Q: exitProc()
    of Key.None: discard
    else: discard

    sleep(50)

main()
```

---

## Cross-Platform GUI

```nim
# nimble install nigui
# nigui provides native GUI widgets (GTK on Linux, Win32 on Windows, Cocoa on macOS)

import nigui

app.init()

var window = newWindow("My App")
window.width = 400
window.height = 300

var container = newLayoutContainer(Layout_Vertical)
window.add(container)

var label = newLabel("Hello, GUI!")
container.add(label)

var button = newButton("Click Me")
container.add(button)

var counter = 0
button.onClick = proc(event: ClickEvent) =
  counter += 1
  label.text = "Clicked " & $counter & " times"

window.show()
app.run()
```

---

## Writing Tests

```nim
import std/unittest

# ─── BASIC TESTS ─────────────────────────────────────────────
suite "Math operations":
  test "addition":
    check 2 + 2 == 4
    check 0 + 0 == 0

  test "string operations":
    check "hello".len == 5
    check "Hello".toLowerAscii() == "hello"

  test "sequences":
    let nums = @[1, 2, 3]
    check nums.len == 3
    check 2 in nums
    check 4 notin nums

# ─── EXPECTING EXCEPTIONS ────────────────────────────────────
suite "Error handling":
  test "raises on invalid input":
    expect(ValueError):
      discard parseInt("not a number")

  test "does not raise on valid input":
    check parseInt("42") == 42

# ─── SETUP / TEARDOWN ────────────────────────────────────────
suite "Database tests":
  setup:
    # runs before each test
    echo "setting up"

  teardown:
    # runs after each test
    echo "tearing down"

  test "insert":
    check true

# ─── RUN TESTS ───────────────────────────────────────────────
# nim c -r tests/test_main.nim
# Or in nimble file:
#   task test, "Run tests":
#     exec "nim c -r tests/test_main.nim"
# Then: nimble test
```

---

## Logging

```nim
import std/logging

# ─── STDLIB LOGGING ───────────────────────────────────────────
# Create loggers
var consoleLog = newConsoleLogger(fmtStr = "[$datetime] $levelname: ")
var fileLog = newFileLogger("app.log", fmtStr = "[$datetime] $levelname: ")

addHandler(consoleLog)
addHandler(fileLog)

# Log at different levels
debug("detailed info for debugging")
info("normal operation info")
notice("notable but normal events")
warn("something unexpected")
error("something failed")
fatal("unrecoverable error")

# Set minimum level
consoleLog.levelThreshold = lvlInfo   # hide debug in console
```

```nim
# ─── CHRONICLES (structured logging — RECOMMENDED) ───────────
# nimble install chronicles
import chronicles

# Outputs structured JSON logs
info "Server started", port = 8080, host = "localhost"
warn "Slow query", duration = 1500, query = "SELECT ..."
error "Connection failed", url = "postgres://...", attempt = 3

# Output:
# {"lvl":"INF","msg":"Server started","port":8080,"host":"localhost"}
```

---

## Random Numbers

```nim
import std/random

# ─── IMPORTANT: seed the RNG first! ──────────────────────────
randomize()   # seed with current time (call once at startup)

# ─── RANDOM INTEGERS ─────────────────────────────────────────
echo rand(100)        # 0 to 100 (inclusive)
echo rand(1..6)       # 1 to 6 (dice roll)

# ─── RANDOM FLOATS ───────────────────────────────────────────
echo rand(1.0)        # 0.0 to 1.0

# ─── RANDOM FROM COLLECTION ──────────────────────────────────
let colors = @["red", "green", "blue"]
echo sample(colors)   # random element

# ─── SHUFFLE ─────────────────────────────────────────────────
var deck = @[1, 2, 3, 4, 5]
shuffle(deck)
echo deck   # random order
```

---

## Functional Patterns

```nim
import std/[sequtils, sugar, algorithm, tables, options]

# ─── MAP / FILTER / REDUCE ───────────────────────────────────
let nums = @[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

let doubled = nums.map(x => x * 2)
let evens = nums.filter(x => x mod 2 == 0)
let sum = nums.foldl(a + b)
let product = nums.foldl(a * b, 1)   # with initial value

# ─── CHAINING ────────────────────────────────────────────────
let result = nums
  .filter(x => x mod 2 == 0)   # keep evens
  .map(x => x * x)              # square them
  .foldl(a + b)                  # sum
echo result   # 4+16+36+64+100 = 220

# ─── COLLECT (list comprehension) ────────────────────────────
let squares = collect:
  for x in 1..10:
    if x mod 2 == 0: x * x
# @[4, 16, 36, 64, 100]

# ─── ZIP & ENUMERATE ─────────────────────────────────────────
let names = @["Alice", "Bob", "Carol"]
let ages = @[30, 25, 28]
let pairs = zip(names, ages)
# @[("Alice", 30), ("Bob", 25), ("Carol", 28)]

# ─── GROUP BY (manual) ───────────────────────────────────────
let words = @["apple", "banana", "avocado", "blueberry", "cherry"]
var grouped = initTable[char, seq[string]]()
for word in words:
  let key = word[0]
  if key notin grouped: grouped[key] = @[]
  grouped[key].add(word)
# {'a': @["apple", "avocado"], 'b': @["banana", "blueberry"], 'c': @["cherry"]}

# ─── OPTION CHAINING ─────────────────────────────────────────
proc findUser(id: int): Option[string] =
  if id == 1: some("Alice") else: none(string)

let greeting = findUser(1).map(proc(n: string): string = "Hello, " & n)
echo greeting   # some("Hello, Alice")
```

---

## Useful Patterns & Idioms

```nim
# ─── UFCS CHAINING (Uniform Function Call Syntax) ─────────────
# Any proc(x, ...) can be called as x.proc(...)
# This enables readable chains:
import std/[strutils, sequtils, sugar]

let result = "  Hello, World!  "
  .strip()
  .toLowerAscii()
  .split(", ")
  .map(s => s & "!")
echo result   # @["hello!", "world!"]

# ─── BLOCK EXPRESSIONS ───────────────────────────────────────
let config = block:
  var c: string
  if existsEnv("CONFIG"):
    c = getEnv("CONFIG")
  else:
    c = "default.yaml"
  c   # last expression is the value

# ─── NAMED BREAK (escape nested loops) ───────────────────────
block search:
  for i in 0..100:
    for j in 0..100:
      if i * j == 42:
        echo "found: ", i, ", ", j
        break search

# ─── TYPE CONVERSION ─────────────────────────────────────────
let x = 42
let f = float(x)       # int → float
let s = $x             # anything → string
let i = int(3.14)      # float → int (truncates)

# ─── TERNARY (if expression) ─────────────────────────────────
let label = if count > 0: "items" else: "empty"

# ─── SWAP ────────────────────────────────────────────────────
var a = 1
var b = 2
swap(a, b)   # a=2, b=1

# ─── DEFER FOR CLEANUP ───────────────────────────────────────
proc processFile(path: string) =
  let f = open(path)
  defer: f.close()
  # ... use f, it's closed automatically on exit

# ─── OBJECT CONSTRUCTION SHORTHAND ───────────────────────────
type Config = object
  host: string
  port: int
  debug: bool

# Named fields (order doesn't matter)
let cfg = Config(port: 8080, host: "localhost", debug: true)

# ─── CASE OBJECT PATTERN (sum types / tagged unions) ─────────
type
  MsgKind = enum text, image, file
  Message = object
    sender: string
    case kind: MsgKind
    of text: content: string
    of image: url: string; width, height: int
    of file: path: string; size: int

let m = Message(sender: "Alice", kind: text, content: "Hello!")

# ─── COMPILE-TIME COMPUTATION ─────────────────────────────────
const Fib10 = block:
  var a = 0
  var b = 1
  for _ in 0..<10:
    let tmp = a + b
    a = b
    b = tmp
  b
# Fib10 is computed at compile time — zero runtime cost
echo Fib10   # 89
```

---

## Quick Reference (Python → Nim)

| Python | Nim | Notes |
|--------|-----|-------|
| `print("hi")` | `echo "hi"` | |
| `len(x)` | `x.len` | UFCS |
| `str(42)` | `$42` | `$` converts to string |
| `int("42")` | `parseInt("42")` | import std/strutils |
| `f"hello {name}"` | `fmt"hello {name}"` | import std/strformat |
| `x = [1,2,3]` | `var x = @[1,2,3]` | seq (dynamic) |
| `x.append(4)` | `x.add(4)` | |
| `x[0]` | `x[0]` | same |
| `x[-1]` | `x[^1]` | `^` = from end |
| `x[1:3]` | `x[1..<3]` | `..<` = exclusive end |
| `for i, v in enumerate(x)` | `for i, v in x:` | built-in |
| `[x*2 for x in range(10)]` | `collect: for x in 0..<10: x*2` | import std/sugar |
| `d = {"a": 1}` | `var d = {"a": 1}.toTable` | import std/tables |
| `"key" in d` | `"key" in d` | same |
| `d.get("key", 0)` | `d.getOrDefault("key", 0)` | |
| `None` | `none(T)` | import std/options |
| `if x is not None` | `if x.isSome` | |
| `def f(x):` | `proc f(x: int): int =` | types required |
| `lambda x: x*2` | `(x: int) => x * 2` | import std/sugar |
| `try/except` | `try/except` | same structure |
| `raise ValueError("msg")` | `raise newException(ValueError, "msg")` | |
| `with open(f) as f:` | `let f = open(...); defer: f.close()` | |
| `import os` | `import std/os` | |
| `from x import y` | `from x import y` | same |
| `class Foo:` | `type Foo = object` | or `ref object` |
| `@property` | just use a proc | UFCS makes it look like a field |
| `async def f():` | `proc f() {.async.}` | |
| `await x` | `await x` | same |
| `pip install x` | `nimble install x` | |
| `python -m pytest` | `nim c -r tests/test.nim` | |

---

*End of cheat sheet. Happy coding!* 🎉
