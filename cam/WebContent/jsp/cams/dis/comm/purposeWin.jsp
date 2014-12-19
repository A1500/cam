<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<next:Window title="资金用途信息" id="typeWin" height="358" width="430"	closeAction="hide" modal="true" hidden="true">
	<next:Panel>
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem text="确定" iconCls="select" handler="pickType"></next:ToolBarItem>
			<next:ToolBarItem text="关闭" iconCls="return" handler="colseTypeWin"></next:ToolBarItem>
		</next:TopBar>
		<next:GridPanel id="typeGrid" dataset="allocationPurposeSelect" height="270" notSelectFirstRow="true">
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
				<next:PagingToolBar dataset="allocationPurposeSelect" />
			</next:BottomBar>
		</next:GridPanel>
	</next:Panel>
</next:Window>	
<script type="text/javascript">
//弹出窗口
function openTypeWin(){
	var typeWin=L5.getCmp("typeWin");
	typeWin.show();	
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
			ds.set(hiddenValue,document.getElementById(hiddenValue).value);
		}else{	
			document.getElementById(hiddenValue).value += (','+cell[i].get("value"));
			document.getElementById(displayName).value += (','+cell[i].get("text"));
			ds.getCurrent().set(hiddenValue,document.getElementById(hiddenValue).value);
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
</script>