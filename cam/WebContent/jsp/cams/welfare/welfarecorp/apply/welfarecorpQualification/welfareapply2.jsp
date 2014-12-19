<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<title>福利企业审批</title>
<%
	String taskCode = (String) request.getParameter("taskCode");
	if (taskCode == null) {
		taskCode = IdHelp.getUUID32();
	}
%>
<next:ScriptManager />
<script type="text/javascript" src="../../../common/js/float.js"></script>
<link href="css/welfareapply2.css" type="text/css" rel="stylesheet" />
<style type="text/css"> 
	label{
		font-size: 12pt;
		font-family: 宋体;
	} 
	div{
		font-size: 12pt;
		font-family: 宋体;
	} 
</style>
<script type="text/javascript">
 	var taskCode='<%=taskCode%>';
 	var certIndex = 1;
 	var certpIndex = 1;
 	var cpIndex=1;
 	var index=1;
 	var saveFalg=true;
 	var workersAll = "";
 	var disNum = "";
 	function init(){
 		var wealUnitInfoDataSet = L5.DatasetMgr.lookup("wealUnitInfoDataSet");
 		wealUnitInfoDataSet.setParameter("TASK_CODE@=", taskCode);
 		wealUnitInfoDataSet.load();
 		wealUnitInfoDataSet.on("load",function(ds){
 			if(ds.getCount==0){
				wealUnitInfoDataSet.newRecord();
			}else{
				queryWorker();
			}
 		});
 		//生产能力信息
		var wealFitProductivepowerDataSet = L5.DatasetMgr.lookup("wealFitProductivepowerDataSet");
		wealFitProductivepowerDataSet.setParameter("TASK_CODE@=", taskCode);
		wealFitProductivepowerDataSet.load();
		wealFitProductivepowerDataSet.on('load',function(ds){
			var productValueTotle=0;
			if(ds.getCount()>0){
				for(var i=0;i<ds.getCount();i++){
					var otr=pntable.insertRow();//插入一个tr 
			 		 var ocel1=otr.insertCell(0);//插入一个td   
			 		 ocel1.innerHTML="<div align='center'><label  id='productName"+i+"' /></div>";  
			 		 var otrrr=pvtable.insertRow();
			 		 var ocel3=otrrr.insertCell(0);
			 		 ocel3.innerHTML="<div align='center'><label  id='productValue"+i+"' name='productValue'/></div>";
			 		if(ds.getCount()!=i+1){
			 			ocel1.className="td";
			 			ocel3.className="td";
			 		 }
					document.getElementById("productName"+i).innerHTML=ds.getAt(i).get('productName');
					document.getElementById("productValue"+i).innerHTML=ds.getAt(i).get('productValue');
					productValueTotle+=ds.getAt(i).get('productValue');
					
					cpIndex=1;
					cpIndex=cpIndex+ds.getCount();
				}
				
			}
			document.getElementById("productValueT").innerHTML=productValueTotle+" 万元";
		});
 	}
	function productCondion(){
 		var rowNum=pntable.rows.length;
 	    for (i=0;i<rowNum;i++)
 	    {
 	    	pntable.deleteRow(0);
 	    	pvtable.deleteRow(0);
 	    }
	    var wealFitProductivepowerDataSet = L5.DatasetMgr.lookup("wealFitProductivepowerDataSet");
		wealFitProductivepowerDataSet.setParameter("TASK_CODE@=", taskCode);
		wealFitProductivepowerDataSet.load();
 	}
 	  function save(){
 		 if(!saveFalg){
 		 }
 		saveFalg=false;
 		var info= validateInfo();
 		if(info){
 			alert(info);
 			return "break";
 		}
		var wealUnitInfoDataSet = L5.DatasetMgr.lookup("wealUnitInfoDataSet");
		var unitInfoValidate = wealUnitInfoDataSet.isValidate();
		if(unitInfoValidate != true){
			L5.Msg.alert("提示",unitInfoValidate);
			return "break";
		}
		var unitInfoRecord=wealUnitInfoDataSet.getCurrent();
		unitInfoRecord.set("workersAll",workersAll);
		unitInfoRecord.set("workersDeform",disNum);
		
		var command = new L5.Command("com.inspur.cams.welfare.welfarecorp.apply.cmd.UnitApplyCmd");
		command.setParameter("unitInfoRecord", unitInfoRecord);
		command.execute("saveQualificationInfo");
		if (!command.error) {
			alert("保存成功！");	
		}else{
			L5.Msg.alert('提示',"保存时出现错误！"+command.error);
		}
		saveFalg=true;
	}
	function showWorkerWin(){
		var width = 1200;
		var height = 600;
		var url="wealworker.jsp?taskCode="+taskCode;
		var reValue=window.showModalDialog(url, window, "scroll:0;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
		queryWorker();
	}
	function showProductWin(){
		var width = 1200;
		var height = 600;
		var url="wealProduct.jsp?taskCode="+taskCode;
		var reValue=window.showModalDialog(url, window, "scroll:0;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
		productCondion();
		
	}
	function validateInfo(){
		
		var its = document.getElementsByTagName("input");
		for(var i=0;i<its.length;i++){
			var vname= its[i].getAttribute("vname");
			if(vname&&its[i].value==""){
				var my=document.getElementById(its[i].id); 
				my.focus();
				return vname+"不能为空!";
			}
		}
		var sel = document.getElementById("economicNatureCode");
		if(sel.value==""){
			var vname= sel.getAttribute("vname");
			sel.focus();
			return vname+"不能为空!"; 
		}
		return false;
	}
	function queryWorker(){
 		//职工统计信息
		var command = new L5.Command("com.inspur.cams.welfare.welfarecorp.apply.cmd.UnitWorkerQueryCmd");
		command.setParameter("taskCode", taskCode);
		command.execute("queryUnitWorkerSum");
		var totalNum=command.getReturn("totalNum");
		var disNum=command.getReturn("disNum");
		var noProNum=command.getReturn("noProNum");
		var proNum=command.getReturn("proNum");
				
		document.getElementById("totalNum").innerHTML=totalNum==null?"0":totalNum;
		document.getElementById("disNum").innerHTML=disNum==null?"0":disNum;
		document.getElementById("noProNum").innerHTML=noProNum==null?"0":noProNum;
		document.getElementById("proNum").innerHTML=proNum==null?"0":proNum;
		
		//给全局变量赋值
		workersAll = totalNum==null?"0":totalNum;
		disNum = disNum==null?"0":disNum;
				
		//残疾职工明细信息
		command.execute("queryUnitWorkerDisability");
		var slcj=command.getReturn("slcj");
		var tlcj=command.getReturn("tlcj");
		var yycj=command.getReturn("yycj");
		var ztcj=command.getReturn("ztcj");
		var zljscj=command.getReturn("zljscj");
				
		document.getElementById("slcj").innerHTML=slcj==null?"0":slcj;
		document.getElementById("tlcj").innerHTML=tlcj==null?"0":tlcj;
		document.getElementById("yycj").innerHTML=yycj==null?"0":yycj;
		document.getElementById("ztcj").innerHTML=ztcj==null?"0":ztcj;
		document.getElementById("zljscj").innerHTML=zljscj==null?"0":zljscj;
 	}
</script>
</head>

<body>
<model:datasets>
	<!-- 业务表 -->
	<model:dataset id="welfUnitApplyDataSet"
		cmd="com.inspur.cams.welfare.base.cmd.WealUnitApplyQueryCommand">
		<model:record
			fromBean="com.inspur.cams.welfare.base.data.WealUnitApply"></model:record>
	</model:dataset>
	<!-- 业务信息表 -->
	<model:dataset id="wealUnitInfoDataSet"
		cmd="com.inspur.cams.welfare.base.cmd.WealUnitInfoQueryCommand">
		<model:record
			fromBean="com.inspur.cams.welfare.base.data.WealUnitInfo">
			<model:field name="companyName" type="string" rule="require" />
			<model:field name="legalPeople" type="string" rule="require" />
			<model:field name="regDate" type="string" rule="require" />
		</model:record>
	</model:dataset>
	<!-- 职工信息表 -->
	<model:dataset id="wealWorkerDataSet"
		cmd="com.inspur.cams.welfare.base.cmd.WealWorkerQueryCommand"
		pageSize="100">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealWorker"></model:record>
		<model:params>
			<model:param name="CERT_CODE@<>" value=''></model:param>
		</model:params>
	</model:dataset>
	<!-- 职工信息表 -->
	<model:dataset id="wealWorkerDataSet1"
		cmd="com.inspur.cams.welfare.base.cmd.WealWorkerQueryCommand"
		pageSize="100">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealWorker"></model:record>
	</model:dataset>
	<!-- 经济性质字典表 -->
	<model:dataset id="ecoDataSet"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='WEAL_DIC_ECONOMICNATURE'></model:param>
		</model:params>
	</model:dataset>
	<!-- 生产能力信息 -->
	<model:dataset id="wealFitProductivepowerDataSet" cmd="com.inspur.cams.welfare.base.cmd.WealFitProductivepowerQueryCommand"  global="true" pageSize="100">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealFitProductivepower"></model:record>
	</model:dataset>
</model:datasets>


<div id="float">
<input field="" type="button" value="下一页"
	style="height: 25px; width: 80px; position: absolute; margin-left: 20px;"
	onclick="nextPage('3')" /> <input field="" type="button" value="上一页"
	style="height: 25px; width: 80px; position: absolute; margin-left: 120px;"
	onclick="lastPage('1')" /> <input field="" type="button" value="保存"
	style="height: 25px; width: 80px; position: absolute; margin-left: 220px;"
	onclick="save()" /> <input field="" type="button" value="返回"
	style="height: 25px; width: 80px; position: absolute; margin-left: 320px;"
	onclick="backPage();" /></div>


<form method="post" onsubmit="return false"
	dataset="wealUnitInfoDataSet">
<TABLE height=629 cellSpacing=0 cellPadding=0 width=800 align=center
	id="tab" border=0>
	<TBODY>
		<TR>
			<TD class=title1 align=middle height=67>&nbsp;</TD>
		</TR>
		<TR>
			<TD align="middle" height=40 class="title3"><br>
			<br>
			</TD>
		</TR>
		<TR vAlign=top>
			<TD vAlign=top height=522>
			<table border=0 cellpadding=0 cellspacing=0 width=690
				style='border-collapse: collapse; table-layout: fixed; width: 520pt'
				class=unnamed1>
				<col width=53 span=11 style='width: 40pt'>
				<col width=107
					style='mso-width-source: userset; mso-width-alt: 3424; width: 80pt'>
				<tr height=45 style='mso-height-source: userset; height: 33.95pt'>
					<td colspan=2 class=unnamed1 height=45 width=106
						style='height: 33.95pt; width: 80pt'>
					<div align="center">企业名称</div>
					</td>
					<td colspan=10 class=unnamed1 width=584
						style='border-left: none; width: 440pt'>
					<div align="left"><input type="text" vname="企业名称"
						id="companyName" field="companyName" size=50 /><font color="red">*</font>
					</div>
					</td>
				</tr>
				<tr height=45 style='mso-height-source: userset; height: 33.95pt'>
					<td colspan=2 height=45 class=unnamed1 style='height: 33.95pt'>
					<div align="center">通讯地址</div>
					</td>
					<td colspan=6 class=unnamed1 style='border-left: none'>
					<div align="left"><input type="text" vname="通讯地址"
						id="address" field="address" size=50 /><font color="red">*</font>
					</div>
					</td>
					<td colspan=2 class=unnamed1 style='border-left: none'>
					<div align="center">邮编</div>
					</td>
					<td colspan=2 class=unnamed1 style='border-left: none'>
					<div align="left"><input type="text" vname="邮编" id="postCode"
						field="postCode" /><font color="red">*</font></div>
					</td>
				</tr>
				<tr height=45 style='mso-height-source: userset; height: 33.95pt'>
					<td colspan=2 height=45 class=unnamed1 style='height: 33.95pt'>
					<div align="center">法定代表人</div>
					</td>
					<td colspan=4 class=unnamed1 style='border-left: none'>
					<div align="left"><input type="text" vname="法人"
						id="legalPeople" field="legalPeople" /><font color="red">*</font></div>
					</td>
					<td colspan=2 class=unnamed1 style='border-left: none'>
					<div align="center">身份证号</div>
					</td>
					<td colspan=4 class=unnamed1 style='border-left: none'>
					<div align="left"><input type="text" vname="法人身份证号"
						id="legalIdCard" field="legalIdCard" /><font color="red">*</font></div>
					</td>
				</tr>
				<tr height=45 style='mso-height-source: userset; height: 33.95pt'>
					<td colspan=2 height=45 class=unnamed1 style='height: 33.95pt'>
					<div align="center">固定电话</div>
					</td>
					<td colspan=4 class=unnamed1 style='border-left: none'>
					<div align="left"><input type="text" vname="法人固定电话"
						id="legalPhone" field="legalPhone" /><font color="red">*</font></div>
					</td>
					<td colspan=2 class=unnamed1 style='border-left: none'>
					<div align="center">手机</div>
					</td>
					<td colspan=4 class=unnamed1 style='border-left: none'>
					<div align="left"><input type="text" vname="法人手机"
						id="legalTelphone" field="legalTelphone" /><font color="red">*</font></div>
					</td>
				</tr>
				<tr height=45 style='mso-height-source: userset; height: 33.95pt'>
					<td colspan=2 height=45 class=unnamed1 style='height: 33.95pt'>
					<div align="center">经办人</div>
					</td>
					<td colspan=4 class=unnamed1 style='border-left: none'>
					<div align="left"><input type="text" vname="经办人"
						id="agentPeople" field="agentPeople" /><font color="red">*</font></div>
					</td>
					<td colspan=2 class=unnamed1 style='border-left: none'>
					<div align="center">联系电话</div>
					</td>
					<td colspan=4 class=unnamed1 style='border-left: none'>
					<div align="left"><input type="text" vname="联系电话"
						id="agentPhone" field="agentPhone" /><font color="red">*</font></div>
					</td>
				</tr>
				<tr height=45 style='mso-height-source: userset; height: 33.95pt'>
					<td colspan=2 height=45 class=unnamed1 style='height: 33.95pt'>
					<div align="center">电子邮箱</div>
					</td>
					<td colspan=10 class=unnamed1 style='border-left: none'>
					<div align="left"><input type="text" vname="电子邮箱"
						id="agentEmail" field="agentEmail" size=50 /><font color="red">*</font>
					</div>
					</td>
				</tr>
				<tr height=45 style='mso-height-source: userset; height: 33.95pt'>
					<td colspan=2 height=45 class=unnamed1 style='height: 33.95pt'>
					<div align="center">网站地址</div>
					</td>
					<td colspan=10 class=unnamed1 style='border-left: none'>
					<div align="left"><input type="text" 
						id="webAddress" field="webAddress" size=50 />
					</div>
					</td>
				</tr>
				<tr height=45 style='mso-height-source: userset; height: 33.95pt'>
					<td colspan=2 height=45 class=unnamed1 style='height: 33.95pt'>
					<div align="center">经济性质</div>
					</td>
					<td colspan=4 class=unnamed1 style='border-left: none'><select
						id=economicNatureCode style='width:133px' field="economicNatureCode" vname="经济性质">
						<option dataset="ecoDataSet"></option>
					</select><font color="red">*</font></td>
					<td colspan=2 class=unnamed1 width=106
						style='border-left: none; width: 80pt'>
					<div align="center">组织机<br />
					构代码</div>
					</td>
					<td colspan=4 class=unnamed1 style='border-left: none'>
					<div align="left"><input type="text"
						id="organCode" field="organCode" /></div>
					</td>
				</tr>
				<tr height=45 style='mso-height-source: userset; height: 33.95pt'>
					<td colspan=2 height=45 class=unnamed1 width=106
						style='height: 33.95pt; width: 80pt'>
					<div align="center">营业执照<br />
					编&nbsp;&nbsp;号</div>
					</td>
					<td colspan=4 class=unnamed1 style='border-left: none'>
					<div align="left"><input type="text" vname="营业执照编号"
						id="licenseCode" field="licenseCode" /><font color="red">*</font></div>
					</td>
					<td colspan=2 class=unnamed1 width=106
						style='border-left: none; width: 80pt'>
					<div align="center">税务登<br />
					记编号</div>
					</td>
					<td colspan=4 class=unnamed1 style='border-left: none'>
					<div align="left"><input type="text" vname="税务登记编号"
						id="registrationCode" field="registrationCode" /><font
						color="red">*</font></div>
					</td>
				</tr>
				<tr height=45>
					<td colspan=2 rowspan=2 height=90 class=unnamed1>
					<div align="center">经营范围</div>
					</td>
					<td colspan=2 height=45 class=unnamed1>
					<div align="center">主营</div>
					</td>
					<td colspan=8 class=unnamed1>
					<div align="left"><input type="text" vname="主营"
						id="firstScope" field="firstScope" style="width: 70%" /><font
						color="red">*</font></div>
					</td>
				</tr>
				<tr height=45>
					<td colspan=2 height=45 class=unnamed1>
					<div align="center">兼营</div>
					</td>
					<td colspan=8 class=unnamed1>
					<div align="left"><input type="text"
						id="secondScope" field="secondScope" style="width: 70%" /></div>
					</td>
				</tr>
				<tr height=45 style='mso-height-source: userset; height: 33.95pt'>
					<td colspan=2 height=45 class=unnamed1 width=106
						style='height: 33.95pt; width: 80pt'>
					<div align="center">注册资金<br />
					（万元）</div>
					</td>
					<td colspan=10 class=unnamed1 style='border-left: none'>
					<div align="left"><input type="text" vname="注册资金（万元）"
						id="regFund" field="regFund" /><font color="red">*</font></div>
					</td>
				</tr>
				<tr height=45>
					<td colspan=2 rowspan=2 height=90 class=unnamed1>
					<div align="center">职工人数<br>
					<input id="showWorker" value="职工信息" type="button"
						onclick="showWorkerWin()" /></div>
					</td>
					<td colspan=2 class=unnamed1>
					<div align="center">合计</div>
					</td>
					<td colspan=3 class=unnamed1>
					<div align="center">非生产人员</div>
					</td>
					<td colspan=3 class=unnamed1>
					<div align="center">生产人员</div>
					</td>
					<td colspan=2 class=unnamed1>
					<div align="center">残疾职工</div>
					</td>
				</tr>
				<tr height=45>
					<td colspan=2 height=45 class=unnamed1>
					<div align="center"><label type="text" name="合计"
						id="totalNum" /></div>
					</td>
					<td colspan=3 class=unnamed1>
					<div align="center"><label type="text" name="非生产人员"
						id="noProNum" /></div>
					</td>
					<td colspan=3 class=unnamed1>
					<div align="center"><label type="text" name="生产人员"
						id="proNum" /></div>
					</td>
					<td colspan=2 class=unnamed1>
					<div align="center"><label type="text" name="残疾职工"
						id="disNum" /></div>
					</td>
				</tr>
				<tr height=45>
					<td colspan=12 height=45 class=unnamed1>残疾职工其中：视力残疾 <label
						type="text" name="视力残疾" id="slcj"></label> 人、听力残疾 <label
						type="text" name="听力残疾" id="tlcj"></label> 人、言语残疾 <label
						type="text" name="言语残疾" id="yycj"></label> 人、肢体残疾 <label
						type="text" name="肢体残疾" id="ztcj"></label> 人、<br>
					智力和精神病残疾 <label type="text" name="智力和精神病残疾" id="zljscj" /></label> 人。</td>
				</tr>
				<tr height=45>
					<td id="proTd" colspan=2 rowspan=3 height=180 class=unnamed1>
					<div align="center">主<br />
					要<br />
					产<br />
					品<br />
					</div>
					</td>
					<td  colspan=5 class=unnamed1 style='border-left: none'>
					<div align="center">产品名称</div>
					</td>
					<td colspan=5 class=unnamed1 style='border-left: none'>
					<div align="center">年销售收入（万元）<input type="button" value="产品信息" onclick="showProductWin()" /></div>
					</td>
				</tr>
				<tr height=45>
					<td colspan=5 height=45 class=unnamed1>
					<div align="center">(合计)</div>
					</td>
					<td colspan=5 class=unnamed1>
					<div align="center"><label name="产值" id="productValueT"/></div>
					</td>
				</tr>
				<tr >
					<td colspan=5  class=unnamed1>
					<div align="center"><table id="pntable" style="width:100%;height:100%"></table></div>
					</td>
					<td colspan=5 class=unnamed1>
					<div align="center"><table id="pvtable" style="width:100%;height:100%"></table></div>
					</td>
				</tr>
				<TR height=45>
						<TD colspan=2 height=180 class=unnamed1 align=middle rowspan="15">
						<p>申</p>
						<p>&nbsp;</p>
						<p align="center">请</p>
						<p>&nbsp;</p>
						<p align="center">理</p>
						<p>&nbsp;</p>
						<p align="center">由</p>
						</TD>
						<TD colspan=10 rowspan="15" valign="top"><textarea
							vname='申请理由' COLS='100' rows='8' CLASS='boder-0' id="reason"
							field="reason">
							</textarea>
						<!--  
						<table width="200" border="0" cellspacing="0" cellpadding="0"
							align="right">
							<tr>
								<td colspan="2">签字：</td>
								<td colspan="2">
								<div align="center"><input type="text" vname="申请签字" id=""
									field="" size=18 /></div>
								</td>
								<td colspan="2"></td>
							</tr>
							
							<tr>
								<td colspan="4">(公 章）</td>
								<td colspan="2"></td>
							</tr>
							<tr>
								<td colspan="2">申请日期：</td>
								<td colspan="4"><input type="text" vname="申请时间" id=""
									field="" size=18 format="Y年m月d日" onclick="LoushangDate(this)"
									readonly="readonly" style="text-align: center" /></td>
							</tr>
							<tr>
								<td colspan="2">&nbsp;</td>
								<td colspan="4">年 月 日</td>
							</tr>
						</table>
						-->
						</TD>
					</TR>
			</table>
			</TD>
		</TR>
		<tr valign=bottom>
			<td height='27' valign=bottom align=center>2</td>
		</tr>
	</TBODY>
</TABLE>
</form>
<div id="float">
<input field="" type="button" value="下一页"
	style="height: 25px; width: 80px; position: absolute; margin-left: 20px;"
	onclick="nextPage('3')" /> <input field="" type="button" value="上一页"
	style="height: 25px; width: 80px; position: absolute; margin-left: 120px;"
	onclick="lastPage('1')" /> <input field="" type="button" value="保存"
	style="height: 25px; width: 80px; position: absolute; margin-left: 220px;"
	onclick="save()" /> <input field="" type="button" value="返回"
	style="height: 25px; width: 80px; position: absolute; margin-left: 320px;"
	onclick="backPage();" /></div>
</body>
</html>
