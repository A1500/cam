var NDate = L5.server.getSysDate();
var conFlag = false; //继续标记
function init(){
	
	
	document.getElementById("conBtn").style.display='none';
	if(method=="insert"){
		familyDs.newRecord();// 初始化界面
		reliefDs.newRecord({
					"damageTime" : formatDateToString(NDate),
					"acceptDate" : formatDateToString(NDate)
				});//初始化界面
		photoDs.newRecord();
		document.getElementById("familyRegister").value="1";//初始化为农村
		familyDs.set("familyRegister","1");
//		document.getElementById("conBtn").style.display='';
		var command = new L5.Command("com.inspur.cams.dis.base.cmd.DisReliefBatchCommand");
		command.setParameter("batchDetailId", batchDetailId);
		command.execute("getGrantAndAlloction");
		var listInfo=command.getReturn("listInfo");
		var lis=listInfo.split(","); 
		L5.getCmp("reliefInfo").on("activate",function(){
			document.getElementById("grantType").value = lis[1];
			document.getElementById("allocationType").value = lis[0];
			document.getElementById("grantType").disabled="true";
			document.getElementById("allocationType").disabled="true";
			reliefDs.set("grantType",lis[1]);
			reliefDs.set("allocationType",lis[0]);
		});
	}else if(method=="update"){
		reliefDs.setParameter("INFO_ID",cx_infoId);
		familyDs.setParameter("RECORD_ID",cx_recordId);
		reliefDs.load();
		familyDs.load();
		photoDs.setParameter("INFO_ID", cx_infoId);
		
		photoDs.on("load", function() {
			L5.getCmp("tabPanel").setActiveTab(2);
			if(photoDs.getCount() > 0) {
				loadImg();
			} else {
				photoDs.newRecord();
			}
			
			
		});
		photoDs.load();
		L5.getCmp("reliefInfo").on("activate",function(){
			document.getElementById("grantType").disabled="true";
			document.getElementById("allocationType").disabled="true";
		});
	}
};

function loadImg(){
	var count = photoDs.getCount();
	var html="";
	for(var i = 0; i < count; i++) {
		var record = photoDs.getAt(i);
		var pid = record.get("photoId");
		var imgHtml = "<img src ='"+L5.webPath + "/showPicServlet?pid="+pid+"' width='300' height='300' />";
		html += "<tr width='100%' id='"+pid+"'>"
				+ "<td width='40%'>"
				+	imgHtml
				+ "<a href='javascript:deletePic(\""+pid+"\")' >删除</a></td>"
				+"</tr>";
	}
	$("#photoTable").append(html);
}

