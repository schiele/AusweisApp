/**
 * Copyright (c) 2026 Governikus GmbH & Co. KG, Germany
 */

#include "NativeTextInput.h"

class NativeTextInputPrivate
{
};


NativeTextInput::NativeTextInput(QQuickItem* pParent)
	: QQuickItem(pParent)
	, d(new NativeTextInputPrivate())
{
}


NativeTextInput::~NativeTextInput() = default;


QFont NativeTextInput::font() const
{
	return QFont();
}


void NativeTextInput::setFont(const QFont& pFont) //NOSONAR
{
	Q_UNUSED(pFont)
}


QColor NativeTextInput::textColor() const
{
	return QColor();
}


void NativeTextInput::setTextColor(QColor pColor) //NOSONAR
{
	Q_UNUSED(pColor)
}


QColor NativeTextInput::backgroundColor() const
{
	return QColor();
}


void NativeTextInput::setBackgroundColor(QColor pColor) //NOSONAR
{
	Q_UNUSED(pColor)
}


QColor NativeTextInput::borderColor() const
{
	return QColor();
}


void NativeTextInput::setBorderColor(QColor pColor) //NOSONAR
{
	Q_UNUSED(pColor)
}


qreal NativeTextInput::borderWidth() const
{
	return 0;
}


void NativeTextInput::setBorderWidth(qreal pWidth) //NOSONAR
{
	Q_UNUSED(pWidth)
}


qreal NativeTextInput::borderRadius() const
{
	return 0;
}


void NativeTextInput::setBorderRadius(qreal pRadius) //NOSONAR
{
	Q_UNUSED(pRadius)
}


int NativeTextInput::maximumLength() const
{
	return 0;
}


void NativeTextInput::setMaximumLength(int pLength) //NOSONAR
{
	Q_UNUSED(pLength)
}


QString NativeTextInput::text() const
{
	return QString();
}


void NativeTextInput::setText(const QString& pText) //NOSONAR
{
	Q_UNUSED(pText)
}


QWindow* NativeTextInput::nativeWindow() const
{
	return nullptr;
}


void NativeTextInput::onParentChanged() //NOSONAR
{
}


void NativeTextInput::updateEffectiveOpacity() //NOSONAR
{
}
