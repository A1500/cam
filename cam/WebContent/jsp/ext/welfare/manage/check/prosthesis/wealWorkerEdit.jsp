<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<next:ScriptManager />
<%
	String method = (String)request.getParameter("method");
	String workerId = (String)request.getParameter("workerId");
	String taskCode = (String)request.getParameter("taskCode");
	if(workerId==null){
		workerId=IdHelp.getUUID32();
	}
	
%>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript">
	workerId='<%=workerId%>';
	method='<%=method%>';
	taskCode='<%=taskCode%>';
	
	function init() {
		if(method=="INSERT"){
			workerDataSet.setParameter("WORKER_ID@=",workerId);
			workerDataSet.load();
			workerDataSet.on('load',function(ds){
				if(ds.getCount()==0){
					workerDataSet.newRecord({"workerId":workerId,"taskCode":taskCode});
				}
			});
		}else{
			workerDataSet.setParameter("WORKER_ID@=",workerId);
			workerDataSet.load();
		}
	};
	function save(){
	var record = workerDataSet.getCurrent();
	var isValidate = workerDataSet.isValidate();
	if(isValidate != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+isValidate);
		return false;
	}
	
	 var info =  validateInfo();
	 if(info){
		alert(info);
		return false;
 	 }
	
	var command = new L5.Command("com.inspur.cams.welfare.base.cmd.WealWorkerCommand");
	command.setParameter("record", record);
		if(method=="INSERT"){
			command.execute("insert");
		}else{
			command.execute("update");
		}
		if (!command.error) {
			if(method=="INSERT"){
				L5.MessageBox.confirm('提示',"数据保存成功,是否继续添加",function(state){
					if(state=="yes"){
					
						var command=new L5.Command("com.inspur.cams.comm.util.IdHelpCmd");
						command.setParameter("IdHelp","Id32");
						command.execute();
						var workerIdS=command.getReturn("id");
						workerDataSet.newRecord({"workerId":workerIdS,"taskCode":taskCode});
						
						var parent=window.dialogArguments;
						parent.init();
					}else{
						window.close();
						var parent=window.dialogArguments;
						parent.init();
					}
					
				});
			}else{
				L5.Msg.alert('提示',"数据保存成功！");
				var parent=window.dialogArguments;
				parent.init();
			}
		}else{
			L5.Msg.alert('提示',"保存时出现错误！"+command.error);
		}
	}
	
	//身份证号校验
	function checkIdCradNo(){
		var idCard=document.getElementById('idCard').value;
	 	if(checkIDCard($("idCard")) != true && !(idCard.length==18 && idCard.lastIndexOf("N")>0 )){
			L5.Msg.alert("提示","校验未通过："+"身份证号不合法");
			document.getElementById('idCard').value='';
			return;
		}else{
			//回填性别
			document.getElementById('sex').value=getSexByCode(idCard);
			workerDataSet.set("sex",getSexByCode(idCard));
		}
	}
	//持证情况
	var flag1=false;
	var flag2=false;
	
	function checkYN(flag){
		(flag=="1")?$("certCode").removeAttribute("disabled"):$("certCode").disabled="disabled";
		(flag=="1")?$("certDate").removeAttribute("disabled"):$("certDate").disabled="disabled";
		if(flag=="0"){
			$("certDate").value="";
			$("certCode").value="";
			workerDataSet.getCurrent().set("certDate",$("certDate").value);
			workerDataSet.getCurrent().set("certCode",$("certCode").value);
		}
		(flag=="1")?flag1=true:flag1=false;
	}
	function checkSpecialYN(flag){
		(flag=="1")?$("certSpecialCode").removeAttribute("disabled"):$("certSpecialCode").disabled="disabled";
		(flag=="1")?$("certSpecialDate").removeAttribute("disabled"):$("certSpecialDate").disabled="disabled";
		if(flag=="0"){
			$("certSpecialCode").value="";
			$("certSpecialDate").value="";
			workerDataSet.getCurrent().set("certSpecialDate",$("certSpecialDate").value);
			workerDataSet.getCurrent().set("certSpecialCode",$("certSpecialCode").value);
		}
		(flag=="1")?flag2=true:flag2=false;
	}
	
	function validateInfo(){
		if(flag1){
			if(_$("certCode")==""){
				return "职业资格证书证书编号不能为空";
			}else if(_$("certDate")==""){
				return "职业资格证书发证时间不能为空";
			} 
		}
		if(flag2){
			if(_$("certSpecialCode")==""){
				return "特有工种职业资格证书证书编号不能为空";
			}else if(_$("certSpecialDate")==""){
				return "特有工种职业资格证书发证时间不能为空";
			}
		}
	}
	
	
