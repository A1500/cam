<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<html>
	<head>
		<title>上传列表</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="uploadlist.js"></script>
		<script>

	var username = '<%=GetBspInfo.getBspInfo(request).getUserName()%>';
   	 	var organName = '<%=BspUtil.getOrganName()%>';
</script>
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
	<model:dataset id="ds" cmd="com.inspur.cams.prs.prsretiredsoldiers.cmd.SoldiersuploadQueryCommand" method="execute" global="true">
		<model:record fromBean="com.inspur.cams.prs.prsretiredsoldiers.dao.SoldiersUpload"></model:record>
	</model:dataset>
	<model:dataset id="uploadDs" cmd="com.inspur.cams.prs.prsretiredsoldiers.cmd.SoldiersuploadQueryCommand" method="execute" global="true">
		<model:record fromBean="com.inspur.cams.prs.prsretiredsoldiers.dao.SoldiersUpload"></model:record>
	</model:dataset>
	<!-- 是否 -->
	<model:dataset id="yesON" enumName="COMM.YESORNO" autoLoad="true"
		global="true">
	</model:dataset>
	<model:dataset id="MilitaryRegionCodeDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_MILITARY_REGION_CODE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
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
					<form style="width: 95%; height: 100%;" class="L5form">
						<table  border="1" width="100%" >
							<tr >


								<td class="FieldLabel">目录名称:</td>
								<td class="FieldInput"><input type="text"  id="catalogCode" class="TextEditor" title="目录名称"  /></td>
								<td class="FieldLabel">是否导入:</td>
								<td class="FieldInput"><select id="insertFlag" style="width:135"
								field="insertFlag" name="是否导入"><option dataset="IfInsert"></option>
							</select></td>
								<td class="FieldInput"><button onclick="query()">查 询</button></td>
								</tr>
								<tr>
								<td class="FieldLabel">上传时间:</td>
								<td class="FieldInput"><input type="text"  id="uploadTime" format="Y-m-d" onclick="LoushangDate(this)" class="TextEditor"  title="上传时间"  /></td>

								<td class="FieldLabel">军区大单位:</td>
								<td class="FieldInput"><select id="militaryRegion" style="width:135"
								field="militaryRegion" name="军区大单位">
								<option dataset="MilitaryRegionCodeDataset"></option>
							</select></td>

								<td class="FieldInput"><button type="reset" >重 置</button>
								 </td>
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>
<input type="hidden"  id="updatefileId" value=""/>
<next:GridPanel id="editGridPanel" name="soldiersuploadGrid" notSelectFirstRow="true"  width="100%" stripeRows="true" height="350" dataset="uploadDs" title="上传">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="导入" iconCls="add" handler="upload" />
		<next:ToolBarItem symbol="-"></next:ToolBarItem>
		<next:ToolBarItem text="增加" iconCls="add" handler="insert"/>
		<next:ToolBarItem symbol="-"></next:ToolBarItem>
		<next:ToolBarItem text="查看" iconCls="detail" id="detail" handler="detail"/>
		<next:ToolBarItem symbol="-"></next:ToolBarItem>
		<next:ToolBarItem text="删除" iconCls="remove" handler="del" />
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
	<next:Column id="catalogcode" header="目录名称" field="catalogCode" width="90" >
			<next:TextField  />
		</next:Column>

		<next:Column id="cataloginfo" header="目录描述" field="catalogInfo" width="90" >
			<next:TextField  />
		</next:Column>
		<next:Column id="militaryregion" header="军区大单位" field="militaryRegion" width="90" dataset="MilitaryRegionCodeDataset">
			<next:TextField  />
		</next:Column>

		<next:Column id="fileoper" header="上传人" field="fileOper" width="90" >
			<next:TextField  />
		</next:Column>

		<next:Column id="uploadTime" header="上传时间" field="uploadTime" width="90" >
			<next:TextField  />
		</next:Column>
		<next:Column id="filePath" header="文件路径" field="filePath" width="200" >
			<next:TextField  />
		</next:Column>
		<next:Column id="insertFlag" header="是否导入" field="insertFlag" width="60" dataset="yesON">
			<next:TextField  />
		</next:Column>
		<next:Column id="contain_num" header="导入数量" field="contain_num" width="60">
			<next:TextField  />
		</next:Column>

	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="uploadDs"/>
	</next:BottomBar>
