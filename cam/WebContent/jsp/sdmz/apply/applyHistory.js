/**
	 * 初始化
	 * @param 
	 * @return
	 */
function init() {
	var grid=L5.getCmp('editGridPanel');
	
	
	L5.DatasetMgr.lookup("ds").load();
	
};
/**
	 * 返回跳转页面
	 * @param 
	 * @return
	 */
function returnPage(){
	var re=returnPage1;
	var url='jsp/sdmz/apply/'+re;
	L5.forward(url);
}
