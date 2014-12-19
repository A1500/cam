<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<html>
<head>
<title>退役士兵列表</title>
<next:ScriptManager />
<script>
	var struId = '<%=BspUtil.getStruId()%>';
	var orgCode  ='<%=BspUtil.getOrganCode()%>';
	var orgName ='<%=BspUtil.getOrganName()%>';
	var organName= decodeURIComponent('<%=request.getParameter("organName")%>');
	var username = '<%=GetBspInfo.getBspInfo(request).getUserName()%>';
</script>
<script type="text/javascript" src="prsretiredsoldiers_list.js"></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "ISPrint.js") %>"></script>
<script type="text/javascript" src="../../bpt/comm/bptComm.js"></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
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
	var str;
function getPrintDataByDataSet(reportName,printDataset){
		var dqsj=new Date();
		var cxsjq ="";
		var cxsjz	= "";
		var records=printDataset.getAllRecords();
		var n=records.length;
		var domicileName=document.getElementById("domicileName").value;
		var cYear=	document.getElementById("cYear").value;
		var xmlStr="<?xml version='1.0' encoding='GBK' standalone='no'?>";
		xmlStr+="<Report ReportName='' Creater='" +dqsj+"' CreateOrgan='"+orgName+"' ReportNo='"+domicileName+"' ReportType='"+n+"' cYear='"+cYear+"'>";
		
		if(records.length==0){return}
		for(i=0;i<n;i++){
			xmlStr +="<Info>";
			L5.each(records[i].fields.items,function(item,index){xmlStr+="<"+item.name+">"+records[i].get(item.name)+"</"+item.name+">";});
			xmlStr +="</Info>";
		}
		xmlStr +="</Report>";
		return xmlStr;
	}
	</script>
