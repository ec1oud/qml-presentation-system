CXX_MODULE = qml
TARGET  = examplehelper
MODULE_BASE_OUTDIR=$$[QT_INSTALL_QML]
TARGETPATH=Qt/labs/presentation/helper
IMPORT_VERSION = 1.0

QT += quick

SOURCES += plugin.cpp pointingfilter.cpp syntaxhighlighter.cpp qmlhighlighter.cpp
HEADERS += examplehelper.h pointingfilter.h syntaxhighlighter.h qmlhighlighter.h

load(qml_plugin)
