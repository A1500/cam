
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.IdHelp"%>
<html>
	<head>
		<title>历史数据采集编辑</title>
		<next:ScriptManager/>
		<script>
			<%
				String taskCode=request.getParameter("taskCode");
				String method=request.getParameter("method");
				if(taskCode==null){
					taskCode=IdHelp.getUUID32();
				}
			%>
			function detailCK(){
				var grid=L5.getCmp("editGridWorker");
				var record=grid.getSelectionModel().getSelections();
				if(record.length!=1){
					L5.Msg.alert("提示","请先选中一行!");
					return;
				}
				var win=L5.getCmp("workerWin");
				win.show(this);
				var workerId=record[0].get("workerId");
				var workerDataSet = L5.DatasetMgr.lookup("workerDataSet");
				workerDataSet.setParameter("WORKER_ID@=",workerId);
				workerDataSet.load(true);
				if(workerDataSet.getAt(0).get("disabilityType").length==0){
					$("disabilityType1").innerHTML="";
				}
				if(workerDataSet.getAt(0).get("disabilityLevel").length==0){
					$("disabilityLevel1").innerHTML="";
				}
				if(workerDataSet.getAt(0).get("education").length==0){
					$("education1").innerHTML="";
				}
				if(workerDataSet.getAt(0).get("entryType").length==0){
					$("entryType1").innerHTML="";
				}
				if(workerDataSet.getAt(0).get("jobLevel").length==0){
					$("jobLevel1").innerHTML="";
				}
				if(workerDataSet.getAt(0).get("ifProductor").length==0){
					$("ifProductor1").innerHTML="";
				}
				if(workerDataSet.getAt(0).get("allocationType").length==0){
					$("allocationType1").innerHTML="";
				}
				if(workerDataSet.getAt(0).get("certSituation").length==0){
					$("certSituation1").innerHTML="";
				}
				if(workerDataSet.getAt(0).get("certSpecialSituation").length==0){
					$("certSpecialSituation1").innerHTML="";
				}
				if(workerDataSet.getAt(0).get("certOrthosisSituation").length==0){
					$("certOrthosisSituation1").innerHTML="";
				}
			}
			function closeWin(){
				var win=L5.getCmp("workerWin");
				win.hide();
			}
			var method='<%=method%>';
			var taskCode='<%=taskCode%>';
		</script>
		<script type="text/javascript" src="fitHistoryEdit.js"></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
	</head>
<body>
<model:datasets>
	<!-- 业务信息表 -->
	<model:dataset id="ds" cmd="com.inspur.cams.welfare.base.cmd.WealFitInfoQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealFitInfo">
		<model:field name="serialNum" type="string" rule="require" />	
		<model:field name="companyName" type="string" rule="require" />	
		<model:field name="economicNatureCode" type="string" rule="require" />
		<model:field name="legalPeople" type="string" rule="require" />
		<model:field name="approveDate" type="string" rule="require" />
		<model:field name="nextCheck" type="string" rule="require" />
		<model:field name="nextChagneCert" type="string" rule="require" />
		</model:record>
	</model:dataset>
	<!-- 业务表 -->
	<model:dataset id="applyDs" cmd="com.inspur.cams.welfare.base.cmd.WealFitApplyQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealFitApply"></model:record>
	</model:dataset>
	<!-- 状态信息表 -->
	<model:dataset id="statusDs" cmd="com.inspur.cams.welfare.base.cmd.WealFitStatusQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealFitStatus"></model:record>
	</model:dataset>
	<!-- 经济性质字典表 -->
	<model:dataset id="ecoDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='WEAL_DIC_ECONOMICNATURE'></model:param>
		</model:params>
	</model:dataset>
	<!-- 职工信息表 -->
	<model:dataset id="workerDs" cmd="com.inspur.cams.welfare.base.cmd.WealWorkerQueryCommand" global="true" pageSize="20">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealWorker"></model:record>
	</model:dataset>
	<model:dataset id="workerDataSet" cmd="com.inspur.cams.welfare.base.cmd.WealWorkerQueryCommand" global="true" pageSize="20">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealWorker"></model:record>
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
	<!-- 设施信息表 -->
	<model:dataset id="deviceDs" cmd="com.inspur.cams.welfare.base.cmd.WealFitDeviceQueryCommand" global="true" >
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealFitDevice">
		</model:record>	
	</model:dataset>
	<!-- 设施信息表1 -->
	<model:dataset id="deviceDataSet1" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='WEAL_DIC_FITDEVICE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 生产能力信息 -->
	<model:dataset id="productDs" cmd="com.inspur.cams.welfare.base.cmd.WealFitProductivepowerQueryCommand"  global="true" pageSize="100">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealFitProductivepower"></model:record>
	</model:dataset>
	<!-- 入厂形式 -->
	<model:dataset id="entry_type" enumName="WEAL.ENTRY_TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 职业资格等级 -->
	<model:dataset id="job_level" enumName="WEAL.JOB_LEVEL" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:ViewPort>