</head>
<body>
<model:datasets>
	<!-- 退役士兵基本信息 -->
	<model:dataset id="retiredSoldierDataset"
		cmd="com.inspur.cams.prs.prsretiredsoldiers.cmd.PrsRetiredSoldiersQueryCommand"
		method="queryBatchSoldiers" global="true">
		<model:record>
			<model:field name="REGION" type="string" />
			<model:field name="NAME" type="string" />
			<model:field name="SPEC" type="string" />
			<model:field name="ENTIME" type="string" />
			<model:field name="ENPLACE" type="string" />
			<model:field name="CONTENT" type="string" />
			<model:field name="ID" type="string" />
			<model:field name="SERVEDARMY" type="string" />
			<model:field name="WHEREPLACEMENT" type="string" />
			<model:field name="SLOCATION" type="string" />
			<model:field name="PRENSON" type="string" />
			<model:field name="TFILE" type="string" />
			<model:field name="FLAG" type="string" />
			<model:field name="FILENUM" type="string" />
			<model:field name="domicileName" type="string" />
		</model:record>
	</model:dataset>
	<!-- 退役士兵基本信息 -->
	<model:dataset id="printDataset"
		cmd="com.inspur.cams.prs.prsretiredsoldiers.cmd.PrsRetiredSoldiersQueryCommand"
		method="queryBatchSoldiers" global="true">
		<model:record>
			<model:field name="REGION" type="string" />
			<model:field name="NAME" type="string" />
			<model:field name="SPEC" type="string" />
			<model:field name="ENTIME" type="string" />
			<model:field name="ENPLACE" type="string" />
			<model:field name="CONTENT" type="string" />
			<model:field name="ID" type="string" />
			<model:field name="SERVEDARMY" type="string" />
			<model:field name="WHEREPLACEMENT" type="string" />
			<model:field name="SLOCATION" type="string" />
			<model:field name="PRENSON" type="string" />
			<model:field name="TFILE" type="string" />
			<model:field name="FLAG" type="string" />
			<model:field name="FILENUM" type="string" />
			<model:field name="domicileName" type="string" />
		</model:record>
	</model:dataset>
	<model:dataset id="ds" cmd="com.inspur.cams.prs.prsretiredsoldiers.cmd.SoldiersuploadQueryCommand" method="execute" global="true">
		<model:record fromBean="com.inspur.cams.prs.prsretiredsoldiers.dao.SoldiersUpload"></model:record>
	</model:dataset>
	<!-- 行政区划 -->
	<model:dataset id="OrgNameDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="false">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CITY'></model:param>
			<model:param name="value" value='ID'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!--军区代码  -->
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
	<!-- 是否 -->
	<model:dataset id="yesON" enumName="COMM.YESORNO" autoLoad="true"
		global="true">
	</model:dataset>
	<!-- 是否退档 -->
	<model:dataset id="ApprovalDataset" enumName="APPROVALSTATE.CODE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 性别 -->
	<model:dataset id="SexDataset" enumName="COMM.SEX" autoLoad="true"
		global="true"></model:dataset>
	<!-- 民族 -->
	<model:dataset id="NationDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 户籍类别 -->
	<model:dataset id="DomicileDataset" enumName="DOMICILE.CODE"
		autoLoad="true" global="true"></model:dataset>
	<!--入伍形式 -->
	<model:dataset id="EnlistTypeDataset" enumName="ENLISTTYPE.CODE"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 是否退档 -->
	<model:dataset id="ApprovalDataset" enumName="APPROVALSTATE.CODE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 档案来源 -->
	<model:dataset id="FileResourcesDataset" enumName="FILESRESOURCE.CODE"
		autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:Panel name="form" width="100%" border="0"
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
				<td class="FieldLabel" nowrap="nowrap">退役年度：</td>
				<td class="FieldInput"><input type="text" id="cYear"
					class="TextEditor" title="退役年度" /></td>
				<td class="FieldLabel" nowrap="nowrap">姓名：</td>
				<td class="FieldInput"><input type="text" id="name"
					class="TextEditor" title="姓名" /></td>
				<td class="FieldLabel" nowrap="nowrap">军区大单位：</td>
				<td class="FieldInput"><select id="servedMilitaryRegion"
					name="军区大单位">
					<option dataset="MilitaryRegionCodeDataset"></option>
				</select></td>
				<td class="FieldInput">
				<button onclick="query()">查 询</button>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel" nowrap="nowrap">安置地：</td>
				<td class="FieldInput"><input type="text" id="domicileName"
					field="domicileName" onclick="forHelp()" readonly="readonly" /> <input
					type="hidden" id="domicileCode" name="安置地" />
				</td>
				<td class="FieldLabel" nowrap="nowrap">入伍地：</td>
				<td class="FieldInput"><input type="text" id="enlistPlace"
					class="TextEditor" title="入伍地" /></td>
				<td class="FieldLabel">是否退档：</td>
				<td class="FieldInput" colspan="1"><select id="sendback"
					name="是否退档">
					<option dataset="ApprovalDataset"></option>
				</select></td>
				<td class="FieldInput">
				<button onclick="reset()">重 置</button>
				</td>
			</tr>
		</table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="prsretiredsoldiersGrid"
	clickToSelectedForChkSM="true" width="99%" stripeRows="true"
	height="100%" style="padding: 5px;" dataset="retiredSoldierDataset"
	autoExpandColumn="content" notSelectFirstRow="true" title="退役士兵信息">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="DBF导入" iconCls="add" handler="upload" />
		<next:ToolBarItem symbol="-"></next:ToolBarItem>
		<next:ToolBarItem text="EXCEL导入" iconCls="detail" id="importExcel" handler="forImportExcel" />
		<next:ToolBarItem symbol="-"></next:ToolBarItem>
		<next:ToolBarItem text="增加" iconCls="add" handler="insert" />
		<next:ToolBarItem symbol="-"></next:ToolBarItem>
		<next:ToolBarItem text="修改" iconCls="edit" handler="update" />
		<next:ToolBarItem symbol="-"></next:ToolBarItem>
		<next:ToolBarItem text="删除" iconCls="remove" handler="del" />
		<next:ToolBarItem symbol="-"></next:ToolBarItem>
		<next:ToolBarItem text="查看" iconCls="detail" id="detail"
			handler="detail" />
		<next:ToolBarItem symbol="-"></next:ToolBarItem>
		<next:ToolBarItem text="打印" iconCls="print" id="print" handler="print" />
		<next:ToolBarItem symbol="-"></next:ToolBarItem>
		<next:ToolBarItem text="审核下发" iconCls="send" id="send" handler="send" />
		<next:ToolBarItem symbol="-"></next:ToolBarItem>
		<next:ToolBarItem text="批量下发" iconCls="send" id="sendPatch"
			handler="sendPatch" />
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="35" header="序号" />
		<next:CheckBoxColumn></next:CheckBoxColumn>

		<next:Column  header="编号" field="FILENUM" id="FILENUM" width="60">
			<next:TextField />
		</next:Column>

		<next:Column  header="姓名" field="NAME"  id="NAME"  width="60">
			<next:TextField />
		</next:Column>

		<next:Column  header="专业特长" field="SPEC" id="specialty" width="80">
			<next:TextField  />
		</next:Column>

		<next:Column  header="部队单位" field="SERVEDARMY"  id="SERVEDARMY" width="80">
			<next:TextField />
		</next:Column>

		<next:Column header="入伍时间" field="ENTIME"  id="enlistTime"
			width="90">
			<next:TextField />
		</next:Column>
		<next:Column header="入伍地" field="ENPLACE" id="ENPLACE"
			width="90">
			<next:TextField />
		</next:Column>

		<next:Column  header="配偶户口所在地" field="SLOCATION" id="sLocation"
			width="100">
			<next:TextField />
		</next:Column>
		<next:Column id="whereplacement" header="安置地"
			field="domicileName" width="100">
			<next:TextField />
		</next:Column>
		<next:Column  header="安置理由" field="PRENSON" id="pRenson"
			 width="90">
			<next:TextField />
		</next:Column>

		<next:Column  header="移交材料" field="TFILE"  id="tFile"
		 width="90" hidden="true">
			<next:TextField />
		</next:Column>

		<next:Column  header="是否退档" field="FLAG"  id="flag"  width="60">
			<next:TextField />
		</next:Column>
		<next:Column  header="军区大单位"
			field="REGION"  width="120"  id="servedMilitaryRegion"  >
			<next:TextField  />
		</next:Column>
		<next:Column hidden="true" header="备注" field="CONTENT"  id="content"  >
			<next:TextField />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="retiredSoldierDataset" />
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
		<next:ToolButton text="确认" handler="save" id="saves"></next:ToolButton>

	</next:Buttons>
</next:Window>
</body>
</html>