</script>
<link href="css/prosthesisapply2.css" type="text/css" rel="stylesheet" />
<style type="text/css">
	table {
		margin-top:50px;
	}
</style>
<title>职工信息</title>
</head>
<body>
<model:datasets>
	<!-- 职工信息表 -->
	<model:dataset id="workerDataSet" cmd="com.inspur.cams.welfare.base.cmd.WealWorkerQueryCommand" global="true" pageSize="20">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealWorker">
		<model:field name="name" type="string" rule="require" />
		</model:record>
	</model:dataset>
	<!-- 残疾类别 -->
	<model:dataset id="disabilityTypeDataset"cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_DISABILITY_TYPE'></model:param>
		</model:params>
	</model:dataset>
	<!-- 残疾等级 -->
	<model:dataset id="DmCjdjDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_HANDICAP_LEVEL'></model:param>
			<model:param name="filterSql" value=' 1=1 order by  CODE DESC'></model:param>
		</model:params>
	</model:dataset>
	<!-- 是否-->
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 有无-->
	<model:dataset id="comm_haveorno" enumName="COMM.HAVEORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 性别 -->
	<model:dataset id="sex" enumName="COMM.SEX"
		autoLoad="true" global="true"></model:dataset>
	<!-- 文化程度-->
	<model:dataset id="eduDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='dic_education'></model:param>
		</model:params>
	</model:dataset>
	<!-- 发放方式 -->
	<model:dataset id="allocation_Type" enumName="WEAL.ALLOCATION_TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 入厂形式 -->
	<model:dataset id="entry_type" enumName="WEAL.ENTRY_TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 职业资格等级 -->
	<model:dataset id="job_level" enumName="WEAL.JOB_LEVEL" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<div id="float" >
	<input field="" type="button" value="保存" style="height:25px;width:80px;position:absolute;margin-left:20px;"  onclick="save()"/>
</div>



