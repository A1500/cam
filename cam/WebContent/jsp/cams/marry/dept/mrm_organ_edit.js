function init() {
	var infocommand = new L5.Command("com.inspur.cams.comm.informUtil.InformSessionCmd");
		infocommand.execute("getUserInfo");
		var userLoginName ="";
		var organCode ="";
		var organName ="";
		if (!infocommand.error) {
			var info = infocommand.getReturn("userInfo");
			  userLoginName =info.userLoginName;//通过登录账号查找对应的婚姻登记处。
			  organCode =info.cantCode;//通过登录账号查找对应的婚姻登记处。
			  organName =info.userDepOrganName;
			}
	var mrmBasePersonCommand = new L5.Command("com.inspur.cams.marry.base.cmd.MrmBasePersonCommand");
		mrmBasePersonCommand.setParameter("loginId",userLoginName);
		mrmBasePersonCommand.execute("getDeptId");
		if (!mrmBasePersonCommand.error) {
			 deptId = mrmBasePersonCommand.getReturn("deptId");
			 deptName= mrmBasePersonCommand.getReturn("deptName");
			}
			
			if(deptId=="" || deptId==null){
				ds.newRecord();
				alert("没有对应的婚姻登记处！");
				return false;
			
			}
    ds.setParameter("DEPT_CODE@=",deptId);
	ds.load();
	L5.QuickTips.init(); 
	document.getElementById("regionCode").value=organCode;
	document.getElementById("regionName").value=organName;
	document.getElementById("deptOrgan").value=organName+"婚姻登记处";

}

 
function save() {
	var record = ds.getCurrent();
	var isValidate = ds.isValidate();
	if(isValidate != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+isValidate);
		return false;
	}
	if(record.get("deptCode").length>200){
		alert("部门代码长度不能大于200！");
		return false;
	}
	if(record.get("name").length>30){
		alert("名称长度不能大于30！");
		return false;
	}
	if(record.get("deptAddress").length>200){
		alert("地址长度不能大于200！");
		return false;
	}
	if(record.get("deptPost").length>100){
		alert("邮编长度不能大于100！");
		return false;
	}
	if(record.get("deptTel").length>100){
		alert("服务电话长度不能大于100！");
		return false;
	}
	if(record.get("deptFax").length>100){
		alert("传真电话长度不能大于100！");
		return false;
	}
	if(record.get("regionCode").length>50){
		alert("所属行政区代码长度不能大于50！");
		return false;
	}
	if(record.get("regionName").length>50){
		alert("所属行政区长度不能大于50！");
		return false;
	}
	if(record.get("deptOrgan").length>50){
		alert("所属民政局长度不能大于50！");
		return false;
	}
	if(record.get("abolishDate").length>19){
		alert("撤销时间长度不能大于19！");
		return false;
	}
	if(record.get("abolishReason").length>500){
		alert("撤销原因长度不能大于500！");
		return false;
	}
	if(record.get("abolishYwgs").length>4){
		alert("撤销后业务归属长度不能大于4！");
		return false;
	}
	if(record.get("homeUrl").length>250){
		alert("部门外网URL长度不能大于250！");
		return false;
	}
	
	if(record.get("remark").length>1000){
		alert("备注长度不能大于1000！");
	}
	
	var command=new L5.Command("com.inspur.cams.marry.base.cmd.MrmRegisOrganInfoCommand"); 
	command.setParameter("record", record);
	command.execute("update");
	if (!command.error) {
		ds.commitChanges();
		L5.Msg.alert('提示',"数据保存成功!");
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}

function getTimes(item) {
	LoushangDate(item.previousSibling);
}
function levelApply(){
	var data = new L5.Map();
	data.put("method","INSERT");
	var url='jsp/cams/marry/dept/level/mrm_level_apply.jsp';
	var text = '增加资源信息表';
	L5.forward(url,text,data);
	
}
 