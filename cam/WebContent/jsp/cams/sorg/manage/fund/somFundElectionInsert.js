/**
*
*/
var electionDate;
var electionPeriodDate;
var electionPeriod;
var sorgId;
function init(){
    var fundElectionDS=L5.DatasetMgr.lookup("fundElectionDS");
	fundElectionDS.newRecord();
	document.getElementById("sorgCode").focus();

}
/**
*保存
*/
function saveElection(){
	if(_$("electionPeriod")!=""){
		electionPeriod=_$("electionPeriod");
	}
	var fundElectionDS=L5.DatasetMgr.lookup("fundElectionDS");
	sorgId=_$("sorgId");
	if(""==sorgId){
		L5.Msg.alert("提示","基金会不存在，不可以备案！");
		return false;
	}
	var somElection=fundElectionDS.getCurrent();
	var validate=fundElectionDS.isValidate(true);
	if(validate!=true){
		L5.Msg.alert("提示","校验未通过，"+validate);
		return;
	}
	somElection.set("sorgId",sorgId);
	somElection.set("sorgType","J");
	var command=new L5.Command("com.inspur.cams.sorg.manage.cmd.SomFundElectionCmd");
	command.setParameter("somElection",somElection);
	command.setParameter("electionDate",_$("meetingDate"));
	command.setParameter("electionPeriod",""+electionPeriod);
	command.setParameter("sorgId",sorgId);
	command.execute("insertElection");
	if (!command.error) {
		L5.Msg.alert("提示","保存成功！",function(){
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
function querySorgFundMess(){
	$("sorgId").value="";
	$("cnName").innerHTML="";
	$("electionDate").value="";
	$("electionPeriodDate").value="";
	var sorgCode=_$("sorgCode").trim();
	if(sorgCode!=""){
		var organDataSet=L5.DatasetMgr.lookup("organDataSet");
		organDataSet.setParameter("SOM_ORGAN.SORG_TYPE@=","J");
		organDataSet.setParameter("SOM_ORGAN.SORG_CODE@=",sorgCode);
		organDataSet.load();
		organDataSet.on('load',function(organDataSet){
			if(organDataSet.getCount()==0){
				L5.Msg.alert("提示","此登记证号不存在,请重新填写！");
				$("sorgCode").value="";
				return;
			}else if("32"==organDataSet.getCurrent().get("sorgStatus") || "62"==organDataSet.getCurrent().get("sorgStatus")){
				L5.Msg.alert("提示","此基金会已注销，不可以进行备案！");
				return;
			}else if("52"==organDataSet.getCurrent().get("sorgStatus")){
				L5.Msg.alert("提示","此基金会已撤销，不可以进行备案！");
				return;
			}else if("22"==organDataSet.getCurrent().get("sorgStatus")){
				record=organDataSet.getCurrent();
				$("sorgCode").value=record.get("sorgCode");
				$("sorgId").value=record.get("sorgId");
				$("cnName").innerHTML=record.get("cnName");
				electionDate=record.get("electionDate");
				if(electionDate==""){
					$("electionPeriodTr").style.display="block";
					
				}else{
				$("electionDate").innerHTML=electionDate;
				electionPeriod=record.get("electionPeriod");
				var dates=electionDate.split("-");
				electionPeriodDate=parseInt(dates[0])+electionPeriod+"-"+dates[1]+"-"+dates[2];
				
				$("electionPeriodDate").innerHTML=electionPeriodDate;
				}
			}else{
				L5.Msg.alert("提示","此基金会未正式成立，不可以进行备案！");
				return;
			}
		});
	}
}	
