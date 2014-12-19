<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.extuser.util.ExtBspInfo"%>
 
<html>
<head>
<next:ScriptManager />
<script type="text/javascript" src="sureyCheckList.js"></script>
<script type="text/javascript" src="IDCard.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script language="javascript">
	var organId = "<%=ExtBspInfo.getUserInfo(request).getOrganId()%>";
	var organArea = "<%=ExtBspInfo.getUserInfo(request).getAreaCode()%>";
	var organName = "<%=ExtBspInfo.getUserInfo(request).getOrganName()%>";
	var organType = "<%=ExtBspInfo.getUserInfo(request).getOrganType()%>";
	var userId = "<%=ExtBspInfo.getUserInfo(request).getUserId()%>";
	var userName = "<%=ExtBspInfo.getUserInfo(request).getUserName()%>";
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
 
<!--设置dataset-->
<model:datasets>
	<!--低保核对_外部单位填报信息的dataset-->
	<model:dataset id="samSureyWfDataset" cmd="com.inspur.cams.drel.surey.comm.cmd.SamSureyWfQueryCmd" global="true" pageSize="10">

	</model:dataset>
	<!--低保核对_增加核对对象信息的dataset-->
	<model:dataset id="winSureyWfDataset" cmd="com.inspur.cams.drel.surey.comm.cmd.SamSureyWfQueryCmd" global="true" pageSize="10">
		<model:record fromBean="com.inspur.cams.drel.surey.comm.data.SamSureyWf">
			<model:field name="name" type="string" rule="require"/>
			<model:field name="idCard" type="string" rule="require"/>
			<model:field name="domicileCode" type="string" rule="require"/>
			<model:field name="apanageCode" type="string" rule="require"/>
		</model:record>
	</model:dataset>
	<!--属地-->
	<model:dataset id="domicileDataset" autoLoad="false" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CITY'></model:param>
			<model:param name="value" value='ID'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 核对项目 -->
	<model:dataset id="assistanceTypeDS" cmd="com.inspur.cams.comm.dicm.cmd.DicDetailsQueryCmd" method="queryForDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dicType" value="SURVEY_ASSISTANCE_TYPE"></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
<!--业务查询-->
<next:Panel name="form" width="100%" border="0"
	bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true">
	<next:Html>
		<fieldset style="overflow: visible;" class="GroupBox">
			<legend class="GroupBoxTitle">查询条件 
				<img class="GroupBoxExpandButton" src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>" onclick="collapse(this)" /> 
			</legend>
			<div>
			<form style="width: 100%; height: 100%;" class="L5form">
			<table border="1" width="100%">
				<tr>
					<td class="FieldLabel">姓名:</td>
					<td class="FieldInput"><input type="text" id="name" maxlength="15" class="TextEditor" /></td>
					<td class="FieldLabel">身份证号:</td>
					<td class="FieldInput" colspan="2"><input type="text" id="sfzh" maxlength="18"  style="width:90%" field="身份证号" class="TextEditor" /></td>
				</tr>
				<tr>
					<td class="FieldLabel">户籍县（市、区）地址：</td>
					<td class="FieldInput">
						<select id="domicileCodeQuery" name='"户籍县（市、区）地址"'>
							<option dataset="domicileDataset"></option>
						</select>
					</td>
					<td class="FieldLabel">居住县（市、区）地址：</td>
					<td class="FieldInput">
						<select id="apanageCodeQuery" name='"居住县（市、区）地址"'>
							<option dataset="domicileDataset"></option>
						</select>
					</td>	
					<td class="FieldButton">
						<button onclick="query()">查 询</button>
					</td>
				</tr>
				<tr>			
					<td class="FieldLabel">申请日期:</td>
					<td class="FieldInput">
						<input type="text" id="applyDateQ" format="Y-m-d" name="applyDateQ" field="applyDate" style="width: 70"	onclick="LoushangDate(this)" readonly="readonly" /> ----- 
						<input type="text" id="applyDateZ" format="Y-m-d" name="applyDateZ" field="applyDate" onclick="LoushangDate(this)" style="width: 70" readonly="readonly" />					
					</td>
					<td class="FieldLabel">核对项目:</td>
					<td class="FieldInput">
						<select id="assistanceTypeQuery" name="assistanceType">
							<option dataset="assistanceTypeDS"></option>
						</select>
					</td>
					<td class="FieldButton">
						<button onclick="reset()">重 置</button>
					</td>
				</tr>
			</table>
			</form>
			</div>
		</fieldset>
	</next:Html>
