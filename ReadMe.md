bogsolve
========

What?
-----------

A program which takes a Boggle grid and a list of acceptable words, and determines which words can be formed using the grid.

Why?
----

Learning Haskell.

How?
----

You'll need:

    - [A Haskell compiler](http://hackage.haskell.org/platform).
    - A dictionary (a file containing words in plain text, each on a seperate line) like [this one](http://www.freebsd.org/cgi/cvsweb.cgi/src/share/dict/web2).

Compile it by getting the source and running (from the source root):

    cd src
    ghc --make Main -o bogsolve

Then run it using the following:

    bogsolve *pathToDictionary* *boggleGrid*

E.g.

    bogsolve ../mydict.txt A B C D E F G H I J K L M N O P

You must specify at least one grid letter. A grid width of 4 is assumed, so the above will solve the following grid:

    A B C D
    E F G H
    I J K L
    M N O P

The above command outputs the following (given a dictionary containing all the relevant words):

    a : a (0, 0)
    ab : a (0, 0) -> b (1, 0)
    abe : a (0, 0) -> b (1, 0) -> e (0, 1)
    ae : a (0, 0) -> e (0, 1)
    b : b (1, 0)
    ba : b (1, 0) -> a (0, 0)
    bae : b (1, 0) -> a (0, 0) -> e (0, 1)
    be : b (1, 0) -> e (0, 1)
    bea : b (1, 0) -> e (0, 1) -> a (0, 0)
    c : c (2, 0)
    d : d (3, 0)
    e : e (0, 1)
    ea : e (0, 1) -> a (0, 0)
    f : f (1, 1)
    fa : f (1, 1) -> a (0, 0)
    fae : f (1, 1) -> a (0, 0) -> e (0, 1)
    fe : f (1, 1) -> e (0, 1)
    fei : f (1, 1) -> e (0, 1) -> i (0, 2)
    fi : f (1, 1) -> i (0, 2)
    fie : f (1, 1) -> i (0, 2) -> e (0, 1)
    fin : f (1, 1) -> i (0, 2) -> n (1, 3)
    fink : f (1, 1) -> i (0, 2) -> n (1, 3) -> k (2, 2)
    g : g (2, 1)
    glop : g (2, 1) -> l (3, 2) -> o (2, 3) -> p (3, 3)
    h : h (3, 1)
    i : i (0, 2)
    ie : i (0, 2) -> e (0, 1)
    if : i (0, 2) -> f (1, 1)
    ife : i (0, 2) -> f (1, 1) -> e (0, 1)
    ijo : i (0, 2) -> j (1, 2) -> o (2, 3)
    in : i (0, 2) -> n (1, 3)
    ink : i (0, 2) -> n (1, 3) -> k (2, 2)
    ino : i (0, 2) -> n (1, 3) -> o (2, 3)
    j : j (1, 2)
    jef : j (1, 2) -> e (0, 1) -> f (1, 1)
    ji : j (1, 2) -> i (0, 2)
    jim : j (1, 2) -> i (0, 2) -> m (0, 3)
    jin : j (1, 2) -> i (0, 2) -> n (1, 3)
    jink : j (1, 2) -> i (0, 2) -> n (1, 3) -> k (2, 2)
    jo : j (1, 2) -> o (2, 3)
    jon : j (1, 2) -> o (2, 3) -> n (1, 3)
    joni : j (1, 2) -> o (2, 3) -> n (1, 3) -> i (0, 2)
    k : k (2, 2)
    klop : k (2, 2) -> l (3, 2) -> o (2, 3) -> p (3, 3)
    knife : k (2, 2) -> n (1, 3) -> i (0, 2) -> f (1, 1) -> e (0, 1)
    knop : k (2, 2) -> n (1, 3) -> o (2, 3) -> p (3, 3)
    ko : k (2, 2) -> o (2, 3)
    kol : k (2, 2) -> o (2, 3) -> l (3, 2)
    kon : k (2, 2) -> o (2, 3) -> n (1, 3)
    kop : k (2, 2) -> o (2, 3) -> p (3, 3)
    l : l (3, 2)
    lo : l (3, 2) -> o (2, 3)
    lonk : l (3, 2) -> o (2, 3) -> n (1, 3) -> k (2, 2)
    lop : l (3, 2) -> o (2, 3) -> p (3, 3)
    m : m (0, 3)
    mi : m (0, 3) -> i (0, 2)
    min : m (0, 3) -> i (0, 2) -> n (1, 3)
    mink : m (0, 3) -> i (0, 2) -> n (1, 3) -> k (2, 2)
    mino : m (0, 3) -> i (0, 2) -> n (1, 3) -> o (2, 3)
    n : n (1, 3)
    ni : n (1, 3) -> i (0, 2)
    nife : n (1, 3) -> i (0, 2) -> f (1, 1) -> e (0, 1)
    nim : n (1, 3) -> i (0, 2) -> m (0, 3)
    no : n (1, 3) -> o (2, 3)
    o : o (2, 3)
    ok : o (2, 3) -> k (2, 2)
    on : o (2, 3) -> n (1, 3)
    p : p (3, 3)
    po : p (3, 3) -> o (2, 3)
    pol : p (3, 3) -> o (2, 3) -> l (3, 2)
    polk : p (3, 3) -> o (2, 3) -> l (3, 2) -> k (2, 2)
    pon : p (3, 3) -> o (2, 3) -> n (1, 3)
    Available points: 36

Note that words may be duplicated if there's more than one way to make them. The numbers in parens are the x-y co-ords of each grid letter. The available points are calculated without duplicates (you can only score a word once, no matter how many ways you can make it).