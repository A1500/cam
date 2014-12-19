<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%
	String assistanceType=request.getParameter( "assistanceType");
	String ifPeople=request.getParameter( "ifPeople");
	String datasetName="";
	String assistanceTypeCode="";
	if("01".equals(assistanceType)){
		assistanceTypeCode="01,02,03,12,13,14,15,16,17,18,19,20,21,22,23,24,26,27,28,29,30,31,32,33,34,35,36,37,39,40";
	}else if("02".equals(assistanceType)){
		assistanceTypeCode="01,02,03,09,10,13,14,15,16,17,18,19,20,21,22,23,24,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40";
	}else if("03".equals(assistanceType)){
		assistanceTypeCode="01,02,03,09,10,13,14,15,16,17,18,19,20,21,22,23,24,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40";
	}
	if(!"1".equals(ifPeople)){
		datasetName="assistanceTypeDataset";
	}else{
		datasetName="peopleTypeDataset";
		if("01".equals(assistanceType)){
			assistanceTypeCode="";
		}else if("02".equals(assistanceType)){
			assistanceTypeCode="04,05,07";
		}else if("03".equals(assistanceType)){
			assistanceTypeCode="04,05,07";
		}
	}
%>
<model:datasets>
	<!-- 救助类型 -->
	<model:dataset id="assistanceTypeDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" pageSize="20">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_ASSITANCE_TYPE_EXT'></model:param>
			<model:param name="assistanceTypeCode" value='<%=assistanceTypeCode %>'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="peopleTypeDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" global="true" >
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SAM_PEOPLE_TYPE'></model:param>
			<model:param name="assistanceTypeCode" value='<%=assistanceTypeCode %>'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>	
<next:Window title="帮助信息" id="typeWin" height="358" width="430"	closeAction="hide" modal="true">
	<next:Panel>
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem text="查询" iconCls="query" handler="selectType"></next:ToolBarItem>
			<next:ToolBarItem text="确定" iconCls="select" handler="pickType"></next:ToolBarItem>
			<next:ToolBarItem text="关闭" iconCls="return" handler="colseTypeWin"></next:ToolBarItem>
			<next:ToolBarItem text="清除" iconCls="no" handler="removeType"></next:ToolBarItem>
		</next:TopBar>
		<next:Panel>
			<next:Html>
				<table>
					<tr>
						<td class="FieldInput">内容：</td>
						<td class="FieldInput"><input type="text" id="qname" /></td>
					</tr>
				</table>
			</next:Html>
		</next:Panel>
		<next:GridPanel id="typeGrid" dataset="<%=datasetName %>" height="270" notSelectFirstRow="true">
			<next:Columns>
				<next:CheckBoxColumn></next:CheckBoxColumn>
				<next:Column field="value" header="编码" width="90">
					<next:TextField></next:TextField>
				</next:Column>
				<next:Column field="text" header="内容" width="260">
					<next:TextField></next:TextField>
				</next:Column>
			</next:Columns>
			<next:BottomBar>
				<next:PagingToolBar dataset="<%=datasetName %>" />
			</next:BottomBar>
		</next:GridPanel>
	</next:Panel>
</next:Window>		
<script type="text/javascript">
var assistanceType='<%=assistanceType%>';
var ifPeople='<%=ifPeople%>';
//弹出窗口
function openTypeWin(){
	if(ifPeople!='1'){
		assistanceTypeDataset.load();
	}else{
		peopleTypeDataset.load();
	}
	var typeWin=L5.getCmp("typeWin");
	typeWin.show();	
}
//查询
function selectType(){
	if(ifPeople!='1'){
		assistanceTypeDataset.setParameter("filterSql"," NAME like '%"+_$('qname')+"%' ");
		assistanceTypeDataset.load();
	}else{
		peopleTypeDataset.setParameter("filterSql"," NAME like '%"+_$('qname')+"%' ");
		peopleTypeDataset.load();
	}
}
//选择数据，并回填
function pickTypeInfo(displayName,hiddenValue){
	var typeGrid=L5.getCmp("typeGrid");
	var cell=typeGrid.getSelectionModel().getSelections();
	if(cell.length<1){
		L5.Msg.alert("提示","请至少选择一条要查看的记录！");
		return;
	}
	document.getElementById(hiddenValue).value="";
	document.getElementById(displayName).value="";
	for(var i=0;i<cell.length;i++){
		if(document.getElementById(hiddenValue).value==""){			
			document.getElementById(hiddenValue).value += cell[i].get("value");
			document.getElementById(displayName).value += cell[i].get("text");
		}else{	
			document.getElementById(hiddenValue).value += (','+cell[i].get("value"));
			document.getElementById(displayName).value += (','+cell[i].get("text"));
		}
	}
	colseTypeWin();
}
//关闭窗口
function colseTypeWin(){
	var typeWin=L5.getCmp("typeWin");
	typeWin.hide();
}
//清除按钮
function removeTypeInfo(displayName,hiddenValue){
	document.getElementById(hiddenValue).value="";
	document.getElementById(displayName).value="";
	colseTypeWin();
}
	
function pickType(){
	if(ifPeople!='1'){
		pickTypeInfo("assistanceTypeName","assistanceType");
	}else{
		pickTypeInfo("peopleTypeName","peopleType");
	}
}
function removeType(){
	if(ifPeople!='1'){
		removeTypeInfo("assistanceTypeName","assistanceType");
	}else{
		removeTypeInfo("peopleTypeName","peopleType");
	}
}
</script>