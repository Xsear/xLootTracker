# Version
ADDON_VERSION = v1.14
ADDON_NAME = xLootTracker

# Paths
PATH_DEV = D:/Documents/Firefall/Addons/xLootTracker
PATH_DEV_WIN = D:\Documents\Firefall\Addons\xLootTracker

PATH_PROJECT = D:/Firefall/My Addons/xLootTracker
PATH_PROJECT_WIN = D:\Firefall\My Addons\xLootTracker

PATH_DROPBOX = D:/Dropbox/Public/Firefall/xLT
PATH_DROPBOX_WIN = D:\Dropbox\Public\Firefall\xLT

PATH_DROPBOX_HTTP = https://dl.dropbox.com/u/9714858/Firefall/xLT

PATH_DERIVED_FILES = ${PATH_PROJECT}/${ADDON_VERSION}/${ADDON_NAME}
PATH_DERIVED_FILES_WIN = ${PATH_PROJECT_WIN}\${ADDON_VERSION}\${ADDON_NAME}

PATH_DERIVED_ARCHIVES = ${PATH_PROJECT}/${ADDON_VERSION}
PATH_DERIVED_ARCHIVES_WIN = ${PATH_PROJECT_WIN}\${ADDON_VERSION}

PATH_DERIVED_ARCHIVE_FILENAME = ${PATH_DERIVED_ARCHIVES}/${ADDON_NAME}_${ADDON_VERSION}
PATH_DERIVED_ARCHIVE_FILENAME_WIN = ${PATH_DERIVED_ARCHIVES_WIN}\${ADDON_NAME}_${ADDON_VERSION}
PATH_DERIVED_ARCHIVE_FILENAME_HTTP = ${PATH_DROPBOX_HTTP}/${ADDON_NAME}_${ADDON_VERSION}

# Xcopy Files
XCOPY_FILES_IGNORE = Ignore

# Xcopy Flags
# /E = Copy dirs and subdirs, including empty
# /F = Display full paths when copying
# /I = Assume copying dir if dest does not exist and more than one source
# /K = Copy attributes
# last time I did this without /K but that was probably not the reason it worked so I added it back
XCOPY_FLAGS_FILES = /E/F/I/K/EXCLUDE:${XCOPY_FILES_IGNORE}
#XCOPY_FLAGS_ARCHIVES = /F

# Rules
release:
	@echo [Begin] [Release] [${ADDON_VERSION}]
	@echo [Copying Files]
	xcopy "${PATH_DEV_WIN}" "${PATH_DERIVED_FILES_WIN}" ${XCOPY_FLAGS_FILES}
	@echo [Creating Archives]
	7z.exe a "${PATH_DERIVED_ARCHIVE_FILENAME_WIN}.7z" "${PATH_DERIVED_FILES_WIN}"
	7z.exe a "${PATH_DERIVED_ARCHIVE_FILENAME_WIN}.zip" "${PATH_DERIVED_FILES_WIN}"
	@echo [Copying to Dropbox]
	xcopy "${PATH_DERIVED_ARCHIVE_FILENAME_WIN}.7z" "${PATH_DROPBOX_WIN}"
	xcopy "${PATH_DERIVED_ARCHIVE_FILENAME_WIN}.zip" "${PATH_DROPBOX_WIN}"
	@echo [Outputting Dropbox Links]
	@echo ${PATH_DERIVED_ARCHIVE_FILENAME_HTTP}.7z
	@echo ${PATH_DERIVED_ARCHIVE_FILENAME_HTTP}.zip
	@echo [Success] [Release] [${ADDON_VERSION}]