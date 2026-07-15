/**
 * Copyright (c) 2017-2026 Governikus GmbH & Co. KG, Germany
 */

import QtQuick
import QtQuick.Layouts

import Governikus.Native
import Governikus.Style

NativeTextInput {
	id: root

	property int enterKeyType: Qt.EnterKeyDefault // only used by GTextField

	property var textStyle: Style.text.normal

	Layout.fillWidth: true
	backgroundColor: Style.color.pane.background.basic_unchecked
	borderColor: Style.color.border
	borderRadius: Style.dimens.control_radius
	borderWidth: Style.dimens.border_width
	font.pixelSize: textStyle.textSize
	textColor: textStyle.textColor

	WindowContainer {
		Accessible.ignored: false
		anchors.fill: parent
		window: root.nativeWindow
	}
}
