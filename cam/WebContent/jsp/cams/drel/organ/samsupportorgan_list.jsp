
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
	<head>
		<title>供养机构管理</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="samsupportorgan_list.js"></script>
		<script language="javascript">
			var organAreaCode = '<%=BspUtil.getOrganCode()%>' ;
			<%
			String organAreaName=BspUtil.getOrganName();
			organAreaName=organAreaName.substring(0, organAreaName.indexOf("民政"));
			%>
			var organAreaName = '<%=organAreaName%>' ;
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
	<model:dataset id="ds" cmd="com.inspur.cams.drel.organ.cmd.SamSupportOrganQueryCmd" global="true" sortField="organAreaCode">
		<model:record fromBean="com.inspur.cams.drel.organ.date.SamSupportOrgan"></model:record>
		<model:params>
			<model:param name="ORGAN_STATUS" value='1'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="winDs" cmd="com.inspur.cams.drel.organ.cmd.SamSupportOrganQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.organ.date.SamSupportOrgan">
			<model:field name="organName" type="string" rule="require|length{50}"/>	
			<model:field name="organType" type="string" rule="require"/>	
		</model:record>
		<model:params>
			<model:param name="ORGAN_STATUS" value='1'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="organTypeDataset" enumName="SAM.SUPPORT.ORGAN.TYPE" autoLoad="true" global="true" />
</model:datasets>

<next:Panel  name="form" width="100%" border="0" >
	<next:Html>
	<fieldset style="overflow: visible;" class="GroupBox"><legend
					class="GroupBoxTitle">查询条件 <img
					class="GroupBoxExpandButton"
					src="<%=SkinUtils.getImage(request,
									"groupbox_collapse.gif")%>"
					onclick="collapse(this)" /> </legend>
				<div>
					<form style="width: 98%; height: 100%;" class="L5form">
						<table  width="100%" >
							<tr >
								<td class="FieldLabel" style='width:20%'>供养机构名称</td>
								<td class="FieldInput" style='width:20%'><input type="text"  id="name" class="TextEditor" title="供养机构名称"  style='width:90%'/></td>	
								<td class="FieldLabel" nowrap="nowrap" width="20%">所属地区</td>
								<td class="FieldInput" width="20%"><input type="text"
									id="organAreaName" name="organAreaName" value="<%=organAreaName%>" readonly="readonly"
									style="width: 180px" /><img
									src="<%=SkinUtils.getImage(request, "l5/help.gif")%>"
									style="cursor: hand" onclick="func_ForDomicileSelect()" /> <input
									type="text" id="organAreaCode" name="domicileCode" value="<%=BspUtil.getOrganCode()%>"
									style="display: none" /></td>
								<td class="FieldButton" style='width:20%'><button onclick="query()">查 询</button> &nbsp;&nbsp;
								<button type="reset">重 置</button></td>
								
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" title='供养机构列表' name="samsupportorganGrid" width="100%" stripeRows="true"  dataset="ds" height='100%'>
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="增加" iconCls="add" handler="insert" />
		<next:ToolBarItem text="修改" iconCls="edit" handler="update"/>
		<next:ToolBarItem text="删除" iconCls="remove" handler="remove"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:RadioBoxColumn></next:RadioBoxColumn>	
		<next:Column header="所属地区" field="organAreaName" align="center" width="20%" ><next:TextField /></next:Column>
		<next:Column header="供养机构名称" field="organName" width="200" >
			<next:TextField  />
		</next:Column>
		<next:Column header="地址" field="address" width="200" >
			<next:TextField  />
		</next:Column>
	
		<next:Column header="联系人" field="contactPeople" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column header="联系人电话" field="contactPhone" width="150" >
			<next:TextField  />
		</next:Column>
	
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:GridPanel>

<next:Window id="supportOrganWin" title="供养机构维护" closeAction="hide"  width="800" modal="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="confirmWin"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="关闭" handler="closeWin"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form dataset="winDs"  onsubmit="return false"  class="L5form">
			<table width="100%" >		
		   		<tr>
					<td class="FieldLabel" style='width:15%'>供养机构名称</td>
					<td class="FieldInput" style='width:35%'>
						<input type="text" name="供养机构名称" field="organName"  style='width:90%'/><span style='color:red'>*</span>
					</td>
					<td class="FieldLabel" nowrap="nowrap" width="15%">所属地区</td>
						<td class="FieldInput" width="35%"><input type="text"
							field="organAreaName" name="organAreaName" readonly="readonly"
							style="width:90%" disabled/><input
							type="text" field="organAreaCode" name="domicileCode"
							style="display: none" /></td>
				</tr>
		   		<tr>
					<td  class="FieldLabel" >负责人</td>
					<td class="FieldInput"><input type="text" name="负责人" field="legelPeople"  style='width:90%'/> </td>
					<td  class="FieldLabel" >成立日期</td>
					<td class="FieldInput"><input type="text" name="成立日期" field="establishDate" onclick="LoushangDate(this)"  format="Y-m-d"  style='width:90%'/> </td>
				</tr>
		   		<tr>
					<td  class="FieldLabel" >地址</td>
					<td class="FieldInput"><input type="text" name="地址" field="address" style='width:90%' /> </td>
					<td  class="FieldLabel" >交通路线</td>
					<td class="FieldInput"><input type="text" name="交通路线" field="trafficRoute" style='width:90%' /> </td>
				</tr>
		   		<tr>
					<td  class="FieldLabel" >联系人</td>
					<td class="FieldInput"><input type="text" name="联系人" field="contactPeople" style='width:90%' /> </td>
					<td  class="FieldLabel" >联系电话</td>
					<td class="FieldInput"><input type="text" name="联系电话" field="contactPhone" style='width:90%' /> </td>
				</tr>
		   		<tr>
					<td  class="FieldLabel" >备注</td>
					<td class="FieldInput" colspan="3"><textarea name="备注" field="remarks" style="width:96%" rows="5" /> </td>
				</tr>				
			</table>
		</form>
   </next:Html>
</next:Window>
</body>
</html>
