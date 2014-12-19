var  orgName ;
function init() {
	var OrgNameDataset = L5.DatasetMgr.lookup("OrgNameDataset");
	OrgNameDataset.setParameter("filterSql","id='"+orgCode+"'");
	OrgNameDataset.load();
	OrgNameDataset.on("load",function() {
	orgName = OrgNameDataset.get("text");
});
	document.getElementById("cYear").value;
	document.getElementById("sendback").value=1;
	var retiredSoldierDataset=L5.DatasetMgr.lookup("retiredSoldierDataset");
	retiredSoldierDataset.load();
	var printDataset=L5.DatasetMgr.lookup("printDataset");
	retiredSoldierDataset.on("load",function(){
		var records=retiredSoldierDataset.getAllRecords();
		var MilitaryRegionCodeDataset = L5.DatasetMgr.lookup("MilitaryRegionCodeDataset")
		var recordEnum = MilitaryRegionCodeDataset.getAllRecords();
		var enumLength = recordEnum.length;
		var n=records.length;
		if(records.length==0){return}
		for(i=0;i<n;i++){
			var value = records[i].get('REGION');
			var flag = records[i].get('FLAG');
			var preason = records[i].get('PRENSON');
			for(var j=0;j<enumLength;j++) {
				var valueEnum = recordEnum[j].get("value");
				if(valueEnum == value) {
					records[i].set("REGION",recordEnum[j].get("text"));
					break;
				}
			}
			if(flag==1){
				records[i].set("FLAG","否");
			}else{
				records[i].set("FLAG","是");
			}
			//1:期满原籍,2:期满易地,3:提前原籍,4:提前易地
			switch (preason) {
			case  "1":
				records[i].set("PRENSON","期满原籍");
				break;
			case  "2":
				records[i].set("PRENSON","期满易地");
				break;
			case  "3":
				records[i].set("PRENSON","提前原籍");
				break;
			case  "4":
				records[i].set("PRENSON","提前易地");
				break;
			}
		}
	});
	printDataset.on("load",function(){
		var records=printDataset.getAllRecords();
		var MilitaryRegionCodeDataset = L5.DatasetMgr.lookup("MilitaryRegionCodeDataset")
		var recordEnum = MilitaryRegionCodeDataset.getAllRecords();
		var enumLength = recordEnum.length;
		var n=records.length;
		if(records.length==0){return}
		for(i=0;i<n;i++){
			var value = records[i].get('REGION');
			var flag = records[i].get('FLAG');
			var preason = records[i].get('PRENSON');
			for(var j=0;j<enumLength;j++) {
				var valueEnum = recordEnum[j].get("value");
				if(valueEnum == value) {
					records[i].set("REGION",recordEnum[j].get("text"));
					break;
				}
			}
			if(flag==1){
				records[i].set("FLAG","否");
			}else{
				records[i].set("FLAG","是");
			}
			//1:期满原籍,2:期满易地,3:提前原籍,4:提前易地
			switch (preason) {
			case  "1":
				records[i].set("PRENSON","期满原籍");
				break;
			case  "2":
				records[i].set("PRENSON","期满易地");
				break;
			case  "3":
				records[i].set("PRENSON","提前原籍");
				break;
			case  "4":
				records[i].set("PRENSON","提前易地");
				break;
			}
		}
		doPrint(printDataset);
		})
	;
	var grid=L5.getCmp('editGridPanel');
	//给grid增加双击侦听事件。
	grid.on("rowdblclick",update);
	L5.QuickTips.init();
}

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
//	var retiredSoldierDataset=L5.DatasetMgr.lookup("retiredSoldierDataset");

	retiredSoldierDataset.setParameter("cYear",getParam("cYear"));
	retiredSoldierDataset.setParameter("name",getParam("name"));
	retiredSoldierDataset.setParameter("servedMilitaryRegion",getParam("servedMilitaryRegion"));
	retiredSoldierDataset.setParameter("domicileCode",getParam("domicileCode"));
	retiredSoldierDataset.setParameter("enlistPlace",getParam("enlistPlace"));
	retiredSoldierDataset.setParameter("sendback",getParam("sendback"));
	retiredSoldierDataset.load();
}

function insert() {
	var data = new L5.Map();
	data.put("type","3");
	var url='jsp/cams/prs/prsallot/prsretiredsoldiersinsert.jsp';
	var text = '添加退役士兵信息';
	L5.forward(url,text,data);
}

function update(){

	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}
	var data = new L5.Map();
	data.put("method","UPDATE");
	data.put("idField",selected[0].get('ID'));
	var url='jsp/cams/prs/prsallot/prsallot_detail.jsp';
	var text = '修改退役士兵信息';
	L5.forward(url,text,data);
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
				delIds[i]=selected[i].get("ID");
			}
			var retiredSoldierDataset=L5.DatasetMgr.lookup("retiredSoldierDataset");
			var command=new L5.Command("com.inspur.cams.prs.prsretiredsoldiers.cmd.PrsRetiredSoldiersCommand");
			command.setParameter("delIds", delIds);
			command.execute("delete");
			if (!command.error) {
				for(var i=0;i<selected.length;i++){
			    	retiredSoldierDataset.remove(selected[i]);
				}
				retiredSoldierDataset.commitChanges();

			}else{
				L5.Msg.alert('提示',"保存时出现错误！"+command.error);
			}
		}else{
			return false;
		}
	});
}

