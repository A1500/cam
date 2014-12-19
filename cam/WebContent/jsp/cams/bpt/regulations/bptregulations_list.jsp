<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>政策法规列表</title>
<next:ScriptManager />
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="bptregulations_list.js"></script>
<script type="text/javascript" src="../comm/bptComm.js"></script>
<script language="javascript">
	  	var getorganCode='<%=BspUtil.getOrganCode()%>';
	  	var getorganName='<%=BspUtil.getOrganName()%>';
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
	<model:dataset id="ds"
		cmd="com.inspur.cams.bpt.regulations.cmd.BptRegulationsQueryCommand"
		global="true">
		<model:record
			fromBean="com.inspur.cams.bpt.regulations.data.BptRegulations"></model:record>
	</model:dataset>
	<model:dataset id="FileLevelDataset" enumName="REGULATION.CODE"
		autoLoad="true" global="true"></model:dataset>
	<model:dataset id="FileStateDataset" enumName="FLAG.CODE"
		autoLoad="true" global="true"></model:dataset>	
	<!-- 类别 -->
	<model:dataset id="TypeDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='BPT_REGULATIONS_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>

<next:Panel name="form" width="99%" border="0"
	bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true">
	<next:Html>
		<fieldset style="overflow: visible;" class="GroupBox"><legend
			class="GroupBoxTitle">查询条件 <img class="GroupBoxExpandButton"
			src="<%=SkinUtils.getImage(request,
									"groupbox_collapse.gif")%>"
			onclick="collapse(this)" /> </legend>
		<div>
		<form style="width: 98%; height: 100%;" class="L5form">
		<table border="1" width="100%">
			<tr>
				<td class="FieldLabel" nowrap="nowrap">文件编号：</td>
				<td class="FieldInput"><input type="text" id="p_fileNum"
					class="TextEditor" /></td>
				<td class="FieldLabel" nowrap="nowrap">文件级别：</td>
				<td class="FieldInput"><select id="p_fileLevel" 
					id="fileLevel">
					<option dataset="FileLevelDataset"></option>
				</select></td>
				<td class="FieldLabel" nowrap="nowrap">文件状态：</td>
				<td class="FieldInput"><select id="p_filestate" 
					id="p_filestate">
					<option dataset="FileStateDataset"></option>
				</select></td>
				<td class="FieldLabel" style="text-align:center;">
					<button id="queryButton" onclick="query()">查 询</button>
				</td>	
			</tr>
			<tr>
				<td class="FieldLabel">类别</td>
				<td class="FieldInput">
					<select field="type" name="类别" id="type">
						<option dataset="TypeDataset"></option>
					</select>
				</td>
				<td class="FieldLabel" nowrap="nowrap">文件标题：</td>
				<td class="FieldInput"><input type="text" id="p_filetitle" 
					class="TextEditor" /></td>
				<td class="FieldLabel" nowrap="nowrap">发布时间：</td>
				<td class="FieldInput"><input type="text" id="p_releaseDate"  format="Y-m-d" style="width: 100px;" maxlength="10"
					class="TextEditor" onpropertychange="changeDateStyle(this)" /><img  src="../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);"></td>
				<td class="FieldLabel" style="text-align:center;">
					<button onclick="reset();">重 置</button>
				</td>
			</tr>
		</table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" width="99%" stripeRows="true"
	height="100%" style="padding: 5px;" dataset="ds"
	notSelectFirstRow="true" title="政策法规信息">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="增加" iconCls="add" handler="insert" id="add" />
		<next:ToolBarItem text="修改" iconCls="edit" handler="update" id="edit"/>
		<next:ToolBarItem text="查看" iconCls="detail" id="detail" handler="detail" />
		<next:ToolBarItem text="删除" iconCls="remove" handler="del" id="remove"/>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="30" />
		<next:CheckBoxColumn></next:CheckBoxColumn>

		<next:Column id="fileNum" header="文件编号" field="fileNum" width="100">
			<next:TextField />
		</next:Column>

		<next:Column id="fileLevel" header="文件级别" field="fileLevel" dataset="FileLevelDataset"
			width="100">
			<next:TextField />
		</next:Column>

		<next:Column id="regulationsTitle" header="标题"
			field="regulationsTitle" width="210">
			<next:TextField />
		</next:Column>

		<next:Column id="releaseDate" header="发布日期" field="releaseDate"
			width="100">
			<next:TextField />
		</next:Column>
		
		<next:Column  header="文件状态" field="flag" dataset="FileStateDataset"
			width="100">
			<next:TextField />
		</next:Column>

		<next:Column id="releasePeople" header="录入人员" field="releasePeople"
			width="100">
			<next:TextField />
		</next:Column>

		<next:Column id="releaseCompany" header="录入单位" field="releaseCompany"
			width="100">
			<next:TextField />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds" />
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
