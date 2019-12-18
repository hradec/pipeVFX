##########################################################################
#
#  Copyright (c) 2012, John Haddon. All rights reserved.
#  Copyright (c) 2013, Image Engine Design Inc. All rights reserved.
#
#  Redistribution and use in source and binary forms, with or without
#  modification, are permitted provided that the following conditions are
#  met:
#
#      * Redistributions of source code must retain the above
#        copyright notice, this list of conditions and the following
#        disclaimer.
#
#      * Redistributions in binary form must reproduce the above
#        copyright notice, this list of conditions and the following
#        disclaimer in the documentation and/or other materials provided with
#        the distribution.
#
#      * Neither the name of John Haddon nor the names of
#        any other contributors to this software may be used to endorse or
#        promote products derived from this software without specific prior
#        written permission.
#
#  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
#  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
#  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
#  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
#  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
#  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
#  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
#  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
#  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
#  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
#  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
##########################################################################

import IECore

import Gaffer
import GafferUI
import math

QtCore, QtGui = pipe.importQt()


## The NumericSlider extends the slider class to provide a mapping between the positions
# and a range defined by a minimum and maximum value.
class frameSlider( GafferUI.NumericSlider ) :
    def __init__( self, value=None, min=0, max=1, hardMin=None, hardMax=None, values=None, **kw ) :
        # GafferUI.NumericSlider.__init__(self, value, min, max, hardMin, hardMax, values, **kw )
        GafferUI.Slider.__init__( self, **kw )

        assert( ( value is None ) or ( values is None) )

        self.__min = min
        self.__max = max
        self.__hardMin = hardMin if hardMin is not None else self.__min
        self.__hardMax = hardMax if hardMax is not None else self.__max

        # It would be nice to not store the values, but always infer them from
        # the positions. This isn't possible though, as the range may be 0 length
        # and then we would lose the values.
        self.__values = []
        if values is not None :
            self.__setValuesInternal( values, self.PositionChangedReason.SetPositions )
        else :
            self.__setValuesInternal( [ 0 if value is None else value ], self.PositionChangedReason.SetPositions )

    ## Convenience function to call setValues( [ value ] )
    def setValue( self, value ) :

        self.setValues( [ value ] )

    ## Convenience function returning getValues()[0] if there
    # is only one value, and raising ValueError if not.
    def getValue( self ) :

        if len( self.__values ) != 1 :
            raise ValueError

        return self.__values[0]

    def setValues( self, values ) :

        self.__setValuesInternal( values, self.PositionChangedReason.SetPositions )

    def getValues( self ) :

        return self.__values

    def setRange( self, min, max, hardMin=None, hardMax=None ) :

        if hardMin is None :
            hardMin = min
        if hardMax is None :
            hardMax = max

        if min==self.__min and max==self.__max and hardMin==self.__hardMin and hardMax==self.__hardMax :
            return

        self.__min = min
        self.__max = max
        self.__hardMin = hardMin
        self.__hardMax = hardMax

        self.__setValuesInternal( self.__values, self.PositionChangedReason.Invalid ) # reclamps the values to the range if necessary
        # __setValuesInternal() won't trigger an update if the position is the same - if
        # the position is at one end of the range, and that end is the same as before.
        self._qtWidget().update()

    def getRange( self ) :

        return self.__min, self.__max, self.__hardMin, self.__hardMax

    def valueChangedSignal( self ) :

        try :
            return self.__valueChangedSignal
        except :
            self.__valueChangedSignal = Gaffer.Signal2()

        return self.__valueChangedSignal

    def _setPositionsInternal( self, positions, reason ) :

        # change it into a __setValuesInternal call so we can apply clamping etc.
        # __setValuesInternal will call Slider._setPositionsInternal for us.
        self.__setValuesInternal(
            [ self.__min + x * ( self.__max - self.__min ) for x in positions ],
            reason
        )

    def __setValuesInternal( self, values, reason ) :

        # clamp values
        values = [ max( self.__hardMin, min( self.__hardMax, x ) ) for x in values ]

        # convert them to positions
        range = self.__max - self.__min
        if range == 0 :
            positions = [ 0 ] * len( values )
        else :
            positions = [ float( x - self.__min ) / range for x in values ]

        # store values. we do this before storing positions so they'll
        # be in sync when the position change is signalled.
        dragBeginOrEnd = reason in ( self.PositionChangedReason.DragBegin, self.PositionChangedReason.DragEnd )
        valueChangedSignal = None
        if values != self.__values or dragBeginOrEnd :
            self.__values = values
            with IECore.IgnoredExceptions( AttributeError ) :
                valueChangedSignal = self.__valueChangedSignal

        # store positions.
        GafferUI.Slider._setPositionsInternal( self, positions, reason )

        # signal value change if necessary. we do this after storing
        # positions so that the positions are in sync.
        if valueChangedSignal is not None :
            valueChangedSignal( self, reason )

    def _drawBackground( self, painter ) :
        size= self.size()
        valueRange = self.__max - self.__min
        if valueRange == 0 :
            return

        idealSpacing = 10
        idealNumTicks = float( size.x ) / idealSpacing
        tickStep = valueRange / idealNumTicks

        logTickStep = math.log10( tickStep )
        flooredLogTickStep = math.floor( logTickStep )
        tickStep = math.pow( 10, flooredLogTickStep )
        blend = (logTickStep - flooredLogTickStep)

        tickValue = math.floor( self.__min / tickStep ) * tickStep
        i = 0
        while tickValue <= self.__max :
            x = size.x * ( tickValue - self.__min ) / valueRange
            if i % 100 == 0 :
                height0 = 0.95
                height1 = 0.95
                alpha0 = alpha1 = 1
            elif i % 50 == 0 :
                height0 = 0.5
                height1 = 0.5
                alpha0 = 1
                alpha1 = 0
            elif i % 10 == 0 :
                height0 = 0.5
                height1 = 0.25
                alpha0 = 1
                alpha1 = 0
            elif i % 5 == 0 :
                height0 = 0.25
                height1 = 0
                alpha0 = 1
                alpha1 = 0
            else :
                height0 = 0.05
                height1 = 0
                alpha0 = 1
                alpha1 = 0

            alpha = alpha0 + (alpha1 - alpha0) * blend
            height = height0 + (height1 - height0) * blend

            pen = QtGui.QPen()
            pen.setWidth( 0 )
            pen.setColor( QtGui.QColor( 0, 0, 0, alpha * 255 ) )
            painter.setPen( pen )

            painter.drawLine( x, size.y, x, size.y * ( 1.0 - height ) )
            tickValue += tickStep
            i += 1