</next:Panel>

<!--业务查询明细-->
<next:GridPanel id="gridPanel" name="gridPanel" width="100%" stripeRows="true" height="100%" dataset="samSureyWfDataset" notSelectFirstRow="true" title="待办人员列表">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text="增加人员" handler="addObject" />
		<next:ToolBarItem iconCls="edit" text="修改人员" handler="editObject" />
		<next:ToolBarItem iconCls="delete" text="删除人员" handler="delObject" />
		<next:ToolBarItem iconCls="select" text="提交" handler="sendObject" />
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="30" />
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="name" header="姓名" field="NAME" width="80">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="idCard" header="身份证号" field="ID_CARD" width="150">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="domicileCode" header="户籍县（市、区）地址" field="DOMICILE_CODE" dataset="domicileDataset" width="150">
			<next:TextField />
		</next:Column>
		<next:Column id="apanageCode" header="居住县（市、区）地址" field="APANAGE_CODE" dataset="domicileDataset" width="150">
			<next:TextField />
		</next:Column>
		<next:Column header="申请日期" field="APPLY_DATE" width="100">
			<next:TextField allowBlank="false" />
		</next:Column>		
		<next:Column header="核对项目" field="ASSISTANCE_TYPE" dataset="assistanceTypeDS" width="100">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="流程ID" field="FLOW_ID" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="核对流水ID" field="SURVEY_ID" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="人员ID" field="PEOPLE_ID" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="samSureyWfDataset" />
	</next:BottomBar>
</next:GridPanel>

<!-- 增加人员窗口 -->
<next:Window id="addWin" title="人员信息窗口" resizable="false" width="650" height="100%" autoHeight="true" closeAction="hide" autoScroll="true">
	<next:Panel id="addWin_panel">
		<next:Html>
			<form id="addWinForm" method="post" dataset="winSureyWfDataset" onsubmit="return false" class="L5form">
				<table width="100%">
					<tr>
						<td class="FieldLabel" style="width:25%">姓名：</td>
						<td class="FieldInput" style="width:25%"><input type="text" id="applyName" field="name" name='"姓名"' style="width:90%" onchange="checkCN('applyName','姓名')"/></td>
						<td class="FieldLabel" style="width:25%">身份证号：</td>
						<td class="FieldInput" style="width:25%"><input type="text" field="idCard" id="idCard" name='"身份证号"' style="width:90%" onchange="checkIDCard('idCard','身份证');"/></td>
					</tr>
					<tr>
						<td class="FieldLabel">户籍县（市、区）地址：</td>
						<td class="FieldInput"><select field="domicileCode"id="domicileCode" name='"户籍县（市、区）地址"' style="width:90%">
							<option dataset="domicileDataset"></option>
						</select></td>
						<td class="FieldLabel">居住县（市、区）地址：</td>
						<td class="FieldInput"><select field="apanageCode" id="apanageCode" name='"居住县（市、区）地址"' style="width:90%">
							<option dataset="domicileDataset"></option>
						</select></td>
					</tr>
					<tr>
						<td class="FieldLabel">申请核对的单位名称：</td>
						<td class="FieldInput"><input type="text" id="applyOrganName" style="width:90%" readonly="readonly"/></td>
						<td class="FieldLabel">核对项目：</td>
						<td class="FieldInput">
							<select id="assistanceTypeSelect" field="assistanceType" style="width:90%">
								<option dataset="assistanceTypeDS"></option>
							</select>
						</td>
					</tr>
				</table>
			</form>				
		</next:Html>
	</next:Panel>
	<next:Buttons>
		<next:ToolButton text="保存" handler="clickSave"></next:ToolButton>
		<next:ToolButton text="关闭" handler="clickClose"></next:ToolButton>
	</next:Buttons>
</next:Window>
</body>
 
</html>