<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
	<head>
		<title>外网用户维护列表</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="comextuser_list.js"></script>
		<script language="javascript">
		 	 //查询条件打开合并函数
		 	 var organArea='<%=BspUtil.getCorpOrgan().getOrganCode()%>';
     		 var organName='<%=BspUtil.getCorpOrgan().getOrganName()%>';
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
	<model:dataset id="ds" cmd="com.inspur.cams.comm.extuser.cmd.ComExtUserQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.comm.extuser.data.ComExtUser"></model:record>
		<model:params>
			<model:param name="ORGAN_TYPE@in" value="FL,JZ"></model:param>
			<model:param name="IN_USE" value="1"></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
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
								<td class="FieldLabel">用户名:</td>
								<td class="FieldInput"><input type="text"  id="userId" class="TextEditor" title="USER_ID"  /></td>	
								<td class="FieldLabel">企业名称:</td>
								<td class="FieldInput"><input type="text"  id="userName" class="TextEditor" title="USER_NAME"  /></td>	
								<td class="FieldLabel">企业类型:</td>
								<td class="FieldInput">
									<select id="organType" field="organType" blank="false">
										<option value ="">请选择</option>
										<option value ="FL">福利企业</option>
										<option value ="JZ">假矫企业</option>
									</select>
								</td>	
								<td class="FieldButton"><button onclick="query()">查 询</button>&nbsp;&nbsp;&nbsp;&nbsp;
								 <button onclick="reset()">重 置</button> </td>
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="comextuserGrid" width="100%" stripeRows="true" height="100%" dataset="ds" title="外网用户维护列表" notSelectFirstRow="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="增加" iconCls="add" handler="insert" />
		<next:ToolBarItem text="修改" iconCls="edit" handler="update"/>
		<next:ToolBarItem text="删除" iconCls="remove" handler="del"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
	     
		<next:Column id="userId" header="用户名" field="userId" width="250" >
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="userName" header="企业名称" field="userName" width="250" >
			<next:TextField  />
		</next:Column>
		
		<next:Column id="organType" header="企业类型" field="organType" width="90" >
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="adds" header="住址" field="adds" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="phone" header="联系电话" field="phone" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="email" header="电子邮件" field="email" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="createPeople" header="创建人" field="createPeople" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="createTime" header="创建时间" field="createTime" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="accountStatus" header="是否启用" field="accountStatus" width="90" >
			<next:TextField  /><next:ComboBox dataset="comm_yesorno"/>
		</next:Column>
	
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
