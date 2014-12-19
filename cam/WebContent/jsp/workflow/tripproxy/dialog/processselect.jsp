<%@page import="org.loushang.workflow.util.WfPageBtnDefApi"%>
<%@page import="org.loushang.sca.ScaComponentFactory"%>
<%@page	import="org.loushang.workflow.processdefinition.procdefpagebuttondef.domain.IProcDefPageButtonDefDomain"%>
<%@page import="org.loushang.next.data.Record"%>
<%@page import="org.loushang.next.data.ParameterSet"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="org.loushang.workflow.util.bsp.WfStru"%>
<%@page import="org.loushang.workflow.util.bsp.BspUtil"%>
<%
WfStru rootStru = BspUtil.getInstance().getTopMember("00"); 
String rootStruId = rootStru.getStruId();
%>

<html>
<head>
<title>流程定义查询</title>
<next:ScriptManager></next:ScriptManager>
<script language="javascript" type="text/javascript">
			//通过下面的一行代码为js中的updateOrganPro传参数组织机构根节点
		     var rootStruId = '<%=rootStruId%>';
		 	 //查询条件面板打开合并函数
			 function collapse(element){
				var fieldsetParent=L5.get(element).findParent("fieldset");
				if(element.expand==null||element.expand==true){	
					fieldsetParent.getElementsByTagName("div")[0].style.display="none";
					element.src = '<%=SkinUtils.getImage(request,"groupbox_expand.gif")%>';
					element.expand=false;
				}else{
					fieldsetParent.getElementsByTagName("div")[0].style.display="";
					element.src = "<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>";
					element.expand =true;
				}
			}

			// 流程定义查询
			function query() {
				var procDefDataset = L5.DatasetMgr.lookup("procDefDataset");
				var procDefName = document.getElementById("procDefName").value;
				if(procDefName.indexOf("'")!=-1){
					  L5.Msg.alert("提示", "不接受单引号输入!");
					  return;
				}
				if (procDefName == "")
					procDefName = undefined;// 如果没有只就设为undifined对应java的null
				
				procDefDataset.setParameter("PROC_DEF_NAME",procDefName);// 设置参数值,用@分开的两段：前面是参数名,后面是比较符号				
				procDefDataset.load();
			}		
			var smObj = {};		
			function init() {
				query();
				var procDefDataset = L5.DatasetMgr.lookup("procDefDataset");
				var sm = L5.getCmp("proxyGridPanel").getSelectionModel();
				sm.on("rowselect",function(sm,i,r){
					smObj[r.get("procDefId")] = r.get("name");
				});
				sm.on("rowdeselect",function(sm,i,r){
					smObj[r.get("procDefId")] = false;
					delete smObj[r.get("procDefId")];
				});
				procDefDataset.on("load",function(ds){
					var sel = [];
					for(var t in smObj){
						sel[sel.length] = ds.find("procDefId",t);
					}
					sm.selectRows(sel);
				});
			}
						
		</script>
</head>
<body>

<model:datasets>
	<model:dataset pageSize="10" id="procDefDataset"
		cmd="org.loushang.workflow.processdefinition.cmd.ProcessDefinitionQueryCmd" method="query">
		<model:record fromBean="org.loushang.workflow.processdefinition.data.ProcessDef"></model:record>
	</model:dataset>
</model:datasets>

<next:ViewPort>
	<next:Defaults>{collapsible:true,split:true,animFloat:true,autoHide:true,useSplitTips:true,bodyStyle:'padding:6px;'}</next:Defaults>
	<next:Panel>
		<next:Panel width="100%" border="0"
			bodyStyle="padding-bottom:10px;padding-top:0px;">
			<next:Html>
				<fieldset style="overflow: visible;" class="GroupBox"><legend
					class="GroupBoxTitle">查询条件 <img
					class="GroupBoxExpandButton"
					src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>"
					onclick="collapse(this);" /> </legend>
				<div class="GroupBoxDiv" style="width: 100%; height: 100%;">
				<form onsubmit="return false;" class="L5form">
				<table border="1" width="100%">
					<tr>
						<td class="FieldLabel">流程名称：</td>
						<td class="FieldInput"><input type="text" id="procDefName"
							class="TextEditor" title="流程名称" /></td>											
						<td class="FieldButton" rowspan="2">
						<button onclick="query()">查询</button>
						</td>
					</tr>
				</table>
				</form>
				</div>
				</fieldset>
			</next:Html>
		</next:Panel>
		<next:GridPanel id="proxyGridPanel" name="proxyGridPanel" anchor="100%"
			width="100%" height="100%" dataset="procDefDataset"    
			title="流程定义列表" notSelectFirstRow="true">
			<next:Columns>
				<next:RowNumberColumn width="30" />
				<next:CheckBoxColumn></next:CheckBoxColumn>
				<next:Column id="id" header="内码" field="procDefId" width="50" hidden="true">
					<next:TextField allowBlank="false" />
				</next:Column>
				<next:Column header="流程名称" field="name" width="250">
					<next:TextField allowBlank="false" />
				</next:Column>
			</next:Columns>
			  <next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="add" text="确定" handler="forSure" />
				<next:ToolBarItem iconCls="remove" text="关闭"
					handler="forClose" />
			</next:TopBar>
			<next:BottomBar>
				<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条"
					displayInfo="true" dataset="procDefDataset" />
			</next:BottomBar>
		</next:GridPanel>
	</next:Panel>
</next:ViewPort>
</body>
<script language="javascript" type="text/javascript">
function forSure(){	
	var proxyGridPanel = L5.getCmp("proxyGridPanel");
	var selected = proxyGridPanel.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.MessageBox.alert("消息提示","请选择至少一条记录");
		return false;
	}
	var returnValue=[];
	var procDefIds="";
	var names="";
	var i=0;
	for(var t in smObj){
		if(i==0){
			procDefIds+=t;
			names+=smObj[t];
			i++;
		}else{
			procDefIds+=","+t;
			names+=","+smObj[t];
		}
	}
	
	returnValue[0]=procDefIds;
	returnValue[1]=names;
	
	window.returnValue = returnValue;
	window.close();
}
function forClose(){
	window.returnValue="";
	window.close();

}
function forClear(){
	var returnValue=[];
	returnValue[0] = "";
	window.returnValue = returnValue;
	window.close();
}
</script>
</html>