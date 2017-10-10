/****************************************************************************
**
** Copyright (C) 2017 The Qt Company Ltd.
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

import QtQuick 2.10
import Qt.labs.presentation 1.0
import Qt.labs.presentation.helper 1.0

Item {
    id: root

    property int orientation: Qt.Horizontal

    property alias paletteName: paletteLoader.name
    property alias palette: paletteLoader.palette
    property alias code: editor.text
    property alias tabStopDistance: editor.tabStopDistance
    property string codeFontFamily: "monospace"
    property real codeFontSize: root.height * 0.03
    property real horizontalSplit : 0.5

    PaletteLoader {
        id: paletteLoader
        name: "Dark"
    }

    Item {
        id: incubationItem
        visible: false
    }

    Item {
        id: itemContainer
        height: parent.height * ((orientation == Qt.Horizontal) ? 1 : 0.497)
        width: parent.width * ((orientation == Qt.Vertical) ? 1 : 1 - 0.003 - horizontalSplit)
        anchors.right: parent.right;
        anchors.top: ((orientation == Qt.Horizontal) ? parent.top : parent.verticalCenter)
        anchors.bottom: parent.bottom

        property var itm : null

        function replaceItem(sourceCode)
        {
            var obj = undefined
            try {
                obj = Qt.createQmlObject(sourceCode, incubationItem);
            } catch(err) {
                return; // silently fail
            }

            if (obj === undefined)
                return;

            if (itemContainer.itm != null)
                itemContainer.itm.destroy()
            obj.parent = itemContainer
            itemContainer.itm = obj
        }
    }

    Rectangle {
        height: parent.height * ((orientation == Qt.Horizontal) ? 1 : 0.497)
        width: parent.width * ((orientation == Qt.Vertical) ? 1 : horizontalSplit - 0.003)
        anchors.left: parent.left
        anchors.bottom: ((orientation == Qt.Horizontal) ? parent.bottom : parent.verticalCenter)
        anchors.top: parent.top

        antialiasing: true
        radius: root.height * 0.03;
        color: Qt.rgba(0.0, 0.0, 0.0, 0.8);

        clip: true;

        Flickable {
             id: flick

             anchors.fill: parent
             contentWidth: editor.paintedWidth
             contentHeight: editor.paintedHeight
             clip: true

             function ensureVisible(r)
             {
                 if (contentX >= r.x)
                     contentX = r.x;
                 else if (contentX+width <= r.x+r.width)
                     contentX = r.x+r.width-width;
                 if (contentY >= r.y)
                     contentY = r.y;
                 else if (contentY+height <= r.y+r.height)
                     contentY = r.y+r.height-height;
             }

            TextEdit {
                id: editor
                anchors.fill: parent;
                anchors.margins: 10

                font.family: codeFontFamily
                font.pixelSize: codeFontSize
                color: "white"
                font.bold: true
                tabStopDistance: 38
                text: "import QtQuick 2.10\nRectangle { }"

                onTextChanged: itemContainer.replaceItem(editor.text)
                onCursorRectangleChanged: flick.ensureVisible(cursorRectangle)

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
            } // TextEdit
        } // Flickable
    } // Rectangle
}