<form method="post" onsubmit="return false"  dataset="workerDataSet">
	<table height=300 cellSpacing=0 cellPadding=0 width=900 align=center id="tab" border=2 style="border-collapse:collapse" borderColor="black">
	<TBODY>
		<tr>
			<td align="center" height="30px" >姓名</td>
			<td><input id="name" field="name" type="text" title="姓名" /><font color="red">*</font></td>
			<td align="center" width="130px">性别</td>
			<td>
				 <select id="sex" field="sex" style="width:130px;" >
				     	<option dataset="sex" ></option>
			     </select>
			</td>
			<td align="center" width="130px">身份证号</td>
			<td><input id="idCard" type="text" field="idCard" title="身份证号" onblur="checkIdCradNo()" /><font color="red">*</font></td>
		</tr>
		<tr>
			<td align="center" height="30px">残疾类别</td>
			<td>
				<select id="disabilityType" field="disabilityType"  style="width:130px;">
			     	<option dataset="disabilityTypeDataset" ></option>
			     </select>
			</td>
			<td align="center">残疾等级</td>
			<td>
				<select id="disabilityLevel" field="disabilityLevel" style="width:130px;" >
			     	<option dataset="DmCjdjDataSet" ></option>
			     </select>
			</td>
			<td align="center">文化程度</td>
			<td>
				<select id="education" field="education" title="文化程度" style="width:130px;">
					<option dataset="eduDataSet"></option>
				</select>
			</td>
		</tr>
		<tr>
			<td align="center" height="30px">家庭住址</td>
			<td><input id="address" field="address" type="text" title="家庭住址" /></td>
			<td align="center">入厂时间</td>
			<td><input type="text" id="entryDate" title="入厂时间" field="entryDate" readonly="readonly" format="Y-m-d" onclick="WdatePicker()" /></td>
			<td align="center">入厂形式</td>
			<td>
				<select id="entryType" field="entryType" style="width:130px">
					<option dataset="entry_type" />
				</select>
			</td>
		</tr>
		<tr>
			<td align="center" height="30px">职业资格等级</td>
			<td>
				<select id="jobLevel" field="jobLevel" style="width:130px" >
					<option dataset="job_level"></option>
				</select>
			</td>
			<td align="center">实发工资</td>
			<td><input type="text" id="realWages" field="realWages" title="实发工资"/></td>
			<td align="center">社会保险(五险一金)</td>
			<td><input type="socialInsurance" field="socialInsurance" title="社会保险"/></td>
		</tr>
		<tr>
			<td align="center" height="30px">商业保险</td>
			<td><input type="text" field="busInsurance" id="busInsurance" title="商业保险"  /></td>
			<td align="center">残疾补贴</td>
			<td><input type="text" field="disSubsidy" id="disSubsidy" title="残疾补贴" /></td>
			<td align="center">是否生产人员</td>
			<td>
				<select id="ifProductor" field="ifProductor" style="width:130px;">
					<option dataset="comm_yesorno"></option>
				</select>
			</td>
		</tr>
		<tr>
		
			<td align="center" height="30px">发放方式</td>
			<td>
				<select field="allocationType" id="allocationType" title="发放方式" style="width:130px" >
					<option dataset="allocation_Type" ></option>
				</select>
			</td>
			<td align="center">养老保险</td>
			<td><input type="text" field="endowmentInsurance" id="endowmentInsurance" title="养老保险" /></td>
			<td align="center">医疗保险</td>
			<td>
				<input type="text" field="medicalInsurance" id="medicalInsurance" title="医疗保险" />
			</td>
		</tr>
		<tr>
			<td align="center" height="30px">失业保险</td>
			<td><input type="text" field="unemployedInsurance" id="unemployedInsurance" title="失业保险"  /></td>
			<td align="center">工伤保险</td>
			<td><input type="text" field="injuryInsurance" id="injuryInsurance" title="工伤保险" /></td>
			<td align="center">生育保险</td>
			<td>
				<input type="text" field="maternityInsurance" id="maternityInsurance" title="生育保险" />
			</td>
		</tr>
		<tr>
			<td align="center">住房公积金</td>
			<td><input type="text" field="housingFund" id="housingFund" title="住房公积金" /></td>
		</tr>
		<tr>
			<td align="center" height="30px">有无职业资格证书持有情况</td>
			<td>
				<select id="certSituation" field="certSituation" onChange="checkYN(this.value)" style="width:130px;">
					<option dataset="comm_haveorno"></option>
				</select>
			</td>
			<td align="center">证书编号</td>
			<td>
				<input type="text" id="certCode" field="certCode" disabled title="职业资格证书编号" />
			</td>
			<td align="center">发证时间</td>
			<td><input type="text" id="certDate" field="certDate" disabled readonly="readonly" format="Y-m-d" onclick="WdatePicker()" /></td>
		</tr>
		<tr>
			<td align="center" height="30px">有无特有工种职业资格证书</td>
			<td>
				<select id="certSpecialSituation" field="certSpecialSituation" onChange="checkSpecialYN(this.value)" style="width:130px;">
					<option dataset="comm_haveorno"></option>
				</select>
			</td>
			<td align="center">证书编号</td>
			<td><input type="text" id="certSpecialCode" field="certSpecialCode" disabled  title="特有工种职业资格证书编号" /></td>
			<td align="center">发证时间</td>
			<td><input type="text" id="certSpecialDate" field="certSpecialDate" disabled format="Y-m-d" onclick="WdatePicker()" /></td>
		</tr>
	</TBODY>
	</table>
</form>

</body>
</html>