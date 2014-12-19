/**
*
*/
var electionDate;
var electionPeriodDate;
var electionPeriod;
var sorgId;
function init(){
	var organDataSet=L5.DatasetMgr.lookup("organDataSet");
	organDataSet.setParameter("SOM_ORGAN.SORG_TYPE@=","J");
	organDataSet.setParameter("SOM_ORGAN.SORG_ID@=",sorgId);
	organDataSet.load();
	organDataSet.on('load',function(organDataSet){
		if(organDataSet.getCount()==0){
			L5.Msg.alert("提示","此基金会已经不存在了！");
			return ;
		}else{
			var record=organDataSet.getCurrent();
			$("sorgCode").innerText=record.get("sorgCode");
			$("cnName").innerText=record.get("cnName");
			$("sorgId").value=record.get("sorgId");
			electionDate=record.get("electionDate");
			$("electionDate").innerHTML=electionDate;
			electionPeriod=record.get("electionPeriod");
			$("electionPeriod").innerHTML=electionPeriod;
			var dates=electionDate.split("-");
			electionPeriodDate=parseInt(dates[0])+electionPeriod+"-"+dates[1]+"-"+dates[2];
			$("electionPeriodDate").innerHTML=electionPeriodDate;
		}	
	});
	
    var fundElectionDS=L5.DatasetMgr.lookup("fundElectionDS");
    fundElectionDS.setParameter("id",id);
	fundElectionDS.load();

}

/**
*返回
*/
function backMain(){
	var url="jsp/cams/sorg/manage/fund/somFundElectionList.jsp";
	L5.forward(url);
}
