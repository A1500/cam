//阻止页面超时，该js中不要加其他方法，特别是ext外部单位登陆相关页面不要引用该js
setInterval("refreshSession()",60000*10);
function refreshSession(){
	var command = new L5.Command("com.inspur.cams.comm.util.RefreshSession");
	command.execute("refresh");
}
