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
*保存
*/
function saveElection(){

	var fundElectionDS=L5.DatasetMgr.lookup("fundElectionDS");
	var somElection=fundElectionDS.getCurrent();
	var validate=fundElectionDS.isValidate(true);
	if(validate!=true){
		L5.Msg.alert("提示","校验未通过，"+validate);
		return;
	}
	var command=new L5.Command("com.inspur.cams.sorg.manage.cmd.SomFundElectionCmd");
	command.setParameter("somElection",somElection);
	command.setParameter("electionPeriod",""+$("electionPeriod").value);
	command.execute("updateElection");
	if (!command.error) {
		L5.Msg.alert("提示","修改成功！",function(){
			var url="jsp/cams/sorg/manage/fund/somFundElectionList.jsp";
			L5.forward(url);		
		});
	}else{
		L5.Msg.alert("提示","Error: " + command.error);
	}	
}
/**
*返回
*/
function backMain(){
	var url="jsp/cams/sorg/manage/fund/somFundElectionList.jsp";
	L5.forward(url);
}
function changeElectionPeriod(){
	var dates=electionDate.split("-");
	electionPeriodDate=parseInt(dates[0])+parseInt($("electionPeriod").value)+"-"+dates[1]+"-"+dates[2];
	$("electionPeriodDate").innerHTML=electionPeriodDate;
}