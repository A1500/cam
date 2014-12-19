var ifQuery = false;
var time = new Date();
var times = time.format("Y");
var query_startTime = times+"-01-01";
var query_endTime = times+"-12-31";
var flag ;
var path ;
var changeContent;
function init() {
	query();
        L5.QuickTips.init();
        /*dsBptObject1.on("load",function(ds){
    		fields1="B32,B2,B5,B1,B33,B34,B35,B39,B36,B40,B37,B38";
    		L5.dataset2excel(ds,"/jsp/cams/bpt/peopleBasicInfo/excel/bptPeople_excel.jsp?fields="+fields1);
    	});*/
};


function sure(){
	var basicInfoGrid;
	var objectTypes="";
	   basicInfoGrid=L5.getCmp('baseGridPanel');
	var selected=basicInfoGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录查看!");
		return false;
	}
	var peopleId = selected[0].get('PEOPLE_ID');
	var username = selected[0].get('NAME');
	var idCard = selected[0].get('ID_CARD');
	
	if(selected[0].get('DISABILITY_FLAG') == '2'){
		objectTypes=objectTypes+",11";
	}
	if(selected[0].get('DEPENDANT_FLAG') == '2'){
		objectTypes=objectTypes+",21";
	}
	if(selected[0].get('DEMOBILIZED_FLAG') == '2'){
		objectTypes=objectTypes+",41";
	}
	if(selected[0].get('DEMOBILIZEDILL_FLAG') == '2'){
		objectTypes=objectTypes+",42";
	}
	if(selected[0].get('WAR_FLAG') == '2'){
		objectTypes=objectTypes+",51";
	}
	if(selected[0].get('TEST_FLAG') == '2'){
		objectTypes=objectTypes+",61";
	}
	if(selected[0].get('RETIRED_FLAG') == '2'){
		objectTypes=objectTypes+",81";
	}
	if(selected[0].get('MARTYR_OFFSPRING_FLAG') == '2'){
		objectTypes=objectTypes+",B1";
	}
	var url='doubleIdRemindEdit.jsp?peopleId='+peopleId+'&username='+username+'&idCard='+idCard+'&objectTypes='+objectTypes;
	var width = screen.width-60;
	var height = 580;
	var win = window.showModalDialog (url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:0");
	/*if (win==null) {
		return;
	}*/
	
	
	
	query();
	
}





function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}

function query() {
	var domicileCode = getParam("domicileCode");
	var name = getParam("name");
	var idCard = getParam("idCard");
	
	
	dsBptObject.setParameter("organCode", domicileCode!=null?domicileCode:organCode);
	dsBptObject.setParameter("name", name);
	dsBptObject.setParameter("idCard", idCard);
	dsBptObject.load();
	noReclick(dsBptObject,"queryButton");
		
	
	// excelLoad();
}
function typeRender(value,o,a){
	var str = ""; 

	var ObjectStateDataset=L5.DatasetMgr.lookup("ObjectStateDataset");
	if(value != ''){
		var str = ObjectStateDataset.data.map[value].data.text ; 
		return str;
	}else {
		return str;
	}
		
}
function reset(){
	document.getElementById("domicileCode").value = "";
	document.getElementById("domicileName").value = "";
	document.getElementById("name").value = "";
	document.getElementById("idCard").value = "";
	document.getElementById("nation").value = "";
}




function forHelp() {
	if(!ifQuery) {
		if (organCode != null && organCode != "") {
			var command = new L5.Command("com.inspur.cams.comm.diccity.cmd.DicCityCommand");
			command.setParameter("ID", organCode);
			command.execute("findOrganName");
			var fullName = command.getReturn("organName");
			if (fullName != null && fullName != "") {
				organName = fullName;
			}
			ifQuery = true;
		}
	}
	var revalue = window.showModalDialog(L5.webPath
					+ "/jsp/cams/comm/diccity/dicCity.jsp?organCode="
					+ organCode + "&radioMaxlevel=0&organName="
					+ escape(encodeURIComponent(organName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	// var
	// revalue=window.showModalDialog(L5.webPath+"/jsp/cams/bpt/comm/getselect_code.jsp?rootId="+struId+"&showOrganType=1&organType=1&isExact=0&isCheckBox=0&isTree=1","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");

		document.getElementById("domicileCode").value = list[0];
		document.getElementById("domicileName").value = list[4];

	}
}



//伤残等级
function forDisability(){
	var revalue=window.showModalDialog("../dicdisabilitylevel/dicdisabilitylevel.jsp");
	if(revalue!=""&&revalue!=undefined){
          var list = revalue.split(";");      
          
          if(list[0] == 0){
//         	document.getElementById("disabilityLevelCode").value=list[0];
            document.getElementById("disabilityLevelCodeName").value="所有伤残等级";
          }else{
          	document.getElementById("disabilityLevelCode").value=list[0];
            document.getElementById("disabilityLevelCodeName").value=list[1];
          }
          
	}
}
function delPeople(){
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?', function(state) {
		if (state == "yes") {
			var basicInfoGrid;
			 basicInfoGrid=L5.getCmp('baseGridPanel');
			var selected=basicInfoGrid.getSelectionModel().getSelections();
			var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptDelPeopleCommand");
			command.setParameter("record", selected);
			command.execute("deletePeople");
			if (!command.error) {
				L5.Msg.alert('提示','删除成功！');
				query();
			}else{
				L5.Msg.alert('提示',"删除时出现错误！"+command.error);
			}
		} else {
				return false;
		}
	});

}