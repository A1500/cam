// 与户主关系字典表
function get_Hzgx_Value(value){
	var dataSet=L5.DatasetMgr.lookup("DmHzgxDataSet");
	var record=dataSet.getById(value);
   	if(record){
   		return record.get("text");
   	}
	return value;
}
 /*
	 * 函数名称：function  __isCN()
	 * 函数功能：判断是否含有中文及全角？之外的其他字符
	 * 作    者：
	 * 时    间：
	 */
 function __isCN(s){
		var i=s.indexOf(".");
		if(i>-1){
			s=s.replace(".","");
		}
		var re = /^[?\u4E00-\u9FA5]+$/;
		return re.test(s);
 }

//姓名输入中文校验
function checkCN(propertyName,tempProperty,ChineseName){
 var obj = document.getElementsByName(propertyName)[0];
 var tempObj = document.getElementsByName(tempProperty)[0];
 if (obj==null){
  return true;
 }
 var str = obj.value;
 if(str.length==0||__isCN(str)){
  return true;
 }else{
  alert("属性‘"+ ChineseName+"’包含非中文，请重新输入！");


  obj.value="";
  obj.select();
  return false;
 }
  return true;
 }

 //家庭成员姓名校验
function checkJtcyCN(propertyId,tempProperty,ChineseName){
 var obj = document.getElementById(propertyId);
 var tempObj = document.getElementsByName(tempProperty)[0];
 if (obj==null){
  return true;
 }
 var str = obj.value;
 if(str.length==0||__isCN(str)){
  return true;
 }else{
  alert("属性‘"+ ChineseName+"’包含非中文，请重新输入！");

  obj.value="";
  obj.select();
  return false;
 }
  return true;
 }

function CheckTxt(ObjNum,ChnName)
 {
 var regExp=/^\d+(\.\d+)?$/;
 var elementTxt=document.getElementById (ObjNum);
 	if(regExp.test (elementTxt.value ))
 	{
 	return true ;
 	}
	else
 	{
	  alert (ChnName+'请输入阿拉伯数字');
	  elementTxt.focus();
	  elementTxt.value="";
	  return false ;
 	}
 }
 function jzlxDbClick() {
	document.getElementById("jzlx").value="";
	document.getElementById("jzlxquery").value="";
}
//校验家庭成员是否重复
/**
 * 是否已经加入了相同编号的流水号
 * @return
 */
function checkCyxxIfReapeat() {

	var rcd = YgjzJtxxCyxxDataSet2.getCurrent();

	var aas=document.getElementById("idCard").value;
	var cmd = new L5.Command('com.inspur.sdmz.jtxx.cmd.YgjzJtxxCyxxCmd');
	cmd.setParameter('sfzh',aas);
	cmd.setParameter('peopleId',rcd.get("peopleId"));

	cmd.execute('checkAdd');
	var num = cmd.getReturn('num');
	if(num!=undefined||num==true){
       L5.Msg.alert("提示","此人已经登记请确认!");
       document.getElementById("idCard").value="";
	}
	
	return ;
}
