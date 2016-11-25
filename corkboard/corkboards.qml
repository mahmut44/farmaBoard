/****************************************************************************
**
** Copyright (C) 2015 The Qt Company Ltd.
** Copyright (C) 2014 BlackBerry Limited. All rights reserved.
** Contact: http://www.qt.io/licensing/
**
** This file is part of the examples of the QtNfc module.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.3
import QtNfc 5.5

Rectangle {
    width: 1600; height: 800
    color: "white"

    Rectangle{
        width: 1600; height: 50
        color: "blue"
        x: 0; y:0
    }

    Rectangle{
        width: 5; height: 800
        color: "blue"
        x: 400; y:0
    }

    Rectangle{
        width: 5; height: 800
        color: "blue"
        x: 800; y:0
    }

    Rectangle{
        width: 5; height: 800
        color: "blue"
        x: 1200; y:0
    }

    Rectangle{
        width: 5; height: 800
        color: "blue"
        x: 1600; y:0
    }

    Rectangle{
        width:300
    }

    NearField {
        property bool requiresManualPolling: false
        orderMatch: false

        onMessageRecordsChanged: {
            var i;
            for (i = 0; i < messageRecords.length; ++i) {
                var data = "";
                if (messageRecords[i].typeNameFormat === NdefRecord.NfcRtd) {
                    if (messageRecords[i].type === "T") {
                        data = messageRecords[i].text;
                    } else if (messageRecords[i].type === "U") {
                        data = messageRecords[i].uri;
                    }
                }
                if (!data)
                    data = "Unknown content";

                list.get(listView.currentIndex).notes.append( {
                        "noteText":data
                })
            }
        }

        onPollingChanged: {
            if (!polling && requiresManualPolling)
                polling = true; //restart polling
        }

        Component.onCompleted: {
            // Polling should be true if
            // QNearFieldManager::registerNdefMessageHandler() was successful;
            // otherwise the platform requires manual polling mode.
            if (!polling) {
                requiresManualPolling = true;
                polling = true;
            }
        }
    }

    ListModel {
        id: list

        ListElement {
            name: "Farma Board"
            notes: [
                ListElement { noteText: "" },
                ListElement { noteText: "" },
                ListElement { noteText: "" },
                ListElement { noteText: "" },
                ListElement { noteText: "" }
            ]
        }

        ListElement {
            name: "Work"
            notes: [
                //ListElement { noteText: "" },
                ListElement { noteText: "" }

            ]
        }
    }

    ListView {
        id: listView
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0

        anchors.fill: parent
        orientation: ListView.Horizontal
        snapMode: ListView.SnapOneItem
        model: list
        highlightRangeMode: ListView.StrictlyEnforceRange
        delegate: Mode {}

        Text {
            id: text1
            x: 92
            y: 74
            width: 220
            height: 80
            text: qsTr("JIRA")
            font.bold: true
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 36
        }

        Text {
            id: text2
            x: 516
            y: 74
            width: 206
            height: 86
            text: qsTr("EN COURS")
            verticalAlignment: Text.AlignVCenter
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 36
        }

        Text {
            id: text3
            x: 912
            y: 74
            width: 208
            height: 80
            text: qsTr("BLOQUEE")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.bold: true
            font.pixelSize: 36
        }

        Text {
            id: text4
            x: 1296
            y: 74
            width: 211
            height: 86
            text: qsTr("TERMINEE")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.bold: true
            font.pixelSize: 36
        }

        Column {
            id: column1
            x: 8
            y: 160
            width: 392
            height: 632
        }

        Column {
            id: column2
            x: 406
            y: 160
            width: 394
            height: 633
        }

        Column {
            id: column3
            x: 806
            y: 160
            width: 390
            height: 632
        }

        Column {
            id: column4
            x: 1202
            y: 160
            width: 398
            height: 640
        }
    }
}
