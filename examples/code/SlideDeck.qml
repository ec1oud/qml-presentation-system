/****************************************************************************
**
** Copyright (C) 2017 Shawn Rutledge
** Contact: http://www.qt-project.org/legal
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


import QtQuick 2.0
import Qt.labs.presentation 1.0

Presentation {
    width: 1280
    height: 720

    CodeSlide {
        sourceFile: "SlideDeck.qml"
    }

    HighlightingCodeSlide {
        paletteName: "Cute"
        sourceFile: "SlideDeck.qml"
    }

    LiveCodeSlide {
        code: "
            import QtQuick 2.5

            Rectangle {
                id: rec
                anchors.fill: parent
                radius: rec.height * 0.03
                color: 'tomato'
                Text {
                    anchors.centerIn: parent
                    text: 'tomato'
                }
            }
        "
    }

    MarkdownSlide {
        title: "MarkdownSlide {} Element"
        text: "
The body of the slide is a Text object to show Markdown.
So all the usual Qt Markdown features are supported.

- bullet points
  + nested ones
- [ ] check lists

ordinary paragraphs with *italics*, **bold**, _underlines_, ...

> block quotes

```
code block, with fixed font
```
"
    }
}
