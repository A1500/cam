
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<html>
	<head>
		<title>职工花名册</title>
		<%
			String taskCode = (String)request.getParameter("taskCode");
		%>
		<next:ScriptManager/>
		<script type="text/javascript" src="wealworker.js"></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
		<script type="text/javascript" src="../../comm/scan.js"></script>
		<script language="javascript">
		 	 //查询条件打开合并函数
			 function collapse(element){
				var fieldsetParent=L5.get(element).findParent("fieldset");
				if(element.expand==null||element.expand==true){
					fieldsetParent.getElementsByTagName("div")[0].style.display="none";
					element.src = '<%=SkinUtils.getImage(request, "groupbox_expand.gif")%>';
					element.expand=false;
				}else{
					fieldsetParent.getElementsByTagName("div")[0].style.display="";
					element.src = "<%=SkinUtils.getImage(request, "groupbox_collapse.gif")%>";
					element.expand =true;
				}
			}
			var taskCode='<%=taskCode%>';
			function detail(){
				var grid=L5.getCmp("editGridPanel");
				var record=grid.getSelectionModel().getSelections();
				if(record.length!=1){
					L5.Msg.alert("提示","请先选中一行!");
					return;
				}
				var win=L5.getCmp("workerWin");
				win.show(this);
				var workerId=record[0].get("workerId");
				var workerDs = L5.DatasetMgr.lookup("workerDs");
				workerDs.setParameter("WORKER_ID@=",workerId);
				workerDs.load(true);
				if(workerDs.getAt(0).get("disabilityType").length==0){
					$("disabilityType1").innerHTML="";
				}
				if(workerDs.getAt(0).get("disabilityLevel").length==0){
					$("disabilityLevel1").innerHTML="";
				}
				if(workerDs.getAt(0).get("education").length==0){
					$("education1").innerHTML="";
				}
				if(workerDs.getAt(0).get("entryType").length==0){
					$("entryType1").innerHTML="";
				}
				if(workerDs.getAt(0).get("jobLevel").length==0){
					$("jobLevel1").innerHTML="";
				}
				if(workerDs.getAt(0).get("ifProductor").length==0){
					$("ifProductor1").innerHTML="";
				}
				if(workerDs.getAt(0).get("allocationType").length==0){
					$("allocationType1").innerHTML="";
				}
				if(workerDs.getAt(0).get("certSituation").length==0){
					$("certSituation1").innerHTML="";
				}
				if(workerDs.getAt(0).get("certSpecialSituation").length==0){
					$("certSpecialSituation1").innerHTML="";
				}
			}

			//关闭人员信息窗口
			function closeWorker(){
				
				L5.getCmp("workerWin").setVisible(false);
			}
		</script>
	</head>
<body>
<model:datasets>
	<!-- 职工信息表 -->
	<model:dataset id="workerDataSet" cmd="com.inspur.cams.welfare.base.cmd.WealWorkerQueryCommand" global="true" pageSize="20">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealWorker">
			<model:field name="name" type="string" rule="require" />
			<model:field name="sex" type="string" rule="require" />
			<model:field name="idCard" type="string" rule="require" />
		</model:record>
	</model:dataset>
	<model:dataset id="workerDs" cmd="com.inspur.cams.welfare.base.cmd.WealWorkerQueryCommand" global="true" pageSize="20">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealWorker">
			<model:field name="name" type="string" rule="require" />
			<model:field name="sex" type="string" rule="require" />
			<model:field name="idCard" type="string" rule="require" />
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
</model:datasets>

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
						<td class="FieldInput"><input type="text"  id="idCard" class="TextEditor" title="ID_CARD"  /></td>			
						<td class="FieldLabel">姓名:</td>
						<td class="FieldInput"><input type="text"  id="name" class="TextEditor" title="NAME"  /></td>			
						<td class="FieldLabel">资格证书编号:</td>
						<td class="FieldInput"><input type="text"  id="certCode" class="TextEditor" title="CERT_CODE"  /></td>			
						<td class="FieldLabel">特有工种职业资格证书编号:</td>
						<td class="FieldInput"><input type="text"  id="certSpecialCode" class="TextEditor" title="CERT_SPECIAL_CODE"  /></td>	
						<td class="FieldLabel"><button onclick="query()">查 询</button>&nbsp;&nbsp;&nbsp; <button type="reset">重 置</button> </td>
					</tr>								
				</table>
				</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>	

<next:EditGridPanel id="editGridPanel" name="wealworkerGrid" width="100%" stripeRows="true" height="100%" dataset="workerDataSet" title="职工信息列表">
	<next:TopBar>
			<next:ToolBarItem symbol="->" ></next:ToolBarItem>
	        <next:ToolBarItem symbol="-" ></next:ToolBarItem>
			<next:ToolBarItem  iconCls="detail" text="查看" handler="detail"  />
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
		<next:PagingToolBar dataset="workerDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>
<next:Window id="workerWin" title="员工信息" expandOnShow="false"
	closeAction="hide" resizable="false" width="1000" height="420">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="关闭" handler="closeWorker" ></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form id="form2" method="post" dataset="workerDs"
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
</body>
</html>
