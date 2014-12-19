<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<script type="text/javascript" src="<%=SkinUtils.getRootUrl(request)%>jsp/cams/comm/dicm/autoComplete.js"></script>
<link href="<%=SkinUtils.getRootUrl(request)%>jsp/cams/comm/dicm/autoComplete.css" rel="stylesheet" type="text/css" />
<model:datasets>
	<model:dataset id="countryDataSetWin" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true" sortField="SORT_NO">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_COUNTRY'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="countrySelectDic" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true" sortField="SORT_NO">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_COUNTRY'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
 <model:dataset id="countryQueryDic" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true" sortField="SORT_NO">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_COUNTRY'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
<!-- 国籍 -->
<next:Window id="countryWin" title="国籍" resizable="false" width="300" height="430" modal="true" closeAction="hide" >
			<next:EditGridPanel id="countryGrid" dataset="countryDataSetWin" stripeRows="true" width="100%" height="85%" autoScroll="true">
				<next:TopBar>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
				</next:TopBar>
				<next:Columns>
					<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column header="国籍" field="text"  editable="false"><next:TextField/></next:Column>
				</next:Columns>
			</next:EditGridPanel>
	<next:Buttons>
		<next:ToolButton text="确定" handler="confirmCountryWin"></next:ToolButton>
		<next:ToolButton text="关闭" handler="closeCountryWin"></next:ToolButton>
	</next:Buttons>
</next:Window>
<script type="text/javascript">
//窗口关闭
function closeCountryWin(){
	var win = L5.getCmp("countryWin");
	win.setVisible(false);
}
function showCountryWin(){
	var win = L5.getCmp("countryWin");
	win.show();
}
function confirmCountryWin(){
	var grid = L5.getCmp("countryGrid");
	var sm = grid.getSelectionModel();
	var record = sm.getSelected();
	if(!record){
		L5.Msg.alert("提示","请选择一条记录!");
		return;
	}
	var nation = record.get('text');
	var countryCode = record.get('value');
	document.getElementById("nation").value = countryCode;
	document.getElementById("nationDispaly").value = nation;
	var win = L5.getCmp("countryWin");
	win.setVisible(false);
}
function clearCountry(obj){
	if(obj.value == ""){
		document.getElementById("nation").value = "";
	}
}
function clearCountryDiv(){
	if(_$("nation") == ""){
		$("nationDispaly").value = "";
	}
	if (countryDiv != null && countryDiv != "") {
		countryDiv.style.display = "none";
	}
}
</script>