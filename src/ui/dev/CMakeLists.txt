###############################################
# The dev plugin provides development features.
###############################################

ADD_PLATFORM_LIBRARY(AusweisAppUiDev)

target_link_libraries(AusweisAppUiDev PRIVATE ${Qt}::Core ${Qt}::Gui ${Qt}::Qml ${Qt}::Quick AusweisAppUi AusweisAppUiQml AusweisAppGlobal)
target_compile_definitions(AusweisAppUiDev PRIVATE QT_STATICPLUGIN)

file(GLOB_RECURSE DEV_QML_FILES RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}" "qml/*.qml")

qt_add_resources(AusweisAppUiDev "dev_qml" PREFIX "/dev" BASE "${CMAKE_CURRENT_SOURCE_DIR}" FILES ${DEV_QML_FILES})
