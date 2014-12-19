
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
			}
			function closeWin(){
				var win=L5.getCmp("workerWin");
				win.hide();
			}
			function toE(){
				var dataset = L5.DatasetMgr.lookup("workerDs");
				L5.dataset2excel(dataset, "/jsp/cams/welfare/welfarecorp/apply/welfarecorpQualification/wealworkerToExcel.jsp");
			}
			var method='<%=method%>';
			var taskCode='<%=taskCode%>';
		</script>
		<script type="text/javascript" src="unitHistoryEdit.js"></script>
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
	<!--主要产品信息 -->
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
				<td  class="FieldLabel" width="14%">福利企业证书编号</td>
				<td class="FieldInput" width="19%"><label title="编号" name="serialNum" field="serialNum" style="width: 95%"/></td>
	
				<td  class="FieldLabel" width="14%">企业名称</td>
				<td class="FieldInput" width="19%"><label title="企业名称" name="companyName" field="companyName" style="width: 95%"/></td>
				
				<td  class="FieldLabel" width="14%"></td>
				<td class="FieldInput" width="19%"></td>
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
				<td class="FieldInput" width="19%"><label type="text" name="法人姓名" field="legalPeople" style="width: 95%" /><font color="red">*</font></td>
				
				<td  class="FieldLabel" width="14%">身份证号码</td>
				<td class="FieldInput" width="19%"><label  type="text" name="法人身份证号码" field="legalIdCard" style="width: 95%"/><font color="red">*</font></td>
				
				<td  class="FieldLabel" width="14%">固定电话</td>
				<td class="FieldInput" width="19%"><label  type="text" name="法人固定电话" field="legalPhone" style="width: 95%" /><font color="red">*</font></td>
				
			</tr>
			<tr>
				<td  class="FieldLabel" width="14%">手机号码</td>
				<td class="FieldInput" width="19%"><label  type="text" name="法人手机号码" field="legalTelphone" style="width: 95%" /><font color="red">*</font></td>
				
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
		<next:EditGridPanel id="editGridWorker" name="editGridWorker" width="100%" height="99.9%" dataset="workerDs" clickToSelectedForChkSM="true">
			<next:TopBar>
					<next:ToolBarItem symbol="->" ></next:ToolBarItem>
					<next:ToolBarItem  iconCls="detail" text="查看"  handler="detailCK" />
					<next:ToolBarItem  iconCls="add" text="导出" handler="toE"  />
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
			
				<next:Column id="entryType" header="入厂形式" dataset="entry_type" editable="false" field="entryType" width="5%" >			
					<next:TextField  />
				</next:Column>
			
				<next:Column id="jobLevel" header="职业资格等级" dataset="job_level" editable="false" field="jobLevel" width="8%" >			
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
			
			</next:Columns>
			<next:BottomBar>
				<next:PagingToolBar dataset="workerDs"/>
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
				<next:Column id="productCode" header="产品代码" field="productCode" width="20%" >			
				</next:Column>
				<next:Column id="productValue" header="年销售收入（万元）" field="productValue" width="20%" >			
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
	closeAction="hide" resizable="false" width="1000" height="350">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="关闭" handler="closeWin" ></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form id="form2" method="post" dataset="workerDs"
			onsubmit="return false" class="L5form">
		<fieldset>
		<table width="100%">
			<tr>
				<td class="FieldLabel" style="width: 15%">姓名：</td>
				<td class=FieldInput style="width: 18%"><label 
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
				<td class="FieldInput" style="width: 18%"><label  id="entryType1" field="entryType" dataset="entry_type" title="入厂形式" style="width: 80%"/></td>
				<td class="FieldLabel" style="width: 15%">职业资格等级：</td>
				<td class="FieldInput" style="width: 18%"><label  id="jobLevel1" dataset="job_level" field="jobLevel" title="职业资格登记" style="width: 80%"></td>
			</tr>
			<tr>	
				<td class="FieldLabel" style="width: 15%">实发工资：</td>
				<td class="FieldInput" style="width: 18%"><label  id="realWages" field="realWages" title="实发工资" style="width: 80%"/></td>

				<td class="FieldLabel" style="width: 15%">社会保险(五险一金)：</td>
				<td class="FieldInput" style="width: 18%"><label type="socialInsurance" field="socialInsurance" title="社会保险" style="width: 80%"/></td>
			
				<td class="FieldLabel" style="width: 15%">商业保险：</td>
				<td class="FieldInput" style="width: 18%"><label  field="busInsurance" id="busInsurance" title="商业保险" style="width: 80%" /></td>
			</tr>
			<tr>	
				<td class="FieldLabel" style="width: 15%">残疾补贴</td>
				<td class="FieldInput" style="width: 18%"><label  field="disSubsidy" id="disSubsidy" title="残疾补贴" style="width: 80%" /></td>
				<td class="FieldLabel" style="width: 15%">是否生产人员</td>
				<td class="FieldInput" style="width: 18%">
					<label id="ifProductor1" field="ifProductor" dataset="comm_yesorno" style="width: 80%">
					</label>
				</td>
			
				<td class="FieldLabel" style="width: 15%">发放方式</td>
				<td class="FieldInput" style="width: 18%">
					<label field="allocationType" id="allocationType1" dataset="allocation_Type" title="发放方式" style="width: 80%">
					</label>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%">养老保险</td>
				<td class="FieldInput" style="width: 18%"><label  field="endowmentInsurance" id="endowmentInsurance" title="养老保险" style="width: 80%"/></td>
				<td class="FieldLabel" style="width: 15%">医疗保险</td>
				<td class="FieldInput" style="width: 18%">
					<label  field="medicalInsurance" id="medicalInsurance" title="医疗保险" style="width: 80%"/>
				</td>
			
				<td class="FieldLabel" style="width: 15%">失业保险</td>
				<td class="FieldInput" style="width: 18%"><label  field="unemployedInsurance" id="unemployedInsurance" title="失业保险" style="width: 80%" /></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%">工伤保险</td>
				<td class="FieldInput" style="width: 18%"><label  field="injuryInsurance" id="injuryInsurance" title="工伤保险" style="width: 80%" /></td>
				<td class="FieldLabel" style="width: 15%">生育保险</td>
				<td class="FieldInput" style="width: 18%">
					<label  field="maternityInsurance" id="maternityInsurance" title="生育保险" style="width: 80%"/>
				</td>
				<td class="FieldLabel" style="width: 15%">住房公积金</td>
				<td class="FieldInput" style="width: 18%"><label  field="housingFund" id="housingFund" title="住房公积金" style="width: 80%"/></td>
			</tr>
		</table>
		</fieldset>
		</form>
	</next:Html>
</next:Window>
</body>
</html>