
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
	<head>
		<title>登记员资格考试安排表列表</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="mrmexamschedule_list.js"></script>
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
	<model:dataset id="ds" cmd="com.inspur.cams.marry.base.cmd.MrmExamScheduleQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmExamSchedule"></model:record>
	</model:dataset>
	<!-- 年度 -->
	<model:dataset id="ndYearDataset" autoLoad="true" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='MRM_EXAM_SCHEDULE'></model:param>
			<model:param name="value" value='ND_YEAR'></model:param>
			<model:param name="text" value='ND_YEAR'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="ksYnDataSet" enumName="MRM.KSYN.TYPE" autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:Panel  name="form" width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" >
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
								<td class="FieldLabel" nowrap>年度:</td>
								<td class="FieldInput" nowrap>
								<select  id="ndYear" name="ndYear" title="年度" >
									<option dataset="ndYearDataset"  />
								</select>
								</td>	
								<td class="FieldLabel" nowrap>考试期次:</td>
								<td class="FieldInput" nowrap><input type="text"  id="ksqs" class="TextEditor" title="考试期数"  /></td>	
								<td class="FieldLabel" nowrap>考试地点:</td>
								<td class="FieldInput" nowrap><input type="text"  id="ksAdd" class="TextEditor" title="考试地点"  /></td>	
								<td align="center" nowrap><button onclick="query()">查 询</button>&nbsp;&nbsp;&nbsp;<button onclick="rest()">重置</button></td>
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="mrmexamscheduleGrid" width="100%" stripeRows="true" height="400" dataset="ds" title="登记员资格考试安排表">
	<next:TopBar>
	<next:ToolBarItem id="qrToolbar" text=""></next:ToolBarItem>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="开启" iconCls="add" handler="startExam" />
		<next:ToolBarItem text="关闭" iconCls="remove" handler="endExam" />
		<next:ToolBarItem text="增加" iconCls="add" handler="insert" />
		<next:ToolBarItem text="修改" iconCls="edit" handler="update"/>
		<next:ToolBarItem text="删除" iconCls="remove" handler="del"/>
		<next:ToolBarItem text="查看" iconCls="detail" handler="detail"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
	     
		<next:Column id="ndYear" header="年度" field="ndYear" width="90" align="center">
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="ksqs" header="考试期次" field="ksqs" width="90" align="center">
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="ksbeginTime" header="考试时间" field="ksbeginTime" width="120" align="center">
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="ksAdd" header="考试地点" field="ksAdd" width="200" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="ksPeonum" header="计划安排人数" field="ksPeonum" width="90" align="center">
			<next:NumberField  />
		</next:Column>
		
		<next:Column id="ksbmPeonum" header="报名人数" field="ksbmPeonum" width="90" align="center">
			<next:NumberField  />
		</next:Column>
		
		<next:Column id="ksYn" header="状态" field="ksYn" dataset="ksYnDataSet" width="90" align="center" />
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
