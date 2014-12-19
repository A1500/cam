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
	somOrganDataset.setParameter("CN_NAME@like",_$("sorgName"));
	somOrganDataset.setParameter("SORG_CODE",_$("sorgCode"));
	somOrganDataset.setParameter("SORG_TYPE",_$("sorgType"));
	somOrganDataset.setParameter("IF_BRANCH",_$("ifBranch"));
	somOrganDataset.setParameter("BUS_SCOPE",_$("busScope"));
	somOrganDataset.setParameter("BORG_NAME@like",_$("borgName"));
	somOrganDataset.setParameter("ORGAN_CODE",_$("organCode"));
	somOrganDataset.setParameter("LEGAL_PEOPLE@like",_$("legalPeople"));
	somOrganDataset.setParameter("SORG_STATUS@=",'51');
	somOrganDataset.load();
}
function forDetail(value,cellmeta,record,rowindex,colindex,dataset){
	var sorgId=record.get('sorgId');
	var url='jsp/cams/sorg/query/som/baseQuery/somBaseQueryDetail.jsp?sorgId='+sorgId;
	return '<a href="javascript:L5.forward(\'' + url + '\')">' + value + '</a>';
}
function cancel(){
	var editGrid=L5.getCmp('organGrid');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录进行操作!");
		return false;
	}
	var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomOrganCmd");
	command.setParameter("sorgId", selected[0].get('sorgId'));
	command.execute("cancelLimitPeriod");
	if (!command.error) {
		L5.Msg.alert("提示","操作成功！",function(){
			init();
		});		
	}else{
		L5.Msg.alert('提示',"操作时出现错误！"+command.error);
	}
	query();
}
</script>
</head> 
<body>
<model:datasets>
	<model:dataset id="somOrganDataset" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" method="queryOrgan" pageSize="15">
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
	<!-- 所属行（事）业 -->
	<model:dataset id="busScopeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BUS_SCOPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>	
	<!-- 业务主管单位 -->
	<model:dataset id="businessOrganSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_BUSINESS_ORGAN'></model:param>
			<model:param name="value" value='BORG_CODE'></model:param>
			<model:param name="text" value='BORG_NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 是否 -->
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>	
</model:datasets>
<next:Panel >
	<next:Panel >
		<next:Html>
			<form class="L5form">
			<fieldset><legend>查询条件</legend>
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width:17%"><label>社会组织名称：</label></td>
					<td class="FieldInput" style="width:17%"><input style='width:90%'  type="text" id="sorgName"/></td>
					<td class="FieldLabel" style="width:17%"><label>登记证号：</label></td>
					<td class="FieldInput" style="width:17%"><input style='width:90%'  type="text" id="sorgCode" /></td>
					<td class="FieldLabel" style="width:17%"><label>社会组织种类：</label></td>
					<td class="FieldInput" style="width:17%"><select style='width:90%' id="sorgType"><option dataset="sorgTypeSelect"></option></select></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>是否为分支：</label></td>
					<td class="FieldInput"><select style='width:90%' id="ifBranch"><option dataset="comm_yesorno"></option></select></td>
					<td class="FieldLabel"><label>所属行（事）业：</label></td>
					<td class="FieldInput"><select style='width:90%' id="busScope"><option dataset="busScopeSelect"></option></select></td>
					<td class="FieldLabel"><label>业务主管单位：</label></td>
					<td class="FieldInput"><select style='width:90%' id="borgName"><option dataset="businessOrganSelect"></option></select></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>组织机构代码：</label></td>
					<td class="FieldInput"><input style='width:90%'  type="text" id="organCode" /></td>
					<td class="FieldLabel"><label>法定代表人：</label></td>
					<td class="FieldInput"><input style='width:90%'  type="text" id="legalPeople" /></td>
					<td class="FieldInput" colspan='2' align='center'>
						<button onclick="query()">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<button type="reset">重置</button>
					</td>
				</tr>
			</table>
			</fieldset>
			</form>
		</next:Html>
	</next:Panel>
	
	<next:GridPanel title="社会组织列表" id="organGrid" dataset="somOrganDataset" height="300"  >
		<next:TopBar>
			<next:ToolBarItem symbol="->" ></next:ToolBarItem>
			<next:ToolBarItem text="取消限期停止活动" iconCls="edit" handler="cancel"/>
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn/>
			<next:CheckBoxColumn></next:CheckBoxColumn>
			<next:Column header="社会组织ID" field="sorgId" sortable="true"  hidden="true"><next:TextField /></next:Column>
			<next:Column header="社会组织种类" field="sorgType" sortable="true" dataset="sorgTypeSelect" width="10%" editable="false"><next:TextField /></next:Column>
			<next:Column header="是否为分支" field="ifBranch" sortable="true" dataset="comm_yesorno" width="10%" editable="false"><next:TextField /></next:Column>
			<next:Column header="社会组织名称"  field="cnName" sortable="true" editable="false"width="20%" renderer="forDetail"><next:TextField></next:TextField></next:Column>
			<next:Column header="登记证号" field="sorgCode" sortable="true" editable="false" width="10%"><next:TextField/></next:Column>
			<next:Column header="社会组织状态" field="sorgStatus" sortable="true" editable="false" width="12%" dataset="sorgStatusSelect"><next:TextField/></next:Column>
			<next:Column header="所属行(事)业" field="busScope" sortable="true" editable="false" width="12%" dataset="busScopeSelect"><next:TextField /></next:Column>
			<next:Column header="业务主管单位" field="borgName" sortable="true" editable="false"  width="20%" dataset="businessOrganSelect"><next:TextField /></next:Column>
			<next:Column header="登记管理机关" field="morgName" sortable="true" editable="false" width="20%"><next:TextField /></next:Column>
			<next:Column header="住所" field="residence" sortable="true" editable="false" width="20%"><next:TextField /></next:Column>
			<next:Column header="活动地域" field="actArea" sortable="true" editable="false" width="20%"><next:TextField /></next:Column>
			<next:Column header="法定代表人" field="legalPeople" sortable="true" editable="false" width="10%"><next:TextField /></next:Column>
			<next:Column header="社会组织电话" field="sorgPhone" sortable="true" editable="false" width="15%"><next:TextField />	</next:Column>
		</next:Columns> 
		<next:BottomBar>
			<next:PagingToolBar dataset="somOrganDataset" />
		</next:BottomBar>
	</next:GridPanel>
</next:Panel>
</body>
</html>