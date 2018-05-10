#include "ctkDICOMDatabase2.h"

//void ctkDICOMDatabase2::insert(const ctkDICOMItem & ctkDataset, bool storeFile, bool generateThumbnail)
//{
//}
//
//void ctkDICOMDatabase2::insert(DcmItem * item, bool storeFile, bool generateThumbnail)
//{
//}

void ctkDICOMDatabase2::insert(const QString & filePath, bool storeFile, bool generateThumbnail, bool createHierarchy, const QString & destinationDirectoryName)
{
	if (filePath.contains("nii")) {
		qDebug() << "nii";
		return;
	}
	ctkDICOMDatabase::insert(filePath, storeFile, generateThumbnail, createHierarchy, destinationDirectoryName);

}