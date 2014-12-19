function init() {
	L5.QuickTips.init();
}

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
	BptPeopleDisabilityDataSet.setParameter("domicileCode",getParam("domicileCode"));
	BptPeopleDisabilityDataSet.setParameter("name",getParam("name"));
	BptPeopleDisabilityDataSet.setParameter("idCard",getParam("idCard"));
	BptPeopleDisabilityDataSet.setParameter("domicileType",getParam("domicileType"));	
	BptPeopleDisabilityDataSet.setParameter("disabilityStateCode",getParam("disabilityStateCode"));	
	BptPeopleDisabilityDataSet.setParameter("disabilityTypeCode",getParam("disabilityTypeCode"));	
	BptPeopleDisabilityDataSet.setParameter("disabilityLevelCode",getParam("disabilityLevelCode"));	
	BptPeopleDisabilityDataSet.setParameter("disabilityCaseCode",getParam("disabilityCaseCode"));
	BptPeopleDisabilityDataSet.setParameter("disabilityGenusCode",getParam("disabilityGenusCode"));	
	BptPeopleDisabilityDataSet.setParameter("disabilityWarCode",getParam("disabilityWarCode"));	
	BptPeopleDisabilityDataSet.setParameter("organCode",organCode);	
	BptPeopleDisabilityDataSet.setParameter("disabilityNo",getParam("disabilityNo"));
	//BptPeopleDisabilityDataSet.setParameter("phoneticCode",getParam("phoneticCode"));
	BptPeopleDisabilityDataSet.load();
	noReclick(BptPeopleDisabilityDataSet,"queryButton"); 
}

function reset(){
	document.getElementById("domicileCode").value = "";
	document.getElementById("name").value = "";
	document.getElementById("idCard").value = "";
	document.getElementById("domicileType").value = "";
	document.getElementById("disabilityStateCode").value = "";
	document.getElementById("disabilityTypeCode").value = "";
	document.getElementById("disabilityLevelCode").value = "";
	document.getElementById("disabilityCaseCode").value = "";
	document.getElementById("disabilityGenusCode").value = "";
	document.getElementById("disabilityWarCode").value = "";
	document.getElementById("disabilityNo").value = "";
	//document.getElementById("phoneticCode").value = "";
}
function insert() {
//  	var data = new L5.Map();
//  	data.put("method","INSERT");
//  	var url='jsp/cams/bpt/dataCollection/disability/disabilityInsert.jsp';
//  	var text = '增加伤残人员信息';
//  	L5.forward(url,text,data);
//	var width = screen.width-200;
//	var height = screen.height-200;
	var url="disabilityInsert.jsp?method=INSERT";
	var width = screen.width-200;
    var height = screen.height-150;
 	var returnValue = window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
 	if(returnValue!=""&returnValue!=undefined){
 		var list = returnValue.split(";");
 		var peopleId = list[0];
 		var familyId = list[1];
 		var url2="disabilityUpdateManage.jsp?familyId="+familyId+"&peopleId="+peopleId;
		var win = window.showModalDialog (url2,window,"scroll:no;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
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
//	var data = new L5.Map();
//	data.put("familyId",selected[0].get('FAMILY_ID'));
//	data.put("peopleId",selected[0].get('PEOPLE_ID'));
//	var url='jsp/cams/bpt/dataCollection/disability/disabilityUpdateManage.jsp';
//	var text = '修改伤残人员信息';
//	L5.forward(url,text,data);
	var familyId = selected[0].get('FAMILY_ID');
	var peopleId = selected[0].get('PEOPLE_ID');
	var photoId = selected[0].get('PHOTO_ID'); 
	var url="disabilityUpdateManage.jsp?familyId="+familyId+"&peopleId="+peopleId+"&photoId="+photoId;
	var width = screen.width-200;
    var height = screen.height-150;
	var win = window.showModalDialog (url,window,"scroll:no;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	//query();
	if (win==null) {
		return;
	}
}

function detail(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}
	
	var familyId = selected[0].get('FAMILY_ID');
	var peopleId = selected[0].get('PEOPLE_ID');
	var photoId = selected[0].get('PHOTO_ID');
	var width = screen.width-200;
    var height = screen.height-150;
	var url='disabilityDetailManage.jsp?familyId='+familyId+'&peopleId='+peopleId+'&photoId='+photoId;
	var win = window.showModalDialog (url,window,"scroll:no;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	if (win==null) {
		return;
	}
}

function del(){
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
			var command=new L5.Command("bpt.com.inspur.cams.bpt.disability.cmd.BptBaseinfoPeopleCommand");
			command.setParameter("delIds", delIds);
			command.execute("delete");
			if (!command.error) {
				for(var i=0;i<selected.length;i++){
			    	BaseinfoPeopleDataSet.remove(selected[i]);
				}
				BaseinfoPeopleDataSet.commitChanges();
			}else{
				L5.Msg.alert('提示',"保存时出现错误！"+command.error);
			}
		}else{
			return false;
		}
	});
}

/**
 * 所属机构窗口
 */
function forHelp(){
		//var struId='<%=struId%>';
		var revalue=window.showModalDialog("../../../../../jsp/bsp/organization/getselect_code.jsp?rootId="+struId+"&showOrganType=11,12,13,14&organType=0&isExact=1&isCheckBox=0&isTree=1","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
		
		if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
		document.getElementById("domicileCode").value = list[0];
		document.getElementById("domicileName").value = list[1];
		}
}
/**
 * 所属机构窗口
 */
function  strToUpp(){
   document.getElementById("phoneticCode").value = document.getElementById("phoneticCode").value.toUpperCase(); 
}
function  ett(){
   var url=L5.webPath+"/jsp/cams/bpt/excelToTable/disability/ErrMessage.jsp";
	var width = screen.width-100;
   	var height = screen.height-140;
   	var win = window.showModalDialog (url,window,"scroll:no;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	if (win==null) {
		return;
	} 
	return win;
}