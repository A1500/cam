<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>添加其他抚恤关系省内迁移</title>
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
		if(type == "23") { //三属省内迁移
			url = "../dependant/dependantmigrate/provincemigration/provinceMigrationInsert.jsp";
		} else if(type == "16") {//伤残省内迁移
			url = "../disability/disabilitymigrate/provincemigration/provinceMigrationInsert.jsp";
		} else if(type == "43") {//在乡复员省内迁移
			url = "../demobilized/demoprovincemigrate/demoProvinceMigrationInsert.jsp";
		} else if(type == "47") {//带病回乡省内迁移
			url = "../demobilizedillness/illprovincemigrate/illprovinceMigrationInsert.jsp";
		} else if(type == "53") {//参战省内迁移
			url = "../war/migrate/provincialmigration/provinceMigrationInsert.jsp";
		} else if(type == "63") {//参试省内迁移
			url = "../tested/testedmigrate/provincemigration/provinceMigrationInsert.jsp";
		} else if(type == "B3") {//部分烈士（错杀被平反人员）子女定补关系省内迁移
			url = "../martyroffspring/martymigrate/provincemigration/mprovinceMigrationInsert.jsp";
		} else if(type == "83") {//年满60周岁农村籍退役士兵定补关系省内迁移
			url = "../countretiredsoldier/soldiermigrate/provincemigration/sprovinceMigrationInsert.jsp";
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
								   		<option value="16" selected="selected">添加伤残抚恤省内迁移</option>
								   		<option value="23">添加三属抚恤省内迁移</option>
								   		<option value="43">添加在乡复员抚恤省内迁移</option>
								   		<option value="47">添加带病回乡抚恤省内迁移</option>
								   		<option value="53">添加参战抚恤省内迁移</option>
								   		<option value="63">添加参试抚恤省内迁移</option>
								   		<option value="B3">部分烈士（错杀被平反人员）子女定补关系省内迁移</option>
								   		<option value="83">年满60周岁农村籍退役士兵定补关系省内迁移</option>
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
