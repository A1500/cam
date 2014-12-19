var nowId;
function init(){
	var samGerocomiumInfoDataSet=L5.DatasetMgr.lookup("samGerocomiumInfoDataSet");
	var samRoomInfoDataSet=L5.DatasetMgr.lookup("samRoomInfoDataSet");
	var samWorkerInfoDataSet=L5.DatasetMgr.lookup("samWorkerInfoDataSet");
	document.getElementById("year").setAttribute("disabled","true");
	if(method=="insert"){
		var date = L5.server.getSysDate();
		samGerocomiumInfoDataSet.newRecord({"year":date.getYear()});
		if(organArea.substring(6,12) != '000000'){//是县级以下
			document.getElementById("serveTowns").value = organName;//前台显示服务乡镇名称
			document.getElementById("serveTownsId").value = organArea;
			samGerocomiumInfoDataSet.set('serveTowns',organName);
			samGerocomiumInfoDataSet.set('serveTownsId',organArea);
			
			document.getElementById("manaLevel").value = organName;//前台显示服务乡镇名称
			document.getElementById("manaLevelId").value = organArea;
			samGerocomiumInfoDataSet.set('manaLevel',organName);
			samGerocomiumInfoDataSet.set('manaLevelId',organArea);
			
			document.getElementById("areaLevel").value = organName;//前台显示服务乡镇名称
			document.getElementById("areaLevelId").value = organArea;
			samGerocomiumInfoDataSet.set('areaLevel',organName);
			samGerocomiumInfoDataSet.set('areaLevelId',organArea);
			
		}else{
		}
	}else{
		var date = L5.server.getSysDate();
		//samGerocomiumInfoDataSet.setParameter("GEROCOMIUM_ID@=",gerocomiumId);
		//samGerocomiumInfoDataSet.setParameter("IF_CURRENT@=","1");
		samGerocomiumInfoDataSet.setParameter("RECORD_ID@=",recordId);
		samGerocomiumInfoDataSet.load();
		samGerocomiumInfoDataSet.on('load',function(){
			if(method=="newYearInsert"){
			document.getElementById("year").value=date.getYear();
		}
		});
		//document.getElementById("gerocomiumName").setAttribute("disabled","true");
		//document.getElementById("establishDate").setAttribute("disabled","true");
		//加载房间信息
		samRoomInfoDataSet.setParameter("GEROCOMIUM_ID@=",gerocomiumId);
		samRoomInfoDataSet.load();	
		//加载员工信息
		samWorkerInfoDataSet.setParameter("GEROCOMIUM_ID@=",gerocomiumId);
		samWorkerInfoDataSet.load();
		//加载床位信息
		//var samBedInfoDataSet = L5.DatasetMgr.lookup("samBedInfoDataSet");
		//samBedInfoDataSet.load();
	}
}
function saveInfo(){
	//敬老院信息
	var samGerocomiumInfoDataSet=L5.DatasetMgr.lookup("samGerocomiumInfoDataSet");
	var validGerocomium=samGerocomiumInfoDataSet.isValidate(true);
	if(validGerocomium!=true){
		L5.Msg.alert("提示","校验未通过，不能保存！"+validGerocomium);
		return false;
	}
	var recordGerocomium=samGerocomiumInfoDataSet.getCurrent();
	if(saveCheck()!=false){
		//房间信息
		var samRoomInfoDataSet=L5.DatasetMgr.lookup("samRoomInfoDataSet");
		var validRoom=samRoomInfoDataSet.isValidate(true);
		if(validRoom!=true){
			L5.Msg.alert("提示","校验未通过，不能保存！"+validRoom);
			return false;
		}
		//var recordRoom=samRoomInfoDataSet.getCurrent();
		var recordRoom=samRoomInfoDataSet.getAllChangedRecords();
		//床位信息
		var samBedInfoDataSet=L5.DatasetMgr.lookup("samBedInfoDataSet");
		var validBed=samBedInfoDataSet.isValidate(true);
		if(validBed!=true){
			L5.Msg.alert("提示","校验未通过，不能保存！"+validBed);
			return false;
		}
		//var recordBed=samBedInfoDataSet.getCurrent();
		samBedInfoDataSet.clearFilter();
		var recordBed=samBedInfoDataSet.getAllChangedRecords();
		//员工信息
		var samWorkerInfoDataSet=L5.DatasetMgr.lookup("samWorkerInfoDataSet");
		var validWorker=samWorkerInfoDataSet.isValidate(true);
		if(validWorker!=true){
			L5.Msg.alert("提示","校验未通过，不能保存！"+validWorker);
			return false;
		}
		//var recordWorker=samWorkerInfoDataSet.getCurrent();
		var recordWorker=samWorkerInfoDataSet.getAllChangedRecords();
			if(method=="insert"){
				recordGerocomium.set("gerocomiumId",newGerocomiumId);
				recordGerocomium.set("ifCurrent","1");
				for(var i=0;i<recordRoom.length;i++){
					recordRoom[i].set("gerocomiumId",newGerocomiumId);
				}
				for(var i=0;i<recordWorker.length;i++){
					recordWorker[i].set("gerocomiumId",newGerocomiumId);
				}
			}else if(method=="newYearInsert"){
				recordGerocomium.set("year",document.getElementById("year").value);
			}
			var command=new L5.Command("com.inspur.cams.drel.samu.cmd.SamGerocomiumInfoCmd");
			command.setParameter("recordGerocomium",recordGerocomium);
			command.setParameter("recordRoom",recordRoom);
			command.setParameter("recordBed",recordBed);
			command.setParameter("recordWorker",recordWorker);
			if(method=="newYearInsert"){
				command.setParameter("recordId",recordId);
			}else if(method=="insert"){
				command.setParameter("recordId",null);
			}
			if(method=="insert"){
				command.execute("save");
				if (!command.error){
					L5.Msg.alert("提示","保存成功！",function(){
						var returnRecordId = command.getReturn("returnRecordId");
						var returnGerocomiumId = command.getReturn("returnGerocomiumId");
						var samWorkerInfoDataSet=L5.DatasetMgr.lookup("samWorkerInfoDataSet");
						samWorkerInfoDataSet.commitChanges();
						var data=new L5.Map();
						data.put("method","update");
						data.put("recordId",returnRecordId);
						data.put("gerocomiumId",returnGerocomiumId);
						var url="jsp/cams/drel/samu/baseinfo/samGerocomiumInfoInsert.jsp";
						L5.forward(url,'',data);
					});
					
				}else{
					L5.Msg.alert("提示","保存出错！");
				}	
			}else if(method=="update"){
				command.execute("update");
				if (!command.error){
					L5.Msg.alert("提示","保存成功！",function(){
						var samWorkerInfoDataSet=L5.DatasetMgr.lookup("samWorkerInfoDataSet");
						samWorkerInfoDataSet.commitChanges();
					});
				}else{
					L5.Msg.alert("提示","保存出错！");
				}
			}else{
				command.execute("save");
				if (!command.error){
					L5.Msg.alert("提示","保存成功！",function(){
						var samWorkerInfoDataSet=L5.DatasetMgr.lookup("samWorkerInfoDataSet");
						samWorkerInfoDataSet.commitChanges();
					});
				}else{
					L5.Msg.alert("提示","保存出错！");
				}
			}
	}
	//history.go(0);
}
function undo(){
	//history.go(-1);
	var data=new L5.Map();
	var url="jsp/cams/drel/samu/baseinfo/samGerocomiumInfoList.jsp";
	L5.forward(url,'',data);
}
//保存校验
function saveCheck(){
	var samGerocomiumInfoDataSet=L5.DatasetMgr.lookup("samGerocomiumInfoDataSet");
	var recordGerocomium=samGerocomiumInfoDataSet.getCurrent();
	if(recordGerocomium.get("gerocomiumName")==''){
		L5.Msg.alert("提示","校验未通过，名称不能为空！");
		return false;
	}
	if(recordGerocomium.get("establishDate")==''){
		L5.Msg.alert("提示","校验未通过，建院时间不能为空！");
		return false;
	}
	if(recordGerocomium.get("manaLevel")==''){
		L5.Msg.alert("提示","校验未通过，主管单位名称不能为空！");
		return false;
	}
	if(recordGerocomium.get("areaLevel")==''){
		L5.Msg.alert("提示","校验未通过，所属行政区划名称不能为空！");
		return false;
	}
	if(recordGerocomium.get("totalRoomNum")==''){
		L5.Msg.alert("提示","校验未通过，总房间数不能为空！");
		return false;
	}
	if(recordGerocomium.get("totalBedNum")==''){
		L5.Msg.alert("提示","校验未通过，总床位不能为空！");
		return false;
	}
	if(recordGerocomium.get("gerocomiumLevel")==''){
		L5.Msg.alert("提示","校验未通过，等级不能为空！");
		return false;
	}
	if(recordGerocomium.get("totalArea")==''){
		L5.Msg.alert("提示","校验未通过，占地面积不能为空！");
		return false;
	}
	if(recordGerocomium.get("buildArea")==''){
		L5.Msg.alert("提示","校验未通过，建筑面积不能为空！");
		return false;
	}
	if(recordGerocomium.get("outdoorArea")==''){
		L5.Msg.alert("提示","校验未通过，室外娱乐场所面积不能为空！");
		return false;
	}
	if(recordGerocomium.get("indoorArea")==''){
		L5.Msg.alert("提示","校验未通过，室内娱乐场所面积不能为空！");
		return false;
	}
	if(recordGerocomium.get("fixedAssets")==''){
		L5.Msg.alert("提示","校验未通过，固定资产不能为空！");
		return false;
	}
	if(recordGerocomium.get("supportStandard")==''){
		L5.Msg.alert("提示","校验未通过，五保对象供养标准不能为空！");
		return false;
	}
	if(recordGerocomium.get("managementFunds")==''){
		L5.Msg.alert("提示","校验未通过，管理工作经费不能为空！");
		return false;
	}
	var yearSidelineIncome=document.getElementById("yearSidelineIncome").value;
	if(yearSidelineIncome==''){
		L5.Msg.alert("提示","校验未通过，年副业收入不能为空！");
		return false;
	}
	if(recordGerocomium.get("heatingWay")==''){
		L5.Msg.alert("提示","校验未通过，取暖方式不能为空！");
		return false;
	}
	var vegetablesArea=document.getElementById("vegetablesArea").value;
	if(vegetablesArea==''){
		L5.Msg.alert("提示","校验未通过，年种植蔬菜面积不能为空！");
		return false;
	}
	var vegetablesYield=document.getElementById("vegetablesYield").value;
	if(vegetablesYield==''){
		L5.Msg.alert("提示","校验未通过，年蔬菜产量不能为空！");
		return false;
	}
	if(recordGerocomium.get("serveTowns")==''){
		L5.Msg.alert("提示","校验未通过，所服务乡镇不能为空！");
		return false;
	}
}
//弹出房间信息窗口
function addRoom(){
	var command=new L5.Command("com.inspur.cams.comm.util.IdHelpCmd");
	command.setParameter("IdHelp","Id32");
	command.execute();
	var newId=command.getReturn("id");
	nowId=newId;
	var samRoomInfoDataSet = L5.DatasetMgr.lookup("samRoomInfoDataSet");
	samRoomInfoDataSet.newRecord({roomId:newId});
	var samBedInfoDataSet = L5.DatasetMgr.lookup("samBedInfoDataSet");
	samBedInfoDataSet.filterBy(function(record, roomId){
			if(record.get('roomId')==newId){
				return record;
			}
		});
	var win=L5.getCmp("addRoomWin");
	win.show(this);
}
//删除房间信息
function deleteRoom(){
	var grid=L5.getCmp("gridRoom");
	var record=grid.getSelectionModel().getSelections();
	if(record.length!=1){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var roomName=record[0].get("roomName");
	var samRoomInfoDataSet = L5.DatasetMgr.lookup("samRoomInfoDataSet");
	samRoomInfoDataSet.remove(record[0]);
}
//修改房间信息
function editRoom(){
	var samRoomInfoDataSet = L5.DatasetMgr.lookup("samRoomInfoDataSet");
	var grid=L5.getCmp("gridRoom");
	var record=grid.getSelectionModel().getSelections();
	if(record.length!=1){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var win=L5.getCmp("addRoomWin");
	win.show(this);
	var roomId=record[0].get("roomId");
	var samRoomInfoDataSet = L5.DatasetMgr.lookup("samRoomInfoDataSet");
	samRoomInfoDataSet.setParameter("ROOM_ID@=",roomId);
	var samBedInfoDataSet = L5.DatasetMgr.lookup("samBedInfoDataSet");
	//samBedInfoDataSet.setParameter("ROOM_ID@=",roomId);
	//samBedInfoDataSet.load();
	samBedInfoDataSet.filterBy(function(record, id){
		if(record.get('roomId')==roomId){
			return record;
		}
	});
	//samBedInfoDataSet.setParameter("ROOM_ID",roomId);
	
}
//房间信息窗口继续添加功能
function addRoomSubmit(){
	if(saveRoomCheck()==false){
	}else{
		var command=new L5.Command("com.inspur.cams.comm.util.IdHelpCmd");
		command.setParameter("IdHelp","Id32");
		command.execute();
		var newId=command.getReturn("id");
		var samRoomInfoDataSet = L5.DatasetMgr.lookup("samRoomInfoDataSet");
		samRoomInfoDataSet.newRecord({roomId:newId});
		var samBedInfoDataSet = L5.DatasetMgr.lookup("samBedInfoDataSet");
		samBedInfoDataSet.filterBy(function(record, roomId){
			if(record.get('roomId')==newId){
				return record;
			}
		});
	}
}
//房间信息窗口确定功能（隐藏窗口）
function hideRoom(){
	if(saveRoomCheck()==false){
	}else{
		L5.getCmp("addRoomWin").setVisible(false);
	}
}
//关闭房间信息窗口
function closeRoom(){
	var samRoomInfoDataSet = L5.DatasetMgr.lookup("samRoomInfoDataSet");
	if(method=="insert"){
		samRoomInfoDataSet.remove(samRoomInfoDataSet.getCurrent());
	}
	L5.getCmp("addRoomWin").setVisible(false);
}
//床位信息添加
function addBed(){
	var samRoomInfoDataSet = L5.DatasetMgr.lookup("samRoomInfoDataSet");
	var record = samRoomInfoDataSet.getCurrent();
	var roomId=record.get("roomId");
	var samBedInfoDataSet = L5.DatasetMgr.lookup("samBedInfoDataSet");
	samBedInfoDataSet.newRecord({roomId:roomId});
}
//床位信息修改
function editBed(){
	var samBedInfoDataSet = L5.DatasetMgr.lookup("samBedInfoDataSet");
	var grid=L5.getCmp("bedGrid");
	var record=grid.getSelectionModel().getSelections();
	if(record.length!=1){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	samBedInfoDataSet.remove(record[0]);
}
//床位信息删除
function deleteBed(){
	var samBedInfoDataSet = L5.DatasetMgr.lookup("samBedInfoDataSet");
	var grid=L5.getCmp("bedGrid");
	var record=grid.getSelectionModel().getSelections();
	if(record.length!=1){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	samBedInfoDataSet.remove(record[0]);
}
//房间窗口继续添加和确定按钮的校验
function saveRoomCheck(){
	var samRoomInfoDataSet = L5.DatasetMgr.lookup("samRoomInfoDataSet");
	var record = samRoomInfoDataSet.getCurrent();
	//var samBedInfoDataSet = L5.DatasetMgr.lookup("samBedInfoDataSet");
	//var recordBed=samBedInfoDataSet.getAllRecords();
	if(record==null){
		
	}else{
		var roomName = record.get("roomName");
		if(roomName==""||roomName==null){
			L5.Msg.alert('提醒','房间名称不能为空！');
			return false;
		}
		var inuseArea = record.get("inuseArea");
		if(inuseArea==""||inuseArea==null){
			L5.Msg.alert('提醒','使用面积不能为空！');
			return false;
		}
		var isToilet = record.get("isToilet");
		if(isToilet==""||isToilet==null){
			L5.Msg.alert('提醒','是否带卫生间不能为空！');
			return false;
		}
		var bedNum = record.get("bedNum");
		if(bedNum==""||bedNum==null){
			L5.Msg.alert('提醒','床位数量不能为空！');
			return false;
		}
		var status = record.get("status");
		if(status==""||status==null){
			L5.Msg.alert('提醒','当前状态不能为空！');
			return false;
		}
	}
	
	//var samBedInfoDataSet = L5.DatasetMgr.lookup("samBedInfoDataSet");
	//var recordBed=samBedInfoDataSet.getAllRecords();
}
//弹出人员信息窗口
function addWorker(){
	var samWorkerInfoDataSet = L5.DatasetMgr.lookup("samWorkerInfoDataSet");
	samWorkerInfoDataSet.newRecord({politicsStatus:"13",nation:"01",isLegelPeople:"0",isOnduty:"1"});
	var win=L5.getCmp("addWorkerWin");
	win.show(this);
}
//删除人员信息
function deleteWorker(){
	var grid=L5.getCmp("gridWorker");
	var record=grid.getSelectionModel().getSelections();
	if(record.length!=1){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var roomName=record[0].get("workerName");
	var samWorkerInfoDataSet = L5.DatasetMgr.lookup("samWorkerInfoDataSet");
	if(record[0].get('workerId')==""||record[0].get('workerId')==null){
		samWorkerInfoDataSet.remove(record[0]);
	}else{
		var command=new L5.Command("com.inspur.cams.drel.samu.cmd.SamWorkerInfoCmd");
		command.setParameter("workerId",record[0].get('workerId'));
		command.execute("delete");
		if (!command.error){
			samWorkerInfoDataSet.remove(record[0]);
		}else{
			L5.Msg.alert("提示","删除出错！");
		}
	}
}
//修改人员信息
function editWorker(){
	var grid=L5.getCmp("gridWorker");
	var record=grid.getSelectionModel().getSelections();
	if(record.length!=1){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var win=L5.getCmp("addWorkerWin");
	win.show(this);
	var workerId=record[0].get("workerId");
	var samWorkerInfoDataSet = L5.DatasetMgr.lookup("samWorkerInfoDataSet");
	samWorkerInfoDataSet.setParameter("WORKER_ID@=",workerId);
	//samWorkerInfoDataSet.load();
}
//人员信息窗口继续添加功能
function addWorkerSubmit(){
	if(saveWorkerCheck()!=false){
		var samWorkerInfoDataSet = L5.DatasetMgr.lookup("samWorkerInfoDataSet");
		samWorkerInfoDataSet.newRecord({politicsStatus:"13",nation:"01",isLegelPeople:"0",isOnduty:"1"});
	}
}
//人员信息窗口确定按钮（隐藏窗口）
function hideWorker(){
	if(saveWorkerCheck()!=false){
		L5.getCmp("addWorkerWin").setVisible(false);
	}
}
//人员信息添加确定检验
function saveWorkerCheck(){
	var samWorkerInfoDataSet = L5.DatasetMgr.lookup("samWorkerInfoDataSet");
	var record = samWorkerInfoDataSet.getCurrent();
	if(record==null){
		
	}else{
		var workerName = record.get("workerName");
		if(workerName==""||workerName==null){
			L5.Msg.alert('提醒','员工名称不能为空！');
			return false;
		}
		if(record.get("idCard")==''){
			L5.Msg.alert('提示','身份证号不能为空！');
			return false;
		}
		if(record.get("sex")==''){
			L5.Msg.alert("提示","校验未通过，性别不能为空！");
			return false;
		}
		if(record.get("birthday")==''){
			L5.Msg.alert('提示','出生日期不能为空！');
			return false;
		}
		if(record.get("postProperty")==''){
			L5.Msg.alert("提示","校验未通过，岗位性质不能为空！");
			return false;
		}
		if(record.get("workType")==''){
			L5.Msg.alert('提示','工种不能为空！');
			return false;
		}
		if(record.get("salary")==''){
			L5.Msg.alert("提示","校验未通过，工资不能为空！");
			return false;
		}
		if(document.getElementById('positon').value=='0'&&document.getElementById('resumeTrain').value==''){
			L5.Msg.alert('提示','职务为院长，培训简历不能为空！');
			return false;
		}
	}
}
//关闭人员信息窗口
function closeWorker(){
	var samWorkerInfoDataSet = L5.DatasetMgr.lookup("samWorkerInfoDataSet");
	if(method=="insert"){
		samWorkerInfoDataSet.remove(samWorkerInfoDataSet.getCurrent());
	}else{
		samWorkerInfoDataSet.remove(samWorkerInfoDataSet.getCurrent());
	}
	L5.getCmp("addWorkerWin").setVisible(false);
}
//检测身份证号并回填性别和年龄
function checkIdCradNo(){
 	var idCard=document.getElementById('idCard').value;
 	if(checkIDCard($("idCard")) != true && !(idCard.length==18 && idCard.lastIndexOf("N")>0 )){
		L5.Msg.alert("提示","校验未通过："+"身份证号不合法");
		document.getElementById('idCard').value='';
		return;
	}else{
		//回填性别
		var samWorkerInfoDataSet = L5.DatasetMgr.lookup("samWorkerInfoDataSet");
		document.getElementById('sex').value=getSexByCode(idCard);
		samWorkerInfoDataSet.set("sex",getSexByCode(idCard));
		//回填出生年月	
		document.getElementById('birthday').value=getBirthByCode(idCard);
		samWorkerInfoDataSet.set("birthday",getBirthByCode(idCard));
	}
}
// 弹出本地的行政区划
function func_ForAreaSelect() {
	if(organArea.substring(6,12) != '000000'){//是县级以下
		return;		
	}
	var samGerocomiumInfoDataSet=L5.DatasetMgr.lookup("samGerocomiumInfoDataSet");
	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=-2&organCode="
					+ organArea + "&organName="
					+ escape(encodeURIComponent(organName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("areaLevelId").value = list[0];
		document.getElementById("areaLevel").value = list[1];
		samGerocomiumInfoDataSet.set('areaLevelId',list[0]);
		samGerocomiumInfoDataSet.set('areaLevel',list[1]);
	}
}
// 弹出主管
function func_ForManaSelect() {
	if(organArea.substring(6,12) != '000000'){//是县级以下
		return;		
	}
	var samGerocomiumInfoDataSet=L5.DatasetMgr.lookup("samGerocomiumInfoDataSet");
	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=-2&organCode="
					+ organArea + "&organName="
					+ escape(encodeURIComponent(organName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("manaLevelId").value = list[0];
		document.getElementById("manaLevel").value = list[1];
		samGerocomiumInfoDataSet.set('manaLevelId',list[0]);
		samGerocomiumInfoDataSet.set('manaLevel',list[1]);
	}
}
//弹出所服务乡镇
function func_ForServeAreaSelect(){
	if(organArea.substring(6,12) != '000000'){//是县级以下
		return;		
	} 
	var samGerocomiumInfoDataSet=L5.DatasetMgr.lookup("samGerocomiumInfoDataSet");
	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=-2&radioType=checkbox&organCode="
					+ organArea + "&organName="
					+ escape(encodeURIComponent(organName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("serveTowns").value = list[1];//前台显示服务乡镇名称
		document.getElementById("serveTownsId").value = list[0];//前台显示服务乡镇名称
		samGerocomiumInfoDataSet.set('serveTowns',list[1]);
		samGerocomiumInfoDataSet.set('serveTownsId',list[0]);
	}
}
function checkNum(obj){
	var value = obj.value;
	if(value!=""){
		if(!_isNum(value)){
			L5.Msg.alert("提示",obj.name+"格式不正确！",function(){
				obj.value="";
				obj.focus();
			});
			return false ;
		}
	}
}
function formatFloat(obj){
	var value = obj.value;
	if(value!=""){
		if(isFloat(value)||_isNum(value)){
			obj.value =formatNum(value)
		}else{
			L5.Msg.alert("提示",obj.name+"格式不正确！",function(){
				obj.value="";
				obj.focus();
			});
			return false ;
		}
	}
}