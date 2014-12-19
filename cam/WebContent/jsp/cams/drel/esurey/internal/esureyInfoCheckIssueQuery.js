//页面初始化方法
function init() {
	esureyFamilyDS.setParameter("CUR_ACTIVITY","03");
	esureyFamilyDS.setParameter("CUR_STATE","0");	
	esureyFamilyDS.baseParams['FAMILY_TYPE']='K';
	esureyFamilyDS.baseParams["CHECK_ORG_AREA@like@String"]=organCode.substring(0,6);	
    esureyFamilyDS.setParameter("sort","REG_TIME");
	esureyFamilyDS.setParameter("dir","desc");
	esureyFamilyDS.load();
}

//设置查询（后台组sql语句）
//查询方法
function query(){
	var esureyFamilyDS=L5.DatasetMgr.lookup("esureyFamilyDS");
	var qName=_$("qName"); 
    var qIdCard=_$("qIdCard");
	esureyFamilyDS.baseParams["FAMILY_NAME"]=qName;
	esureyFamilyDS.baseParams["FAMILY_CARD_NO"]=qIdCard;
	esureyFamilyDS.baseParams["CUR_ACTIVITY"]="03";	
	esureyFamilyDS.baseParams["CUR_STATE"]="0";	
	esureyFamilyDS.baseParams["CHECK_ORG_AREA@like@String"]=organCode.substring(0,6);	
	esureyFamilyDS.baseParams['FAMILY_TYPE']='K';
    esureyFamilyDS.setParameter("sort","REG_TIME");
	esureyFamilyDS.setParameter("dir","desc");
	esureyFamilyDS.load();
}

//查看详细信息
function details() {
	var grid=L5.getCmp('sbjtxxGridPanel');
	var cell=grid.getSelectionModel().getSelections();
	if(cell.length!=1){
		L5.Msg.alert("提示","请选择一条记录查看!");
		return false;
	}
	var familyId=cell[0].get("familyId");
	var data=new L5.Map();
	data.put("familyId",familyId);
	data.put("method","detailC");
	var text="困难家庭信息";
	var url="jsp/cams/drel/esurey/internal/esureyInfoDetail.jsp";
	L5.forward(url,text,data);
}

//按成员进行核对分发
function memberIssue() {
	var grid=L5.getCmp('sbjtxxGridPanel');
	var cell=grid.getSelectionModel().getSelections();
	if(cell.length<1){
		L5.Msg.alert("提示","请选择一条记录或多条数据进行核对分发!");
		return false;
	}
	var flg=0;
	for(n=0;n<cell.length;n++){
		if(cell[n].get("curActivity")!="03"||cell[n].get("curState")!="0"){
			flg=1;
		}
	}
	if(flg==1){
		L5.Msg.alert("提示","选中记录中有不在当前环节的记录！");
		return;
	}
	var ids = "";
	for(var i=0; i < cell.length; i++) {
		var selected=cell[0];
		ids += cell[i].get("familyId") + ",";
	}
	ids = ids.substring(0, ids.length - 1);
	
	var data = new L5.Map();
	//data.put("id", ids);
	var url='jsp/cams/drel/esurey/internal/esureyInfoCheckIssueMember.jsp'+'?id='+ids;
	var text = '准备核对家庭信息';
	L5.forward(url,text,data);
}

//按家庭进行核对分发
function familyIssue() {
	var grid=L5.getCmp('sbjtxxGridPanel');
	var cell=grid.getSelectionModel().getSelections();
	if(cell.length<1){
		L5.Msg.alert("提示","请选择一条记录或多条数据进行核对分发!");
		return false;
	}
	
	var ids = "";
	for(var i=0; i < cell.length; i++) {
		var selected=cell[0];
		ids += cell[i].get("familyId") + ",";
	}
	ids = ids.substring(0, ids.length - 1);
	
	var data = new L5.Map();
	//data.put("id", ids);
	var url='jsp/cams/drel/esurey/internal/esureyInfoCheckIssueFamily.jsp'+'?id='+ids;
	var text = '选中家庭信息';
	L5.forward(url,text,data);
}


