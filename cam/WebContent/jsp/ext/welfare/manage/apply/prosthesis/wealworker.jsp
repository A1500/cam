
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
						<td class="FieldLabel"><button onclick="query()">查 询</button> </td>
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
			<next:ToolBarItem  iconCls="add" text="增加" handler="addW"  />
			<next:ToolBarItem  iconCls="edit" text="修改" handler="editW"  />
			<next:ToolBarItem  iconCls="save" text="保存" handler="save"  />
			<next:ToolBarItem  iconCls="remove" text="删除" handler="del"  />
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
		<next:Column id="phone" header="联系电话" field="phone" editable="false" width="10%" >			
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
	
		<next:Column id="certSituation" header="假肢制作师证书执有情况" field="certSituation" width="14%" >			
			<next:ComboBox triggerAction="all" editable="false" valueField="value" displayField="text"  dataset="comm_haveorno"/>
		</next:Column>
	
		<next:Column id="certCode" header="证书编号" editable="false" field="certCode" width="8%" >			
			<next:TextField  />
		</next:Column>
	
		<next:Column id="certDate" header="发证时间" field="certDate" width="7%" >			
			<next:DateField allowBlank="false" editable="false" format="Y-m-d" ></next:DateField>
		</next:Column>
		
		<next:Column id="certTime" header="最近一次年检时间" field="certTime" width="10%" >			
			<next:DateField allowBlank="false" editable="false" format="Y-m-d" ></next:DateField>
		</next:Column>
		
		<next:Column id="certOrthosisSituation" header="矫形器制作师证书执有情况" field="certOrthosisSituation" width="14%" >			
			<next:ComboBox triggerAction="all" editable="false" valueField="value" displayField="text"  dataset="comm_haveorno"/>
		</next:Column>
	
		<next:Column id="certOrthosisCode" header="证书编号" editable="false" field="certOrthosisCode" width="8%" >			
			<next:TextField  />
		</next:Column>
	
		<next:Column id="certOrthosisDate" header="发证时间" field="certOrthosisDate" width="7%" >			
			<next:DateField allowBlank="false" editable="false" format="Y-m-d" ></next:DateField>
		</next:Column>
		
		<next:Column id="certOrthosisTime" header="最近一次年检时间" field="certOrthosisTime" width="10%" >			
			<next:DateField allowBlank="false" editable="false" format="Y-m-d" ></next:DateField>
		</next:Column>
	
		<next:Column id="certSpecialSituation" header="有无特有工种职业资格证书" field="certSpecialSituation" width="14%" >			
			<next:ComboBox triggerAction="all" editable="false" valueField="value" displayField="text"  dataset="comm_haveorno"/>
		</next:Column>
	
		<next:Column id="certSpecialCode" header="证书编号" editable="false" field="certSpecialCode" width="8%" >			
			<next:TextField  />
		</next:Column>
	
		<next:Column id="certSpecialDate" header="发证时间" field="certSpecialDate" width="7%" >			
			<next:DateField allowBlank="false" editable="false" format="Y-m-d" ></next:DateField>
		</next:Column>
		
		<next:Column id="certSpecialTime" header="最近一次年检时间" field="certSpecialTime" width="10%" >			
			<next:DateField allowBlank="false" editable="false" format="Y-m-d" ></next:DateField>
		</next:Column>
			
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="workerDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>
<next:Window id="workerWin" title="增加员工信息" expandOnShow="false"
	closeAction="hide" resizable="false" width="1000" height="550"
	closable="false">
	<next:Html>
		<form id="form2" method="post" dataset="workerDataSet"
			onsubmit="return false" class="L5form">
		<fieldset>
		<table width="100%">
			<tr>
				<td class="FieldLabel" style="width: 15%">姓名</td>
				<td class="FieldInput" style="width: 18%"><input type="text"
					name="姓名" id="name1" field="name" maxlength="50"
					style="width: 80%" /><font color="red">*</font><a  href="javascript:scan()" >扫描</a></td>

				<td class="FieldLabel" style="width: 15%">身份证号</td>
				<td class="FieldInput" style="width: 18%"><input type="text"
					name="身份证号" id="idCard1" field="idCard" maxlength="50"
					style="width: 80%" onblur="checkIdCradNo()"/><font color="red">*</font></td>

				<td class="FieldLabel" style="width: 15%">性别</td>
				<td class="FieldInput" style="width: 18%"><select id="sex1"
					name="性别" title="性别" field="sex" style="width: 80%">
					<option dataset="sex"></option>
					</select><font color="red">*</font></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%">联系电话</td>
				<td class="FieldInput" style="width: 18%" ><input id="phone" field="phone" type="text" title="联系电话" style="width: 80%"/>
				<td class="FieldLabel" style="width: 15%">家庭住址</td>
				<td class="FieldInput" style="width: 18%" colspan="3"><input id="address" field="address" type="text" title="家庭住址" style="width: 80%"/>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%">残疾类别</td>
				<td class="FieldInput" style="width: 18%"><select id="disabilityType" field="disabilityType" style="width: 80%">
			     	<option dataset="disabilityTypeDataset" ></option>
			     </select></td>

				<td class="FieldLabel" style="width: 15%">残疾等级</td>
				<td class="FieldInput" style="width: 18%"><select id="disabilityLevel" field="disabilityLevel" style="width: 80%" >
			     	<option dataset="DmCjdjDataSet" ></option>
			     </select></td>

				<td class="FieldLabel" style="width: 15%">文化程度</td>
				<td class="FieldInput" style="width: 18%"><select id="education" field="education" title="文化程度" style="width: 80%">
					<option dataset="eduDataSet"></option>
				</select></td>
			</tr>
			
			<tr>	
				<td class="FieldLabel" style="width: 15%">入厂时间</td>
				<td class="FieldInput" style="width: 18%"><input type="text" id="entryDate" title="入厂时间" field="entryDate" readonly="readonly" format="Y-m-d" onclick="WdatePicker()" style="width: 80%" /></td>
				<td class="FieldLabel" style="width: 15%">入厂形式</td>
				<td class="FieldInput" style="width: 18%"><select  id="entryType" field="entryType" title="入厂形式" style="width: 80%">
					<option dataset="entry_type"></option>
				</select></td>
				<td class="FieldLabel" style="width: 15%">职业资格等级</td>
				<td class="FieldInput" style="width: 18%"><select  id="jobLevel" field="jobLevel" title="职业资格登记" style="width: 80%">
					<option dataset="job_level"></option>
				</select></td>
			</tr>
			<tr>	
				<td class="FieldLabel" style="width: 15%">是否生产人员</td>
				<td class="FieldInput" style="width: 18%">
					<select id="ifProductor1" field="ifProductor" style="width: 80%">
						<option dataset="comm_yesorno"></option>
					</select>
				</td>
				<td class="FieldLabel" style="width: 15%">实发工资(元)</td>
				<td class="FieldInput" style="width: 18%"><input type="text" id="realWages1" field="realWages" title="实发工资" style="width: 80%"/><font color="red">*</font></td>
				<td class="FieldLabel" style="width: 15%">残疾补贴(元)</td>
				<td class="FieldInput" style="width: 18%"><input type="text" field="disSubsidy" id="disSubsidy" title="残疾补贴" style="width: 80%" /></td>
			</tr>
			<tr>	
				<td class="FieldLabel" style="width: 15%">发放方式</td>
				<td class="FieldInput" style="width: 18%">
					<select field="allocationType" id="allocationType" title="发放方式" style="width: 80%">
						<option dataset="allocation_Type" ></option>
					</select>
				</td>
				<td class="FieldLabel" style="width: 15%">社会保险(五险一金)(元)</td>
				<td class="FieldInput" style="width: 18%"><input type="text" id="socialInsurance1" field="socialInsurance" title="社会保险" style="width: 80%"/><font color="red">*</font></td>
				
				<td class="FieldLabel" style="width: 15%">商业保险(元)</td>
				<td class="FieldInput" style="width: 18%"><input type="text" field="busInsurance" id="busInsurance1" title="商业保险" style="width: 80%" /><font color="red">*</font></td>
				
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%">养老保险(元)</td>
				<td class="FieldInput" style="width: 18%"><input type="text" field="endowmentInsurance" id="endowmentInsurance1" title="养老保险" style="width: 80%"/><font color="red">*</font></td>
				<td class="FieldLabel" style="width: 15%">医疗保险(元)</td>
				<td class="FieldInput" style="width: 18%">
					<input type="text" field="medicalInsurance" id="medicalInsurance1" title="医疗保险" style="width: 80%"/><font color="red">*</font>
				</td>
				
				<td class="FieldLabel" style="width: 15%">失业保险(元)</td>
				<td class="FieldInput" style="width: 18%"><input type="text" field="unemployedInsurance" id="unemployedInsurance1" title="失业保险" style="width: 80%" /><font color="red">*</font></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%">工伤保险(元)</td>
				<td class="FieldInput" style="width: 18%"><input type="text" field="injuryInsurance" id="injuryInsurance1" title="工伤保险" style="width: 80%" /><font color="red">*</font></td>
				<td class="FieldLabel" style="width: 15%">生育保险(元)</td>
				<td class="FieldInput" style="width: 18%">
					<input type="text" field="maternityInsurance" id="maternityInsurance1" title="生育保险" style="width: 80%"/><font color="red">*</font>
				</td>
				<td class="FieldLabel" style="width: 15%">住房公积金(元)</td>
				<td class="FieldInput" style="width: 18%"><input type="text" field="housingFund" id="housingFund1" title="住房公积金" style="width: 80%"/><font color="red">*</font></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%">假肢制作师证书<br>持有情况</td>
				<td class="FieldInput" style="width: 18%" >
					<select id="certSituation1" field="certSituation"  onchange="checkYN(this.value)" style="width: 80%">
						<option dataset="comm_haveorno"></option>
					</select>
				</td>
				<td class="FieldLabel" style="width: 15%"></td>
				<td class="FieldInput" style="width: 15%"></td>
				<td class="FieldLabel" style="width: 15%"></td>
				<td class="FieldInput" style="width: 15%"></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%">证书编号</td>
				<td class="FieldInput" style="width: 18%">
					<input type="text" id="certCode1" field="certCode" title="职业资格证书编号" disabled style="width: 80%"/>
				</td>
				<td class="FieldLabel" style="width: 15%">发证时间</td>
				<td class="FieldInput" style="width: 18%"><input type="text" id="certDate1" disabled field="certDate" readonly="readonly" format="Y-m-d" onclick="WdatePicker()" style="width: 80%"/></td>
				<td class="FieldLabel" style="width: 15%">最近一次年检时间</td>
				<td class="FieldInput" style="width: 18%"><input type="text" id="certTime1" disabled field="certTime" readonly="readonly" format="Y-m-d" onclick="WdatePicker()" style="width: 80%"/></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%">矫形器制作师证书<br>持有情况</td>
				<td class="FieldInput" style="width: 18%" >
					<select id="certOrthosisSituation1" field="certOrthosisSituation"  onchange="checkOrthosisYN(this.value)" style="width: 80%">
						<option dataset="comm_haveorno"></option>
					</select>
				</td>
				<td class="FieldLabel" style="width: 15%"></td>
				<td class="FieldInput" style="width: 15%"></td>
				<td class="FieldLabel" style="width: 15%"></td>
				<td class="FieldInput" style="width: 15%"></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%">证书编号</td>
				<td class="FieldInput" style="width: 18%">
					<input type="text" id="certOrthosisCode1" field="certOrthosisCode" title="职业资格证书编号" disabled style="width: 80%"/>
				</td>
				<td class="FieldLabel" style="width: 15%">发证时间</td>
				<td class="FieldInput" style="width: 18%"><input type="text" id="certOrthosisDate1" disabled field="certOrthosisDate" readonly="readonly" format="Y-m-d" onclick="WdatePicker()" style="width: 80%"/></td>
				<td class="FieldLabel" style="width: 15%">最近一次年检时间</td>
				<td class="FieldInput" style="width: 18%"><input type="text" id="certOrthosisTime1" disabled field="certOrthosisTime" readonly="readonly" format="Y-m-d" onclick="WdatePicker()" style="width: 80%"/></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%">特有工种职业资格证书<br>持有情况</td>
				<td class="FieldInput" style="width: 18%" >
					<select id="certSpecialSituation1" field="certSpecialSituation"   onchange="checkSpecialYN(this.value)" style="width: 80%">
						<option dataset="comm_haveorno"></option>
					</select>
				</td>
				<td class="FieldLabel" style="width: 15%"></td>
				<td class="FieldInput" style="width: 15%"></td>
				<td class="FieldLabel" style="width: 15%"></td>
				<td class="FieldInput" style="width: 15%"></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%">证书编号</td>
				<td class="FieldInput" style="width: 18%"><input type="text" id="certSpecialCode1" disabled field="certSpecialCode" title="特有工种职业资格证书编号" style="width: 80%"/></td>
				<td class="FieldLabel" style="width: 15%">发证时间</td>
				<td class="FieldInput" style="width: 18%"><input type="text" id="certSpecialDate1" disabled field="certSpecialDate" format="Y-m-d" onclick="WdatePicker()" style="width: 80%"/></td>
				<td class="FieldLabel" style="width: 15%">最近一次年检时间</td>
				<td class="FieldInput" style="width: 18%"><input type="text" id="certSpecialTime1" disabled field="certSpecialTime" format="Y-m-d" onclick="WdatePicker()" style="width: 80%"/></td>
			</tr>
		</table>
		</fieldset>
		</form>
	</next:Html>
	<next:Buttons>
		<next:ToolButton text="继续添加" handler="addWorkerSubmit"></next:ToolButton>
		<next:ToolButton text="确定" handler="confirmWorker"></next:ToolButton>
		<next:ToolButton text="取消" handler="closeWorker"></next:ToolButton>
	</next:Buttons>
</next:Window>

