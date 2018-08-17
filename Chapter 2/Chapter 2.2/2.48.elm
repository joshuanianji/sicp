module Main exposing (..)

import Segments exposing (LineSegment)
import Vectors exposing (..)


-- I just wrote this code here because I won't actually use makeSegment and startSegment irl cuz it's dumb.


makeSegment : Vector -> Vector -> LineSegment
makeSegment v1 v2 =
    LineSegment
        v1
        v2


startSegment : LineSegment -> Vector
startSegment line =
    line.start


endSegment : LineSegment -> Vector
endSegment line =
    line.end
