<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<script type="text/javascript" src="<%=SkinUtils.getRootUrl(request)%>jsp/cams/comm/dicm/autoComplete.js"></script>
<link href="<%=SkinUtils.getRootUrl(request)%>jsp/cams/comm/dicm/autoComplete.css" rel="stylesheet" type="text/css" />
<model:datasets>
	<model:dataset id="dutyDataSetWin" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true" sortField="CODE">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_DUTY'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="dutySelectDic" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true" sortField="CODE">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_DUTY'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
 <model:dataset id="dutyQueryDic" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true" sortField="CODE">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_DUTY'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
<!-- 职务 -->
<next:Window id="dutyWin" title="职务" resizable="false" width="300" height="430" modal="true" closeAction="hide" >
			<next:EditGridPanel id="dutyGrid" dataset="dutyDataSetWin" stripeRows="true" width="95%" height="85%" autoScroll="true">
				<next:TopBar>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
				</next:TopBar>
				<next:Columns>
					<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column header="职务" field="text"  editable="false"><next:TextField/></next:Column>
				</next:Columns>
			</next:EditGridPanel>
	<next:Buttons>
		<next:ToolButton text="确定" handler="confirmdutyWin"></next:ToolButton>
		<next:ToolButton text="关闭" handler="closedutyWin"></next:ToolButton>
	</next:Buttons>
</next:Window>
<script type="text/javascript">
//窗口关闭
function closedutyWin(){
	var win = L5.getCmp("dutyWin");
	win.setVisible(false);
}
function showdutyWin(){
	var win = L5.getCmp("dutyWin");
	win.show();
}
function confirmdutyWin(){
	var grid = L5.getCmp("dutyGrid");
	var sm = grid.getSelectionModel();
	var record = sm.getSelected();
	if(!record){
		L5.Msg.alert("提示","请选择一条记录!");
		return;
	}
	var nation = record.get('text');
	var dutyCode = record.get('value');
	document.getElementById("sorgDuties").value = dutyCode;
	document.getElementById("sorgDutiesNameDispaly").value = nation;
	var win = L5.getCmp("dutyWin");
	win.setVisible(false);
}
function clearduty(obj){
	if(obj.value == ""){
		document.getElementById("nation").value = "";
	}
}
function cleardutyDiv(){
	if(_$("sorgDuties") == ""){
		$("sorgDutiesNameDispaly").value = "";
	}
	if (autoDiv != null && autoDiv != "") {
		autoDiv.style.display = "none";
	}
}
</script>