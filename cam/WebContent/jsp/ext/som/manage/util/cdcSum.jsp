<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<script type="text/javascript">
var organPath=organCode;
var organPathLevel=organLevel;
var childDataSet;
var parentCodeSearch;
var reportFlag=true;//下级单位是否全部上报
//注册dataset事件
function regMethod(){
	var listDataSet=L5.DatasetMgr.lookup(childDataSet);
	var cityDataSet=L5.DatasetMgr.lookup("cityDataSet");
	listDataSet.on('beforeload',function(){
		listDataSet.removeAll();
	});
	cityDataSet.on('beforeload',function(){
		cityDataSet.removeAll();
	});
	listDataSet.on('load',function(){
		cityDataSet.setParameter("id",parentCodeSearch);
		cityDataSet.load();
	});
	cityDataSet.on('load',function(){
		cityDataSet.each(function(record,index){
			if(listDataSet.find("organCode",record.get("id"),0)==-1){
				//有未上报下级单位
				if(parentCodeSearch==organCode){
					reportFlag=false;
				}
				listDataSet.newRecord({"organCode":record.get("id"),"organName":record.get("name"),"parentCode":record.get("ups"),"status":"0"});
			}
		});
	});
}
//查询下级数据
function getUnder(parentCode){
	parentCodeSearch=parentCode;
	var listDataSet=L5.DatasetMgr.lookup(childDataSet);
	listDataSet.setParameter("PARENT_CODE@=",parentCode);
	listDataSet.setParameter("STATUS@=","1");
	listDataSet.setParameter("REPORT_DATE@=",_$("reportDate"));
	listDataSet.load();
}
function getData(){
	if($("reportDate").value==""){
		var listDataSet=L5.DatasetMgr.lookup(childDataSet);
		listDataSet.removeAll();
		organPath=organCode;
		hiddenButton();
		return;
	}else{
		reportFlag=true;
		organPath=organCode;
		organPathLevel=organLevel;
		getUnder(organCode);
	}
}
//获取code的下级单位
function getChild(code){
	getUnder(code);
	organPath=organPath+"#"+code;
	if(organPathLevel=="11"){
		organPathLevel="12";
	}else if(organPathLevel=="12"){
		organPathLevel="13";
	}else if(organPathLevel=="13"){
		organPathLevel="JD";
	}
	hiddenButton();
}
//获取上级单位
function getUp(){
	var len=organPath.lastIndexOf("#");
	if(len!=-1&&len!=0){
		organPath=organPath.substr(0,len);
		getUnder(organPath.substr(organPath.lastIndexOf("#")+1,organPath.length));
		if(organPathLevel=="12"){
			organPathLevel="11";
		}else if(organPathLevel=="13"){
			organPathLevel="12";
		}else if(organPathLevel=="JD"){
			organPathLevel="13";
		}
		hiddenButton();
	}
}
function hiddenButton(){
	if(organPath.indexOf("#")==-1&&method=="insert"){
		$("auditButton").style.display="";
	}else{
		$("auditButton").style.display="none";
	}
}
//未填报单位显示红色，填报显示蓝色，社区级无超链接
function statusRender(val,el,rec){
	var color;
	if(rec.get("status")=="0"){
		color= 'red';
	}else{
		color= 'blue';
	}
	var desc='<font color="'+color+'">'+val+'</font>';
	if(organPathLevel!="JD"){
		desc='<a href="javascript:getChild(\''+rec.get("organCode")+'\')">'+desc+'</a>'
	}
	return desc;
}
</script>