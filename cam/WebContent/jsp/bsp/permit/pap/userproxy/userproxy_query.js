var page;
if(!page) page = {};
page.enums = {
	0:'全代理',
	1:'部分代理',
	2:'内置代理'
}
function rendererName(value){
	var v = page.enums[value];
	if(v==undefined){
		return "全代理";
	}
	return v?v:value;
}
/*
 *
 */
function init() {
	var userproxyDataSet = L5.DatasetMgr.lookup("userproxyDataSet");
	userproxyDataSet.load();
	L5.QuickTips.init();
}

/*
 * 增加_代理
 */
function add_click() {
	L5.forward("jsp/bsp/permit/pap/userproxy/userproxy.jsp?pageMode=1",title);
}
/*
 * 修改_代理
 */
function edit_click(){
	var title = '编辑代理';
	var userproxyGrid = new L5.getCmp("userproxyGrid");
	var selected = userproxyGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
	   L5.MessageBox.alert(RES_PROMOT,"请选择一条记录");
	}else {
	  var rcd = userproxyDataSet.getCurrent();
	  var url = '&proxyUserId=' + rcd.get('proxyuserid');

		url += '&proxyType=' + rcd.get('proxytype');
	 L5.forward("jsp/bsp/permit/pap/userproxy/userproxy.jsp?pageMode=3"+url,title);
	}

}
/*
 * 删除_代理
 */
function remove_click() {
	var userproxyDataSet = L5.DatasetMgr.lookup("userproxyDataSet");
	//代理人
	var proxyUserArray = new Array();
	//代理权限
	var proxyTypeArray = new Array();
	var userproxyGrid = new L5.getCmp("userproxyGrid");
	var selected = userproxyGrid.getSelectionModel().getSelections();
	if(selected.length==0){
		L5.MessageBox.alert(RES_PROMOT,ASK_SELETE_DELETE);
		return false;
	}
	for(var i=0;i<selected.length;i++){
		proxyUserArray[i] = selected[i].get("proxyuserid");
		proxyTypeArray[i] = selected[i].get("proxytype");
	}
	L5.MessageBox.confirm(RES_PROMOT, RES_DELETE,
	function(sta){
		if(sta=="yes"){
			var command = new L5.Command("org.loushang.bsp.permit.pap.userproxy.cmd.UserProxyCommand");
			command.setParameter("proxyUserArray", proxyUserArray);
			command.setParameter("proxyTypeArray", proxyTypeArray);
			command.execute("deleteUserProxy");
			if (!command.error) {
				for(var i=0;i<selected.length;i++){
					userproxyDataSet.remove(selected[i]);
				}
				L5.MessageBox.alert(RES_PROMOT,"删除成功");
				return;
			}else{
				L5.MessageBox.alert(RES_PROMOT,command.error);
				return;
			}
		}else return;
	});

}