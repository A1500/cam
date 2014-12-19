//
function init() {
	L5.DatasetMgr.lookup("roleDataSet").load();

	L5.QuickTips.init();
}
var res;
if(!res) res = {};
res.prompts = '提示 ';

/*
 * 查询
 */
function search(){
	 var roleDataSet = L5.DatasetMgr.lookup("roleDataSet");
	 var app = document.getElementById("appCode").value;
	 var relation = document.getElementById("relationId").value;
	 var roleName=document.getElementById("roleName").value;	
	 if(roleName!=""&&roleName.indexOf("'")!=-1){
		 L5.MessageBox.alert(res.prompts,'查询条件不能输入单引号');
			return;
	 }
	 if(app!=''){
	 	roleDataSet.setParameter("appCode",app);
	 }
	 roleDataSet.setParameter("relationId",relation);
	 roleDataSet.setParameter("roleName",roleName);
	 roleDataSet.load();
}
/*
* 重置查询
*/
function reset(){
	document.getElementById("appCode").value="";
	document.getElementById("relationId").value="";
	document.getElementById("roleName").value="";
}
/*
* 定义操作集
*/
function rolePermit_click(){
	var roleGrid = L5.getCmp("roleGrid");
	var selected = roleGrid.getSelectionModel().getSelections();
	if(selected.length != 1){
		L5.MessageBox.alert(res.prompts,'必须选择一条记录！');
		return;
	}
	var map = new L5.Map();
	map.put("method","UPDATE");
	map.put("roleId",selected[0].get("roleId"));
	map.put("appCode",selected[0].get("appCode"));
	L5.forward("jsp/bsp/eai/pap/role/role_permition.jsp",'修改',map);
}

//增加
function add_click(){
	var map = new L5.Map();
	map.put("method","INSERT");
	L5.forward("jsp/bsp/eai/pap/role/role_edit.jsp",'增加',map);
}
//修改
function update_click(){
	var roleGrid = L5.getCmp("roleGrid");
	var selected = roleGrid.getSelectionModel().getSelections();
	if(selected.length != 1){
		L5.MessageBox.alert(res.prompts,'必须选择一条记录！');
		return;
	}
	var map = new L5.Map();
	map.put("method","UPDATE");
	map.put("roleId",selected[0].get("roleId"));
	L5.forward("jsp/bsp/eai/pap/role/role_edit.jsp",'修改',map);
}
//删除
function remove_click(){
	var roleDataSet = L5.DatasetMgr.lookup("roleDataSet");
	var roleGrid = new L5.getCmp("roleGrid");
	var idArray = new Array();
	var appCodeArray = new Array();
	var selected = roleGrid.getSelectionModel().getSelections();
	if(selected.length==0){
		L5.MessageBox.alert(res.prompts,'请选择要删除的记录');
		return;
	 }
	for(var i=0;i<selected.length;i++){
		idArray[i] = selected[i].get("roleId");
		appCodeArray[i] = selected[i].get("appCode");
	}
	L5.MessageBox.confirm(res.prompts, RES_DELETE,
		function(sta){
			if(sta=="yes"){
				var command = new L5.Command("org.loushang.bsp.eai.pap.role.cmd.RoleCommand");
				command.setParameter("ids", idArray);
				command.setParameter("appCodes", appCodeArray);
				command.execute("delete");
				if (!command.error) {
					L5.MessageBox.alert(res.prompts,"删除成功");
					for(var i=0;i<selected.length;i++){
						roleDataSet.remove(selected[i]);
					}
				}else{
					L5.MessageBox.alert(res.prompts,command.error);
				}

			}else return;
		});
}
/*
* 通用帮助
*/
function forHelp(){
	var revalue=window.showModalDialog("../../../organization/getselect.jsp?rootId=rootId&showOrganType=0&organType=1&isExact=0&isCheckBox=0&isTree=1","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
		document.getElementById("relationId").value = list[2];
		document.getElementById("organName").value = list[1];
		var roleDataSet = L5.DatasetMgr.lookup("roleDataSet");
		var record = roleDataSet.getCurrent();
		record.set("relationId",list[2]);
	}
}
function forHelpApp(){
	var revalue=window.showModalDialog("../application/app_query_list.jsp","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
		document.getElementById("appCode").value = list[0];
		document.getElementById("appName").value = list[1];
		var roleDataSet = L5.DatasetMgr.lookup("roleDataSet");
		var record = roleDataSet.getCurrent();
		if(record!=undefined){
			record.set("appCode",list[0]);
		}
	}
}