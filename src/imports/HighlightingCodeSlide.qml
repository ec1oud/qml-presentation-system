/****************************************************************************
**
** Copyright (C) 2016 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the QML Presentation System.
**
** $QT_BEGIN_LICENSE:LGPL$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and Digia.  For licensing terms and
** conditions see http://qt.digia.com/licensing.  For further information
** use the contact form at http://qt.digia.com/contact-us.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 2.1 as published by the Free Software
** Foundation and appearing in the file LICENSE.LGPL included in the
** packaging of this file.  Please review the following information to
** ensure the GNU Lesser General Public License version 2.1 requirements
** will be met: http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
**
** In addition, as a special exception, Digia gives you certain additional
** rights.  These rights are described in the Digia Qt LGPL Exception
** version 1.1, included in the file LGPL_EXCEPTION.txt in this package.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 3.0 as published by the Free Software
** Foundation and appearing in the file LICENSE.GPL included in the
** packaging of this file.  Please review the following information to
** ensure the GNU General Public License version 3.0 requirements will be
** met: http://www.gnu.org/copyleft/gpl.html.
**
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.10 // tabStopDistance is new
import Qt.labs.presentation 1.0
import Qt.labs.presentation.helper 1.0

Slide {
    id: slide;

    // Either set an example file
    property string sourceFile;
    // or directly set the code here
    property string code: helper.contentWithoutComments;
    property alias qtSourceModule: helper.qtSourceModule
    property Component background: gradientBackground

    property string codeFontFamily: parent.codeFontFamily;
    property real codeFontSize: baseFontSize * 0.6;
    property real margins: 24
    property real rightMargin: 300

    property alias paletteName: paletteLoader.name
    property alias palette: paletteLoader.palette
    property alias tabStopDistance: editor.tabStopDistance

    PaletteLoader {
        id: paletteLoader
        name: "Cute"
    }

    property alias __helper: helper

    Component {
        id: gradientBackground
        Rectangle {
            id: background
            anchors.fill: parent
            radius: 12
            gradient: Gradient {
                GradientStop { position: 0; color: Qt.rgba(0.8, 0.8, 0.8, 0.5); }
                GradientStop { position: 1; color: Qt.rgba(0.2, 0.2, 0.2, 0.5); }
            }
            border.color: slide.textColor;
            border.width: height / 250;
            antialiasing: true
        }
    }

    Loader {
        sourceComponent: background
        anchors.fill: parent
        anchors.margins: slide.margins
        clip: true
    }

    onVisibleChanged: {
        editor.focus = slide.visible;
    }

    Rectangle {
        color: "#11111111"
        width: 1
        anchors {
            left: flick.right
            top: flick.top
            bottom: flick.bottom
            margins: -12
        }
    }

    Flickable {
         id: flick
         anchors.fill: parent
         anchors.margins: slide.margins
         anchors.rightMargin: slide.rightMargin
         contentWidth: editor.paintedWidth
         contentHeight: editor.paintedHeight

        TextEdit {
            id: editor
            anchors.fill: parent;
            focus: true
            text: code
            font.family: codeFontFamily
            font.pixelSize: codeFontSize
        }
    }

    SyntaxHighlighter {
        id: syntaxHighlighter

        normalColor: palette.editorNormal
        commentColor: palette.editorComment
        numberColor: palette.editorNumber
        stringColor: palette.editorString
        operatorColor: palette.editorOperator
        keywordColor: palette.editorKeyword
        builtInColor: palette.editorBuiltIn
        markerColor: palette.editorMarker
        itemColor: palette.editorItem
        propertyColor: palette.editorProperty
    }

    Component.onCompleted: {
        syntaxHighlighter.setHighlighter(editor)
    }

    ExampleHelper {
        id: helper
        source: slide.visible ? sourceFile : ""
    }
}
