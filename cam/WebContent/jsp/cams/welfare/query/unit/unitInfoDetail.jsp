
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.IdHelp"%>
<html>
	<head>
		<title>基本信息查询</title>
		<next:ScriptManager/>
		<script>
			<%
				String taskCode=request.getParameter("taskCode");
				String method=request.getParameter("method");
				if(taskCode==null){
					taskCode=IdHelp.getUUID32();
				}
			%>
			var method='<%=method%>';
			var taskCode='<%=taskCode%>';
		</script>
		<script type="text/javascript" src="unitInfoDetail.js"></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
	</head>
<body>
<model:datasets>
	<!-- 业务信息表 -->
	<model:dataset id="ds" cmd="com.inspur.cams.welfare.base.cmd.WealUnitInfoQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealUnitInfo">
		<model:field name="serialNum" type="string" rule="require" />	
		<model:field name="companyName" type="string" rule="require" />	
		<model:field name="economicNatureCode" type="string" rule="require" />
		<model:field name="legalPeople" type="string" rule="require" />
		<model:field name="approveDate" type="string" rule="require" />
		<model:field name="nextCheck" type="string" rule="require" />
		</model:record>
	</model:dataset>
	<!-- 业务表 -->
	<model:dataset id="applyDs" cmd="com.inspur.cams.welfare.base.cmd.WealUnitApplyQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealUnitApply"></model:record>
	</model:dataset>
	<!-- 状态信息表 -->
	<model:dataset id="statusDs" cmd="com.inspur.cams.welfare.base.cmd.WealUnitStatusQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealUnitStatus"></model:record>
	</model:dataset>
	<!-- 经济性质字典表 -->
	<model:dataset id="ecoDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='WEAL_DIC_ECONOMICNATURE'></model:param>
		</model:params>
	</model:dataset>
	<!-- 职工信息表 -->
	<model:dataset id="workerDs" cmd="com.inspur.cams.welfare.base.cmd.WealWorkerQueryCommand" global="true" pageSize="15">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealWorker"></model:record>
	</model:dataset>
	<model:dataset id="workerDsExcel" cmd="com.inspur.cams.welfare.base.cmd.WealWorkerQueryCommand" method="getWorker"  global="true" pageSize="15">
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
	<!-- 职业资格等级 -->
	<model:dataset id="job_level" enumName="WEAL.JOB_LEVEL" autoLoad="true" global="true"></model:dataset>
	<!-- 入厂形式 -->
	<model:dataset id="entry_type" enumName="WEAL.ENTRY_TYPE" autoLoad="true" global="true"></model:dataset>
	<!--主要产品信息 -->
	<model:dataset id="productDs" cmd="com.inspur.cams.welfare.base.cmd.WealFitProductivepowerQueryCommand"  global="true" pageSize="100">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealFitProductivepower"></model:record>
	</model:dataset>
	<!-- 年检信息 -->
	<model:dataset id="checkDs" cmd="com.inspur.cams.welfare.welfarecorp.apply.cmd.UnitApplyQueryCmd" method="queryCheck" global="true">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealUnitApply"></model:record>
	</model:dataset>
	<model:dataset id="exploration_base_opinion" enumName="WEAL.EXPLORATION_BASE_OPINION" autoLoad="true" global="true"></model:dataset>
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
				<td class="FieldInput" width="19%"><label title="编号" name="serialNum" field="serialNum" style="width: 95%"/></td>
	
				<td  class="FieldLabel" width="14%">企业名称</td>
				<td class="FieldInput" width="19%"><label title="企业名称" name="companyName" field="companyName" style="width: 95%"/></td>
				
				<td  class="FieldLabel" width="14%">姓名</td>
				<td class="FieldInput" width="19%"><label name="legalPeople" field="legalPeople" style="width: 95%" /></td>
			</tr>
	   		<tr>
	   			<td  class="FieldLabel" width="14%">注册地址</td>
				<td class="FieldInput" width="19%"><label name="address" field="address" style="width: 95%" /> </td>
				
				<td  class="FieldLabel" width="14%">邮编</td>
				<td class="FieldInput" width="19%"><label name="postCode" field="postCode" style="width: 95%" /> </td>
			
				<td  class="FieldLabel" width="14%">网站地址</td>
				<td class="FieldInput" width="19%"><label name="webAddress" field="webAddress" style="width: 95%" /> </td>
			</tr>
			<tr>
				<td  class="FieldLabel" width="14%">经济性质</td>
				<td class="FieldInput" width="19%">
					<label dataset="ecoDataSet" id="economicNatureCode" field="economicNatureCode" name="经济性质" title="经济性质" style="width: 95%"/></td>
					
				<td  class="FieldLabel" width="14%">注册资金（万元）</td>
				<td class="FieldInput" width="19%"><label name="regFund" field="regFund" style="width: 95%" /> </td>	
				
				<td  class="FieldLabel" width="14%"></td>
				<td class="FieldInput" width="19%"></td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" width="14%">组织机构代码</td>
				<td class="FieldInput" width="19%"><label name="organCode" field="organCode" style="width: 95%" /> </td>
			
				<td  class="FieldLabel" width="14%">营业执照编号</td>
				<td class="FieldInput" width="19%"><label name="licenseCode" field="licenseCode" style="width: 95%" /> </td>
			
				<td  class="FieldLabel" width="14%">税务登记编号</td>
				<td class="FieldInput" width="19%"><label name="registrationCode" field="registrationCode" style="width: 95%" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" width="14%">经营范围 主营</td>
				<td class="FieldInput" width="19%"><label name="firstScope" field="firstScope" style="width: 95%" /> </td>
			
				<td  class="FieldLabel" width="14%">经营范围 兼营</td>
				<td class="FieldInput" width="19%"><label name="secondScope" field="secondScope" style="width: 95%" /> </td>
				
				<td  class="FieldLabel" width="14%"></td>
				<td class="FieldInput" width="19%"></td>
			</tr>
   		</table>
		</fieldset>
		<fieldset>
		<legend>法人信息</legend>
		<table border="1"  width="100%" >
	   		<tr>
				<td  class="FieldLabel" width="14%">姓名</td>
				<td class="FieldInput" width="19%"><label  name="法人姓名" field="legalPeople" style="width: 95%" /></td>
				
				<td  class="FieldLabel" width="14%">身份证号码</td>
				<td class="FieldInput" width="19%"><label  name="法人身份证号码" field="legalIdCard" style="width: 95%" /></td>
				
				<td  class="FieldLabel" width="14%">固定电话</td>
				<td class="FieldInput" width="19%"><label  name="法人固定电话" field="legalPhone" style="width: 95%" /></td>
				
			</tr>
			<tr>
				<td  class="FieldLabel" width="14%">手机号码</td>
				<td class="FieldInput" width="19%"><label  name="法人手机号码" field="legalTelphone" style="width: 95%" /></td>
				
				<td  class="FieldLabel" width="14%"></td>
				<td  class="FieldInput" width="14%"></td>
				
				<td  class="FieldLabel" width="14%"></td>
				<td  class="FieldInput" width="14%"></td>
			</tr>
		</table>
		</fieldset>
		<fieldset>
		<legend>经办人信息</legend>
		<table border="1"  width="100%" >
	   		<tr>
				<td  class="FieldLabel" width="14%">姓名</td>
				<td class="FieldInput" width="19%"><label name="agentPeople" field="agentPeople" style="width: 95%" /> </td>
			
				<td  class="FieldLabel" width="14%">联系电话</td>
				<td class="FieldInput" width="19%"><label name="agentPhone" field="agentPhone" style="width: 95%" /> </td>
			
				<td  class="FieldLabel" width="14%">电子邮箱</td>
				<td class="FieldInput" width="19%"><label name="agentEmail" field="agentEmail" style="width: 95%" /> </td>
			</tr>
		</table>
		</fieldset>
		<fieldset>
		<legend>业务信息</legend>
		<table border="1"  width="100%" >
	   		<tr>
				<td class="FieldLabel" width="14%">批准通过时间</td>
				<td class="FieldInput" width="19%"><label id="approveDate" name="approveDate" field="approveDate" style="width: 95%" /></td>
			
				<td class="FieldLabel" width="14%">下一次年检年度</td>
				<td class="FieldInput" width="19%"><label id="nextCheck" name="nextCheck" field="nextCheck" style="width: 95%" /></td>
			
				<td class="FieldLabel" width="14%"></td>
				<td class="FieldInput" width="19%"> </td>
			</tr>
		</table>
		</fieldset>
		</form>
   </next:Html>
   </next:Panel>
   
   <next:Panel title="员工信息" width="100%" height="100%">
	   	<next:Panel  name="form" width="100%" border="0" autoHeight="true" >
			<next:Html>
				<fieldset style="overflow: visible;" class="GroupBox"><legend
								class="GroupBoxTitle">查询条件 <img
								class="GroupBoxExpandButton"
								src="<%=SkinUtils.getImage(request,
												"groupbox_collapse.gif")%>"
								onclick="collapse(this)" /> </legend>
							<div>
								<form style="width: 95%; height: 100%;" class="L5form">
							<table  border="1" width="100%" >
								<tr >		
									<td class="FieldLabel">身份证号:</td>
									<td class="FieldInput"><input type="text"  id="idCardQuery" class="TextEditor" title="ID_CARD"  /></td>			
									<td class="FieldLabel">姓名:</td>
									<td class="FieldInput"><input type="text"  id="nameQuery" class="TextEditor" title="NAME"  /></td>			
									<%-- 
									<td class="FieldLabel">资格证书编号:</td>
									<td class="FieldInput"><input type="text"  id="certCodeQuery" class="TextEditor" title="CERT_CODE"  /></td>			
									<td class="FieldLabel">特有工种职业资格证书编号:</td>
									<td class="FieldInput"><input type="text"  id="certSpecialCodeQuery" class="TextEditor" title="CERT_SPECIAL_CODE"  /></td>	
									--%>
									<td class="FieldLabel"><button onclick="query()">查 询</button>&nbsp;&nbsp;&nbsp; <button type="reset">重 置</button> </td>
								</tr>								
							</table>
							</form>
							</div>
				</fieldset>
			</next:Html>
		</next:Panel>
		<next:EditGridPanel id="editGridWorker" name="editGridWorker" width="100%" height="100%" dataset="workerDs" clickToSelectedForChkSM="true">
			<next:TopBar>
					<next:ToolBarItem symbol="->" ></next:ToolBarItem>
					<next:ToolBarItem  iconCls="detail" text="查看"  handler="editW" />
					<next:ToolBarItem  iconCls="add" text="导出" handler="toE"/>
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
				<next:Column id="idCard" header="身份证号" field="idCard" width="12%"  editable="false" >			
					<next:TextField />
				</next:Column>
				<next:Column id="sex" header="性别" field="sex" width="4%" >			
					<next:ComboBox triggerAction="all" editable="false" valueField="value" displayField="text"  dataset="sex"/>
				</next:Column>
				<next:Column id="phone" header="联系电话" editable="false" field="phone" width="10%" >			
					<next:TextField />
				</next:Column>
				<next:Column id="disabilityType" header="残疾类别" field="disabilityType" width="6%" >			
					<next:ComboBox triggerAction="all" editable="false" valueField="value" displayField="text"  dataset="disabilityTypeDataset"/>
				</next:Column>
				<next:Column id="disabilityLevel" header="残疾等级" field="disabilityLevel" width="6%" >			
					<next:ComboBox triggerAction="all" editable="false" valueField="value" displayField="text"  dataset="DmCjdjDataSet"/>
				</next:Column>
				<next:Column id="education" header="文化程度" field="education" width="9%" >			
					<next:ComboBox triggerAction="all" editable="false" valueField="value" displayField="text"  dataset="eduDataSet"/>
				</next:Column>
			
				<next:Column id="address" header="家庭住址" editable="false" field="address" hidden="true" width="12%" >			
					<next:TextField  />
				</next:Column>
			
				<next:Column id="entryDate" header="入厂时间" field="entryDate" width="8%" >			
					<next:DateField allowBlank="false" format="Y-m-d" editable="false" ></next:DateField>
				</next:Column>
			
				<next:Column id="entryType" header="入厂形式" editable="false" field="entryType" width="6%" >			
					<next:ComboBox triggerAction="all" editable="false" valueField="value" displayField="text"  dataset="entry_type"/>
				</next:Column>
			
				<next:Column id="jobLevel" header="职业资格等级" editable="false" dataset="job_level" field="jobLevel" width="8%" >			
					<next:TextField  />
				</next:Column>
			
				<next:Column id="realWages" header="实发工资" editable="false" field="realWages" width="6%" >			
					<next:NumberField  />
				</next:Column>
			
				<next:Column id="socialInsurance" header="社会保险" editable="false" field="socialInsurance" width="6%" >			
					<next:NumberField  />
				</next:Column>
				
				<next:Column id="endowmentInsurance" header="养老保险" editable="false" field="endowmentInsurance" width="6%" >			
					<next:NumberField  />
				</next:Column>
				
				<next:Column id="medicalInsurance" header="医疗保险" editable="false" field="medicalInsurance" width="6%" >			
					<next:NumberField  />
				</next:Column>
				
				<next:Column id="unemployedInsurance" header="失业保险" editable="false" field="unemployedInsurance" width="6%" >			
					<next:NumberField  />
				</next:Column>
				
				<next:Column id="injuryInsurance" header="工伤保险" editable="false" field="injuryInsurance" width="6%" >			
					<next:NumberField  />
				</next:Column>
				
				<next:Column id="maternityInsurance" header="生育保险" editable="false" field="maternityInsurance" width="6%" >			
					<next:NumberField  />
				</next:Column>
				
				<next:Column id="housingFund" header="住房公积金" editable="false" field="housingFund" width="8%" >			
					<next:NumberField  />
				</next:Column>
			
				<next:Column id="busInsurance" header="商业保险" editable="false" field="busInsurance" width="6%" >			
					<next:NumberField  />
				</next:Column>
				
				<next:Column id="disSubsidy" header="残疾人补贴" editable="false" field="disSubsidy" width="7%" >			
					<next:NumberField  />
				</next:Column>
				
				<next:Column id="allocationType" header="发放方式" editable="false" field="allocationType" width="6%" >			
					<next:ComboBox triggerAction="all" editable="false" valueField="value" displayField="text"  dataset="allocation_Type"/>
				</next:Column>
			
				<next:Column id="ifProductor" header="是否生产人员" field="ifProductor" width="8%" >			
					<next:ComboBox triggerAction="all" editable="false" valueField="value" displayField="text"  dataset="comm_yesorno"/>
				</next:Column>
					
			</next:Columns>
			<next:BottomBar>
				<next:PagingToolBar dataset="workerDs"/>
			</next:BottomBar>
		</next:EditGridPanel>
   </next:Panel>
  <%-- 
    <next:Panel title="生产能力信息" width="100%" height="100%">
   		<next:EditGridPanel id="editGridProduct" name="editGridProduct" width="100%" stripeRows="true" height="99.9%" dataset="productDs" >
			<next:TopBar>
					<next:ToolBarItem symbol="->" ></next:ToolBarItem>
			</next:TopBar>
			    <next:Columns>
			    <next:RowNumberColumn width="30"/>
			    <next:RadioBoxColumn></next:RadioBoxColumn>
				<next:Column id="produceId" header="生产能力表ID" field="produceId" width="95" hidden="true" ></next:Column>
				<next:Column id="taskCode" header="业务编码" field="taskCode" width="95" hidden="true" ></next:Column>
				<next:Column id="productName" header="产品名称" editable="false" field="productName" width="20%" >			
				</next:Column>
				<next:Column id="productValue" header="年销售收入（万元）" editable="false" field="productValue" width="20%" >			
				</next:Column>
			</next:Columns>
			<next:BottomBar>
				<next:PagingToolBar dataset="productDs"/>
			</next:BottomBar>
		</next:EditGridPanel>
   </next:Panel>
   --%>
    <next:Panel title="年检信息" width="100%" height="100%">
   		<next:EditGridPanel id="editGridCheck" name="editGridCheck" width="100%" stripeRows="true" height="99.9%" dataset="checkDs" >
			<next:TopBar>
					<next:ToolBarItem symbol="->" ></next:ToolBarItem>
			</next:TopBar>
			    <next:Columns>
			    <next:RowNumberColumn width="30"/>
			    <next:RadioBoxColumn></next:RadioBoxColumn>
				<next:Column id="TASK_CODE" header="业务编码" field="TASK_CODE" width="95" hidden="true" ></next:Column>
				<next:Column id="UNIT_ID" header="福利企业ID" field="UNIT_ID" width="95" hidden="true" ></next:Column>
				<next:Column id="APPLY_YEAR" header="年度" field="APPLY_YEAR" renderer="detailHref" width="10%" >			
				</next:Column>
				<next:Column id="COUNTY_CHARGE_BASE_OPINION" header="县主管审核基本意见" field="COUNTY_CHARGE_BASE_OPINION" dataset="exploration_base_opinion" width="10%" >			
				</next:Column>
				<next:Column id="COUNTY_CHARGE_TIME" header="县主管审核时间" field="COUNTY_CHARGE_TIME" width="10%" >			
				</next:Column>
				<next:Column id="COUNTY_CHIEF_BASE_OPINION" header="县局长审核基本意见" field="COUNTY_CHIEF_BASE_OPINION" dataset="exploration_base_opinion" width="10%" >			
				</next:Column>
				<next:Column id="COUNTY_CHIEF_TIME" header="县局长审核时间" field="COUNTY_CHIEF_TIME" width="10%" >			
				</next:Column>
				<next:Column id="CITY_CHARGE_BASE_OPINION" header="市主管审核基本意见" field="CITY_CHARGE_BASE_OPINION" dataset="exploration_base_opinion" width="10%" >			
				</next:Column>
				<next:Column id="CITY_CHARGE_TIME" header="市主管审核时间" field="CITY_CHARGE_TIME" width="10%" >			
				</next:Column>
				<next:Column id="CITY_CHIEF_BASE_OPINION" header="市局长审核基本意见" field="CITY_CHIEF_BASE_OPINION" dataset="exploration_base_opinion" width="10%" >			
				</next:Column>
				<next:Column id="CITY_CHIEF_TIME" header="市局长审核时间" field="CITY_CHIEF_TIME" width="10%" >			
				</next:Column>
			</next:Columns>
			<next:BottomBar>
				<next:PagingToolBar dataset="checkDs"/>
			</next:BottomBar>
		</next:EditGridPanel>
   </next:Panel>
   
   </next:Tabs>
   </next:TabPanel>