function send(){

	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要下发的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要下发选中的记录吗?',function(state){
		if(state=="yes"){
			var  delIds=[];
			for(var i=0;i<selected.length;i++){
				if(selected[i].get("FLAG")=='2'){
					L5.Msg.alert('提示',"退档士兵信息不能下发!");
					return false;
				};
			}
			for(var i=0;i<selected.length;i++){
				delIds[i]=selected[i].get("ID");
			}

			var retiredSoldierDataset=L5.DatasetMgr.lookup("retiredSoldierDataset");
			var command=new L5.Command("com.inspur.cams.prs.prsretiredsoldiers.cmd.PrsRetiredSoldiersCommand");
			command.setParameter("ids", delIds);
			command.execute("updateAllotFlag");
			if (!command.error) {
				retiredSoldierDataset.reload();
			}else{
				L5.Msg.alert('提示',"保存时出现错误！"+command.error);
			}
		}else{
			return false;
		}
	});
}

function forHelp() {
	// var struId='<%=struId%>';
	var organName ="山东省";
	var revalue=window.showModalDialog(L5.webPath+"/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&level=2&organCode="+orgCode+"&organName="+encodeURIComponent(encodeURIComponent(organName)),"","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");

	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("domicileCode").value = list[0];
		document.getElementById("domicileName").value = list[1];

	}
}
/**function forHelp() {
	var revalue = window
			.showModalDialog(
					"../../../bsp/organization/getselect_code.jsp?rootId="
							+ struId
							+ "&showOrganType=11,12,13&organType=0&isExact=1&isCheckBox=0&isTree=1",
					"",
					"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");

	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("domicileCode").value = list[0];
		document.getElementById("domicileName").value = list[1];
	}
}
*/
function sendPatch(){

	L5.MessageBox.confirm('确定', '确定要下发所有的记录吗?',function(state){
		if(state=="yes"){
			var command=new L5.Command("com.inspur.cams.prs.prsretiredsoldiers.cmd.PrsRetiredSoldiersCommand");
			command.setParameter("cYear",getParam("cYear"));
			command.setParameter("name",getParam("name"));
			command.setParameter("servedMilitaryRegion",getParam("servedMilitaryRegion"));
			command.setParameter("domicileCode",getParam("domicileCode"));
			command.setParameter("enlistPlace",getParam("enlistPlace"));
			command.setParameter("sendback",getParam("sendback"));
			command.execute("updateAllotFlagAll");
			if (!command.error) {
				var retiredSoldierDataset=L5.DatasetMgr.lookup("retiredSoldierDataset");
				retiredSoldierDataset.reload();
			}else{
				L5.Msg.alert('提示',"保存时出现错误！"+command.error);
			}
		}else {
			return false;
		}
	});

}
function func_ForDomicileSelect() {
	var revalue=window.showModalDialog(L5.webPath+"/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&level=2&organCode=370000000000&organName=山东省","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("enlistPlace").value = list[0];
		document.getElementById("enlistPlaceName").value = list[1];
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
	data.put("idField",selected[0].get('ID'));
	var url='jsp/cams/prs/readonly/prsretiredsoldiers_detail.jsp';
	var text = '查看退役士兵信息';
	L5.forward(url,text,data);
}
var printTitle;
//数据上传导入
function upload(){
	var ds = L5.DatasetMgr.lookup("ds");
	ds.removeAll();
	ds.newRecord();
	var win=L5.getCmp("uploadinsert");
	win.show(this);
	document.getElementById("saves").disabled=false;	
	document.getElementById("Rtime").innerText = new Date();
	document.getElementById("form_content").reset(); 
}
function save() {
//上传文件保存
	var filename=document.getElementById("catalogName").value;
	if(filename == " " || filename == ""){
		L5.MessageBox.alert("提示", "请选择要导入的用户文件！");
		return;
	}
	if((filename.lastIndexOf(".dbf") == -1)&&(filename.lastIndexOf(".DBF") == -1)){
		L5.MessageBox.alert("提示", "请选择文件格式为*.DBF或dbf的文件！");
		return;
	}
	
	
	var isValidate = ds.isValidate();
	if(isValidate != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+isValidate);
		return false;
	}
	document.getElementById("saves").disabled=true;	
	var command = new L5.Command("com.inspur.cams.prs.prsretiredsoldiers.cmd.SoldiersuploadCommand");
	command.setParameter("record",ds.getCurrent());
	command.setForm("form_content");
	command.execute("insert");
	if (!command.error) {
		L5.Msg.alert('提示',"上传成功！",function(){
		
		var filePath = command.getReturn("filepath");
		var win=L5.getCmp("uploadinsert");
				win.hide();
			
		var cmd=new L5.Command("com.inspur.cams.prs.prsretiredsoldiers.cmd.PrsRetiredSoldiersCommand");
		cmd.setParameter("filename",filePath);
		cmd.execute("upload");
		var count = cmd.getReturn("count");
			if (!cmd.error) {
				L5.Msg.alert('提示',"成功导入"+count+"条数据!",function(){
				//command.setParameter("id",catalogId);
				//command.setParameter("count",count);
				//command.execute("updateFlag");
				var soldierDs=L5.DatasetMgr.lookup("retiredSoldierDataset");
				soldierDs.load();
				//cmd.execute("DeleteFolder");
				}
			);}
			else{
				L5.Msg.alert('提示',"导入时出现错误！"+cmd.error);
			}
			});
 	}else{
		L5.Msg.alert('提示',"上传时出现错误！"+command.error);
	}
	
	
	
	
	/*if (!command.error) {
		L5.Msg.alert('提示',"数据保存成功!",function(){
	var win=L5.getCmp("uploadinsert");
		win.hide();});
	}
	else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}*/
}



