/*
 * Copyright (C) 2025 - Avellea Jenkins
 *               2018 - Timo Könnecke <el-t-mo@arcor.de>
 *               2015 - Florent Revest <revestflo@gmail.com>
 *               2014 - Aleksi Suomalainen <suomalainen.aleksi@gmail.com>
 * All rights reserved.
 *
 * You may use this file under the terms of BSD license as follows:
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 *     * Neither the name of the author nor the
 *       names of its contributors may be used to endorse or promote products
 *       derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
 * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

/*
* Based on Florents 002-alternative-digital stock watchface.
* Bigger monotype font (GeneraleMono) and fixed am/pm display by slicing to two chars.
* Calculated ctx.shadows with variable px size for better display in watchface-settings
*/

/* 
* Further based on digital-alternative-mosen by eLtMosen <Timo Könnecke>
* Font: Poppins (OFL, https://fonts.google.com/specimen/Poppins/license)
* Added battery percentage and charge indicator.
*/

import QtQuick 2.15
import QtQuick.Shapes 1.15
import org.asteroid.controls 1.0
import org.asteroid.utils 1.0
import Nemo.Mce 1.0


Item {

    // MouseArea {
    //     anchors.fill: parent
    // }

    MceBatteryState {
        id: batteryChargeState
    }

    MceBatteryLevel {
        id: batteryChargePercentage
    }


    Icon {
        id: batteryIcon
        name: "ios-battery-charging"
        visible: batteryChargeState.value === MceBatteryState.Charging

        anchors {
            centerIn: parent
            verticalCenterOffset: -parent.height * 0.4
        }

        width: parent.width * 0.15
        height: parent.height * 0.15
        opacity: 0.65
    }

    Text {
        id: hourMinuteCanvas

        anchors {
            centerIn: parent
        }

        antialiasing: true
        smooth: true
        renderType: Text.NativeRendering

        font { 
            pixelSize: 50 + (parent.height*0.075)
            family: "Poppins"
        }

        color: '#FFFFFF'
        opacity: (displayAmbient ? 0.35 : 1.00)

        text: wallClock.time.toLocaleString(Qt.locale(), (use12H.value ? "hh:mm a" : "HH:mm")).slice(0,5)
    }

    Text {
        id: ampmDisplay

        visible: use12H.value

        anchors {
            centerIn: parent
            verticalCenterOffset: -parent.height * 0.15
            horizontalCenterOffset: parent.width * 0.255
        }

        font { 
            pixelSize: 0 + (parent.height*0.0725)
            family: "Poppins"
        }

        color: '#FFFFFF'
        opacity: (displayAmbient ? 0.35 : 0.75)

        text: wallClock.time.toLocaleString(Qt.locale(), "ap")
    }

    Text { 
        id: batteryCanvas
        
        anchors {
            centerIn: parent
            verticalCenterOffset: -parent.height * 0.15
        }

        renderType: Text.NativeRendering

        font {
            pixelSize: parent.height * 0.072
            family: "Poppins"
        }

        color: '#FFFFFF'
        opacity: (displayAmbient ? 0.35 : 0.75)

        // property var value: (featureSlider.value * 100).toFixed(0)
        property var value: batteryChargePercentage.percent

        text: value + "%"

    }

    Text {
        id: dateCanvas
        
        anchors {
            centerIn: parent
            verticalCenterOffset: parent.height * 0.15
        }

        antialiasing: true
        smooth: true
        renderType: Text.NativeRendering

        font { 
            pixelSize: 0 + (parent.height*0.0725)
            family: "Poppins"
        }

        color: '#FFFFFF'
        opacity: (displayAmbient ? 0.35 : 0.75)

        text: wallClock.time.toLocaleString(Qt.locale(), "ddd, MMM d")

    }
}
