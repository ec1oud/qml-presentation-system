MODULE_BASE_OUTDIR=$$[QT_INSTALL_QML]
TARGETPATH=Qt/labs/presentation

QML_FILES = \
    Clock.qml \
    CodeSlide.qml \
    HighlightingCodeSlide.qml \
    ImageSlide.qml \
    LiveCode.qml \
    LiveCodeSlide.qml \
    MarkdownSlide.qml \
    PaletteLoader.qml \
    palettes/CutePalette.qml \
    palettes/DarkPalette.qml \
    palettes/BasePalette.qml \
    palettes/LightPalette.qml \
    Presentation.qml \
    QmlCodeSlide.qml \
    Slide.qml \
    SlideCounter.qml \
    dictionaries/javascript.txt \
    dictionaries/keywords.txt \
    dictionaries/properties.txt \
    dictionaries/qml.txt

load(qml_module)
