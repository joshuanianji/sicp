module Main exposing (main)

import Collage exposing (Collage, defaultLineStyle, group, scale)
import Collage.Render exposing (svg)
import Html exposing (Html)
import List
import Segments exposing (LineSegment)
import Vectors exposing (..)


-- segments -> painter function. I could not complete the last part so technically this is incomplete.


type alias Frame =
    { origin : Vector
    , edge1 : Vector
    , edge2 : Vector
    }



-- takes in a frame and outputs a function that scales vectors according to that frame


frameCoordMap : Frame -> (Vector -> Vector)
frameCoordMap frame =
    \v ->
        addVect
            frame.origin
            (addVect
                (scaleVect
                    frame.edge1
                    (xVect v)
                )
                (scaleVect
                    frame.edge2
                    (yVect v)
                )
            )



-- takes in a list of LineSegments and returns a function that takes in a frame and outputs lines ready to be drawn


segmentToPainter : List LineSegment -> (Frame -> List Collage.Path)
segmentToPainter segmentList =
    \frame ->
        List.map
            (\line ->
                Collage.segment
                    (line.start
                        |> frameCoordMap frame
                    )
                    (line.end
                        |> frameCoordMap frame
                    )
            )
            segmentList



-- draws lines in a frame


drawLine : Frame -> (Frame -> List Collage.Path) -> Collage msg
drawLine frame painter =
    List.map
        (Collage.traced defaultLineStyle)
        (painter frame)
        |> group



-- this frame scales it twice via the x axis


origin : Vector
origin =
    makeVect 0 0


edge1 : Vector
edge1 =
    makeVect 40 20


edge2 : Vector
edge2 =
    makeVect -5 20


frameXScale : Frame
frameXScale =
    Frame
        origin
        edge1
        edge2


defaultFrame : Frame
defaultFrame =
    Frame
        (makeVect 0 0)
        (makeVect 10 0)
        (makeVect 0 10)


lineOne : LineSegment
lineOne =
    LineSegment
        (makeVect 0 0)
        (makeVect 10 10)



-- takes in a frame and calculates what line segments are needed to make an outline
-- I only need to do ones and zeroes because the frame scales it for me


frameOutlines : Frame -> List LineSegment
frameOutlines frame =
    [ LineSegment
        (makeVect 0 0)
        (makeVect 0 1)
    , LineSegment
        (makeVect 0 1)
        (makeVect 1 1)
    , LineSegment
        (makeVect 1 1)
        (makeVect 1 0)
    , LineSegment
        (makeVect 1 0)
        (makeVect 0 0)
    ]



--draws the frame outline


drawFrameOutline : Frame -> Collage msg
drawFrameOutline frame =
    segmentToPainter (frameOutlines frame)
        |> drawLine frame



-- takes in a frame and connects the opposite corners


cornerConnectOutlines : Frame -> List LineSegment
cornerConnectOutlines frame =
    [ LineSegment
        (makeVect 0 0)
        (makeVect 1 1)
    , LineSegment
        (makeVect 0 1)
        (makeVect 1 0)
    ]


connectCorners : Frame -> Collage msg
connectCorners frame =
    segmentToPainter (cornerConnectOutlines frame)
        |> drawLine frame



-- connects the midpoints of a frame


midpointConnectOutlines : Frame -> List LineSegment
midpointConnectOutlines frame =
    [ LineSegment
        (makeVect 0.5 0)
        (makeVect 1 0.5)
    , LineSegment
        (makeVect 1 0.5)
        (makeVect 0.5 1)
    , LineSegment
        (makeVect 0.5 1)
        (makeVect 0 0.5)
    , LineSegment
        (makeVect 0 0.5)
        (makeVect 0.5 0)
    ]


connectMidpoints : Frame -> Collage msg
connectMidpoints frame =
    segmentToPainter (midpointConnectOutlines frame)
        |> drawLine frame


main : Html msg
main =
    group
        [ drawFrameOutline frameXScale
        , connectMidpoints frameXScale
        ]
        |> svg
