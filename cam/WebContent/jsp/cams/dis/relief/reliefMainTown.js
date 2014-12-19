function init() {
	disFafangDs.setParameter("requiredOrganCode", organCode);
	disFafangDs.load();
	
	disShenqingDs.setParameter("requiredOrganCode", organCode);
	disShenqingDs.load();
	
	reliefInfoDs.setParameter("organCode", organCode);
	reliefInfoDs.setParameter("workflowStatus", '2,3,5,6,9,E');
	reliefInfoDs.load();
	
	reliefInfoColumnDs.setParameter("organCode", organCode);
	reliefInfoColumnDs.setParameter("workflowStatus", '2,3,5,6,9,E');
	reliefInfoColumnDs.load();
}
// 打开指定的url
function openUrls(_url) {
	var width = screen.width;
	var height = screen.height;
	var returnValue = window.showModalDialog(_url, window,
			"scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:0");
}
// 总申请
function sumNumRenderer(value, cellmeta, record, rowindex,
		colindex, dataset) {
	if (value > 0)
		return "有<a href='#' onclick=openUrls('dc/dcList.jsp')>"+value+"</a>笔业务新申请，请及时填报！";
	else
		return value + "笔业务";
}
// 冬春申请
function dcNumRenderer(value, cellmeta, record, rowindex,
		colindex, dataset) {
	if (value > 0)
		return "有<a href='#' onclick=openUrls('dc/dcList.jsp')>"+value+"</a>笔业务新申请！";
	else
		return value + "笔业务";
}
// 应急申请
function yjNumRenderer(value, cellmeta, record, rowindex,
		colindex, dataset) {
	if (value > 0)
		return "有<a href='#' onclick=openUrls('yj/yjList.jsp')>"+value+"</a>笔业务新申请！";
	else
		return value + "笔业务";
}
// 死亡申请
function swNumRenderer(value, cellmeta, record, rowindex,
		colindex, dataset) {
	if (value > 0)
		return "有<a href='#' onclick=openUrls('sw/swList.jsp')>"+value+"</a>笔业务新申请！";
	else
		return value + "笔业务";
}
// 过渡申请
function gdNumRenderer(value, cellmeta, record, rowindex,
		colindex, dataset) {
	if (value > 0)
		return "有<a href='#' onclick=openUrls('gd/gdList.jsp')>"+value+"</a>笔业务新申请！";
	else
		return value + "笔业务";
}
// 重建申请
function cjNumRenderer(value, cellmeta, record, rowindex,
		colindex, dataset) {
	if (value > 0)
		return "有<a href='#' onclick=openUrls('cj/cjList.jsp')>"+value+"</a>笔业务新申请！";
	else
		return value + "笔业务";
}
// 总发放
function sumFafangNumRenderer(value, cellmeta, record, rowindex,
		colindex, dataset) {
	if (value > 0)
		return "有<a href='#' onclick=openUrls('dc/dcList.jsp')>"+value+"</a>笔业务已发放！";
	else
		return value + "笔业务";
}
// 冬春发放
function dcFafangNumRenderer(value, cellmeta, record, rowindex,
		colindex, dataset) {
	if (value > 0)
		return "有<a href='#' onclick=openUrls('dc/dcList.jsp')>"+value+"</a>笔业务已发放！";
	else
		return value + "笔业务";
}
// 应急发放
function yjFafangNumRenderer(value, cellmeta, record, rowindex,
		colindex, dataset) {
	if (value > 0)
		return "有<a href='#' onclick=openUrls('yj/yjList.jsp')>"+value+"</a>笔业务已发放！";
	else
		return value + "笔业务";
}
// 死亡发放
function swFafangNumRenderer(value, cellmeta, record, rowindex,
		colindex, dataset) {
	if (value > 0)
		return "有<a href='#' onclick=openUrls('sw/swList.jsp')>"+value+"</a>笔业务已发放！";
	else
		return value + "笔业务";
}
// 过渡发放
function gdFafangNumRenderer(value, cellmeta, record, rowindex,
		colindex, dataset) {
	if (value > 0)
		return "有<a href='#' onclick=openUrls('gd/gdList.jsp')>"+value+"</a>笔业务已发放！";
	else
		return value + "笔业务";
}
// 重建发放
function cjFafangNumRenderer(value, cellmeta, record, rowindex,
		colindex, dataset) {
	if (value > 0)
		return "有<a href='#' onclick=openUrls('cj/cjList.jsp')>"+value+"</a>笔业务已发放！";
	else
		return value + "笔业务";
}