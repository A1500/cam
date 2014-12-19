function init() {
	var ndYearDataset = L5.DatasetMgr.lookup("ndYearDataset");
	ndYearDataset.baseParams["filterSql"]=" ks_sign = '0'";//1:登记员
	ndYearDataset.load();
	var infocommand = new L5.Command("com.inspur.cams.comm.informUtil.InformSessionCmd");
	infocommand.execute("getUserInfo");
	var userLoginId ="";
	if (!infocommand.error) {
		var info = infocommand.getReturn("userInfo");
		  userLoginId =info.userLoginName;//通过登录账号查找对应的婚姻登记处。
	}
	
	var commDeptId = new L5.Command("com.inspur.cams.marry.base.cmd.MrmBasePersonCommand");
	commDeptId.setParameter("loginId",userLoginId);
	commDeptId.execute("getDeptId");
	var deptId = commDeptId.getReturn("deptId");
	
//	ds.baseParams["organId"]=organCode;
	ds.baseParams["deptId"]=deptId;
//	ds.baseParams["bzyCode"]="01";//01：登记员
	ds.baseParams["ksSign"]="0";//0：登记员
	ds.load();
	
	L5.QuickTips.init();
};

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}

function query(){		
	ds.setParameter("ndYear",getParam("ndYear"));		
	ds.setParameter("ksjg",getParam("ksjg"));		
	ds.load();
}
function rest(){
	document.getElementById("ndYear").value = ''; 
	document.getElementById("ksjg").value = ''; 
}