function deletePic(pid) {
	var delPid = $("#delPicPid").val();
	if(delPid == "") {
		delPid = pid;
	} else {
		delPid = delPid + "," + pid;
	}
	$("#delPicPid").val(delPid);
	$("#"+pid).remove();
}
function saveClickContinue(){
	conFlag = true;
	saveClickAfter();
}
function saveClick() {
	conFlag = false;
	saveClickAfter();
}
function saveClickAfter(){
	var familyDs = L5.DatasetMgr.lookup("familyDs");//家庭信息
	var reliefDs = L5.DatasetMgr.lookup("reliefDs");//救助信息
	var familyRecord = familyDs.getCurrent();
	var reliefRecord = reliefDs.getCurrent();
	
	var name = document.getElementById("name").value;
	if(name==""||name==null){
		L5.Msg.alert("提示","户主姓名不能为空！");
		return false;
	}
	var idCard = document.getElementById("idCard").value;
	if(!checkIDCard(document.getElementById("idCard"))){
		L5.Msg.alert("提示","身份证号码不正确，请重新填写！");
		return false;
	}
	var familyNum = document.getElementById("familyNum").value;
	if(familyNum==""||familyNum==null){
		L5.Msg.alert("提示","家庭人口不能为空！");
		return false;
	}
	if(!/^[1-9][0-9]{0,1}$/.test(familyNum)){
		L5.Msg.alert("提示","家庭人口必须为大于0的数字！");
		return false;
	}
	var familyType = document.getElementById("familyType").value;
	if(familyType==null||familyType==""){
		L5.Msg.alert("提示","家庭类型不能为空！");
		return false;
	}
	var familyRegister = document.getElementById("familyRegister").value;
	if(familyRegister==null||familyRegister==""){
		L5.Msg.alert("提示","户口所在地不能为空！");
		return false;
	}
	var houseCount = document.getElementById("houseCount").value;
	if(houseCount==null||houseCount==""){
		L5.Msg.alert("提示","房屋间数不能为空！");
		return false;
	}
	if(!/^(([1-9][0-9]{0,3})|0)$/.test(houseCount)){
		L5.Msg.alert("提示","房屋间数必须为数字！");
		return false;
	}
	var houseStructure = document.getElementById("houseStructure").value;
	if(houseStructure==null||houseStructure==""){
		L5.Msg.alert("提示","房屋结构不能为空！");
		return false;
	}
	var damageTime = reliefDs.get("damageTime");
	if(damageTime==null||damageTime==""){
		L5.Msg.alert("提示","受灾时间不能为空！");
		return false;
	}
	if(damageTime.length!=10){
		L5.Msg.alert("提示","受灾时间格式不正确！");
		return false;
	}
	var disasterType = reliefDs.get("disasterType");
	if(disasterType==null||disasterType==""){
		L5.Msg.alert("提示","灾害种类不能为空！");
		return false;
	}
	var allocationType = reliefDs.get("allocationType");
	if(allocationType==null||allocationType==""){
		L5.Msg.alert("提示","资金发放类型不能为空！");
		return false;
	}
	
	var command = new L5.Command("com.inspur.cams.dis.base.cmd.AssistanceCommand");
	command.setParameter("familyRecord",familyRecord);
	command.setParameter("reliefRecord",reliefRecord);
	command.setParameter("organCode", organCode);
	command.setParameter("organName", organName);
	command.setParameter("batchDetailId", batchDetailId);
	command.setParameter("delPicPid", $("#delPicPid").val());
	command.setParameter("method",method);
	if(familyRecord.length<1||reliefRecord<1){
		L5.Msg.alert('提示', '没有需要保存的数据！');
		return false;
	}
	if($("input[type=file]").size() > 0) {
		command.setParameter("isupload", "true");
		command.setForm("photoForm");
	} else {
		command.setParameter("isupload", "false");
	}
	command.afterExecute = function() {
		if(!command.error){
			L5.Msg.alert('提示','保存成功！', function() {
				if(conFlag) {
					var tabPanel = L5.getCmp("tabPanel");
					tabPanel.setActiveTab(0);
					
					photoDs.removeAll();
					photoDs.newRecord();

					familyDs.getCurrent().set("name", "");
					familyDs.getCurrent().set("idCard", "");
					familyDs.getCurrent().set("familyNum", "");
					familyDs.getCurrent().set("familyType", "");
					familyDs.getCurrent().set("houseCount", "");
					familyDs.getCurrent().set("houseStructure", "");
					
					reliefDs.getCurrent().set("disasterType", "");
					reliefDs.getCurrent().set("collapsedHouse", "");
					reliefDs.getCurrent().set("seriousDamageHouse", "");
					reliefDs.getCurrent().set("generalDamageHouse", "");
					reliefDs.getCurrent().set("rebuildHouse", "");
					reliefDs.getCurrent().set("repairedHouse", "");
					reliefDs.getCurrent().set("approvalRebuiledHouse", "");
					reliefDs.getCurrent().set("approvalRepairedHouse", "");
					reliefDs.getCurrent().set("approvalMonry", "");
					reliefDs.getCurrent().set("accountCode", "");
					reliefDs.getCurrent().set("note", "");
				}else {
					window.returnValue = true;
					window.close();
				}
			});
		}else{
			L5.Msg.alert('提示','保存出现错误！'+command.error);
		}
	};
	command.execute("save");
}

/**
 * 选择住址行政区划窗口
 */
function forOrganSelect() {
	var revalue = window.showModalDialog(
			L5.webPath+"/jsp/cams/dis/assistance/dic_city/dicCity.jsp?organCode="
					+ organCode + "&organName="
					+ escape(encodeURIComponent(organName))+"&radioType=radiobox&level=4", "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("villiageCode").value=list[0];
		document.getElementById("acceptAreaCode").value=list[0];
		document.getElementById("acceptAreaName").value=list[4];
		familyDs.set("villiageCode",list[0]);
		reliefDs.set("acceptAreaCode",list[0]);
		reliefDs.set("acceptAreaName",list[4]);
	}
}

/**
 * 有关照片
 */
var row_index=0;
function  add_row()
{
	var table2 = document.getElementById("table2");
	row_index++;
	var new_row=table2.insertRow(table2.rows.length);
	new_row.setAttribute("id", "row"+row_index);
	new_row.setAttribute("width", "40%");
	var new_col=new_row.insertCell(0);
	new_col.innerHTML="<input type='file' name='filename"+row_index+"' id='filename"+row_index+"' style='width:240px;' >";
	var new_col=new_row.insertCell(1);
	new_col.innerHTML="&nbsp;<input type='button' value='删除' onclick=\"delete_row('row"+row_index+ "')\">";
	document.getElementById("filename"+row_index).focus();
//	document.getElementById("span").innerHTML="<font color='red'>点击添加图片</font>";
}
 function delete_row(rname)
{
	var table2 = document.getElementById("table2");
	var i;
	i=table2.rows(rname).rowIndex;
	table2.deleteRow(i);
}
function formatDateToString(date) {
	return date.getYear()
			+ "-"
			+ ((date.getMonth() + 1) > 9 ? (date.getMonth() + 1) : "0"
					+ (date.getMonth() + 1)) + "-"
			+ (date.getDate() > 9 ? date.getDate() : "0" + date.getDate());
}