</next:GridPanel>
<next:Window id="uploadinsert" title="信息录入" width="550" height="300" closeAction="hide" modal="true" resizable="true">
		<next:AnchorLayout>
			<next:Panel title="信息录入" collapsible="true">
		<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
	</next:TopBar>
			<next:Html>
				<form id="form_content" name="form_content" method="post" dataset="ds" onsubmit="return false" class="L5form">
					<table border="0" width="98%">
		<tr>
			<td class="FieldLabel" style="width:10%">目录名称:</td>
		<td class="FieldInput" style="width:20%"><input type="text" field="catalogCode" name="目录名称"/></td>

		<td class="FieldLabel" style="width:10%">军区大单位:</td>
		<td class="FieldInput" style="width:20%"><select id="militaryRegion" style="width:135"
								field="militaryRegion" name="军区大单位">
								<option dataset="MilitaryRegionCodeDataset"></option>
							</select><font color="red">*</font></td>
		</tr>
		<tr>
		<td class="FieldLabel" style="width:10%">目录描述：</td>
		<td class="FieldInput" colspan="3"><textarea style="width:90%" rows="3" id="catalogInfo" field="catalogInfo"  name="目录描述"></textarea></td>
		</tr>
		<tr>
			<td width="78%" nowrap="nowrap" class="FieldInput" colspan="4">
				<input style="width:450px;" type="file" id="catalogName" name="catalogName" title="目录名称"  />
			</td>
		</tr>
		<tr>
		<td class="FieldLabel" style="width:10%" nowrap="nowrap" align="left" colspan="2">上传人:<%=GetBspInfo.getBspInfo(request).getUserName()%></td>

		<td class="FieldLabel" nowrap="nowrap" align="left" colspan="2" >上传时间:<label  id="Rtime"
						size="20"  /></td>
		</tr>
		</table>
		</form></next:Html>
		</next:Panel>
	</next:AnchorLayout>
	<next:Buttons>
		<next:ToolButton text="确认" handler="save"></next:ToolButton>

	</next:Buttons>
</next:Window>
<next:Window id="uploaddetail" title="信息查看" width="550" height="300" closeAction="hide" modal="true" resizable="true">
		<next:AnchorLayout>
			<next:Panel title="信息查看" collapsible="true">
			<next:Html>
				<form id="uploadForm" name="uploadForm" method="post" dataset="ds" onsubmit="return false" class="L5form">
					<table border="0" width="98%">
		<tr>
		<td class="FieldLabel" style="width:10%">目录名称:</td>
		<td class="FieldInput" style="width:20%"><label  type="text"  id="catalogCode" field="catalogCode" name="目录名称"/></td>
		<td class="FieldLabel" style="width:10%">军区大单位:</td>
		<td class="FieldInput" style="width:20%"><label  type="text"  id="militaryRegion" field="militaryRegion" dataset="MilitaryRegionCodeDataset"/></td>
		</tr>

		<tr>
		<td class="FieldLabel" style="width:10%">上传人:</td>
		<td class="FieldInput" style="width:20%"><label  type="text"  id="fileOper" field="fileOper"/></td>
		<td class="FieldLabel" style="width:10%">上传时间:</td>
		<td class="FieldInput" style="width:20%"><label  type="text"  id="uploadTime" field="uploadTime"/></td>
		</tr>

		<tr>
		<td class="FieldLabel" style="width:10%">目录描述：</td>
		<td class="FieldInput" colspan="3"><textarea style="width:90%" rows="3" id="catalogInfo" field="catalogInfo" disabled="disabled"></textarea></td>
		</tr>

		</table>
		</form></next:Html>
		</next:Panel>
	</next:AnchorLayout>

</next:Window>
</body>
</html>