<next:AnchorLayout>
<next:Panel  title="企业信息">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="undo"  text="返回" handler="back"/>
	</next:TopBar>
	<next:TabPanel>
	<next:Tabs>
	<next:Panel title="基本信息" width="99%" height="100%" autoScroll="true">
	<next:Html>
		<form id="editForm"   dataset="ds" onsubmit="return false" style="padding: 5px;" class="L5form">
		<fieldset>
		<legend>企业基本信息</legend>
		<table border="1"  width="100%" >
	   		<tr>
				<td  class="FieldLabel" width="14%">编号</td>
				<td class="FieldInput" width="19%"><label  title="字号" name="serialNum" field="serialNum" style="width: 95%" /></td>
	
				<td  class="FieldLabel" width="14%">企业名称</td>
				<td class="FieldInput" width="19%"><label  title="企业名称" name="companyName" field="companyName" style="width: 95%" /> </td>
			
				<td  class="FieldLabel" width="14%"></td>
				<td class="FieldInput" width="19%"></td>
			</tr>
	   		<tr>	
				<td  class="FieldLabel" width="14%">注册地址</td>
				<td class="FieldInput" width="19%"><label  name="address" field="address" style="width: 95%" /> </td>
			
				<td  class="FieldLabel" width="14%">邮编</td>
				<td class="FieldInput" width="19%"><label  name="postCode" field="postCode" style="width: 95%" /> </td>
			
				<td  class="FieldLabel" width="14%">网站地址</td>
				<td class="FieldInput" width="19%"><label  name="webAddress" field="webAddress" style="width: 95%" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" width="14%">经济性质</td>
				<td class="FieldInput" width="19%">
					<label id="economicNatureCode" dataset="ecoDataSet" field="economicNatureCode" name="经济性质" title="经济性质" style="width: 95%">
					     	</label></td>
				<td  class="FieldLabel" width="14%">注册资金（万元）</td>
				<td class="FieldInput" width="19%"><label  name="regFund" field="regFund" style="width: 95%" /> </td>
				
				<td  class="FieldLabel" width="14%"></td>
				<td class="FieldInput" width="19%"></td>
			</tr>
	   		<tr>	
				<td  class="FieldLabel" width="14%">组织机构代码</td>
				<td class="FieldInput" width="19%"><label  name="organCode" field="organCode" style="width: 95%" /> </td>
			
				<td  class="FieldLabel" width="14%">营业执照编号</td>
				<td class="FieldInput" width="19%"><label  name="licenseCode" field="licenseCode" style="width: 95%" /> </td>
			
				<td  class="FieldLabel" width="14%">税务登记编号</td>
				<td class="FieldInput" width="19%"><label  name="registrationCode" field="registrationCode" style="width: 95%" /> </td>
			</tr>
	   		<tr>
				
				<td  class="FieldLabel" width="14%">经营范围</td>
				<td class="FieldInput" width="19%" colspan="3"><label  name="businessScope" field="businessScope" style="width: 98%" /> </td>
			
				<td  class="FieldLabel" width="14%"></td>
				<td class="FieldInput" width="19%"></td>
			</tr>
   		</table>
		</fieldset>
	   	<fieldset>
		<legend>法定代表人信息</legend>
		<table border="1"  width="100%" >
			<tr>		
				<td  class="FieldLabel" width="14%">姓名</td>
				<td class="FieldInput" width="19%"><label  name="legalPeople" field="legalPeople" style="width: 95%" /></td>
			
				<td  class="FieldLabel" width="14%">身份证号</td>
				<td class="FieldInput" width="19%"><label  name="legalIdCard" field="legalIdCard" style="width: 95%" /> </td>
			
				<td  class="FieldLabel" width="14%">固定电话</td>
				<td class="FieldInput" width="19%"><label  name="legalPhone" field="legalPhone" style="width: 95%" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" width="14%">手机</td>
				<td class="FieldInput" width="19%"><label  name="legalTelphone" field="legalTelphone" style="width: 95%" /> </td>
			
				<td  class="FieldLabel" width="14%">电子邮箱</td>
				<td class="FieldInput" width="19%"><label  name="legalEmail" field="legalEmail" style="width: 95%" /> </td>
				
				<td  class="FieldLabel" width="14%"></td>
				<td class="FieldInput" width="19%"></td>
			</tr>
   		</table>
		</fieldset>
		<fieldset>
		<legend>经办人信息</legend>
		<table border="1"  width="100%" >
	   		<tr>
				<td  class="FieldLabel" width="14%">姓名</td>
				<td class="FieldInput" width="19%"><label  name="agentPeople" field="agentPeople" style="width: 95%" /> </td>
			
				<td  class="FieldLabel" width="14%">身份证号</td>
				<td class="FieldInput" width="19%"><label  name="agentIdCard" field="agentIdCard" style="width: 95%" /> </td>
			
				<td  class="FieldLabel" width="14%">固定电话</td>
				<td class="FieldInput" width="19%"><label  name="agentPhone" field="agentPhone" style="width: 95%" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" width="14%">手机</td>
				<td class="FieldInput" width="19%"><label  name="agentTelphone" field="agentTelphone" style="width: 95%" /> </td>
			
				<td  class="FieldLabel" width="14%">电子邮箱</td>
				<td class="FieldInput" width="19%"><label  name="agentEmail" field="agentEmail" style="width: 95%" /> </td>
			
				<td  class="FieldLabel" width="14%"></td>
				<td class="FieldInput" width="19%"></td>
			</tr>
		</table>
		</fieldset>
		<fieldset>
		<legend>场地信息</legend>
		<table border="1"  width="100%" >
	   		<tr>
				<td  class="FieldLabel" width="14%">总经营面积（m2）</td>
				<td class="FieldInput" width="19%"><label  name="operateArea" field="operateArea" style="width: 95%" /> </td>
			
				<td  class="FieldLabel" width="14%">制作间面积（m2）</td>
				<td class="FieldInput" width="19%"><label  name="productArea" field="productArea" style="width: 95%" /> </td>
			
				<td  class="FieldLabel" width="14%">康复室面积（m2）</td>
				<td class="FieldInput" width="19%"><label  name="recoveryArea" field="recoveryArea" style="width: 95%" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" width="14%">接待室面积（m2）</td>
				<td class="FieldInput" width="19%"><label  name="receptionArea" field="receptionArea" style="width: 95%" /> </td>
			
				<td  class="FieldLabel" width="14%">训练厅面积（m2）</td>
				<td class="FieldInput" width="19%"><label  name="trainArea" field="trainArea" style="width: 95%" /> </td>
			
				<td  class="FieldLabel" width="14%">理疗室面积（m2）</td>
				<td class="FieldInput" width="19%"><label  name="treatmentArea" field="treatmentArea" style="width: 95%" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" width="14%">办公面积（m2）</td>
				<td class="FieldInput" width="19%"><label  name="workArea" field="workArea" style="width: 95%" /> </td>
			
				<td  class="FieldLabel" width="14%">休闲区面积（m2）</td>
				<td class="FieldInput" width="19%"><label  name="leisureArea" field="leisureArea" style="width: 95%" /> </td>
			
				<td  class="FieldLabel" width="14%">其它（m2）</td>
				<td class="FieldInput" width="19%"><label  name="otherArea" field="otherArea" style="width: 95%" /> </td>
			</tr>
		</table>
		</fieldset>
		<fieldset>
		<legend>业务信息</legend>
		<table border="1"  width="100%" >
	   		<tr>
				<td  class="FieldLabel" width="14%">批准通过时间</td>
				<td class="FieldInput" width="19%"><label  id="approveDate" name="approveDate" field="approveDate" style="width: 95%" /></td>
			
				<td  class="FieldLabel" width="14%">下一次年检年度</td>
				<td class="FieldInput" width="19%"><label  id="nextCheck" name="nextCheck" field="nextCheck" style="width: 95%" /></td>
			
				<td  class="FieldLabel" width="14%">下一次换证年度</td>
				<td class="FieldInput" width="19%"><label  id="nextChagneCert" name="nextChagneCert" field="nextChagneCert" style="width: 95%" /></td>
			</tr>
		</table>
		</fieldset>
		</form>
   </next:Html>
   </next:Panel>
   <next:Panel title="员工信息" width="100%" height="100%">
		<next:EditGridPanel id="editGridWorker" name="editGridWorker" width="100%" height="99.9%" dataset="workerDs" clickToSelectedForChkSM="true">
			<next:TopBar>
					<next:ToolBarItem symbol="->" ></next:ToolBarItem>
					<next:ToolBarItem  iconCls="detail" text="查看"  handler="detailCK" />
			</next:TopBar>
			    <next:Columns>
			    <next:RowNumberColumn width="30"/>
			    <next:RadioBoxColumn></next:RadioBoxColumn>
			     
				<next:Column id="workerId" header="职工信息表ID" field="workerId"  hidden="true" ></next:Column>
				<next:Column id="taskCode" header="业务编码" field="taskCode"  hidden="true" ></next:Column>
			
				<next:Column id="corporationType" header="企业类别" field="corporationType"  hidden="true" ></next:Column>
				<next:Column id="name" header="姓名" field="name" width="7%" editable="false" >			
					<next:TextField  />
				</next:Column>
				<next:Column id="idCard" header="身份证号" field="idCard" width="5%"  editable="false" >			
					<next:TextField />
				</next:Column>
				<next:Column id="sex" header="性别" field="sex" width="3%" >			
					<next:ComboBox triggerAction="all" editable="false" valueField="value" displayField="text"  dataset="sex"/>
				</next:Column>
				
				<next:Column id="phone" header="联系电话" editable="false" field="phone" width="5%" >			
					<next:TextField  />
				</next:Column>
			
				<next:Column id="disabilityType" header="残疾类别" field="disabilityType" width="5%" >			
					<next:ComboBox triggerAction="all" editable="false" valueField="value" displayField="text"  dataset="disabilityTypeDataset"/>
				</next:Column>
				<next:Column id="disabilityLevel" header="残疾等级" field="disabilityLevel" width="5%" >			
					<next:ComboBox triggerAction="all" editable="false" valueField="value" displayField="text"  dataset="DmCjdjDataSet"/>
				</next:Column>
				<next:Column id="education" header="文化程度" field="education" width="7%" >			
					<next:ComboBox triggerAction="all" editable="false" valueField="value" displayField="text"  dataset="eduDataSet"/>
				</next:Column>
			
				<next:Column id="address" header="家庭住址" editable="false" field="address" hidden="true" width="12%" >			
					<next:TextField  />
				</next:Column>
			
				<next:Column id="entryDate" header="入厂时间" field="entryDate" width="8%" >			
					<next:DateField allowBlank="false" format="Y-m-d" editable="false" ></next:DateField>
				</next:Column>
			
				<next:Column id="entryType" header="入厂形式" editable="false" dataset="entry_type" field="entryType" width="5%" >			
					<next:TextField  />
				</next:Column>
			
				<next:Column id="jobLevel" header="职业资格等级" editable="false" dataset="job_level" field="jobLevel" width="8%" >			
					<next:TextField  />
				</next:Column>
			
				<next:Column id="realWages" header="实发工资" editable="false" field="realWages" width="5%" >			
					<next:NumberField  />
				</next:Column>
			
				<next:Column id="socialInsurance" header="社会保险" editable="false" field="socialInsurance" width="5%" >			
					<next:NumberField  />
				</next:Column>
				
				<next:Column id="endowmentInsurance" header="养老保险" editable="false" field="endowmentInsurance" width="5%" >			
					<next:NumberField  />
				</next:Column>
				
				<next:Column id="medicalInsurance" header="医疗保险" editable="false" field="medicalInsurance" width="5%" >			
					<next:NumberField  />
				</next:Column>
				
				<next:Column id="unemployedInsurance" header="失业保险" editable="false" field="unemployedInsurance" width="5%" >			
					<next:NumberField  />
				</next:Column>
				
				<next:Column id="injuryInsurance" header="工伤保险" editable="false" field="injuryInsurance" width="5%" >			
					<next:NumberField  />
				</next:Column>
				
				<next:Column id="maternityInsurance" header="生育保险" editable="false" field="maternityInsurance" width="5%" >			
					<next:NumberField  />
				</next:Column>
				
				<next:Column id="housingFund" header="住房公积金" editable="false" field="housingFund" width="5%" >			
					<next:NumberField  />
				</next:Column>
			
				<next:Column id="busInsurance" header="商业保险" editable="false" field="busInsurance" width="5%" >			
					<next:NumberField  />
				</next:Column>
				
				<next:Column id="disSubsidy" header="残疾人补贴" editable="false" field="disSubsidy" width="6%" >			
					<next:NumberField  />
				</next:Column>
				
				<next:Column id="allocationType" header="发放方式" editable="false" field="allocationType" width="5%" >			
					<next:ComboBox triggerAction="all" editable="false" valueField="value" displayField="text"  dataset="allocation_Type"/>
				</next:Column>
			
				<next:Column id="ifProductor" header="是否生产人员" field="ifProductor" width="8%" >			
					<next:ComboBox triggerAction="all" editable="false" valueField="value" displayField="text"  dataset="comm_yesorno"/>
				</next:Column>
			
				<next:Column id="certSituation" header="假肢制作师证书执有情况" field="certSituation" width="11%" >			
					<next:ComboBox triggerAction="all" editable="false" valueField="value" displayField="text"  dataset="comm_haveorno"/>
				</next:Column>
			
				<next:Column id="certCode" header="证书编号" editable="false" field="certCode" width="8%" >			
					<next:TextField  />
				</next:Column>
			
				<next:Column id="certDate" header="发证时间" field="certDate" width="6%" >			
					<next:DateField allowBlank="false" editable="false" format="Y-m-d" ></next:DateField>
				</next:Column>
				
				<next:Column id="certTime" header="发证时间" field="certTime" width="6%" >			
					<next:DateField allowBlank="false" editable="false" format="Y-m-d" ></next:DateField>
				</next:Column>
				
				<next:Column id="certOrthosisSituation" header="矫形器制作师证书执有情况" field="certOrthosisSituation" width="11%" >			
					<next:ComboBox triggerAction="all" editable="false" valueField="value" displayField="text"  dataset="comm_haveorno"/>
				</next:Column>
			
				<next:Column id="certOrthosisCode" header="证书编号" editable="false" field="certOrthosisCode" width="8%" >			
					<next:TextField  />
				</next:Column>
			
				<next:Column id="certOrthosisDate" header="发证时间" field="certOrthosisDate" width="6%" >			
					<next:DateField allowBlank="false" editable="false" format="Y-m-d" ></next:DateField>
				</next:Column>
				
				<next:Column id="certTime" header="最近一次年检时间" field="certTime" width="6%" >			
					<next:DateField allowBlank="false" editable="false" format="Y-m-d" ></next:DateField>
				</next:Column>
			
				<next:Column id="certSpecialSituation" header="有无特有工种职业资格证书" field="certSpecialSituation" width="11%" >			
					<next:ComboBox triggerAction="all" editable="false" valueField="value" displayField="text"  dataset="comm_haveorno"/>
				</next:Column>
			
				<next:Column id="certSpecialCode" header="证书编号" editable="false" field="certSpecialCode" width="8%" >			
					<next:TextField  />
				</next:Column>
			
				<next:Column id="certSpecialDate" header="发证时间" field="certSpecialDate" width="6%" >			
					<next:DateField allowBlank="false" editable="false" format="Y-m-d" ></next:DateField>
				</next:Column>
				
				<next:Column id="certSpecialTime" header="最近一次年检时间" field="certSpecialTime" width="6%" >			
					<next:DateField allowBlank="false" editable="false" format="Y-m-d" ></next:DateField>
				</next:Column>
					
			</next:Columns>
			<next:BottomBar>
				<next:PagingToolBar dataset="workerDs"/>
			</next:BottomBar>
		</next:EditGridPanel>
   </next:Panel>
   
   <next:Panel title="设施信息" width="100%" height="100%">
   		<next:EditGridPanel id="editGridDevice" name="editGridDevice" width="100%" stripeRows="true" height="99.9%" dataset="deviceDs" >
			<next:TopBar>
					<next:ToolBarItem symbol="->" ></next:ToolBarItem>
			</next:TopBar>
			    <next:Columns>
			    <next:RowNumberColumn width="30"/>
			    <next:CheckBoxColumn></next:CheckBoxColumn>
				<next:Column id="deviceCode" header="设施名称" field="deviceCode" width="15%" dataset="deviceDataSet1">			
				</next:Column>
				<next:Column id="deviceNum" header="数量"  field="deviceNum" width="15%" >			
				</next:Column>
			</next:Columns>
			
			<next:BottomBar>
				<next:PagingToolBar dataset="deviceDs"/>
			</next:BottomBar>
		</next:EditGridPanel>
   </next:Panel>
   
    <next:Panel title="生产能力信息" width="100%" height="100%">
   		<next:EditGridPanel id="editGridProduct" name="editGridProduct" width="100%" stripeRows="true" height="99.9%" dataset="productDs" >
			<next:TopBar>
					<next:ToolBarItem symbol="->" ></next:ToolBarItem>
			</next:TopBar>
			    <next:Columns>
			    <next:RowNumberColumn width="30"/>
			    <next:CheckBoxColumn></next:CheckBoxColumn>
				<next:Column id="produceId" header="生产能力表ID" field="produceId" width="95" hidden="true" ></next:Column>
				<next:Column id="taskCode" header="业务编码" field="taskCode" width="95" hidden="true" ></next:Column>
				<next:Column id="productName" header="产品名称" field="productName" width="20%" >			
				</next:Column>
				<next:Column id="productNum" header="产品数量" field="productNum" width="20%" >			
				</next:Column>
				<next:Column id="productValue" header="产品产值（万元）" field="productValue" width="20%" >			
				</next:Column>
			</next:Columns>
			<next:BottomBar>
				<next:PagingToolBar dataset="productDs"/>
			</next:BottomBar>
		</next:EditGridPanel>
   </next:Panel>
   
   </next:Tabs>
   </next:TabPanel>
