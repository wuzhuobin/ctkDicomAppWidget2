// ctk
#include <ctkDICOMDatabase.h>

class ctkDICOMDatabase2 : public ctkDICOMDatabase {
	Q_OBJECT;
public:
	/// Insert into the database if not already exsting.
	/// @param dataset The dataset to store into the database. Usually, this is
	///                is a complete DICOM object, like a complete image. However
	///                the database also inserts partial objects, like studyl
	///                information to the database, even if no image data is
	///                contained. This can be helpful to store results from
	///                querying the PACS for patient/study/series or image
	///                information, where a full hierarchy is only constructed
	///                after some queries.
	/// @param storeFile If store file is set (default), then the dataset will
	///                  be stored to disk. Note that in case of a memory-only
	///                  database, this flag is ignored. Usually, this flag
	///                  does only make sense if a full object is received.
	/// @param @generateThumbnail If true, a thumbnail is generated.
	///
	//Q_INVOKABLE void insert(const ctkDICOMItem& ctkDataset,
	//	bool storeFile, bool generateThumbnail);
	//void insert(DcmItem *item,
	//	bool storeFile = true, bool generateThumbnail = true);
	Q_INVOKABLE void insert(const QString& filePath,
		bool storeFile = true, bool generateThumbnail = true,
		bool createHierarchy = true,
		const QString& destinationDirectoryName = QString());

};