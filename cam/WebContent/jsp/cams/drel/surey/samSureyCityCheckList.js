//单位类型--民政局--'A1'
var SAM_ORGAN_TYPE = "A1";
//流程结束标志--未结束
var UNClOSED = "0";
//当前环节--区核对
var ACT_CHECK = "ACT_CHECK";
//当前环节--市核对
var ACT_CITY_CHECK = "ACT_CITY_CHECK";
//当前环节--区填报
var ACT_FILLING = "ACT_FILLING";
//当前环节--市转发
var ACT_CITY_SEND = "ACT_CITY_SEND";
//当前环节--市填报
var ACT_CITY_FILLING = "ACT_CITY_FILLING";
//当前环节--市分发
var ACT_DISPENSE = "ACT_DISPENSE";
//环节状态--待办
var TODO = "TODO";
//环节状态--转办
var TO_OTHER = "TO_OTHER";
//环节状态--已办
var DONE = "DONE";
//市级民政
var BE_CITY = "beCity";
//区县民政
var BE_DISTRICT = "beDistrict";
function init() {
	var SamSureyWfDS = L5.DatasetMgr.lookup("SamSureyWfDS");
	SamSureyWfDS.baseParams["CUR_ACTIVITY@in"] = ACT_CITY_SEND + "," + ACT_FILLING + "," + ACT_CITY_CHECK+","+ACT_CITY_FILLING;
	SamSureyWfDS.baseParams["CUR_STATUS@in"] = TODO + "," + DONE;
	SamSureyWfDS.baseParams["CUR_ACTIVITY_ORGAN_TYPE"] = SAM_ORGAN_TYPE;
	SamSureyWfDS.baseParams["CUR_ACTIVITY_AREA"] = organArea;
	SamSureyWfDS.baseParams["IS_FINISH"] = UNClOSED;
	SamSureyWfDS.setParameter("sort", "CUR_ACTIVITY_ST");
	SamSureyWfDS.setParameter("dir", "desc");
	SamSureyWfDS.load();
}
/*****地市流程调整 开始****/
//移交
function transfer() {
	var grid = L5.getCmp("surey_done_grid");
	var selected = grid.getSelectionModel().getSelections();
	if (selected.length < 1) {
		L5.Msg.alert("\u63d0\u793a", "\u8bf7\u9009\u62e9\u4e00\u6761\u8981\u6838\u5bf9\u7684\u8bb0\u5f55\uff01");
		return;
	}
	L5.MessageBox.confirm("\u63d0\u793a", "\u4f60\u786e\u5b9a\u8981\u79fb\u4ea4\u9009\u4e2d\u7684\u8bb0\u5f55\uff01", function (sta) {
		if (sta == "yes") {
			var length = selected.length;
			for (var i = 0; i < length; i++) {
				var surveyId = selected[i].get("surveyId");
				var applyTitle = selected[i].get("applyTitle");
				var flowId = selected[i].get("flowId");
				var curActivity = selected[i].get("curActivity");
				var curStatus = selected[i].get("curStatus");
				var domicileCode = selected[i].get("domicileCode");
				var apanageCode = selected[i].get("apanageCode");
			 
			   
				var map = new L5.Map();
				map.put("flowId", flowId);
				map.put("surveyId", surveyId);
				map.put("organId", organId);
				map.put("userId", userId);
				map.put("organName", organName);
				map.put("userName", userName);
				map.put("domicileCode", domicileCode);
				map.put("apanageCode", apanageCode);
				if ( curActivity == ACT_CITY_CHECK && curStatus == TODO ) {
					//市经济核对中心下发核对任务到区县经济核对中心
					var command = new L5.Command("com.inspur.cams.drel.surey.comm.cmd.SamSureyWfCmd");
					command.setParameter("map", map);
					command.execute("cityDistribute");
					if (!command.error) {
						var SamSureyWfDS = L5.DatasetMgr.lookup("SamSureyWfDS");
						SamSureyWfDS.remove(selected[i]);
					} else {
						L5.Msg.alert("\u9519\u8bef", applyTitle + "\u79fb\u4ea4\u5931\u8d25\uff01", function () {
						});
					}
				}else if( curActivity == ACT_CITY_SEND && curStatus == TODO ){
			 
					//市经济核对中心核对请求转发给区县经济核对中心--区县
						var command=new L5.Command("com.inspur.cams.drel.surey.comm.cmd.SamSureyWfCmd");
						command.setParameter("map",map);
						command.execute("cityCenterToTownCenter");
						if(!command.error){
							var SamSureyWfDS=L5.DatasetMgr.lookup("SamSureyWfDS");
							SamSureyWfDS.remove(selected[i]);
						}else{
							L5.Msg.alert("错误",applyTitle+'移交失败！',function(){});
						}
		       } else if(curActivity==ACT_CITY_CHECK&&curStatus==DONE){
		 
					//市经济核对中心将核对结果反馈给市外部单位 
						var command=new L5.Command("com.inspur.cams.drel.surey.comm.cmd.SamSureyWfCmd");
						command.setParameter("map",map);
						command.execute("cityDistributeToApply");
						if(!command.error){
							var SamSureyWfDS=L5.DatasetMgr.lookup("SamSureyWfDS");
							SamSureyWfDS.remove(selected[i]);
						}else{
							L5.Msg.alert("错误",applyTitle+'移交失败！',function(){});
						}
		       } else if (curActivity == ACT_FILLING && curStatus == DONE) {
					//区填报 已办
					 
						var command = new L5.Command("com.inspur.cams.drel.surey.comm.cmd.SamSureyWfCmd");
						command.setParameter("map", map);
						command.execute("districtFilling");
						if (!command.error) {
							var SamSureyWfDS = L5.DatasetMgr.lookup("SamSureyWfDS");
							SamSureyWfDS.remove(selected[i]);
						} else {
							L5.Msg.alert("\u9519\u8bef", applyTitle + "\u79fb\u4ea4\u5931\u8d25\uff01", function () {
							});
						}
			  	} else if (curActivity == ACT_CITY_FILLING && curStatus == DONE) {
					// 市经济核对中心将核对结果反馈给区县
				 
						var command = new L5.Command("com.inspur.cams.drel.surey.comm.cmd.SamSureyWfCmd");
						command.setParameter("map", map);
						command.execute("cityCenterToApply");
						if (!command.error) {
							var SamSureyWfDS = L5.DatasetMgr.lookup("SamSureyWfDS");
							SamSureyWfDS.remove(selected[i]);
						} else {
							L5.Msg.alert("\u9519\u8bef", applyTitle + "\u79fb\u4ea4\u5931\u8d25\uff01", function () {
							});
						}
			  	}
			}
		}
	});
}
/*****地市流程调整 结束****/

