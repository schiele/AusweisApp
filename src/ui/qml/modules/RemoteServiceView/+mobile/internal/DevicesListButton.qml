/**
 * Copyright (c) 2017-2026 Governikus GmbH & Co. KG, Germany
 */

import QtQuick

BaseDevicesListDelegate {
	Accessible.role: Accessible.Button

	Accessible.onPressAction: clicked(null)
}
