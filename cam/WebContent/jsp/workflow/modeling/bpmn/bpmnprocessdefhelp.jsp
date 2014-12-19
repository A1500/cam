<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="org.loushang.workflow.util.bsp.WfStru"%>
<%@page import="org.loushang.workflow.util.bsp.BspUtil"%>
<%@page import="org.loushang.sca.ScaComponentFactory"%>
<%@page import="org.loushang.next.data.Record"%>
<%@page import="org.loushang.next.data.ParameterSet"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="java.util.List"%>
<%
	WfStru rootStru = BspUtil.getInstance().getTopMember("00"); 
	String rootStruId = rootStru.getStruId();
%>
<html>
<head>
<title>BPMN流程定义查询</title>
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
			//流程版本
			function setProcVersionText(rec)
			{
				if(rec=="1"){
			   		return "旧版本";
			   	}else{
			   		return "新版本";
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

				var version = document.getElementById("version").value;
				var isHistory = "";
				if (version != null && version == "newversion") {
					isHistory = "0";//
				} else if (version != null && version == "oldversion")
					isHistory = "1";//
				else {
					isHistory = undefined;
				}
				procDefDataset.setParameter("WF_PROCESS_DEF_MODELING_BPMN.PROC_DEF_NAME@like",
						procDefName);// 设置参数值,用@分开的两段：前面是参数名,后面是比较符号
				procDefDataset.setParameter("WF_PROCESS_DEF_MODELING_BPMN.IS_HISTORY@like",
						isHistory);
				procDefDataset.setParameter("WF_PROCESS_DEF_MODELING_BPMN.IS_HIGH_LEVEL@=",
						'1');

				procDefDataset.load();
			}	
			
			function init() {
				query();
			}

			function confirmSelect(){
				var userGridPanel = L5.getCmp("userGridPanel");
				var selecteds = userGridPanel.getSelectionModel().getSelections();
                if(selecteds.length!=1){
                	L5.Msg.alert("提示：","请选择一个模板!");
                    return;
                    }
                window.returnValue=selecteds[0].get("id");
                window.close();
			}
						
		</script>
</head>
<body>

<model:datasets>
	<model:dataset pageSize="10" id="procDefDataset"
		cmd="org.loushang.workflow.modeling.definition.cmd.BPMNProcessDefinitionModelingQueryCmd">
		<model:record excluding="modelingContent,extensionContent"
			fromBean="org.loushang.workflow.modeling.definition.data.BPMNProcessDefinitionModeling"></model:record>
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
						<td class="FieldLabel">流程版本：</td>
						<td class="FieldInput"><select type="text" value="newversion"
							id="version" class="TextEditor" title="流程版本">
							<option value="newversion">新版本</option>
							<option value="all">全部</option>
							<option value="oldversion">旧版本</option>
						</select></td>
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
		<next:GridPanel id="userGridPanel" name="userGridPanel" anchor="100%"
			width="100%" height="100%" dataset="procDefDataset"    
			title="流程定义列表" notSelectFirstRow="true">

			<next:Columns>
				<next:RowNumberColumn width="30" />
				<next:CheckBoxColumn></next:CheckBoxColumn>
				<next:Column id="id" header="内码" field="id" width="50" hidden="true">
					<next:TextField allowBlank="false" />
				</next:Column>
				<next:Column header="流程名称" field="procDefName" width="150">
					<next:TextField allowBlank="false" />
				</next:Column>
				<next:Column header="创建时间" field="createTime" width="150">
					<next:TextField allowBlank="false" />
				</next:Column>
				<next:Column header="流程类型" field="processType" width="150"
					hidden="true">
					<next:TextField allowBlank="false" />
				</next:Column>
				<next:Column header="流程类型名称" field="processTypeName" width="250">
					<next:TextField allowBlank="false" />
				</next:Column>
				<next:Column id="isHistory" header="流程版本" field="isHistory"
					renderer="setProcVersionText" width="100">
					<next:TextField allowBlank="false" />
				</next:Column>
			</next:Columns>
			<next:TopBar>
				<next:ToolBarItem iconCls="add" text="确定"	handler="confirmSelect" />
			</next:TopBar>
			<next:BottomBar>
				<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条"
					displayInfo="true" dataset="procDefDataset" />
			</next:BottomBar>
		</next:GridPanel>
	</next:Panel>
</next:ViewPort>
</body>
</html>