</next:Panel>
</next:AnchorLayout>
</next:ViewPort>
<next:Window id="workerWin" title="员工信息" expandOnShow="false"
	closeAction="hide" resizable="false" width="1000" height="420">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="关闭" handler="closeWorker" ></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form id="form2" method="post" dataset="workerDataSet"
			onsubmit="return false" class="L5form">
		<fieldset>
		<table width="100%">
			<tr>
				<td class="FieldLabel" style="width: 15%">姓名：</td>
				<td class="FieldInput" style="width: 18%"><label 
					name="姓名" id="name" field="name" maxlength="50"
					style="width: 80%" /></td>

				<td class="FieldLabel" style="width: 15%">身份证号：</td>
				<td class="FieldInput" style="width: 18%"><label 
					name="身份证号" id="idCard" field="idCard" maxlength="50"
					style="width: 80%" /></td>

				<td class="FieldLabel" style="width: 15%">性别：</td>
				<td class="FieldInput" style="width: 18%"><label id="sex"
					name="性别" title="性别" field="sex" style="width: 80%" dataset="sex">
					</label></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%">联系电话</td>
				<td class="FieldInput" style="width: 18%" ><label id="phone" field="phone" type="text" title="联系电话" style="width: 80%"/>
				<td class="FieldLabel" style="width: 15%">家庭住址</td>
				<td class="FieldInput" style="width: 18%" colspan="3"><label id="address" field="address" type="text" title="家庭住址" style="width: 80%"/>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%">残疾类别：</td>
				<td class="FieldInput" style="width: 18%"><label id="disabilityType1" field="disabilityType" dataset="disabilityTypeDataset" style="width: 80%">
			     </label></td>

				<td class="FieldLabel" style="width: 15%">残疾等级：</td>
				<td class="FieldInput" style="width: 18%"><label id="disabilityLevel1" field="disabilityLevel" dataset="DmCjdjDataSet" style="width: 80%" >
			     </label></td>

				<td class="FieldLabel" style="width: 15%">文化程度：</td>
				<td class="FieldInput" style="width: 18%"><label id="education1" field="education" title="文化程度" dataset="eduDataSet" style="width: 80%">
				</label></td>
			</tr>
			<tr>	
				<td class="FieldLabel" style="width: 15%">入厂时间：</td>
				<td class="FieldInput" style="width: 18%"><label  id="entryDate" title="入厂时间" field="entryDate" style="width: 80%" /></td>
				<td class="FieldLabel" style="width: 15%">入厂形式：</td>
				<td class="FieldInput" style="width: 18%"><label  id="entryType1" field="entryType" title="入厂形式" style="width: 80%"/></td>
				<td class="FieldLabel" style="width: 15%">职业资格等级：</td>
				<td class="FieldInput" style="width: 18%"><label  id="jobLevel1" field="jobLevel" title="职业资格登记" style="width: 80%"></td>
			</tr>
			<tr>	
				<td class="FieldLabel" style="width: 15%">是否生产人员</td>
				<td class="FieldInput" style="width: 18%">
					<label id="ifProductor1" field="ifProductor" dataset="comm_yesorno" style="width: 80%">
					</label>
				</td>
				<td class="FieldLabel" style="width: 15%">实发工资(元/年)</td>
				<td class="FieldInput" style="width: 18%"><label  id="realWages" field="realWages" title="实发工资" style="width: 80%"/></td>
				
				<td class="FieldLabel" style="width: 15%">残疾补贴(元/年)</td>
				<td class="FieldInput" style="width: 18%"><label  field="disSubsidy" id="disSubsidy" title="残疾补贴" style="width: 80%" /></td>
			</tr>
			<tr>	
				<td class="FieldLabel" style="width: 15%">发放方式</td>
				<td class="FieldInput" style="width: 18%">
					<label field="allocationType" id="allocationType1" dataset="allocation_Type" title="发放方式" style="width: 80%">
					</label>
				</td>
				<td class="FieldLabel" style="width: 15%">社会保险(五险一金)：</td>
				<td class="FieldInput" style="width: 18%"><label type="socialInsurance" field="socialInsurance" title="社会保险" style="width: 80%"/></td>
			
				<td class="FieldLabel" style="width: 15%">商业保险：</td>
				<td class="FieldInput" style="width: 18%"><label  field="busInsurance" id="busInsurance" title="商业保险" style="width: 80%" /></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%">养老保险(元/年)</td>
				<td class="FieldInput" style="width: 18%"><label  field="endowmentInsurance" id="endowmentInsurance" title="养老保险" style="width: 80%"/></td>
				<td class="FieldLabel" style="width: 15%">医疗保险(元/年)</td>
				<td class="FieldInput" style="width: 18%">
					<label  field="medicalInsurance" id="medicalInsurance" title="医疗保险" style="width: 80%"/>
				</td>
			
				<td class="FieldLabel" style="width: 15%">失业保险(元/年)</td>
				<td class="FieldInput" style="width: 18%"><label  field="unemployedInsurance" id="unemployedInsurance" title="失业保险" style="width: 80%" /></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%">工伤保险(元/年)</td>
				<td class="FieldInput" style="width: 18%"><label  field="injuryInsurance" id="injuryInsurance" title="工伤保险" style="width: 80%" /></td>
				<td class="FieldLabel" style="width: 15%">生育保险(元/年)</td>
				<td class="FieldInput" style="width: 18%">
					<label  field="maternityInsurance" id="maternityInsurance" title="生育保险" style="width: 80%"/>
				</td>
				<td class="FieldLabel" style="width: 15%">住房公积金(元/年)</td>
				<td class="FieldInput" style="width: 18%"><label  field="housingFund" id="housingFund" title="住房公积金" style="width: 80%"/></td>
			</tr>
		</table>
		</fieldset>
		</form>
	</next:Html>
