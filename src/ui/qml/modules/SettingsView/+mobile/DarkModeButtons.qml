/**
 * Copyright (c) 2023-2024 Governikus GmbH & Co. KG, Germany
 */
import QtQuick
import QtQuick.Layouts
import Governikus.Global
import Governikus.Type

ColumnLayout {
	id: root

	readonly property var checkedButton: system.mode === SettingsModel.userDarkMode ? system : dark.mode === SettingsModel.userDarkMode ? dark : light
	readonly property string selectedIconPath: checkedButton.image
	readonly property string selectedText: checkedButton.title

	signal buttonClicked
	signal receivedFocus(var pItem)

	function onAppearanceButtonClicked(mode) {
		if (SettingsModel.userDarkMode === mode)
			return;
		SettingsModel.userDarkMode = mode;
		root.buttonClicked();
	}

	spacing: 0

	Component.onCompleted: {
		if (!UiPluginModel.osDarkModeSupported)
			system.visible = false;
	}

	GCollapsibleSubButton {
		id: system

		readonly property var mode: SettingsModel.ModeOption.AUTO

		//: LABEL ALL_PLATFORMS
		Accessible.description: qsTr("Set the app appearance to system mode")
		Layout.fillWidth: true
		image: "qrc:///images/appearance_system_mode.svg"
		tintIcon: true
		//: LABEL ALL_PLATFORMS
		title: qsTr("System")

		onClicked: root.onAppearanceButtonClicked(mode)
		onFocusChanged: if (focus)
			root.receivedFocus(this)
	}
	GCollapsibleSubButton {
		id: dark

		readonly property var mode: SettingsModel.ModeOption.ON

		//: LABEL ALL_PLATFORMS
		Accessible.description: qsTr("Set the app appearance to dark mode")
		Layout.fillWidth: true
		image: "qrc:///images/appearance_dark_mode.svg"
		tintIcon: true
		//: LABEL ALL_PLATFORMS
		title: qsTr("Dark")

		onClicked: root.onAppearanceButtonClicked(mode)
		onFocusChanged: if (focus)
			root.receivedFocus(this)
	}
	GCollapsibleSubButton {
		id: light

		readonly property var mode: SettingsModel.ModeOption.OFF

		//: LABEL ALL_PLATFORMS
		Accessible.description: qsTr("Set the app appearance to light mode")
		Layout.fillWidth: true
		image: "qrc:///images/appearance_light_mode.svg"
		tintIcon: true
		//: LABEL ALL_PLATFORMS
		title: qsTr("Light")

		onClicked: root.onAppearanceButtonClicked(mode)
		onFocusChanged: if (focus)
			root.receivedFocus(this)
	}
}
