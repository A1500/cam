function init() {
	L5.DatasetMgr.lookup("menuTypeDataSet").load();
	L5.getCmp("menusystypeGrid").show();
	L5.QuickTips.init();
}

var RowSelect=function(sm,rowIndex,record){
	//alert(record.get("menuTypeId"));
}

//增加按钮
function add_click(){
	menuTypeDataSet.newRecord({isSysDefault:'0',isSys:'0'});
	menuTypeDataSet.moveLast();
}

//应用菜单
function app_menu(){
	var menusystypeGrid=L5.getCmp('menusystypeGrid');
	var selected = menusystypeGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.MessageBox.alert(RES_PROMOT,'请选择要使用的菜单');
		return false;
	}
	var menuIds=new Array();
		menuIds[0]=selected[0].get('menuTypeId');
	var command=new L5.Command("org.loushang.bsp.permit.menu.cmd.MenuTypeCmd");
	command.setParameter("currentMenuId",menuIds);
	command.execute("appMenu");
	menuTypeDataSet.load();


}

//删除
function remove_click(){
	var menusystypeGrid=L5.getCmp('menusystypeGrid');
	var selected = menusystypeGrid.getSelectionModel().getSelections();
	//alert(selected);
	if(selected.length<1){
		L5.MessageBox.alert(RES_PROMOT,'请选择要删除的记录');
		return false;
	}
	L5.MessageBox.confirm(RES_PROMOT, RES_DELETE,
			function(sta){
				if(sta=="yes"){
					var menuSysTypeIds=[];
					for(var i=0;i<selected.length;i++){
						menuSysTypeIds[i]=selected[i].get("menuTypeId");
					}
					var command=new L5.Command("org.loushang.bsp.permit.menu.cmd.MenuTypeCmd");
					command.setParameter("menuSysTypeId", menuSysTypeIds);
					command.execute("delete");
					if (!command.error) {
						for(var i=0;i<selected.length;i++){
							menuTypeDataSet.remove(selected[i]);
						}
					}else{
						L5.MessageBox.alert(RES_PROMOT,command.error);
					}
				}
				else return ;
			}
		);
}

//对是否当前应用菜单进行校验，有且仅有一个当前应用菜单
function validIsSysDefault(){

}

//保存
function save_click(){
	//对是否当前应用菜单进行校验，有且仅有一个当前应用菜单
	var validMsg=validate_default();
	if(validMsg!=null){
		L5.Msg.alert('提示',validMsg);
		return false;
	}
	var validName=validate_name();
	//var msg = menuTypeDataSet.isValidate();
	//if(msg !== true){
	if(validName!=null){
		L5.Msg.alert('提示',validName);
		return false;
	}
	var records = menuTypeDataSet.getAllChangedRecords();
	if(records.length<1){
		L5.Msg.alert(RES_PROMOT,RES_NOCHANGE);
		return false;
	}
//	var valid = menuTypeDataSet.isValidate();
//	if(valid!=true){
//		L5.Msg.alert(RES_PROMOT,RES_UNVALIDATED+valid);
//		return false;
//	}=]
	var command = new L5.Command("org.loushang.bsp.permit.menu.cmd.MenuTypeCmd");
	command.setParameter("records", records);
	command.execute("save");
	if (!command.error) {
		menuTypeDataSet.commitChanges();
		L5.Msg.alert(RES_PROMOT,RES_SAVE);
		L5.DatasetMgr.lookup("menuTypeDataSet").load();
	}else{
		L5.Msg.alert(RES_PROMOT,command.error);
	}

}

//取消
function undo_click(){
	menuTypeDataSet.rejectChanges();
}

//菜单维护
function manage_menu(){
	var menusystypeGrid=L5.getCmp('menusystypeGrid');
	var selected = menusystypeGrid.getSelectionModel().getSelections();
	//alert(selected.length);
	if(selected.length!=1){
		L5.Msg.alert(RES_PROMOT,ALERT_SELECT_ONE);
		return false;
	}
	var records =selected[0];
	if(records.state=="1"){
		L5.Msg.alert('提示',"所选菜单类型未保存，不能进行维护操作！");
		return false;
	}
	var menuTypeName=selected[0].get("menuTypeName")
	menuTypeName = encodeURI(encodeURI(menuTypeName));
	var map = new L5.Map();
	map.put("menuTypeId",selected[0].get("menuTypeId"));
	map.put("menuTypeName",menuTypeName);
	map.put("isSys",selected[0].get("isSys"));
	map.put("isSysDefault",selected[0].get("isSysDefault"));
	L5.forward("jsp/bsp/permit/menu/menusys/menu_tree.jsp",MENU_TREE_MANAGER,map);
}

function select_click(src){
	//alert(src.value);
	//src.value = 1;
}

//checkbox的联动
function setisSysDefault(src){
	var records = menuTypeDataSet.getCurrent();
	if(src.checked){
		src.value = '1';
		records.set("isSysDefault","1");
	}else{
		records.set("isSysDefault","0");
	}
}

/*
 * 是否系统使用只能有一个为是
 */
