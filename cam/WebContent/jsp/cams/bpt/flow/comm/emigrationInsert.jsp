<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>添加其他抚恤关系跨省迁出</title>
<next:ScriptManager />
<script type="text/javascript">
	function init() {
		changeTab();
	}

	function changeTab() {
		var type = document.getElementById("serviceType").value;
		var options = document.getElementById("serviceType");
		var title = "";
		var url = "";
		for(var i=0;i<options.length;i++) {
			if(options[i].value == type) {
				title = options[i].text;
				break;
			}
		}
		if (type == "19") { //伤残跨省迁出
			url = "../disability/disabilitymigrate/emigration/emigrationInsert.jsp";
		} else if(type == "25") { //三属跨省迁出
			url = "../dependant/dependantmigrate/emigration/emigrationInsert.jsp";
		} else if(type == "4A") {//在乡复员跨省迁出
			url = "../demobilized/demobilizedmigrate/demomigrationInsert.jsp";
		} else if(type == "4B") {//带病回乡跨省迁出
			url = "../demobilizedillness/illmigrate/illMigrationInsert.jsp";
		} else if(type == "55") {//参战跨省迁出
			url = "../war/migrate/emigration/emigrationInsert.jsp";
		} else if(type == "65") {//参试跨省迁出
			url = "../tested/testedmigrate/emigration/emigrationInsert.jsp";
		} else if(type == "B4") {//部分烈士（错杀被平反人员）子女定补关系跨省迁出
			url = "../martyroffspring/martymigrate/emigration/martyEmigrationInsert.jsp";
		} else if(type == "84") {//60岁退役士兵跨省迁出
			url = "../countretiredsoldier/soldiermigrate/emigration/sEmigrationInsert.jsp";
		} 
		document.getElementById("migrationInsert").src=url;
		L5.getCmp("pageTab").setTitle(title);
	}
</script>
</head>
<body>
<next:Panel    width="100%" border="0"   autoScroll="true" autoHeight="true" >
	<next:Html>
		<fieldset style="overflow: visible;" class="GroupBox">
	    <legend class="GroupBoxTitle">请选择</legend>
				<div>
					<form style="width: 98%; height: 100%;" class="L5form">
						<table  border="1" width="100%" >
						<tr>		
								<td class="FieldLabel" width="20%" nowrap="nowrap">优抚对象类别：</td>
								<td class="FieldInput">
									<select id="serviceType" style="width:180px;" onchange="changeTab()">
								   		<option value="19" selected="selected">添加伤残抚恤跨省迁出</option>
								   		<option value="25">添加三属抚恤跨省迁出</option>
								   		<option value="4A">添加在乡复员抚恤跨省迁出</option>
								   		<option value="4B">添加带病回乡抚恤跨省迁出</option>
								   		<option value="55">添加参战抚恤跨省迁出</option>
								   		<option value="65">添加参试抚恤跨省迁出</option>
								   		<option value="B4">部分烈士（错杀被平反人员）子女定补关系跨省迁出</option>
								   		<option value="84">年满60周岁农村籍退役士兵定补关系跨省迁出</option>
		   							</select>
						 			</td>
						</tr>		
						</table>
					</form>
				</div>
				</fieldset>
	 </next:Html>
</next:Panel> 
<next:Panel title="添加三属抚恤省内迁移" id="pageTab"  width="100%"   autoScroll="true"    height="100%"> 
 	<next:Html>
		   <iframe id="migrationInsert" src=""
				frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	 	   </iframe>
	 </next:Html>
</next:Panel>   
</body>
</html>