## The Timeline presents a time slider which edits the frame
# entry of a context.
class TimelineImage( GafferUI.EditorWidget ) :

    def __init__( self, scriptNode, **kw ) :

        self.__row = GafferUI.ListContainer( GafferUI.ListContainer.Orientation.Horizontal, borderWidth = 4, spacing = 2 )

        GafferUI.EditorWidget.__init__( self, self.__row, scriptNode, **kw )


        with self.__row :

            self.__visibilityButton = GafferUI.Button( image="timeline3.png", hasFrame=False )
            self.__visibilityButtonClickedConnection = self.__visibilityButton.clickedSignal().connect( Gaffer.WeakMethod( self.__visibilityButtonClicked ) )

            self.__scriptRangeStart = GafferUI.NumericPlugValueWidget( scriptNode["frameRange"]["start"] )
            self.__scriptRangeStart.numericWidget().setFixedCharacterWidth( 4 )
            self.__scriptRangeStart.setToolTip( self.__scriptRangeStart.getPlug().fullName() )

            self.__sliderRangeStart = GafferUI.NumericWidget( scriptNode["frameRange"]["start"].getValue() )
            self.__sliderRangeStart.setFixedCharacterWidth( 4 )
            self.__sliderRangeStart.setToolTip( "Slider minimum" )
            self.__sliderRangeStartChangedConnection = self.__sliderRangeStart.editingFinishedSignal().connect( Gaffer.WeakMethod( self.__sliderRangeChanged ) )

            self.__slider = frameSlider(
                value = self.getContext().getFrame(),
                min = float( scriptNode["frameRange"]["start"].getValue() ),
                max = float( scriptNode["frameRange"]["end"].getValue() ),
                # values = range( int( scriptNode["frameRange"]["start"].getValue() ), int( scriptNode["frameRange"]["end"].getValue() ) ),
            )
            # self.__slider.setPositionIncrement( 0 ) # disable so the slider doesn't mask our global frame increment shortcut
            self.__sliderValueChangedConnection = self.__slider.valueChangedSignal().connect( Gaffer.WeakMethod( self.__valueChanged ) )

            self.__startButton = GafferUI.Button( image = "timelineStart.png", hasFrame=False )
            self.__startButtonClickedConnection = self.__startButton.clickedSignal().connect( Gaffer.WeakMethod( self.__startOrEndButtonClicked ) )

            self.__playPause = GafferUI.Button( image = "timelinePlay.png", hasFrame=False )
            self.__playPauseClickedConnection = self.__playPause.clickedSignal().connect( Gaffer.WeakMethod( self.__incrementFrame ) )

            self.__endButton = GafferUI.Button( image = "timelineEnd.png", hasFrame=False )
            self.__endButtonClickedConnection = self.__endButton.clickedSignal().connect( Gaffer.WeakMethod( self.__startOrEndButtonClicked ) )

            self.__frame = GafferUI.NumericWidget( self.getContext().getFrame() )
            self.__frame.setFixedCharacterWidth( 5 )
            self.__frame.setToolTip( "Current frame" )
            self.__frameChangedConnection = self.__frame.valueChangedSignal().connect( Gaffer.WeakMethod( self.__valueChanged ) )

            self.__sliderRangeEnd = GafferUI.NumericWidget( scriptNode["frameRange"]["end"].getValue() )
            self.__sliderRangeEnd.setFixedCharacterWidth( 4 )
            self.__sliderRangeEnd.setToolTip( "Slider maximum" )
            self.__sliderRangeEndChangedConnection = self.__sliderRangeEnd.editingFinishedSignal().connect( Gaffer.WeakMethod( self.__sliderRangeChanged ) )

            self.__scriptRangeEnd = GafferUI.NumericPlugValueWidget( scriptNode["frameRange"]["end"] )
            self.__scriptRangeEnd.numericWidget().setFixedCharacterWidth( 4 )
            self.__scriptRangeEnd.setToolTip( self.__scriptRangeEnd.getPlug().fullName() )

        self.__scriptNodePlugSetConnection = scriptNode.plugSetSignal().connect( Gaffer.WeakMethod( self.__scriptNodePlugSet ) )

        frameIncrementShortcut = QtGui.QShortcut( QtGui.QKeySequence( "Right" ), self._qtWidget() )
        frameIncrementShortcut.activated.connect( Gaffer.WeakMethod( self.__incrementFrame ) )

        frameDecrementShortcut = QtGui.QShortcut( QtGui.QKeySequence( "Left" ), self._qtWidget() )
        frameDecrementShortcut.activated.connect( IECore.curry( Gaffer.WeakMethod( self.__incrementFrame ), -1 ) )

        self.__playback = None
        self._updateFromContext( set() )

        if 'changedCallback' in dir(self):
            self.__slider.changedCallback = self.changedCallback


    def _updateFromContext( self, modifiedItems ) :

        if not hasattr(self, '__playback') or self.__playback is None or not self.__playback.context().isSame( self.getContext() ) :
            self.__playback = GafferUI.Playback.acquire( self.getContext() )
            self.__playback.setFrameRange( self.__sliderRangeStart.getValue(), self.__sliderRangeEnd.getValue() )
            self.__playbackStateChangedConnection = self.__playback.stateChangedSignal().connect( Gaffer.WeakMethod( self.__playbackStateChanged ) )
            self.__playbackFrameRangeChangedConnection = self.__playback.frameRangeChangedSignal().connect( Gaffer.WeakMethod( self.__playbackFrameRangeChanged ) )

        if "frame" not in modifiedItems :
            return

        # update the frame counter and slider position
        with Gaffer.BlockedConnection( [ self.__frameChangedConnection, self.__sliderValueChangedConnection ] ) :
            self.__frame.setValue( self.getContext().getFrame() )
            self.__slider.setValue( self.getContext().getFrame() )


    def __sliderRangeChanged( self, widget ) :

        assert( widget is self.__sliderRangeStart or widget is self.__sliderRangeEnd )

        # clamp value within range specified by script
        value = widget.getValue()
        value = max( self.scriptNode()["frameRange"]["start"].getValue(), value )
        value = min( self.scriptNode()["frameRange"]["end"].getValue(), value )

        # move the other end of the range if necessary
        if widget is self.__sliderRangeStart :
            minValue = value
            maxValue = max( value, self.__sliderRangeEnd.getValue() )
        else :
            maxValue = value
            minValue = min( value, self.__sliderRangeStart.getValue() )

        self.__playback.setFrameRange( minValue, maxValue )

    # this is connected to the valueChangedSignal on both the slider and the frame field
    def __valueChanged( self, widget, reason ) :

        assert( widget is self.__slider or widget is self.__frame )

        if widget is self.__slider :
            ## \todo Have the rounding come from NumericSlider, and allow the shift
            # modifier to choose fractional frame values.
            frame = int( self.__slider.getValue() )
        else :
            frame = self.__frame.getValue()

        frame = float( max( frame, self.scriptNode()["frameRange"]["start"].getValue() ) )
        frame = float( min( frame, self.scriptNode()["frameRange"]["end"].getValue() ) )

        if reason == reason.DragBegin :
            self.__playback.setState( self.__playback.State.Scrubbing )
        elif reason == reason.DragEnd :
            self.__playback.setState( self.__playback.State.Stopped )

        if widget is self.__frame :
            # if frame was set outside the range, the actual value in the context
            # may not change, so we need to update the value in the frame field manually
            self.__frame.setValue( frame )

        self.getContext().setFrame( frame )

        if 'changedCallback' in dir(self):
            self.changedCallback( self.getContext().getFrame() )


    def __scriptNodePlugSet( self, plug ) :

        combineFunction = None
        if plug.isSame( self.scriptNode()["frameRange"]["start"] ) :
            combineFunction = max
        elif plug.isSame( self.scriptNode()["frameRange"]["end"] ) :
            combineFunction = min

        if combineFunction is not None :
            self.__playback.setFrameRange(
                combineFunction( plug.getValue(), self.__sliderRangeStart.getValue() ),
                combineFunction( plug.getValue(), self.__sliderRangeEnd.getValue() ),
            )

    def __visibilityButtonClicked( self, button ) :

        assert( button is self.__visibilityButton )

        if self.__scriptRangeStart.getVisible() :
            self.__scriptRangeStart.setVisible( False )
            self.__scriptRangeEnd.setVisible( False )
            self.__visibilityButton.setImage( "timeline2.png" )
        elif self.__sliderRangeStart.getVisible() :
            self.__sliderRangeStart.setVisible( False )
            self.__sliderRangeEnd.setVisible( False )
            self.__visibilityButton.setImage( "timeline1.png" )
        else :
            self.__scriptRangeStart.setVisible( True )
            self.__scriptRangeEnd.setVisible( True )
            self.__sliderRangeStart.setVisible( True )
            self.__sliderRangeEnd.setVisible( True )
            self.__visibilityButton.setImage( "timeline3.png" )

    def __playPauseClicked( self, button ) :

        assert( button is self.__playPause )

        if self.__playback.getState() == self.__playback.State.Stopped :
            self.__playback.setState( self.__playback.State.PlayingForwards )
        else :
            self.__playback.setState( self.__playback.State.Stopped )

    def __startOrEndButtonClicked( self, button ) :

        self.__playback.setState( self.__playback.State.Stopped )

        if button is self.__startButton :
            self.getContext().setFrame( self.__sliderRangeStart.getValue() )
        else :
            self.getContext().setFrame( self.__sliderRangeEnd.getValue() )



    def __playbackStateChanged( self, playback ) :

        if playback.getState() in ( playback.State.PlayingForwards, playback.State.PlayingBackwards ) :
            self.__playPause.setImage( "timelinePause.png" )
        else :
            self.__playPause.setImage( "timelinePlay.png" )

    def __playbackFrameRangeChanged( self, playback ) :

        minValue, maxValue = playback.getFrameRange()

        with Gaffer.BlockedConnection( ( self.__sliderRangeStartChangedConnection, self.__sliderRangeEndChangedConnection ) ) :
            self.__slider.setRange( minValue, maxValue )
            self.__sliderRangeStart.setValue( minValue )
            self.__sliderRangeEnd.setValue( maxValue )

    def __incrementFrame( self, increment = 1 ) :

        self.__playback.incrementFrame( increment )
        if 'changedCallback' in dir(self):
            self.changedCallback( self.getContext().getFrame() )


    def __repr__( self ) :

        return "GafferUI.TimelineImage( scriptNode )"

GafferUI.EditorWidget.registerType( "TimelineImage", TimelineImage )
