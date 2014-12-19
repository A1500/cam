 
//当前command
var command;
//当前dataset
var dataset;
//当前页面
var currentJsp;
//提交条件是否正确
var flag=true;
//页面初始化方法
function init(){
	
	domicileDataset.setParameter("filterSql"," id like '"+organCode.substring(0,4)+"%000000'");
	domicileDataset.load();
	//得到当前路径
	var parths=document.location.pathname.split("/");
	currentJsp=parths[parths.length-1];
	//根据当前路径中的jsp文件名判断使用哪个Command和dataset
	if(currentJsp=="esureyCredit.jsp"){
		command=new L5.Command("com.inspur.cams.drel.esurey.cmd.SamEsureyFamilyQueryCmd");
		dataset=L5.DatasetMgr.lookup("externalCreditDataset");
		queryCredit();
	}
	
}
//弹出救助对象属地选择通用帮助
function forHelp(){
       var revalue=window.showModalDialog("../../../../../jsp/bsp/organization/getselect_code.jsp?rootId="+struId+"&showOrganType=1&organType=11,12,13&isExact=0&isCheckBox=0&isTree=1","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
       if(revalue!=""&&revalue!=undefined){
          var list = revalue.split(";");
          document.getElementById("familyAddress").value = list[1];
          document.getElementById("familyAddressh").value = list[0];
       }     
}
//检查时间段合法
function checked(){
	var s=document.getElementById("startTime").value;
    var e=document.getElementById("endTime").value; 
	if(e!==""&&s>e){
		document.getElementById("et").innerHTML='<font color="red">开始时间不能晚于结束时间</font>';
		flag=false;
	}else{
		document.getElementById("et").innerHTML='';
		flag=true;
	}
}



//诚信查询按钮方法
function queryCredit(){
	checked();
	if(flag){
		dataset.setParameter("creditRating",getParam("creditRating"));
		dataset.setParameter("assistanceType",getParam("assistanceType"));
		dataset.setParameter("familyAddress",getParam("familyAddressh"));
		dataset.setParameter("startTime",getParam("startTime"));
		dataset.setParameter("endTime",getParam("endTime"));
		dataset.setParameter("organArea",organArea);
		dataset.load();
	}
}

//根据组件的ID得到组件的value
function getParam(ElementId){
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
