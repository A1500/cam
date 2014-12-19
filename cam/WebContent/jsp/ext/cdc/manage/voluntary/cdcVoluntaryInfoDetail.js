function init() {
	cdcVoluntaryInfoDataSet.setParameter("VOLUNTARY_ID", voluntaryId);
	cdcVoluntaryInfoDataSet.on('load', function() {
				if (cdcVoluntaryInfoDataSet.getCount() > 0) {
					var photoId = cdcVoluntaryInfoDataSet.getAt(0)
							.get("photoId");
					if (photoId != '') {
						document.getElementById("img").src = L5.webPath
								+ "/download?table=COM_PHOTO_"
								+ photoId.substring(0, 6)
								+ "&column=PHOTO_CONTENT&pk=PHOTO_ID&PHOTO_ID='"
								+ photoId + "'";
					}
				}
			});
	cdcVoluntaryInfoDataSet.load();
}
// 返回
function back() {
	window.close();
	window.returnValue = 'T';
}