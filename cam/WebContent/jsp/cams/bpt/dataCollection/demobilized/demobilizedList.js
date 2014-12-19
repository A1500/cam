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
	var belongDate = getParam("belongDate");
	var isKoreanwar = getParam("isKoreanwar");
	var objectState = getParam("objectState");
	var domicileType = getParam("domicileType");
	var note = getParam("note");
	
	BaseinfoPeopleDataSet.setParameter("domicileCode",domicileCode);
	BaseinfoPeopleDataSet.setParameter("name",name);
	BaseinfoPeopleDataSet.setParameter("idCard",idCard);	
	BaseinfoPeopleDataSet.setParameter("belongDate",belongDate);	
	BaseinfoPeopleDataSet.setParameter("isKoreanwar",isKoreanwar);	
	BaseinfoPeopleDataSet.setParameter("objectState",objectState);	
	BaseinfoPeopleDataSet.setParameter("domicileType",domicileType);
	BaseinfoPeopleDataSet.setParameter("organCode",organCode);	
	BaseinfoPeopleDataSet.setParameter("note",note);	
	BaseinfoPeopleDataSet.load();
	noReclick(BaseinfoPeopleDataSet,"queryButton");  
}

function reset(){
	document.getElementById("domicileCode").value = "";
	document.getElementById("domicileName").value = "";
	document.getElementById("name").value = "";
	document.getElementById("idCard").value = "";
	document.getElementById("belongDate").value = "";
	document.getElementById("isKoreanwar").value = "";
	document.getElementById("objectState").value = "";
	document.getElementById("domicileType").value = "";
	document.getElementById("note").value = "";
}
function insert() {
//	var data = new L5.Map();
//	data.put("method","INSERT");
//	var url='jsp/cams/bpt/dataCollection/demobilized/demobilizedInsert.jsp';
//	var text = '增加基础信息_人员信息';
//	L5.forward(url,text,data);
	var url="demobilizedInsert.jsp?method=INSERT";
// 	var width = 850;
// 	var height = 500;
	var width = screen.width-200;
    var height = screen.height-150;
 	var returnValue = window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
 	if(returnValue!=""&returnValue!=undefined){
 		var list = returnValue.split(";");
 		var peopleId = list[0];
 		var familyId = list[1];
 		var url2="demobilizedUpdateManage.jsp?familyId="+familyId+"&peopleId="+peopleId;
		var win = window.showModalDialog (url2,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
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
//	data.put("method","UPDATE");
//	data.put("familyId",selected[0].get('FAMILY_ID'));
//	data.put("peopleId",selected[0].get('PEOPLE_ID'));
//	var url='jsp/cams/bpt/dataCollection/demobilized/demobilizedUpdateManage.jsp';
//	var text = '修改基础信息_人员信息';
//	L5.forward(url,text,data);
	var familyId = selected[0].get('FAMILY_ID');
	var peopleId = selected[0].get('PEOPLE_ID');
	var url="demobilizedUpdateManage.jsp?familyId="+familyId+"&peopleId="+peopleId;
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
		L5.Msg.alert('提示',"请选择一条记录查看!");
		return false;
	}
	var data = new L5.Map();
	
	var peopleId = selected[0].get('PEOPLE_ID');
	var familyId = selected[0].get('FAMILY_ID');
	var url='demobilizedDetail.jsp?peopleId='+peopleId+'&familyId='+familyId;
	var width = screen.width-200;
    var height = screen.height-150;
	var win = window.showModalDialog (url,window,"scroll:no;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
}
function del(){
	/*var editGrid=L5.getCmp('editGridPanel');
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
	});*/
}
function forHelp(){
       var revalue=window.showModalDialog("../../../../../jsp/bsp/organization/getselect_code.jsp?rootId="+struId+"&showOrganType=11,12,13,14&organType=0&isExact=1&isCheckBox=0&isTree=1","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
       if(revalue!=""&&revalue!=undefined){
          var list = revalue.split(";");
          document.getElementById("domicileCode").value = list[0];
          document.getElementById("domicileName").value = list[1];
       }
}
function  ett(){
   var url=L5.webPath+"/jsp/cams/bpt/excelToTable/demobilized/ErrMessage.jsp";
	var width = screen.width-100;
   	var height = screen.height-140;
   	var win = window.showModalDialog (url,window,"scroll:no;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	if (win==null) {
		return;
	} 
	return win;
}