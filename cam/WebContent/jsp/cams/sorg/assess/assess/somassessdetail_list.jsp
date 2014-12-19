
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
	<head>
		<title>社会组织评估填写情况列表</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="somassessdetail_list.js"></script>
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
	<model:dataset id="ds" cmd="com.inspur.cams.sorg.assess.assess.cmd.SomAssessQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.assess.assess.data.SomAssess"></model:record>
		<model:params>
			<model:param name="TASK_ID" value='<%=request.getParameter("taskId")%>'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="sorgTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SORG_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="assessTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='som_assess_type'></model:param>
			<model:param name="value" value='TYPE'></model:param>
			<model:param name="text" value='TYPE_DESC'></model:param>
		</model:params>
	</model:dataset>
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
					<form style="width: 100%; height: 100%;" class="L5form">
						<table  border="1" width="100%" >
							<tr >
								<td class="FieldLabel">评估人姓名:</td>
								<td class="FieldInput"><input type="text"  id="assessPersonName" class="TextEditor" title="评估人姓名"  /></td>	
								<td class="FieldButton"><button onclick="query()">查 询</button> </td>
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="somassessGrid" width="100%" stripeRows="true" height="100%" dataset="ds" title="社会组织评估填写情况列表">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="修改" iconCls="edit" handler="update" />
		<next:ToolBarItem text="返回" iconCls="undo" handler="back"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
	     
		<next:Column id="taskCode" header="业务编号" field="taskCode" width="90" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="taskId" header="任务编号" field="taskId" width="90"  hidden="true">
			<next:TextField  />
		</next:Column>
	
		<next:Column id="assessType" header="评估类型" field="assessType" width="250" >
			<next:TextField  /><next:ComboBox dataset="assessTypeSelect"/>
		</next:Column>
	
		<next:Column id="sorgType" header="评估社会组织类型" field="sorgType" width="90" >
			<next:TextField  /><next:ComboBox dataset="sorgTypeSelect"/>
		</next:Column>
	
		<next:Column id="sorgCode" header="评估社会组织登记证号" field="sorgCode" width="150" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="sorgName" header="社会组织名称" field="sorgName" width="250" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="score" header="总分数" field="score" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="assessPersonName" header="评估人姓名" field="assessPersonName" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="loginName" header="登陆人姓名" field="loginName" width="90"  hidden="true">
			<next:TextField  />
		</next:Column>
	
		<next:Column id="loginOrganId" header="登陆人组织机构代码" field="loginOrganId" width="90"  hidden="true">
			<next:TextField  />
		</next:Column>
	
		<next:Column id="areaCode" header="登陆人所在行政区划" field="areaCode" width="90"  hidden="true">
			<next:TextField  />
		</next:Column>
	
		<next:Column id="assessDate" header="评估时间" field="assessDate" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="note" header="备注" field="note" width="90"  hidden="true">
			<next:TextField  />
		</next:Column>
	
	</next:Columns>
	<next:BottomBar>a
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
