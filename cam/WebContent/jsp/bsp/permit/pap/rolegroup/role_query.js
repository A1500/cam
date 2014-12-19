
/*
 * 
 */
function init() {
	var dataset = L5.DatasetMgr.lookup("roleDataSet");
	dataset.baseParams["roleGroupId"]=roleGroupId;
	dataset.load();
	roleGroupName = unescape(roleGroupName);
	L5.QuickTips.init();
}

/*
* 转到增加页面
*/
function add_click(){
	var map = new L5.Map();
	map.put("method","INSERT");
	map.put("roleGroupId",encodeURIComponent(encodeURIComponent(roleGroupId)));
	map.put("roleGroupName",encodeURIComponent(encodeURIComponent(roleGroupName)));
	L5.forward("jsp/bsp/permit/pap/role/role_edit.jsp",definition_role,map);
}
/**
 * 
 */
function back_click(){
	L5.forward('/jsp/bsp/permit/pap/rolegroup/rolegroup_query.jsp','角色组管理');
}
/*
* 转到修改页面
*/
function update_click(){
	var roleGrid = new L5.getCmp("roleGrid");
	var selected = roleGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.MessageBox.alert(RES_PROMOT,ALERT_SELECT_ONE);
		return false;
	}
	var map = new L5.Map();
	map.put("method","UPDATE");
	map.put("roleGroupId",encodeURIComponent(encodeURIComponent(roleGroupId)));
	map.put("primeKey",encodeURIComponent(encodeURIComponent(selected[0].get("roleId"))));
	map.put("roleGroupName",encodeURIComponent(encodeURIComponent(roleGroupName)));
	L5.forward("jsp/bsp/permit/pap/role/role_edit.jsp",definition_role,map);
}

/*
* 删除
*/
function remove_click(){
	var roleDataSet = L5.DatasetMgr.lookup("roleDataSet");
	var roleGrid = new L5.getCmp("roleGrid");
	var array = new Array();
 	var selected = roleGrid.getSelectionModel().getSelections();
	if(selected.length==0){
			L5.MessageBox.alert(RES_PROMOT,'没有选择记录');
			return false;
	}
	for(var i=0;i<selected.length;i++){
		array[i] = selected[i].get("roleId");
	}
	L5.MessageBox.confirm(RES_PROMOT, RES_DELETE,
		function(sta){
			if(sta=="yes"){
					var command = new L5.Command("org.loushang.bsp.permit.pap.role.cmd.RoleCommand");
					command.setParameter("delIds", array);
					command.execute("validateDelete");
					var retMes = command.getReturn("return");
					if(retMes.size()>0){//存在正在被使用的
						var mes = '';
						for(var num=0;num<retMes.size();num++){
							for(var i=0;i<selected.length;i++){
								if(retMes.get(num)==selected[i].get("roleId")){
									if(mes==''){
										mes += selected[i].get("roleName");
									}else{
										mes += ';' + selected[i].get("roleName");
									}
								}
							}
						}
						L5.MessageBox.alert(RES_PROMOT,"'"+mes+"'"+alert_delete_mes);
					}else{
						command.execute("delete");
						if (!command.error) {
							for(var i=0;i<selected.length;i++){
								roleDataSet.remove(selected[i]);		    	
							}
						}else{
							L5.MessageBox.alert(RES_PROMOT,command.error);
						}
					}
			}else return;
		});
}

/*
* 查询
*/
function search(){
	var dataset = L5.DatasetMgr.lookup("roleDataSet");
	if(document.getElementById("name").value!=''){
		dataset.setParameter("roleName", document.getElementById("name").value);
	}
	dataset.setParameter("roleGroupId",roleGroupId);
	dataset.load();
}