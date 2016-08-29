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
#include <QtQml>

#ifndef EXAMPLEHELPER_H
#define EXAMPLEHELPER_H

class ExampleHelper: public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString source READ source WRITE setSource NOTIFY sourceChanged)
    Q_PROPERTY(QString content READ content NOTIFY contentChanged)
    Q_PROPERTY(QString sourcePath READ sourcePath NOTIFY sourcePathChanged)

    QString m_source;
    QString m_content;
    QString m_sourcePath;

public:

    QString source() const
    {
        return m_source;
    }

    QString sourcePath() const
    {
        return m_sourcePath;
    }

    QString content() const
    {
        return m_content;
    }

public slots:
    void setSource(const QString &path)
    {
        if (m_source == path)
            return;

        m_source = path;
        emit sourceChanged(path);

        QFile file(path);
        if (!file.open(QFile::ReadOnly)) {
            qWarning() << "Could not read file: " << path;
            return;
        }

        m_sourcePath = QFileInfo(m_source).absoluteFilePath();
        emit sourcePathChanged(m_sourcePath);

        m_content = QString::fromUtf8(file.readAll());
        emit contentChanged(m_content);
    }

signals:
    void sourceChanged(const QUrl &arg);
    void sourcePathChanged(const QUrl &arg);
    void contentChanged(const QString &arg);
};

#endif
