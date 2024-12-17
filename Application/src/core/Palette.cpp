#include "Palette.h"

#include <mutex>

namespace {

const uint32_t g_layer1 = 0x557174;
const uint32_t g_layer2 = 0x9DAD7F;
const uint32_t g_layer3 = 0xC7CFB7;
const uint32_t g_layer4 = 0xF7F7E8;
const uint32_t g_layer5 = 0x000000;
const uint32_t g_layerHover1 = 0xA6C5C8;
const uint32_t g_layerHover2 = 0xC7C7C7;

const uint32_t g_border = 0xBCBCBC;

const uint32_t g_background1 = 0x3A3A3A;
const uint32_t g_background2 = 0xFFFFFF;
const uint32_t g_background3 = 0x000000;
const uint32_t g_background4 = 0xFFF9F1;
const uint32_t g_background5 = 0xF7F7E8;

const uint32_t g_error1 = 0xC94A51;

} // namespace

static std::once_flag flag;
static Palette *palette = nullptr;

Palette *Palette::instantiateQmlSingleton(QQmlEngine *engine, QJSEngine *jsEngine)
{
    Q_UNUSED(jsEngine)
    Q_UNUSED(engine)

    std::call_once(flag, [] {
        palette = new Palette();

        std::atexit([] {
            if (palette) {
                delete palette;
            }
        });
    });

    QJSEngine::setObjectOwnership(palette, QJSEngine::CppOwnership);
    return palette;
}

QColor Palette::layer1() const
{
	static auto color = QColor::fromRgb(g_layer1);
	return color;
}

QColor Palette::layer2() const
{
	static auto color = QColor::fromRgb(g_layer2);
	return color;
}

QColor Palette::layer3() const
{
	static auto color = QColor::fromRgb(g_layer3);
	return color;
}

QColor Palette::layer4() const
{
	static auto color = QColor::fromRgb(g_layer4);
	return color;
}

QColor Palette::layer5() const
{
	static auto color = QColor::fromRgb(g_layer5);
	return color;
}

QColor Palette::border() const
{
	static auto color = QColor::fromRgb(g_border);
	return color;
}

QColor Palette::layerHover1() const
{
	static auto color = QColor::fromRgb(g_layerHover1);
	return color;
}

QColor Palette::layerHover2() const
{
	static auto color = QColor::fromRgb(g_layerHover2);
	return color;
}

QColor Palette::background1() const
{
	static auto color = QColor::fromRgb(g_background1);
	return color;
}

QColor Palette::background2() const
{
	static auto color = QColor::fromRgb(g_background2);
	return color;
}

QColor Palette::background3() const
{
	static auto color = QColor::fromRgb(g_background3);
	return color;
}

QColor Palette::background4() const
{
	static auto color = QColor::fromRgb(g_background4);
	return color;
}

QColor Palette::background5() const
{
	static auto color = QColor::fromRgb(g_background5);
	return color;
}

QColor Palette::error1() const
{
	static auto color = QColor::fromRgb(g_error1);
	return color;
}

Palette::Palette(QObject *parent)
	: QObject(parent)
{
}

Palette::~Palette()
{
}