function validate_default(){
	var menusystypeGrid=L5.getCmp('menusystypeGrid');
	var count=menuTypeDataSet.getCount();
	var k=0;
	for(var i=0;i<count;i++){
		var sys_default=L5.isIE?menusystypeGrid.getView().getCell(i,3).innerText:menusystypeGrid.getView().getCell(i,3).textContent;
		if(sys_default=="是"){
			k++;
		}
	}
	if(k>1 || k==0){
		return "有且仅有一套菜单是当前应用的默认菜单";
	}
}

function validate_name(){
	var menusystypeGrid=L5.getCmp('menusystypeGrid');
	var count=menuTypeDataSet.getCount();
	var k=0;
	for(var i=0;i<count;i++){
		var menuTypeName=L5.isIE?menusystypeGrid.getView().getCell(i,2).innerText:menusystypeGrid.getView().getCell(i,2).textContent;
		if(menuTypeName.trim()=="" || menuTypeName.trim()==" "){
			k++;
		}
	}
	if(k>0){
		return "菜单分类名称不能为空";
	}
}

/*
function do_default(src){
//	getValue

	var command = new L5.Command("org.loushang.bsp.permit.menu.cmd.MenuTypeCmd");
	command.execute("getSysDefaultMenu");
	var menuTypeId = command.getReturn("menuTypeId");
	var record = menuTypeDataSet.getCurrent();
	//if(menuTypeId!=record.get("menuTypeId")){
		//alert("系统默认使用菜单只能存在一个!");
	//}
	var menusystypeGrid=L5.getCmp('menusystypeGrid');
	var count=menuTypeDataSet.getCount();
	for(var i=0;i<count;i++){
		alert(menusystypeGrid.getView().getCell(i,3).value);
	}
	//var selected = menusystypeGrid.getSelectionModel().getSelections();

}
*/
//导出菜单类型
function exportMenu(e){
	var editGrid=L5.getCmp('menusystypeGrid');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length==0){
		L5.Msg.alert('提示',"请选择一条要导出的记录!");
		return false;
	}else if(selected.length>1){
		L5.Msg.alert('提示',"只能选择一条记录导出!");
		return false;
	}
	var record=selected[0];
	var path=window.showModalDialog("../../../id/selectexport.jsp","","dialogHeight:550px;dialogWidth:500px;resizable:no;scroll:yes;dialogLeft:"+(window.screen.width-300)/2+";dialogTop:"+(window.screen.height-400)/2);
	if(path!=undefined&&path!=""){
		if(path.indexOf(":")==0){
			L5.Msg.alert("提示","请选择正确的文件目录");
			return;
		}
		L5.getCmp('menusystypeGrid').hide();
		L5.getCmp('dao').show();
		var panel=L5.getCmp('dao');
//		e.stopEvent();
		loadExportPage(panel,record,path);
	}
}

//菜单导出时加载
function loadExportPage(panel,record,path) {	
	var menuTypeId=record.get("menuTypeId");
	var iframes=panel.body.query('iframe');
	var loading=L5.fly('loadmask',panel.body);
	loading.setStyle("display","block");
	iframes[0].style.visibility="hidden";
	iframes[0].onload=iframes[0].onreadystatechange=function(){
	if(this.readyState=="complete"||!this.readyState){
		(function(){
			loading.dom.style.display="none";
			iframes[0].style.visibility="visible";
		}).defer(50);
		}
	}
	menuTypeId = encodeURI(encodeURI(menuTypeId));
	path= encodeURI(encodeURI(path));
	var url="../../pap/function/exportInfo.jsp?menuTypeId="+menuTypeId+"&path="+path+"&dataType=menuType";
	iframes[0].src =url;
}

//菜单导入
function importMenu(){
	var path=window.showModalDialog("../../../id/selectexport.jsp","","dialogHeight:550px;dialogWidth:500px;resizable:no;scroll:yes;dialogLeft:"+(window.screen.width-300)/2+";dialogTop:"+(window.screen.height-400)/2);
	if(path!=undefined&&path!=""){
		if(path.indexOf(":")==0){
			L5.Msg.alert("提示","请选择正确的文件目录");
			return;
		}
		L5.getCmp("menusystypeGrid").hide();
		L5.getCmp("dao").show();
		var panel=L5.getCmp('dao');
		loadImportPage(panel,path);
	}		
}

//组织导入时加载
function loadImportPage(panel,path) {
		var iframes=panel.body.query('iframe');
		var loading=L5.fly('loadmask',panel.body);
		loading.setStyle("display","block");
		iframes[0].style.visibility="hidden";
		iframes[0].onload=iframes[0].onreadystatechange=function(){
		if(this.readyState=="complete"||!this.readyState){
			(function(){
				loading.dom.style.display="none";
				iframes[0].style.visibility="visible";
			}).defer(50);
		  }
		}
		path= encodeURI(encodeURI(path));
		var url="../../pap/function/importInfo.jsp?path="+path+"&dataType=menuType";
		iframes[0].src =url;
	}	
