
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%
	String organCode = BspUtil.getOrganCode();
%>
<html> 
	<head>
		<title>颁证员资格考试信息表列表</title>
		<next:ScriptManager/>
		<script type="text/javascript">
			var organCode='<%=BspUtil.getOrganCode()%>';
			var organType = '<%=BspUtil.getOrganType()%>';
		</script>
		<script type="text/javascript" src="mrmqualificationexambzy_list.js"></script>
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
		</script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.marry.base.cmd.MrmQualificationExamQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmQualificationExam"></model:record>
	</model:dataset>
	<model:dataset id="dsExcel" cmd="com.inspur.cams.marry.base.cmd.MrmQualificationExamQueryCommand" method="queryPersonExamExcel" global="true">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmQualificationExam"></model:record>
	</model:dataset>
		<!-- 登记员资格考试安排表 -->
	<model:dataset id="apds"
		cmd="com.inspur.cams.marry.base.cmd.MrmExamScheduleQueryCommand"
		global="true">
		<model:record  
			fromBean="com.inspur.cams.marry.base.data.MrmExamSchedule"></model:record>
	</model:dataset>
	<!-- 是否补证 -->
	<model:dataset id="yesornoDataset" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 考试结果 -->
	<model:dataset id="ksjgDataset" enumName="MRM.KSJG.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 补考结果 -->
	<model:dataset id="bkjgDataset" enumName="MRM.BKJG.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 初考复考标志 -->
	<model:dataset id="ckfkbzDataset" enumName="MRM.CKFKBZ.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 年度 -->
	<model:dataset id="ndYearDataset" autoLoad="true" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='MRM_QUALIFICATION_EXAM'></model:param>
			<model:param name="value" value='ND_YEAR'></model:param>
			<model:param name="text" value='ND_YEAR'></model:param>
		</model:params>
	</model:dataset>
	<!-- 资格证状态 -->
	<model:dataset id="zgzztDataset" enumName="MRM.ZGZZT.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 考试时间 -->
	<model:dataset id="ksTimeDataset" 
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='MRM_EXAM_SCHEDULE'></model:param>
			<model:param name="value" value='KSQS'></model:param>
			<model:param name="text" value='KSBEGIN_TIME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 考试QISHU -->
	<model:dataset id="ksqsDataset" 
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='MRM_EXAM_SCHEDULE'></model:param>
			<model:param name="value" value='KSQS'></model:param>
			<model:param name="text" value='KSQS'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>

<next:Panel  name="form" width="100%" autoScroll="true" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" >
	<next:Html>
	<fieldset style="overflow: visible;" class="GroupBox"><legend
					class="GroupBoxTitle">查询条件 <img
					class="GroupBoxExpandButton"
					src="<%=SkinUtils.getImage(request,
									"groupbox_collapse.gif")%>"
					onclick="collapse(this)" /> </legend>
				<div>
					<form style="width: 100%; height: 100%;" class="L5form">
						<table  border="1" width="100%" >
							<tr >
								<td class="FieldLabel" nowrap>姓名:</td>
								<td class="FieldInput"><input type="text"  id="name" class="TextEditor" title="姓名"  /></td>	
								<td class="FieldLabel" nowrap>年度:</td>
								<td class="FieldInput">
								<select  id="ndYear" name="ndYear" title="年度" >
									<option dataset="ndYearDataset" />
								</select>
								</td>	
								<td class="FieldLabel" nowrap>考试期次:</td>
								<td class="FieldInput"><input type="text" id="ksqs" class="TextEditor" title="考试期数"  /></td>	
								<td class="FieldLabel" nowrap>登记处名称:</td>
								<td class="FieldInput"><input type="text"  id="deptName" onclick="forHelp()" readonly="readonly" style="width:90%"  title="所属部门"  />
								<input type="hidden" id="deptId" name="deptId" /></td>	
								<td align="center" nowrap ><button onclick="query()">查 询</button></td>
							</tr>
							<tr>
								<td class="FieldLabel" nowrap>考试结果:</td>
								<td class="FieldInput">
								<select id="ksjg" name="ksjg" title="考试结果" >
									<option dataset="ksjgDataset" />
								</select>
								</td>	
								<td class="FieldLabel" nowrap>补考结果:</td>
								<td class="FieldInput">
								<select  id="bkjg" name="bkjg" title="补考结果" >
									<option dataset="bkjgDataset" />
								</select>
								</td>	
								<td class="FieldLabel" nowrap>资格证编号:</td>
								<td class="FieldInput"><input type="text"  id="bzyzgzh" class="TextEditor" title="资格证编号"  /></td>	
								<td class="FieldLabel" nowrap>是否补证:</td>
								<td class="FieldInput">
								<select id="fillCardTime" name="fillCardTime" title="是否补证"  />
									<option dataset="yesornoDataset" />
								</select>
								</td>	
								<td align="center"><button onclick="rest()">重 置</button></td>
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>

