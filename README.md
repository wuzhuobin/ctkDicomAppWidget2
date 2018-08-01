<html>
<title>README</title>
<h1>ctkDICOMAppWidget2</h1>
<p>
  Somethings changed in ctkDICOMAppWidget2. 
  <ul>
    <li>When ctkDICOMAppWidget is doing scaning a path with a lot of non-DICOM files, it will take a lot of time to print out error messages. Because it could not find out whether the file is a DICOM file before checking all its DICOM tags. I changed it that if a file is not a DICOM file, it will ignore it directly instead of checking all its DICOM tags. </li>
    <li>
      As for my another program, QVTKProject, I added a few functions for doing reading images. 
      e.g. Exporting is for emit a signal with DICOM sequences(A <code>QStringLists</code> contains all DICOM files' paths. ) for my another program to accept. Multiple selection can export a few sequences a time. 
    </li>
  </ul>
  <h2>CTK CMake configure cache arguements for reference</h2>
  <code>-DCMAKE_CXX_MP_FLAG:BOOL=ON</code><br>
  <code>-DBUILD_DOCUMENTATION:BOOL=OFF </code><br>
  <code>-DCTK_BUILD_EXAMPLES:BOOL=OFF </code><br>
  <code>-DCTK_BUILD_SHARED_LIBS:BOOL=${BUILD_SHARED_LIBS} </code><br>
  <code>-DBUILD_TESTING:BOOL=OFF </code><br>
  <code># -DCTK_APPctkDICOM:BOOL=ON </code><br>
  <code># -DCTK_APPctkDICOM2:BOOL=ON </code><br>
  <code>-DCTK_ENABLE_DICOM:BOOL=ON </code><br>
  <code>-DCTK_LIB_DICOM/Core:BOOL=ON </code><br>
  <code>-DCTK_LIB_DICOM/Widgets:BOOL=ON </code><br>
  <code>-DCTK_QT_VERSION:STRING=5 </code><br>
  <code>-DQt5_DIR:PATH=${Qt5_DIR} </code><br>
  The above arguements was tried in MSVC2015 and GCC 6.3 and succeed. 
</p>
</html>