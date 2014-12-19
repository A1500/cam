function init() {
	cdcCaperInfoDataSet.setParameter("CAPER_ID", caperId);
	cdcCaperInfoDataSet.load();
	cdcVoluntaryInfoDataSet.setParameter("caperId", caperId);
	cdcVoluntaryInfoDataSet.load();
}
// 返回
function back() {
	window.close();
	window.returnValue = 'T';
}