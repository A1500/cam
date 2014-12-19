function init(){
	ds.baseParams["activity_id@="]=beforeInit.actId;
	ds.setParameter("activityId",beforeInit.actId);
	ds.load();
}
function toActivity(){
	var text='环节归档实例列表';
	L5.forward("jsp/workflow/manage/queryactivityendadmin.jsp",text);
}
function addName(){
	return beforeInit.actDefName;
}
