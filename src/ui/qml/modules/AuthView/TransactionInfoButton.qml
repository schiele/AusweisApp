/**
 * Copyright (c) 2016-2026 Governikus GmbH & Co. KG, Germany
 */

import QtQuick
import QtQuick.Layouts

import Governikus.Global
import Governikus.Style
import Governikus.View

GAbstractButton {
	id: root

	property alias showDataNotRequiredText: dataNotRequiredText.visible
	property alias transactionText: contentText.text

	//: ALL_PLATFORMS
	Accessible.description: enabled ? qsTr("Show more information about the transaction.") : qsTr("Information about the transaction.")
	Accessible.name: subheading.text + ". " + contentTextMetrics.elidedText + (showDataNotRequiredText ? ". " + dataNotRequiredText.text : "")
	Accessible.role: enabled ? Accessible.Button : Accessible.StaticText
	enabled: contentText.truncated
	padding: Style.dimens.pane_padding

	background: GPaneBackground {
		Accessible.ignored: true
		border.color: colors.paneBorder
		color: colors.paneBackground

		FocusFrame {
			marginFactor: 0.8
			radius: parent.radius * 1.2
			scope: root
		}
	}
	contentItem: RowLayout {
		spacing: Style.dimens.pane_spacing

		ColumnLayout {
			spacing: Style.dimens.text_spacing

			Subheading {
				id: subheading

				Accessible.ignored: true
				//: ALL_PLATFORMS
				text: qsTr("Transactional information")
			}
			GText {
				id: contentText

				Accessible.ignored: true
				elide: Text.ElideRight
				maximumLineCount: 2
				objectName: "transactionText"
				textFormat: Text.StyledText
				visible: !!text

				TextMetrics {
					id: contentTextMetrics

					elide: contentText.elide
					elideWidth: contentText.width * contentText.maximumLineCount
					font: contentText.font
					text: contentText.text
				}
			}
			GText {
				id: dataNotRequiredText

				Accessible.ignored: true
				//: ALL_PLATFORMS
				text: qsTr("The provider mentioned above does not require any data stored on your ID card, only confirmation of you possessing a valid ID card.")
			}
		}
		TintableIcon {
			Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
			source: "qrc:///images/material_arrow_right.svg"
			sourceSize.height: Style.dimens.small_icon_size
			tintColor: contentText.color
			visible: root.enabled
		}
	}

	HoverHandler {
		id: hoverHandler

		enabled: root.enabled
	}
	StatefulColors {
		id: colors

		disabledCondition: false
		hoveredCondition: hoverHandler.hovered
		statefulControl: root
	}
}