<next:EditGridPanel id="editGridPanel" name="mrmqualificationexamGrid" width="100%" height="98%" stripeRows="true" dataset="ds" title="颁证员资格考试信息表">
	<%
		if ("0000000000".equals(organCode.substring(2))
					&& "00000000".equals(organCode.substring(4))) {
	%>
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="批量设置考试合格" iconCls="plsz" handler="plszhg"/>
		<next:ToolBarItem text="调整考试" iconCls="edit" handler="detail"/>
		<next:ToolBarItem text="保存" iconCls="add" handler="insert" />
		<next:ToolBarItem text="删除" iconCls="remove" handler="del"/>
		<next:ToolBarItem text="打印" iconCls="edit" handler="commonQuery"/>
		<next:ToolBarItem text="导出" iconCls="chart" handler="emportExcel" />
	</next:TopBar> 
	<%
		}
	%>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
	
		<next:Column id="personId" header="人员ID" field="PERSON_ID" width="90"  hidden="true" />
			<next:Column id="name" header="姓名" field="NAME" width="70" align="center"/>
		<next:Column id="deptName" header="登记处" field="DEPT_NAME" width="200" align="center"/>
		
		<next:Column id="ndYear" header="年度" field="ND_YEAR" width="90" align="center"/>
   <next:Column id="ckfkbz" header="初考复考标志" field="CKFKBZ" width="90" align="center">
			<next:ComboBox triggerAction="all" valueField="value" displayField="text" dataset="ckfkbzDataset" />
		</next:Column>
		
		<next:Column id="ksqs" header="考试期次" field="KSQS" width="90"
			align="center">
		</next:Column>
		
		<next:Column id="kssj" header="考试时间" field="KSSJ_TIME" width="150"
			 align="center">
		</next:Column>
		
		<next:Column id="ksjg" header="考试结果" field="KSJG" width="90" align="center">
			<next:ComboBox triggerAction="all" valueField="value"  displayField="text" dataset="ksjgDataset"  />
		</next:Column>
	
		<next:Column id="bkjg" header="补考结果" field="BKJG" width="90" align="center">
			<next:ComboBox triggerAction="all" valueField="value" displayField="text" dataset="bkjgDataset" />
		</next:Column>
	
		<next:Column id="BZYZGZH" header="资格证编号" field="BZYZGZH" width="100" align="center">
			<next:TextField  />
		</next:Column>
	
		<next:Column id="fillCardTime" header="是否补证" field="FILL_CARD_TIME" width="70" >
			<next:ComboBox triggerAction="all" valueField="value" displayField="text" dataset="yesornoDataset" />
		</next:Column>
	
		<next:Column id="giveOutTime" header="发证时间" field="GIVE_OUT_TIME" width="90" align="center">
			<next:DateField  />
		</next:Column>
	
		<next:Column id="zgzzt" header="资格证状态" field="ZGZZT" width="90" >
			<next:ComboBox triggerAction="all" valueField="value" displayField="text" dataset="zgzztDataset" />
		</next:Column>
		
		<next:Column id="cxyy" header="撤销原因" field="CXYY" width="130" >
			<next:TextField />
		</next:Column>
	
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:EditGridPanel>
<next:EditGridPanel id="gridPanel" hidden="true" name="mrmqualificationexamGrid" width="100%" height="98%" stripeRows="true" dataset="ds" title="颁证员资格考试信息表">
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
	
		<next:Column id="personId" header="人员ID" field="PERSON_ID" width="90"  hidden="true" />
			<next:Column id="name" header="姓名" field="NAME" width="70" align="center"/>
		<next:Column id="deptName" header="登记处" field="DEPT_NAME" width="200" align="center"/>
		
		<next:Column id="ndYear" header="年度" field="ND_YEAR" width="90" align="center"/>
		
   		<next:Column id="ckfkbz" header="初考复考标志" field="CKFKBZ" width="90" align="center" editable="false">
			<next:ComboBox triggerAction="all" valueField="value" displayField="text" dataset="ckfkbzDataset" />
		</next:Column>
		
		<next:Column id="ksqs" header="考试期次" field="KSQS" width="90"
			align="center">
		</next:Column>
		
		<next:Column id="kssj" header="考试时间" field="KSSJ_TIME" width="150"
			 align="center">
		</next:Column>
		
		<next:Column id="ksjg" header="考试结果" field="KSJG" width="90" align="center" editable="false">
			<next:ComboBox triggerAction="all" valueField="value"  displayField="text" dataset="ksjgDataset"  />
		</next:Column>
	
		<next:Column id="bkjg" header="补考结果" field="BKJG" width="90" align="center" editable="false">
			<next:ComboBox triggerAction="all" valueField="value" displayField="text" dataset="bkjgDataset" />
		</next:Column>
	
		<next:Column id="certificateId" header="资格证编号" field="BZYZGZH" width="100" align="center" editable="false">
			<next:TextField  />
		</next:Column>
	
		<next:Column id="fillCardTime" header="是否补证" field="FILL_CARD_TIME" width="70" editable="false" >
			<next:ComboBox triggerAction="all" valueField="value" displayField="text" dataset="yesornoDataset" />
		</next:Column>
	
		<next:Column id="giveOutTime" header="发证时间" field="GIVE_OUT_TIME" width="90" align="center" editable="false">
			<next:DateField  />
		</next:Column>
	
		<next:Column id="zgzzt" header="资格证状态" field="ZGZZT" width="90" editable="false" >
			<next:ComboBox triggerAction="all" valueField="value" displayField="text" dataset="zgzztDataset" />
		</next:Column>
		
		<next:Column id="cxyy" header="撤销原因" field="CXYY" width="130" editable="false">
			<next:TextField />
		</next:Column>
	
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:EditGridPanel>
<next:Window id="detailWin" resizable="false" width="600" height="150" modal="true" closeAction="hide" autoScroll="true">
<next:Panel title="登记员资格考试信息表">
			<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="save" text="保存" handler="confirm"/>
				<next:ToolBarItem iconCls="delete" text="关闭" handler="closeWin"/>
			</next:TopBar>
			<next:Html>
				<form id="editForm2" dataset="ds" onsubmit="return false"
					style="padding: 5px;" class="L5form">
				<table border="1" width="95%">

					<tr>
						<td class="FieldLabel" style="width:25%">姓名</td>
						<td class="FieldInput" style="width:25%"><label field="NAME" /></td>
						
						<td class="FieldLabel" style="width:25%">年度</td>
						<td class="FieldInput" style="width:25%"><label field="ND_YEAR" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">考试期数</td>
						<td class="FieldInput">
						<select id="ksqs1" name="ksqs1" field="KSQS" onchange="tochange()">
							<option  dataset="ksqsDataset"/>
						</select>
						<input type="hidden" id="ksapId_hidden" />
						</td>
					
						<td class="FieldLabel">考试时间</td>
						<td class="FieldInput"><label id="kssjTime1" field="KSSJ_TIME" />
						<input type="hidden" id="kssjTime2" />
						</td>
					</tr>
				</table>
				</form>
			</next:Html>
		</next:Panel>
</next:Window>
</body>
<input type="hidden" id="docpath" value=""/>
<input type="hidden" id="ksxxId" name="printQuery" queryData="queryData" value=""/>
<input type="hidden" id="scaconfPath" value="MrmQualificationExam/MrmQualificationExamPrintDao"/>
</html>
