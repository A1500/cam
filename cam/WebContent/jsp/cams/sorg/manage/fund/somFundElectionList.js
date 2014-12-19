/**
*
*/
function init(){
	var fundElectionDS=L5.DatasetMgr.lookup("fundElectionDS");
	fundElectionDS.setParameter("SORG_TYPE@=","J");
	fundElectionDS.setParameter("IF_CURRENT@=","1");
	fundElectionDS.load();
}
/**
*查询
*/
function query(){
	var fundElectionDS=L5.DatasetMgr.lookup("fundElectionDS");
    var qcnName=_$("qcnName"); 
    var qmeetingName=_$("qmeetingName");
    var qifCurrent=_$("qifCurrent");
    if(qcnName=="") qcnName=undefined;
    if(isQuoteIn(qcnName)){
    	L5.Msg.alert("提示","基金会名称含有非法字符！");
    	return false;
    }
	fundElectionDS.setParameter("SOM_MEETING.SORG_ID@like",qcnName);
	

	if(qmeetingName=="") qmeetingName=undefined;
    if(isQuoteIn(qmeetingName)){
    	L5.Msg.alert("提示","会议名称含有非法字符！");
    	return false;
    }		
	fundElectionDS.setParameter("SOM_MEETING.MEETING_NAME@like",qmeetingName);	
	
	if(qifCurrent=="") qifCurrent=undefined;
	fundElectionDS.setParameter("SOM_MEETING.IF_CURRENT@=",qifCurrent);	
	
	fundElectionDS.load();
}
/**
*新增
*/
function newElection(){
	var url="jsp/cams/sorg/manage/fund/somFundElectionInsert.jsp";
	L5.forward(url);
}
/**
*修改
*/
function editElection(){
	var Election=L5.getCmp("ElectionGrid");
	var records=Election.getSelectionModel().getSelections();
	if(records.length!=1){
		L5.Msg.alert("提示","请先选择一行！");
		return false;
	}
	var data=new L5.Map();
	data.put("id",records[0].get("id"));
	data.put("sorgId",records[0].get("sorgId"));	
	var text="基金会换届（成立）选举报告";
	var url="jsp/cams/sorg/manage/fund/somFundElectionUpdate.jsp";
	L5.forward(url,text,data);
}
/**
*查看明细
*/
function detailElection(){
	var Election=L5.getCmp("ElectionGrid");
	var records=Election.getSelectionModel().getSelections();
	if(records.length!=1){
		L5.Msg.alert("提示","请先选择一行！");
		return false;
	}
	var data=new L5.Map();
	data.put("id",records[0].get("id"));
	data.put("sorgId",records[0].get("sorgId"));	
	var text="基金会换届（成立）选举报告";
	var url="jsp/cams/sorg/manage/fund/somFundElection.jsp";
	L5.forward(url,text,data);
}