<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
function init(){
}
function query(){
	var somOrganDataset=L5.DatasetMgr.lookup("somOrganDataset");
	somOrganDataset.setParameter("IF_BRANCH","0");
	somOrganDataset.setParameter("CN_NAME@like",_$("sorgName"));
	somOrganDataset.setParameter("SORG_CODE",_$("sorgCode"));
	somOrganDataset.setParameter("SORG_TYPE",_$("sorgType"));
	somOrganDataset.setParameter("LEGAL_PEOPLE@like",_$("legalPeople"));
	somOrganDataset.load();
}
function detail(){
	var grid=L5.getCmp("organGrid");
	var selected = grid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert("提示","请选择一条记录进行查看!");
		return false;
	}
	var record=selected[0];
	var sorgId=record.get("sorgId");
	var data=new L5.Map();
	data.put('sorgId',sorgId);
	data.put('sorgType',record.get("sorgType"));	
	var url='jsp/cams/sorg/query/somHis/somHisQueryDetail.jsp';
	text='';
	L5.forward(url,text,data);
}
</script>
</head> 
<body>
<model:datasets>
	<model:dataset id="somOrganDataset" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" method="queryOrgan">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan"></model:record>
	</model:dataset>	
	<!-- 社会组织种类 -->
	<model:dataset id="sorgTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SORG_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 社会组织状态 -->
	<model:dataset id="sorgStatusSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SORG_STATUS'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
<next:Panel width='100%' height='100%'>
	<next:Panel >
		<next:Html>
			<form class="L5form">
			<fieldset><legend>查询条件</legend>
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width:20%"><label>社会组织名称：</label></td>
					<td class="FieldInput" style="width:20%"><input style='width:90%'  type="text" id="sorgName"/></td>
					<td class="FieldLabel" style="width:20%"><label>登记证号：</label></td>
					<td class="FieldInput" style="width:20%"><input style='width:90%'  type="text" id="sorgCode" /></td>
					<td class="FieldButton" style="width:20%">
						<button onclick="query()">查询</button>
					</td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:17%"><label>社会组织种类：</label></td>
					<td class="FieldInput" style="width:17%"><select style='width:90%' id="sorgType"><option dataset="sorgTypeSelect"></option></select></td>
					<td class="FieldLabel"><label>法定代表人：</label></td>
					<td class="FieldInput"><input style='width:90%'  type="text" id="legalPeople" /></td>
					<td class="FieldButton"  >
						<button type="reset">重置</button>
					</td>
				</tr>
			</table>
			</fieldset>
			</form>
		</next:Html>
	</next:Panel>
	
	<next:EditGridPanel title="社会组织列表" id="organGrid" dataset="somOrganDataset" height="100%" notSelectFirstRow="true">
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem  iconCls="detail" text="查看" handler="detail" ></next:ToolBarItem>
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn/>
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column header="社会组织种类" field="sorgType" sortable="true" dataset="sorgTypeSelect" width="10%" editable="false"><next:TextField /></next:Column>
			<next:Column header="社会组织名称"  field="cnName" sortable="true" editable="false"width="20%" ><next:TextField></next:TextField></next:Column>
			<next:Column header="登记证号" field="sorgCode" sortable="true" editable="false" width="10%"><next:TextField/></next:Column>
			<next:Column header="社会组织状态" field="sorgStatus" sortable="true" editable="false" width="12%" dataset="sorgStatusSelect"><next:TextField/></next:Column>
			<next:Column header="法定代表人" field="legalPeople" sortable="true" editable="false" width="10%"><next:TextField /></next:Column>
		</next:Columns> 
		<next:BottomBar>
			<next:PagingToolBar dataset="somOrganDataset" />
		</next:BottomBar>
	</next:EditGridPanel>
</next:Panel>
</body>
</html>