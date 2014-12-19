
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>公墓查询</title>
<next:ScriptManager />
<script type="text/javascript" src="../ep.js"></script>
<script type="text/javascript" src="cemeInformationDetail.js"></script>
<script>
        var orgCode ='<%=BspUtil.getParentOrgan().getOrganCode()%>';
		var orgName ='<%=BspUtil.getParentOrgan().getOrganName()%>';
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
	<model:dataset id="ds"
		cmd="com.inspur.cams.fis.base.cmd.FisCemeteryOrganQueryCmd" global="true"
		sortField="organId">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisCemeteryOrgan"></model:record>
	</model:dataset>
	<model:dataset id="propDataSet" enumName="FIS.CEME.PROP"
		autoLoad="true" global="true"></model:dataset>
	<model:dataset id="dominDataSet" enumName="FIS.CEME.DOMINATION"
		autoLoad="true" global="true"></model:dataset>
		
</model:datasets>

<next:Panel name="form" width="99.9%" border="0" autoHeight="true">
	<next:Html>
		<fieldset style="overflow: visible;" class="GroupBox"><legend
			class="GroupBoxTitle">查询条件 <img class="GroupBoxExpandButton"
			src="<%=SkinUtils.getImage(request,
									"groupbox_collapse.gif")%>"
			onclick="collapse(this)" /> </legend>
		<div>
		<form style="width: 100%; height: 100%;" class="L5form">
		<table border="1" width="100%">
			<tr>
				<td class="FieldLabel">公墓编号:</td>
				<td class="FieldInput"><input type="text" id="organId"
					class="TextEditor" title="公墓编号" /></td>
				<td class="FieldLabel">公墓名称:</td>
				<td class="FieldInput"><input type="text" id="name"
					class="TextEditor" title="公墓名称" /></td>
				<td class="FieldLabel" >主管单位:</td>
				<td class="FieldInput" ><input type="text"
					name="manaLevel" id="manaLevel" field="manaLevel"
					class="TextEditor" readonly="readonly" /> <input type="text"
					id="manaLevelId" field="manaLevelId" style="display: none;" />
					<button  style="cursor: hand" onclick="selectOrganNoDs()">选择</button></td>
			</tr>
			<tr>
				<td class="FieldLabel">公墓性质:</td>
				<td class="FieldInput"><select name="prop" id="prop">
					<option dataset="propDataSet" title="公墓性质"></option>
				</select></td>
				<td class="FieldLabel">法人代表:</td>
				<td class="FieldInput"><input type="text" id="legalPeople"
					class="TextEditor" title="法人代表姓名" /></td>
				<td class="FieldLabel">主办单位:</td>
				<td class="FieldInput"><input type="text" id="organizer"
					class="TextEditor" title="主办单位" /></td>
			</tr>
			<tr>
				<td class="FieldLabel">正式营业时间:</td>
				<td class="FieldInput"><input type="text" id="gestionTime" format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly"
					class="TextEditor" title="正式营业时间" /></td>
				<td class="FieldLabel">地址:</td>
				<td class="FieldInput"><input type="text" id="address"
					class="TextEditor" title="地址" /></td>
				<td class="FieldLabel" colspan="2">
					<button onclick="query()">查 询</button>
					&nbsp;
					<button onclick="resetQuery()">重 置</button>
				</td>
			</tr>
		</table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="fiscemeGrid" width="99.9%"
	height="100%" dataset="ds" notSelectFirstRow="true">
	<next:TopBar>
		<next:ToolBarItem id="qrToolbar" text="查询结果"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="增加公益性公墓信息" iconCls="add"
			handler="insertNoprofitCeme" />
		<next:ToolBarItem text="修改" iconCls="edit"
			handler="update" />
		<next:ToolBarItem text="明细" iconCls="detail" handler="detail" />
		<next:ToolBarItem text="导出" iconCls="export"/>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="25" />
		<next:RadioBoxColumn></next:RadioBoxColumn>

		<next:Column id="gmorganId" header="公墓编号" field="organId" width="120">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="gmname" header="公墓名称" field="name" width="100" renderer="showDetailsRendener">
			<next:TextField />
		</next:Column>

		<next:Column id="prope" header="公墓性质" dataset="propDataSet" field="prop" width="90">
			<next:TextField />
		</next:Column>
		<next:Column id="legalPeople1" header="法人代表" field="legalPeople"
			width="100">
			<next:TextField />
		</next:Column>
		<next:Column id="organiz" header="主办单位" field="organizer"
			width="100">
			<next:TextField />
		</next:Column>
		<next:Column id="approveTime1" header="批准建设时间" field="approveTime"
			width="110">
			<next:TextField />
		</next:Column>
		<next:Column id="gestionTime1" header="正式营业时间" field="gestionTime"
			width="110">
			<next:TextField />
		</next:Column>
		<next:Column id="numberOf" header="编制人数(人)" field="numberOf"
			width="90" hidden="true">
			<next:TextField />
		</next:Column>
		<next:Column id="domination" header="管辖级别" field="domination" dataset="dominDataSet"
			width="110">
			<next:TextField />
		</next:Column>
		<next:Column id="manaLevName" header="主管单位" field="manaLevel"
			width="110">
			<next:TextField />
		</next:Column>
		<next:Column id="deptName1" header="所属行政区" field="deptName" align="center"
			width="150">
			<next:TextField />
		</next:Column>
		<next:Column id="address1" header="地址" field="address" width="180">
			<next:TextField />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds" />
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
