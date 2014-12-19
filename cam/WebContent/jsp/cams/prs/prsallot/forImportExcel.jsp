<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>导入士兵信息</title>
<next:ScriptManager/>
</head>
<body>
<model:datasets>
	<model:dataset id="excelImportDataSet"
		cmd="com.inspur.cams.prs.prsretiredsoldiers.cmd.DetailExcelImportCmd">
		<model:record
			fromBean="com.inspur.cams.prs.prsretiredsoldiers.dao.PrsRetiredSoldiers"></model:record>
	</model:dataset>
</model:datasets>
<next:Panel>
	<next:TopBar>
		<next:ToolBarItem symbol="导入士兵信息"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="导入" handler="importJzfamxExcel" />
		<next:ToolBarItem iconCls="undo" text="返回" handler="backToPre" />
	</next:TopBar>
	<next:Html>
		<form id="upLoadFileForm" method="post" dataset="excelImportDataSet"
			onsubmit="return false"  class="L5form">
		<table width="100%" border="1">
			<tr>
				<td class="FieldLabel" width="20%">请选择要导入的Excel文件:</td>
				<td class="FieldInput" width="80%"><input type="file" maxlength="100"
					id="uploadFile" name="uploadFile" style ="width:300"/></td>
			</tr>
		</table>
		<input type="hidden" name="planId" value='<%=request.getParameter("planId")%>'>
		</form>
	</next:Html>
</next:Panel>
</body>
<script language="javascript">
function init(){
	var excelImportDataSet = L5.DatasetMgr.lookup("excelImportDataSet");
	excelImportDataSet.newRecord();
}
//导入救助方案明细Excel
function importJzfamxExcel() {
	//首先校验选择文件
	var files = document.forms[0].uploadFile;
	if(files.value == " " || files.value == ""){
		L5.MessageBox.alert("提示", "请选择要导入的用户文件！");
		return;
	}
	if(files.value.lastIndexOf(".xls") == -1){
		L5.MessageBox.alert("提示", "请选择文件格式为*.xls的文件！");
		return;
	}
	var excelImportDataSet = L5.DatasetMgr.lookup("excelImportDataSet");
	
	var record = excelImportDataSet.getCurrent();
	var command = new L5.Command("com.inspur.cams.prs.prsretiredsoldiers.cmd.DetailExcelImportCmd");	
	command.setForm(L5.getDom("upLoadFileForm"));
    command.setParameter("upLoadViewRecord", record);
    
    command.execute("importSoldierExcel");
   
    command.afterExecute=function(){
            	  if (!command.error) {
  					  var count = command.getReturn("count");
   
            		L5.Msg.alert("提示", "成功导入"+count+"条数据!", function(){
            			//转向查询页面
              			var url="/jsp/cams/prs/prsallot/prsretiredsoldiers_list.jsp";
              			L5.forward(url, "士兵信息");
                		});
          		}else{
          			L5.Msg.alert("错误:", command.error);
          		}
    }
}
function backToPre() {
	var returnJsp='<%=request.getParameter("returnJsp")%>'
	var planId = document.all.planId.value;
	var text = "";
	var url="/jsp/cams/prs/prsallot/prsretiredsoldiers_list.jsp";
	L5.forward(url, text);
}
</script>
</html>