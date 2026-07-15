/**
 * Copyright (c) 2022-2026 Governikus GmbH & Co. KG, Germany
 */

#include "PortWrapper.h"

#include "PortFile.h"

#include <QFile>
#include <QLoggingCategory>


using namespace governikus;


Q_DECLARE_LOGGING_CATEGORY(rproxy)


PortWrapper::PortWrapper(quint16 pLocalPort, quint16 pPeerPort)
	: mPorts()
{
	Q_UNUSED(pPeerPort)

	const auto& portFiles = PortFile::getAllPortFiles();
	for (const auto& portFile : portFiles)
	{
		const auto& filename = portFile.absoluteFilePath();
		const auto port = readPortFile(filename);

		if (port < 1)
		{
			qCWarning(rproxy) << "Ignore invalid port file:" << filename;
			continue;
		}

		if (port != pLocalPort)
		{
			mPorts << port;
		}
	}

	qCDebug(rproxy) << "Found instances on Ports:" << mPorts;
}


quint16 PortWrapper::readPortFile(const QString& pFile)
{
	QFile portfile(pFile);
	if (portfile.exists() && portfile.open(QIODevice::ReadOnly | QIODevice::Unbuffered))
	{
		return static_cast<quint16>(portfile.readAll().toInt());
	}

	return 0;
}