</next:Panel>
</next:AnchorLayout>
</next:ViewPort>
<next:Window id="workerWin" title="员工信息" expandOnShow="false"
	closeAction="hide" resizable="false" width="1000" height="550">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="关闭" handler="closeWin" ></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form id="form2" method="post" dataset="workerDataSet"
			onsubmit="return false" class="L5form">
		<fieldset>
		<table width="100%">
			<tr>
				<td class="FieldLabel" style="width: 15%">姓名</td>
				<td class="FieldInput" style="width: 18%"><label type="text"
					name="姓名" id="name1" field="name" maxlength="50"
					style="width: 80%" /></td>

				<td class="FieldLabel" style="width: 15%">身份证号</td>
				<td class="FieldInput" style="width: 18%"><label type="text"
					name="身份证号" id="idCard1" field="idCard" maxlength="50"
					style="width: 80%" /></td>

				<td class="FieldLabel" style="width: 15%">性别</td>
				<td class="FieldInput" style="width: 18%"><label id="sex1"
					name="性别" title="性别" field="sex" dataset="sex" style="width: 80%">
					</label></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%">联系电话</td>
				<td class="FieldInput" style="width: 18%" ><label id="phone" field="phone" type="text" title="联系电话" style="width: 80%"/>
				<td class="FieldLabel" style="width: 15%">家庭住址</td>
				<td class="FieldInput" style="width: 18%" colspan="3"><label id="address" field="address" type="text" title="家庭住址" style="width: 80%"/>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%">残疾类别</td>
				<td class="FieldInput" style="width: 18%"><label id="disabilityType1" dataset="disabilityTypeDataset" field="disabilityType" style="width: 80%">
			     </label></td>

				<td class="FieldLabel" style="width: 15%">残疾等级</td>
				<td class="FieldInput" style="width: 18%"><label dataset="DmCjdjDataSet" id="disabilityLevel1" field="disabilityLevel" style="width: 80%" >
			     </label></td>

				<td class="FieldLabel" style="width: 15%">文化程度</td>
				<td class="FieldInput" style="width: 18%"><label id="education1" dataset="eduDataSet" field="education" title="文化程度" style="width: 80%">
				</label></td>
			</tr>
			
			<tr>	
				<td class="FieldLabel" style="width: 15%">入厂时间</td>
				<td class="FieldInput" style="width: 18%"><label type="text" id="entryDate" title="入厂时间" field="entryDate" readonly="readonly" format="Y-m-d" onclick="WdatePicker()" style="width: 80%" /></td>
				<td class="FieldLabel" style="width: 15%">入厂形式</td>
				<td class="FieldInput" style="width: 18%"><label  id="entryType1" dataset="entry_type" field="entryType" title="入厂形式" style="width: 80%">
				</label></td>
				<td class="FieldLabel" style="width: 15%">职业资格等级</td>
				<td class="FieldInput" style="width: 18%"><label dataset="job_level"  id="jobLevel1" field="jobLevel" title="职业资格登记" style="width: 80%">
				</label></td>
			</tr>
			<tr>	
				<td class="FieldLabel" style="width: 15%">是否生产人员</td>
				<td class="FieldInput" style="width: 18%">
					<label id="ifProductor1" dataset="comm_yesorno" field="ifProductor" style="width: 80%">
					</label>
				</td>
				<td class="FieldLabel" style="width: 15%">实发工资(元)</td>
				<td class="FieldInput" style="width: 18%"><label type="text" id="realWages1" field="realWages" title="实发工资" style="width: 80%"/><font color="red">*</font></td>
				<td class="FieldLabel" style="width: 15%">残疾补贴(元)</td>
				<td class="FieldInput" style="width: 18%"><label type="text" field="disSubsidy" id="disSubsidy" title="残疾补贴" style="width: 80%" /></td>
			</tr>
			<tr>	
				<td class="FieldLabel" style="width: 15%">发放方式</td>
				<td class="FieldInput" style="width: 18%">
					<label field="allocationType" dataset="allocation_Type" id="allocationType1" title="发放方式" style="width: 80%">
					</label>
				</td>
				<td class="FieldLabel" style="width: 15%">社会保险(五险一金)(元)</td>
				<td class="FieldInput" style="width: 18%"><label type="text" id="socialInsurance1" field="socialInsurance" title="社会保险" style="width: 80%"/><font color="red">*</font></td>
				
				<td class="FieldLabel" style="width: 15%">商业保险(元)</td>
				<td class="FieldInput" style="width: 18%"><label type="text" field="busInsurance" id="busInsurance1" title="商业保险" style="width: 80%" /><font color="red">*</font></td>
				
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%">养老保险(元)</td>
				<td class="FieldInput" style="width: 18%"><label type="text" field="endowmentInsurance" id="endowmentInsurance1" title="养老保险" style="width: 80%"/><font color="red">*</font></td>
				<td class="FieldLabel" style="width: 15%">医疗保险(元)</td>
				<td class="FieldInput" style="width: 18%">
					<label type="text" field="medicalInsurance" id="medicalInsurance1" title="医疗保险" style="width: 80%"/><font color="red">*</font>
				</td>
				
				<td class="FieldLabel" style="width: 15%">失业保险(元)</td>
				<td class="FieldInput" style="width: 18%"><label type="text" field="unemployedInsurance" id="unemployedInsurance1" title="失业保险" style="width: 80%" /><font color="red">*</font></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%">工伤保险(元)</td>
				<td class="FieldInput" style="width: 18%"><label type="text" field="injuryInsurance" id="injuryInsurance1" title="工伤保险" style="width: 80%" /><font color="red">*</font></td>
				<td class="FieldLabel" style="width: 15%">生育保险(元)</td>
				<td class="FieldInput" style="width: 18%">
					<label type="text" field="maternityInsurance" id="maternityInsurance1" title="生育保险" style="width: 80%"/><font color="red">*</font>
				</td>
				<td class="FieldLabel" style="width: 15%">住房公积金(元)</td>
				<td class="FieldInput" style="width: 18%"><label type="text" field="housingFund" id="housingFund1" title="住房公积金" style="width: 80%"/><font color="red">*</font></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%">假肢制作师证书<br>持有情况</td>
				<td class="FieldInput" style="width: 18%" >
					<label id="certSituation1" dataset="comm_haveorno" field="certSituation"  style="width: 80%">
					</label>
				</td>
				<td class="FieldLabel" style="width: 15%"></td>
				<td class="FieldInput" style="width: 15%"></td>
				<td class="FieldLabel" style="width: 15%"></td>
				<td class="FieldInput" style="width: 15%"></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%">证书编号</td>
				<td class="FieldInput" style="width: 18%">
					<label type="text" id="certCode1" field="certCode" title="职业资格证书编号"  style="width: 80%"/>
				</td>
				<td class="FieldLabel" style="width: 15%">发证时间</td>
				<td class="FieldInput" style="width: 18%"><label type="text" id="certDate1"  field="certDate" readonly="readonly" format="Y-m-d"  style="width: 80%"/></td>
				<td class="FieldLabel" style="width: 15%">最近一次年检时间</td>
				<td class="FieldInput" style="width: 18%"><label type="text" id="certTime1" field="certTime" readonly="readonly" format="Y-m-d"  style="width: 80%"/></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%">矫形器制作师证书<br>持有情况</td>
				<td class="FieldInput" style="width: 18%" >
					<label id="certOrthosisSituation1" dataset="comm_haveorno" field="certOrthosisSituation"   style="width: 80%">
					</label>
				</td>
				<td class="FieldLabel" style="width: 15%"></td>
				<td class="FieldInput" style="width: 15%"></td>
				<td class="FieldLabel" style="width: 15%"></td>
				<td class="FieldInput" style="width: 15%"></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%">证书编号</td>
				<td class="FieldInput" style="width: 18%">
					<label type="text" id="certOrthosisCode1" field="certOrthosisCode" title="职业资格证书编号"  style="width: 80%"/>
				</td>
				<td class="FieldLabel" style="width: 15%">发证时间</td>
				<td class="FieldInput" style="width: 18%"><label type="text" id="certOrthosisDate1"  field="certOrthosisDate" readonly="readonly" format="Y-m-d" style="width: 80%"/></td>
				<td class="FieldLabel" style="width: 15%">最近一次年检时间</td>
				<td class="FieldInput" style="width: 18%"><label type="text" id="certOrthosisTime1"  field="certOrthosisTime" readonly="readonly" format="Y-m-d"  style="width: 80%"/></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%">特有工种职业资格证书<br>持有情况</td>
				<td class="FieldInput" style="width: 18%" >
					<label id="certSpecialSituation1" dataset="comm_haveorno" field="certSpecialSituation"    style="width: 80%">
					</label>
				</td>
				<td class="FieldLabel" style="width: 15%"></td>
				<td class="FieldInput" style="width: 15%"></td>
				<td class="FieldLabel" style="width: 15%"></td>
				<td class="FieldInput" style="width: 15%"></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%">证书编号</td>
				<td class="FieldInput" style="width: 18%"><label type="text" id="certSpecialCode1"  field="certSpecialCode" title="特有工种职业资格证书编号" style="width: 80%"/></td>
				<td class="FieldLabel" style="width: 15%">发证时间</td>
				<td class="FieldInput" style="width: 18%"><label type="text" id="certSpecialDate1" field="certSpecialDate" format="Y-m-d" style="width: 80%"/></td>
				<td class="FieldLabel" style="width: 15%">最近一次年检时间</td>
				<td class="FieldInput" style="width: 18%"><label type="text" id="certSpecialTime1"  field="certSpecialTime" format="Y-m-d" style="width: 80%"/></td>
			</tr>
		</table>
		</fieldset>
		</form>
	</next:Html>
</next:Window>
</body>
</html>