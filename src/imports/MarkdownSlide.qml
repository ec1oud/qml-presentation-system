/****************************************************************************
**
** Copyright (C) 2024 The Qt Company Ltd.
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

import QtQuick

Item {
    /*
        A MarkdownSlide can only be instantiated as a direct child of a
        Presentation {} as it relies on several properties there.
     */

    id: slide
    objectName: title

    property bool isSlide: true;

    property string title;
    property string text;
    property string notes;
    // property alias source: markdownText.textDocument.source
    property url source

    property real fontSize: parent.height * 0.05
    property real fontScale: parent.fontScale

    property real baseFontSize: fontSize * fontScale
    property real titleFontSize: fontSize * 1.2 * fontScale
    property real bulletSpacing: 1

    property real contentWidth: contentArea.width

    width: parent.width
    height: parent.height

    property real masterWidth: parent.width
    property real masterHeight: parent.height

    property color titleColor: parent.titleColor;
    property real titleMargin: parent.titleMargin
    property color textColor: parent.textColor;
    property string fontFamily: parent.fontFamily;

    visible: false
    layer.enabled: true
    layer.sourceRect: Qt.rect(-x, -y, parent.width, parent.height)

    Text {
        id: titleText
        font.pixelSize: titleFontSize
        text: title;
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: parent.titleMargin
        font.bold: true;
        font.family: slide.fontFamily
        color: slide.titleColor
        horizontalAlignment: Text.Center
        z: 1
    }

    Item {
        id: contentArea
        x: parent.width * 0.05
        y: parent.height * 0.2
        width: parent.width * 0.9
        height: parent.height * 0.7

        Flickable {
            id: flick
            anchors.fill: parent
            contentWidth: markdownText.contentWidth
            contentHeight: markdownText.contentHeight

            TextEdit {
                id: markdownText
                readOnly: true
                width: flick.width
                textDocument.source: slide.source
                font.family: slide.fontFamily
                font.pixelSize: baseFontSize
                color: slide.textColor
                wrapMode: Text.Wrap
                text: slide.text
                textFormat: Text.MarkdownText
            }
        }
    }
}
