# Fortran

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://jagot.github.io/Fortran.jl/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://jagot.github.io/Fortran.jl/dev)
[![Build Status](https://travis-ci.com/jagot/Fortran.jl.svg?branch=master)](https://travis-ci.com/jagot/Fortran.jl)
[![Build Status](https://ci.appveyor.com/api/projects/status/github/jagot/Fortran.jl?svg=true)](https://ci.appveyor.com/project/jagot/Fortran-jl)
[![Coverage](https://codecov.io/gh/jagot/Fortran.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/jagot/Fortran.jl)

Experiment in parsing Fortran source code via the Python package
[fparser](https://github.com/stfc/fparser).

## Example

Example taken from https://numpy.org/doc/1.17/f2py/getting-started.html
```fortran
C FILE: FIB1.F
      SUBROUTINE FIB(A,N)
C
C     CALCULATE FIRST N FIBONACCI NUMBERS
C
      INTEGER N
      REAL*8 A(N)
      DO I=1,N
         IF (I.EQ.1) THEN
            A(I) = 0.0D0
         ELSEIF (I.EQ.2) THEN
            A(I) = 1.0D0
         ELSE 
            A(I) = A(I-1) + A(I-2)
         ENDIF
      ENDDO
      END
C END FILE FIB1.F
```

```julia
using Fortran

fparse(open("fib1.f"))
```

```
PyObject       BeginSource
        blocktype='beginsource'
        name='<_io.StringIO object at 0x13121fb88> mode=fix'
        a=AttributeHolder:
      external_subprogram=<dict with keys ['fib']>
        content:
          Subroutine
            args=['a', 'n']
            item=Line('SUBROUTINE FIB(A,N)',(2, 2),None,None,<reader>)
            a=AttributeHolder:
        variables=<dict with keys ['a', 'n']>
            content:
              Integer
                selector=('', '')
                entity_decls=['n']
                item=Line('INTEGER N',(6, 6),None,None,<reader>)
              Real
                selector=('8', '')
                entity_decls=['a(n)']
                item=Line('REAL*8 A(N)',(7, 7),None,None,<reader>)
              Do
                blocktype='do'
                item=Line('DO I=1,N',(8, 8),None,None,<reader>)
                content:
                  IfThen
                    blocktype='ifthen'
                    item=Line('IF (I.EQ.1) THEN',(9, 9),None,None,<reader>)
                    content:
                      Assignment
                        variable='a(i)'
                        sign='='
                        expr='0.0d0'
                        item=Line('A(I) = 0.0D0',(10, 10),None,None,<reader>)
                      ElseIf
                        item=Line('ELSEIF (I.EQ.2) THEN',(11, 11),None,None,<reader>)
                      Assignment
                        variable='a(i)'
                        sign='='
                        expr='1.0d0'
                        item=Line('A(I) = 1.0D0',(12, 12),None,None,<reader>)
                      Else
                        item=Line('ELSE',(13, 13),None,None,<reader>)
                      Assignment
                        variable='a(i)'
                        sign='='
                        expr='a(i-1) + a(i-2)'
                        item=Line('A(I) = A(I-1) + A(I-2)',(14, 14),None,None,<reader>)
                  EndIfThen
                    blocktype='if'
                    item=Line('ENDIF',(15, 15),None,None,<reader>)
              EndDo
                blocktype='do'
                item=Line('ENDDO',(16, 16),None,None,<reader>)
          EndSubroutine
            blocktype='subroutine'
            name='fib'
            item=Line('END',(17, 17),None,None,<reader>)
```
