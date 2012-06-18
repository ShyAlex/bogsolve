bogsolve
========

What?
-----------

A program which takes a Boggle grid and a list of acceptable words, and determines which words can be formed using the grid.

Why?
----

Learning Haskell and stuff.

How?
----

You'll need:

  - [A Haskell compiler](http://hackage.haskell.org/platform).
  - A dictionary (a file containing words in plain text, each on a seperate line) like [this one](http://www.freebsd.org/cgi/cvsweb.cgi/src/share/dict/web2).

Compile it by getting the source and running (from the source root):

    cd src
    ghc --make Main -o bogsolve

Then run it using the following:

    bogsolve pathToDictionary boggleGrid

E.g.

    bogsolve ../web2 e g i b h o t n r s e r y p e qu

You must specify at least one grid letter. A grid width of 4 is assumed. The above command outputs the following (given a dictionary containing all the relevant words):

    ...
    e  g  i  b      pry                             
    h  o  t  n      1 point(s)                      
    R  s  e  r      p (1, 3) -> r (0, 2) -> y (0, 3)
    Y  P  e  qu                                     

    e  g  i  b      pryse                                                   
    h  o  t  n      2 point(s)                                              
    R  S  E  r      p (1, 3) -> r (0, 2) -> y (0, 3) -> s (1, 2) -> e (2, 2)
    Y  P  e  qu                                                             

    e  g  i  b      pryse                                                   
    h  o  t  n      2 point(s)                                              
    R  S  e  r      p (1, 3) -> r (0, 2) -> y (0, 3) -> s (1, 2) -> e (2, 3)
    Y  P  E  qu                                                             

    e  g  i  b      pst                             
    h  o  T  n      1 point(s)                      
    r  S  e  r      p (1, 3) -> s (1, 2) -> t (2, 1)
    y  P  e  qu                                     

    e  g  i  b      pyr                             
    h  o  t  n      1 point(s)                      
    R  s  e  r      p (1, 3) -> y (0, 3) -> r (0, 2)
    Y  P  e  qu                                     

    e  g  i  b      pyro                                        
    h  O  t  n      1 point(s)                                  
    R  s  e  r      p (1, 3) -> y (0, 3) -> r (0, 2) -> o (1, 1)
    Y  P  e  qu                                                 

    e  g  i  b      queen                                        
    h  o  t  N      2 point(s)                                   
    r  s  E  r      qu (3, 3) -> e (2, 3) -> e (2, 2) -> n (3, 1)
    y  p  E  QU                                                  
    ...
    Available points: 379

Note that words may be duplicated if there's more than one way to make them (as with 'pryse' above). The available points are calculated without duplicates (you can only score a word once, no matter how many ways you can make it).