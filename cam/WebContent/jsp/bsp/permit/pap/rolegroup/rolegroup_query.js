//
function init() {
	L5.DatasetMgr.lookup("roleGroupDataSet").load();

	L5.QuickTips.init();
}
var res;
if(!res) res = {};
res.prompts = '提示 ';
//明细
function detail_click(){
	var roleGroupGrid = new L5.getCmp("roleGroupGrid");
	var selected = roleGroupGrid.getSelectionModel().getSelections();
	if(selected.length != 1){
		L5.MessageBox.alert(res.prompts,ALERT_SELECT_ONE);
		return;
	}
	var map = new L5.Map();
	var roleGroupId = encodeURI(encodeURI(selected[0].get("roleGroupId")));
	var roleGroupName = encodeURI(encodeURI(selected[0].get("roleGroupName")));
	var struId= encodeURI(encodeURI(selected[0].get("corporation")));
	map.put("roleGroupId",roleGroupId);
	map.put("roleGroupName",roleGroupName);
	map.put("struId",struId);
	L5.forward("jsp/bsp/permit/pap/rolegroup/role_query.jsp",ROLE_QUERY,map);
}

//增加
function add_click(){
    var command = new L5.Command("org.loushang.bsp.permit.pap.user.cmd.UserCmd");
    command.execute("getCorpNameOfLoginUser");
    var corpName=command.getReturn("organName");
    var corpId=command.getReturn("struId");
	var map = new L5.Map();
	map.put("method","INSERT");
	map.put("corpName",encodeURI(encodeURI(corpName)));
	map.put("corpId",encodeURI(encodeURI(corpId)));
	L5.forward("jsp/bsp/permit/pap/rolegroup/rolegroup_edit.jsp",rolegroup_add,map);
}

//修改
function update_click(){
	var roleGroupGrid = L5.getCmp("roleGroupGrid");
	var selected = roleGroupGrid.getSelectionModel().getSelections();
	if(selected.length != 1){
		L5.MessageBox.alert(res.prompts,ALERT_SELECT_ONE);
		return;
	}
	var map = new L5.Map();
	map.put("method","UPDATE");
	var roleGroupId = encodeURI(encodeURI(selected[0].get("roleGroupId")));
	var roleGroupName = encodeURI(encodeURI(selected[0].get("corporationName")));

	map.put("roleGroupId",roleGroupId);
	map.put("roleGroupName",roleGroupName);
	L5.forward("jsp/bsp/permit/pap/rolegroup/rolegroup_edit.jsp",rolegroup_add,map);
}

//删除
function remove_click(){
	var roleGroupDataSet = L5.DatasetMgr.lookup("roleGroupDataSet");
	var roleGroupGrid = new L5.getCmp("roleGroupGrid");
	var array = new Array();
 	var selected = roleGroupGrid.getSelectionModel().getSelections();
	if(selected.length==0){
		L5.MessageBox.alert(res.prompts,'请选择要删除的记录');
		return;
	}
	for(var i=0;i<selected.length;i++){
		array[i] = selected[i].get("roleGroupId");
	}
	L5.MessageBox.confirm(RES_PROMOT, RES_DELETE,
		function(sta){
			if(sta=="yes"){
					var command = new L5.Command("org.loushang.bsp.permit.pap.rolegroup.cmd.RoleGroupCmd");
					command.setParameter("ids", array);
					command.execute("delete");
						if (!command.error) {
						    L5.MessageBox.alert(res.prompts,"删除成功");
							for(var i=0;i<selected.length;i++){
								roleGroupDataSet.remove(selected[i]);
							}
						}else{
							L5.MessageBox.alert(res.prompts,command.error);
						}
					//}

			}else return;
		});

}

//定义角色
function addrole_click(){
	var roleGroupGrid = L5.getCmp("roleGroupGrid");
	var selected = roleGroupGrid.getSelectionModel().getSelections();
	if(selected.length !=1){
		L5.MessageBox.alert(res.prompts,ALERT_SELECT_ONE);
		return false;
	}
	var map = new L5.Map();
	map.put("method","INSERT");
	map.put("roleGroupId",selected[0].get("roleGroupId"));
	map.put("roleGroupName",encodeURI(encodeURI(selected[0].get("roleGroupName"))));
	L5.forward("jsp/bsp/permit/pap/role/role_edit.jsp",definition_role,map);
}

/*
 * 查询
 */
function search(){
	 var roleGroupDataSet = L5.DatasetMgr.lookup("roleGroupDataSet");
	 var name = document.getElementById("name").value
	 name=name.replace("'", " ");
	 document.getElementById("name").value=name.trim();
	 if(name!=''){
		if(name.indexOf("'")!=-1){//如果包括单引号
			L5.MessageBox.alert(res.prompts,"查询条件中不能包含单引号字符");
		    return;
		}else{
			roleGroupDataSet.setParameter("ROLE_GROUP_NAME",name);
		}
	 }
	 roleGroupDataSet.load();
}

/*
 * 重置查询
 */
function reset(){
	document.getElementById("name").value="";
}