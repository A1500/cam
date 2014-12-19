var page;
if(!page) page={};
page.prompt='提示';
page.struNameMap={} ;
function init() {
	if(_includeRoleInSubStru) {
		var cmd = new L5.Command('org.loushang.bsp.permit.pap.role.cmd.RoleCommand');
		cmd.setParameter('topStruId',_struId);
		cmd.execute('queryAllRole');
		
		struNameMap = cmd.getReturn('struname');
		struNameMap = struNameMap.replace(/=/g,":\"");
		struNameMap = struNameMap.replace(/,/g,"\",");
		struNameMap = struNameMap.replace(/}/g,"\"}");
		struNameMap = "("+struNameMap+")";
		page.struNameMap = eval(struNameMap);
		var leng = roleDataset.getCount();
		//触发renderer
		for(var i=0; i<leng; i++) {
			var r = roleDataset.getAt(i);
			r.set('roleGroupId',r.get('roleGroupId')+"#");
		}
		} else {
		 roleDataset.setParameter('relation_id@=',_struId);	
		 roleDataset.load();
	 }
	
}
function confirmValue(){
	var selected=L5.getCmp('rolePanel').getSelectionModel()
	.getSelections();
	var leng = selected.length;
	var ret  ="";
	if(leng  < 1) {
		L5.MessageBox.alert(page.prompt,"没有选择角色");
		return;
	}
	for(var i=0; i<leng-1; i++) {
		var r = selected[i];
		ret +=r.get('roleId')+";"+r.get('roleName')+",";
	}
	ret +=selected[leng-1].get('roleId')+";"+selected[leng-1].get('roleName');
	closeDig();
}
function closeDig(){
	window.returnValue="";
	window.close();
}
function relationName(value) {
	var name = page.struNameMap[value];
	 name = name===undefined?value:name;
	return name;
}