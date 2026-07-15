/**
 * Copyright (c) 2014-2026 Governikus GmbH & Co. KG, Germany
 */

#include "pace/ec/EcdhGenericMapping.h"

#include "Randomizer.h"
#include "pace/ec/EcUtil.h"

#include <QtTest>

using namespace governikus;


class test_EcdhGenericMapping
	: public QObject
{
	Q_OBJECT

	private Q_SLOTS:
		void curve_data()
		{
			QTest::addColumn<int>("nid");

			QTest::newRow("with curve") << NID_brainpoolP256r1;
			QTest::newRow("without curve") << NID_undef;
		}


		void curve()
		{
			QFETCH(int, nid);

			auto curve = EcUtil::createCurve(nid);
			EcdhGenericMapping mapping(curve);
			QCOMPARE(mapping.getCurve(), curve);
			QCOMPARE(mapping.generateLocalMappingData().isEmpty(), curve.isNull());
		}


		void curveGenerator_data()
		{
			QTest::addColumn<bool>("derived");

			QTest::newRow("derived") << true;
			QTest::newRow("not derived") << false;
		}


		void curveGenerator()
		{
			QFETCH(bool, derived);

			const auto nid = NID_brainpoolP256r1;
			const auto originalCurve = EcUtil::createCurve(nid);
			EcdhGenericMapping cardMapping(originalCurve);
			const auto originalGenerator = EcUtil::point2oct(originalCurve, EC_GROUP_get0_generator(originalCurve.data()));

			if (derived)
			{
				EcdhGenericMapping terminalMapping(EcUtil::createCurve(nid));
				const auto& nonce = Randomizer::getInstance().createBytes(16);
				QVERIFY(!cardMapping.generateLocalMappingData().isEmpty());
				QVERIFY(cardMapping.generateEphemeralDomainParameters(terminalMapping.generateLocalMappingData(), nonce));
			}

			const auto curve = cardMapping.getCurve();
			const auto generator = EcUtil::point2oct(curve, EC_GROUP_get0_generator(curve.data()));
			QVERIFY(!generator.isEmpty());
			if (derived)
			{
				QCOMPARE_NE(generator, originalGenerator);
			}

			const auto key = EcUtil::generateKey(curve);
			QVERIFY(key);

#if OPENSSL_VERSION_NUMBER >= 0x30000000L && !defined(USE_LEGACY_OPENSSL_API)
			size_t bufferLength = 0;
			EVP_PKEY_get_utf8_string_param(key.data(), "group", nullptr, 0, &bufferLength);
			QByteArray groupName(bufferLength, Qt::Uninitialized);
			EVP_PKEY_get_utf8_string_param(key.data(), "group", groupName.data(), groupName.size(), &bufferLength);

			QCOMPARE(groupName, derived ? QByteArray() : QByteArrayView(OBJ_nid2sn(nid))); // modified/derived curve must be empty group name!
#endif

#if OPENSSL_VERSION_NUMBER >= 0x30000000L && !defined(USE_LEGACY_OPENSSL_API)
			EVP_PKEY_get_octet_string_param(key.data(), "generator", nullptr, 0, &bufferLength);
			QByteArray extractedGenerator(bufferLength, Qt::Uninitialized);
			EVP_PKEY_get_octet_string_param(key.data(), "generator", reinterpret_cast<uchar*>(extractedGenerator.data()), extractedGenerator.size(), &bufferLength);
#else
			QByteArray extractedGenerator(EcUtil::point2oct(curve, EC_GROUP_get0_generator(EC_KEY_get0_group(key.data()))));
#endif
			QCOMPARE(extractedGenerator.toHex(), generator.toHex());
		}


};

QTEST_GUILESS_MAIN(test_EcdhGenericMapping)
#include "test_EcdhGenericMapping.moc"
