function init() {
	L5.QuickTips.init();
};

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
	
	var domicileCode = getParam("domicileCode");
	var name = getParam("name");
	var idCard = getParam("idCard");
	var statusType = getParam("statusType");
	var sacrificeDate = getParam("sacrificeDate");
	var domicileType = getParam("domicileType");
	var lezswApproveDate = getParam("lezswApproveDate");
	
	BaseinfoPeopleDataSet.setParameter("domicileCode",domicileCode);
	BaseinfoPeopleDataSet.setParameter("organCode",organCode);
	BaseinfoPeopleDataSet.setParameter("name",name);
	BaseinfoPeopleDataSet.setParameter("idCard",idCard);
	BaseinfoPeopleDataSet.setParameter("domicileType",domicileType);
	BaseinfoPeopleDataSet.setParameter("statusType",statusType);	
	BaseinfoPeopleDataSet.setParameter("sacrificeDate",sacrificeDate);	
	BaseinfoPeopleDataSet.setParameter("lezswApproveDate",lezswApproveDate);
	BaseinfoPeopleDataSet.load();
	noReclick(BaseinfoPeopleDataSet,"queryButton");
}

function reset(){
	document.getElementById("domicileCode").value = "";
	document.getElementById("domicileName").value = "";
	document.getElementById("name").value = "";
	document.getElementById("idCard").value = "";
	document.getElementById("statusType").value = "";
	document.getElementById("sacrificeDate").value = "";
	document.getElementById("domicileType").value = "";
	document.getElementById("lezswApproveDate").value = "";
}


function insert() {
    
	var url="cmartyrOffspringInsert.jsp";

	var width = screen.width-200;
    var height = screen.height-150;
 	var returnValue = window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:0");
 	if(returnValue!=""&returnValue!=undefined){
 		var list = returnValue.split(";");
 		var peopleId = list[0];
 		var familyId = list[1];
 		var url2="cmartyrOffspringUpdateManage.jsp?familyId="+familyId+"&peopleId="+peopleId;
		var win = window.showModalDialog (url2,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
		query();
		if (win==null) {
			return;
		}
 	}
}

function update(){
    var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}

	var familyId = selected[0].get('FAMILY_ID');
	var peopleId = selected[0].get('PEOPLE_ID');
	var url="cmartyrOffspringUpdateManage.jsp?familyId="+familyId+"&peopleId="+peopleId;
	var width = screen.width-200;
    var height = screen.height-150;
	var win = window.showModalDialog (url,window,"scroll:no;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:0");
	//query();
	if (win==null) {
		return;
	}
}

function detail(){
    var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录查看!");
		return false;
	}
	var data = new L5.Map();
	
	var peopleId = selected[0].get('PEOPLE_ID');
	var familyId = selected[0].get('FAMILY_ID');
	var url='cmartyrOffspringDetailManage.jsp?peopleId='+peopleId+'&familyId='+familyId;
	var width = screen.width-200;
    var height = screen.height-150;
	var win = window.showModalDialog (url,window,"scroll:no;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:0");
}
/*function del(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var  delIds=[];
			for(var i=0;i<selected.length;i++){
				delIds[i]=selected[i].get("peopleId");
			}
			var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptCountRetiredSoldierCommand");
			command.setParameter("delIds", delIds);
			command.execute("delete");
			if (!command.error) {
				for(var i=0;i<selected.length;i++){
			    	ds.remove(selected[i]);
				}
				ds.commitChanges();
			}else{
				L5.Msg.alert('提示',"保存时出现错误！"+command.error);
			}
		}else{
			return false;
		}
	});
}*/

/*
 * 通用帮助
 */
function forHelp(){
    var revalue=window.showModalDialog("../../../../bsp/organization/getselect_code.jsp?rootId="+struId+"&showOrganType=11,12,13,14&organType=0&isExact=1&isCheckBox=0&isTree=1","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
		document.getElementById("domicileCode").value = list[0];
		document.getElementById("domicileName").value = list[1];

	}
}

function  ett(){
   var url=L5.webPath+"/jsp/cams/bpt/excelToTable/martyrOffspring/ErrMessage.jsp";
	var width = screen.width-100;
   	var height = screen.height-140;
   	var win = window.showModalDialog (url,window,"scroll:no;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	if (win==null) {
		return;
	} 
	return win;
}