function saveSeven() {
//上传文件保存
	//var filename=document.getElementById("catalogName").value;
	var file_upl = document.getElementById('catalogName');
	file_upl.select();

	var filename = document.selection.createRange().text;

	
	if(filename == " " || filename == ""){
		L5.MessageBox.alert("提示", "请选择要导入的用户文件！");
		return;
	}
	if((filename.lastIndexOf(".dbf") == -1)&&(filename.lastIndexOf(".DBF") == -1)){
		L5.MessageBox.alert("提示", "请选择文件格式为*.DBF或dbf的文件！");
		return;
	}
	
	
	var isValidate = ds.isValidate();
	if(isValidate != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+isValidate);
		return false;
	}
	var command = new L5.Command("com.inspur.cams.prs.prsretiredsoldiers.cmd.SoldiersuploadCommand");
	command.setParameter("record",ds.getCurrent());
	command.setForm("form_content");
	command.execute("insert");
	var cmd=new L5.Command("com.inspur.cams.prs.prsretiredsoldiers.cmd.PrsRetiredSoldiersCommand");
	cmd.setParameter("filename",filename);
	cmd.execute("upload");
	var count = cmd.getReturn("count");
	if (!command.error) {
		L5.Msg.alert('提示',"成功导入"+count+"条数据!",function(){
		command.setParameter("id", command.getReturn("catalogId"));
		command.setParameter("count",count);
		command.execute("updateFlag");
	var uploadDs=L5.DatasetMgr.lookup("retiredSoldierDataset");
	uploadDs.load();
	var win=L5.getCmp("uploadinsert");
		win.hide();}
		);
		
 	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
	
	
}
//删除增加一行
var row_index=0;
   function  add_row()
  {
    var table2 = document.getElementById("table2");
	row_index++;
    var new_row=table2.insertRow(table2.rows.length);
	new_row.setAttribute("id", "row"+row_index);
	var new_col=new_row.insertCell(0);
	new_col.innerHTML="<input type='file' name='filename"+row_index+"' size='87' >";
    var new_col=new_row.insertCell(1);
    new_col.innerHTML="&nbsp;<input type='button' value='删除' onclick=\"delete_row('row"+row_index+ "')\">";
    document.getElementById("filename"+row_index).focus();
    document.getElementById("span").innerHTML="<font color='red'>附件大小不能超过5M</font>";
  }
//删除增加一行
    function delete_row(rname)
  {
	var table2 = document.getElementById("table2");
    var i;
    i=table2.rows(rname).rowIndex;
    table2.deleteRow(i);
  }
var printTitle;
//打印预览调用方法
function print(){

	var printDataset=L5.DatasetMgr.lookup("printDataset");
	var pageSize = retiredSoldierDataset.pageInfo.pageSize;
	var startCursor = retiredSoldierDataset.pageInfo.startCursor;
	printDataset.setParameter("cYear",getParam("cYear"));
	printDataset.setParameter("name",getParam("name"));
	printDataset.setParameter("servedMilitaryRegion",getParam("servedMilitaryRegion"));
	printDataset.setParameter("domicileCode",getParam("domicileCode"));
	printDataset.setParameter("enlistPlace",getParam("enlistPlace"));
	printDataset.setParameter("sendback",getParam("sendback"));
	printDataset.baseParams["flag"]="1";  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
	printDataset.baseParams["startExcel"]=startCursor;  //总记录中当前页记录起始位置
	printDataset.baseParams["limitExcel"]=retiredSoldierDataset.getTotalCount();
	printDataset.load();
}
// 打印方法传递的record
function doPrint(printDataset){
	var xml = getPrintDataByDataSet(printTitle,printDataset);
	printReport(xml,L5.webPath+'/jsp/cams/prs/query/XFff.fr3');
}
//转向导入excel
function forImportExcel() {
	var returnJsp="prsretiredsoldiers_list.jsp"
	var url = "/jsp/cams/prs/prsallot/forImportExcel.jsp?returnJsp="+returnJsp;
	var text = "导入救助方案明细";
	L5.forward(url, text);
}