</next:Window>
<next:Window id="checkWin" title="年检信息" expandOnShow="false"
	closeAction="hide" resizable="false" width="1000" height="600">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="关闭" handler="closeWin" ></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form id="formCheck" method="post" dataset="ds"
			onsubmit="return false" class="L5form">
		<fieldset>
		<legend>一、企业基本情况</legend>
		<table width="100%">
			<tr>
				<td class="FieldLabel" style="width: 15%">年末职工总数：</td>
				<td class="FieldInput" style="width: 15%"><div align="center"><label 
					name="年末职工总数" id="workersAll" field="workersAll" maxlength="50"
					style="width: 80%" ></label>人</div></td>

				<td class="FieldLabel" style="width: 15%">（其中）健全职工：</td>
				<td class="FieldInput" style="width: 15%"><div align="center"><label 
					name="（其中）健全职工" id="workersHealth" field="workersHealth" maxlength="50"
					style="width: 80%" /></label>人</div></td>

				<td class="FieldLabel" style="width: 15%">（其中）残疾职工：</td>
				<td class="FieldInput" style="width: 15%"><div align="center"><label 
					name="（其中）残疾职工" id="workersDeform" field="workersDeform" maxlength="50"
					style="width: 80%" /></label>人</div></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%">1、肢体残疾：</td>
				<td class="FieldInput" style="width: 15%"><div align="center"><label 
					name="肢体残疾" id="workersDeformLimb" field="workersDeformLimb" maxlength="50" 
					style="width: 80%"/></label>人</div></td>

				<td class="FieldLabel" style="width: 15%">2、听力语言残疾：</td>
				<td class="FieldInput" style="width: 15%"><div align="center"><label 
					name="听力语言残疾" id="workersDeformHear" field="workersDeformHear" maxlength="50" 
					style="width: 80%"/></label>人</div></td>

				<td class="FieldLabel" style="width: 15%">3、视力残疾：</td>
				<td class="FieldInput" style="width: 15%"><div align="center"><label 
					name="视力残疾" id="workersDeformEye" field="workersDeformEye" maxlength="50" 
					style="width: 80%"/></label>人</div></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%">4、综合残疾：</td>
				<td class="FieldInput" style="width: 15%"><div align="center"><label 
					name="综合残疾" id="workersDeformMulti" field="workersDeformMulti" maxlength="50" 
					style="width: 80%"/></label>人</div></td>
				
				<td class="FieldLabel" style="width: 15%">残疾职工占职工总数比例：</td>
				<td class="FieldInput" style="width: 15%"><div align="center"><label 
					name="残疾职工占职工总数比例" id="scaleLimb" field="scaleLimb" maxlength="50" 
					style="width: 80%"/></label>%</div></td>
					
				<td class="FieldLabel" style="width: 15%"></td>
				<td class="FieldInput" style="width: 15%"></td>
			</tr>
		</table>
		<legend>二、当年财务、纳税及减免税情况</legend>
		<table width="100%">
			<tr>
				<td class="FieldLabel" style="width: 15%">固定资产原值：</td>
				<td class="FieldInput" style="width: 15%"><div align="center"><label 
					name="固定资产原值" id="assets" field="assets" maxlength="50"
					style="width: 80%" ></label>万元</div></td>

				<td class="FieldLabel" style="width: 15%">营业收入：</td>
				<td class="FieldInput" style="width: 15%"><div align="center"><label 
					name="营业收入" id="incomeBusiness" field="incomeBusiness" maxlength="50"
					style="width: 80%" /></label>万元</div></td>

				<td class="FieldLabel" style="width: 15%">费用合计：</td>
				<td class="FieldInput" style="width: 15%"><div align="center"><label 
					name="费用合计" id="allcost" field="allcost" maxlength="50"
					style="width: 80%" /></label>万元</div></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%">营业利润：</td>
				<td class="FieldInput" style="width: 15%"><div align="center"><label 
					name="营业利润" id="gainBusiness" field="gainBusiness" maxlength="50"
					style="width: 80%" ></label>万元</div></td>

				<td class="FieldLabel" style="width: 15%">企业单位增加值：</td>
				<td class="FieldInput" style="width: 15%"><div align="center"><label 
					name="企业单位增加值" id="addingvalue" field="addingvalue" maxlength="50"
					style="width: 80%" /></label>万元</div></td>

				<td class="FieldLabel" style="width: 15%">纳税总额：</td>
				<td class="FieldInput" style="width: 15%"><div align="center"><label 
					name="纳税总额" id="taxAll" field="taxAll" maxlength="50"
					style="width: 80%" /></label>万元</div></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%">增值税总额：</td>
				<td class="FieldInput" style="width: 15%"><div align="center"><label 
					name="增值税总额" id="taxAdded" field="taxAdded" maxlength="50"
					style="width: 80%" ></label>万元</div></td>

				<td class="FieldLabel" style="width: 15%">营业税总额：</td>
				<td class="FieldInput" style="width: 15%"><div align="center"><label 
					name="营业税总额" id="taxBusiness" field="taxBusiness" maxlength="50"
					style="width: 80%" /></label>万元</div></td>

				<td class="FieldLabel" style="width: 15%">所得税总额：</td>
				<td class="FieldInput" style="width: 15%"><div align="center"><label 
					name="所得税总额" id="taxIncome" field="taxIncome" maxlength="50"
					style="width: 80%" /></label>万元</div></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%">应减免税金总额：</td>
				<td class="FieldInput" style="width: 15%"><div align="center"><label 
					name="应减免税金总额" id="taxShouldReduce" field="taxShouldReduce" maxlength="50"
					style="width: 80%" ></label>万元</div></td>

				<td class="FieldLabel" style="width: 15%">实际减免税金总额：</td>
				<td class="FieldInput" style="width: 15%"><div align="center"><label 
					name="实际减免税金总额" id="taxFactReduce" field="taxFactReduce" maxlength="50"
					style="width: 80%" /></label>万元</div></td>

				<td class="FieldLabel" style="width: 15%">盈利总额：</td>
				<td class="FieldInput" style="width: 15%"><div align="center"><label 
					name="盈利总额" id="profit" field="profit" maxlength="50"
					style="width: 80%" /></label>万元</div></td>
			</tr>
		</table>	
		<legend>三、当年劳动、工资及福利</legend>
		<table width="100%">
			<tr>
				<td class="FieldLabel" style="width: 15%">所在区县适用最低月工资标准：</td>
				<td class="FieldInput" style="width: 15%"><div align="center"><label 
					name="所在区县适用最低月工资标准" id="assets" field="assets" maxlength="50"
					style="width: 80%" ></label>元</div></td>

				<td class="FieldLabel" style="width: 15%">残疾职工最低月工资（含保险等）：</td>
				<td class="FieldInput" style="width: 15%"><div align="center"><label 
					name="残疾职工最低月工资（含保险等）" id="incomeBusiness" field="incomeBusiness" maxlength="50"
					style="width: 80%" /></label>元</div></td>

				<td class="FieldLabel" style="width: 15%"></td>
				<td class="FieldInput" style="width: 15%"></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%">职工人均年收入：</td>
				<td class="FieldInput" style="width: 15%"><div align="center"><label 
					name="职工人均年收入" id="incomePerworkerYear" field="incomePerworkerYear" maxlength="50"
					style="width: 80%" /></label>元</div></td>

				<td class="FieldLabel" style="width: 15%">残疾职工年人均收入：</td>
				<td class="FieldInput" style="width: 15%"><div align="center"><label 
					name="残疾职工年人均收入" id="incomePerdedormYear" field="incomePerdedormYear" maxlength="50"
					style="width: 80%" ></label>元</div></td>

				<td class="FieldLabel" style="width: 15%"></td>
				<td class="FieldInput" style="width: 15%"></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%">参加养老保险残疾职工数：</td>
				<td class="FieldInput" style="width: 15%"><div align="center"><label 
					name="参加养老保险残疾职工数" id="workersDeformSecurity" field="workersDeformSecurity" maxlength="50"
					style="width: 80%" /></label>人</div></td>

				<td class="FieldLabel" style="width: 15%">参加医疗保险残疾职工数：</td>
				<td class="FieldInput" style="width: 15%"><div align="center"><label 
					name="参加医疗保险残疾职工数" id="workersDeformMedical" field="workersDeformMedical" maxlength="50"
					style="width: 80%" /></label>人</div></td>

				<td class="FieldLabel" style="width: 15%">参加失业保险残疾职工数：</td>
				<td class="FieldInput" style="width: 15%"><div align="center"><label 
					name="参加失业保险残疾职工数" id="workersDeformUnemployed" field="workersDeformUnemployed" maxlength="50"
					style="width: 80%" ></label>人</div></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%">参加工伤保险残疾职工数：</td>
				<td class="FieldInput" style="width: 15%"><div align="center"><label 
					name="参加工伤保险残疾职工数" id="workersDeformInjury" field="workersDeformInjury" maxlength="50"
					style="width: 80%" /></label>人</div></td>

				<td class="FieldLabel" style="width: 15%">签订用工合同残疾职工数：</td>
				<td class="FieldInput" style="width: 15%"><div align="center"><label 
					name="签订用工合同残疾职工数" id="workersDeformPact" field="workersDeformPact" maxlength="50"
					style="width: 80%" /></label>人</div></td>

				<td class="FieldLabel" style="width: 15%">通过金融机构发放工资残疾职工数：</td>
				<td class="FieldInput" style="width: 15%"><div align="center"><label 
					name="通过金融机构发放工资残疾职工数" id="workersDeformPaybybank" field="workersDeformPaybybank" maxlength="50"
					style="width: 80%" /></label>人</div></td>
			</tr>
		</table>
		<legend>四、当年减免税金管理及使用情况</legend>
		<table width="100%">
			<tr>
				<td class="FieldLabel" style="width: 15%">当年减免税金额：</td>
				<td class="FieldInput" style="width: 15%"><div align="center"><label 
					name="当年减免税金额" id="taxReduce" field="taxReduce" maxlength="50"
					style="width: 80%" ></label>元</div></td>

				<td class="FieldLabel" style="width: 15%"></td>
				<td class="FieldInput" style="width: 15%"></td>

				<td class="FieldLabel" style="width: 15%"></td>
				<td class="FieldInput" style="width: 15%"></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%">1、用于福利和各类保险：</td>
				<td class="FieldInput" style="width: 15%"><div align="center"><label 
					name="用于福利和各类保险" id="taxReduceWeal" field="taxReduceWeal" maxlength="50"
					style="width: 80%" /></label>元</div></td>

				<td class="FieldLabel" style="width: 15%">2、用于社会福利事业捐赠:</td>
				<td class="FieldInput" style="width: 15%"><div align="center"><label 
					name="用于社会福利事业捐赠" id="taxReduceDonate" field="taxReduceDonate" maxlength="50"
					style="width: 80%" /></label>元</div></td>
					
				<td class="FieldLabel" style="width: 15%"></td>
				<td class="FieldInput" style="width: 15%"></td>
			</tr>
		</table>
		</fieldset>
		</form>
	</next:Html>
</next:Window>
</body>
</html>