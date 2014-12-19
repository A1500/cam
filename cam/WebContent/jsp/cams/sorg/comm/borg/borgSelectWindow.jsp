<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<script type="text/javascript" src="<%=SkinUtils.getRootUrl(request)%>jsp/cams/comm/dicm/autoComplete.js"></script>
<link href="<%=SkinUtils.getRootUrl(request)%>jsp/cams/comm/dicm/autoComplete.css" rel="stylesheet" type="text/css" />
<model:datasets>
	<model:dataset id="businessOrganWin" cmd="com.inspur.cams.sorg.base.cmd.SomBorgQueryCmd"  global="true"  pageSize="300" sortField="ORDER_NUMBER">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomBorg"></model:record>
		<model:params>
			<model:param name="MORG_CODE" value='<%=BspUtil.getOrganCode().substring(0,6)%>'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="businessOrganSelectDic" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true" sortField="ORDER_NUMBER">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_BUSINESS_ORGAN'></model:param>
			<model:param name="value" value='BORG_CODE'></model:param>
			<model:param name="text" value='BORG_NAME'></model:param>
			<model:param name="filterSql" value='<%="MORG_CODE ="+BspUtil.getOrganCode().substring(0,6)%>'></model:param>

		</model:params>
	</model:dataset>
	<model:dataset id="businessOrganAuto" cmd="com.inspur.cams.sorg.base.cmd.SomBorgQueryCmd"  global="true"  pageSize="300" sortField="ORDER_NUMBER">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomBorg"></model:record>
		<model:params>
			<model:param name="MORG_CODE" value='<%=BspUtil.getOrganCode().substring(0,6)%>'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>

<!-- 业务主管单位 -->
<next:Window id="borgWin" title="业务主管单位" resizable="false" width="600" height="430" modal="true" closeAction="hide" >
		<next:Panel>
				<next:Html>
				<fieldset>

					<form onsubmit="return false"  class="L5form">
						<table width="100%">

							<tr>

								<td class="FieldInput" style="width:17%">
								<input type="text" id="borgNames"   style="width:90%; "/>
								</td>
						<td class="FieldButton" style="width:10%"><button onclick="queryborgName()">查询</button></td>
							</tr>
						</table>
					</form>
				</fieldset>
				</next:Html>
			</next:Panel>
			<next:EditGridPanel id="somBorgGrid" dataset="businessOrganWin" stripeRows="true" width="586" height="85%" autoScroll="true">
				<next:TopBar>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>

				</next:TopBar>
				<next:Columns>
					<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column header="业务主管单位名称" field="borgName" width="35%" editable="false"><next:TextField/></next:Column>
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar dataset="businessOrganWin" />
				</next:BottomBar>
			</next:EditGridPanel>
	<next:Buttons>
		<next:ToolButton text="确定" handler="confirmBorgWin"></next:ToolButton>
		<next:ToolButton text="关闭" handler="closeBorgWin"></next:ToolButton>
	</next:Buttons>
</next:Window>
<script type="text/javascript">
//窗口关闭
function closeBorgWin(){
	var win = L5.getCmp("borgWin");
	win.setVisible(false);
}
function showBorgWin(){
	var businessOrganWin=L5.DatasetMgr.lookup("businessOrganWin");
	businessOrganWin.load();
	var win = L5.getCmp("borgWin");
	win.show();
}
function confirmBorgWin(){
	var grid = L5.getCmp("somBorgGrid");
	var sm = grid.getSelectionModel();
	var record = sm.getSelected();
	if(!record){
		L5.Msg.alert("提示","请选择一条记录!");
		return;
	}
	var borgName = record.get('borgName');
	var borgCode = record.get('borgCode');
	document.getElementById("borgName").value = borgCode;
	document.getElementById("borgNameDispaly").value = borgName;
	if(document.getElementById("ifHis")){
		document.getElementById("ifHis").value=record.get('ifHis');
	}
	var win = L5.getCmp("borgWin");
	win.setVisible(false);
}
function clearBorg(obj){
	if(obj.value == ""){
		document.getElementById("borgName").value = "";
	}
}
function clearDiv(){
	if(_$("borgName") == ""){
		$("borgNameDispaly").value = "";
	}
	if (autoDiv != null && autoDiv != "") {
		autoDiv.style.display = "none";
	}
}



//待办任务查询
function queryborgName(){
	var borgName=document.getElementById('borgNames').value;

businessOrganWin.setParameter("BORG_NAME@like","%"+borgName+"%");

		businessOrganWin.load();

}
</script>