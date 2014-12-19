<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>添加其他抚恤关系跨省迁入</title>
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
		if(type == "15") { //伤残跨省迁入
			url="../disability/disabilitymigrate/ingoingprovince/intoProviInsert.jsp?method=INSERT";
		} else if(type == "22") { //三属跨省迁入
			url = "../dependant/dependantmigrate/ingoingprovince/intoProviInsert.jsp";
		} else if(type == "42") {//在乡复员跨省迁入
			url = "../demobilized/demoingoingprovince/demobilizedInsert.jsp?method=INSERT";
		} else if(type == "46") {//带病回乡跨省迁入
			url = "../demobilizedillness/illingoingmigrate/demobilizedIllnessInsert.jsp?method=INSERT";
		} else if(type == "62") {//参试跨省迁入
			url = "../tested/testedmigrate/ingoingprovince/intoProviInsert.jsp";
		} else if(type == "52") {//参战跨省迁入
			url = "../war/migrate/ingoingprovince/intoProviInsert.jsp?method=INSERT";
		} else if(type == "82") {//年满60周岁农村籍退役士兵定补关系跨省迁入
			url = '../countretiredsoldier/soldiermigrate/ingoingprovince/sintoProviInsert.jsp';
		} else if(type == "B2") {//部分烈士（错杀被平反人员）子女定补关系跨省迁入
			url = '../martyroffspring/martymigrate/ingoingprovince/mintoProviInsert.jsp';
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
								   		<option value="15" selected="selected">添加伤残抚恤跨省迁入</option>
								   		<option value="22">添加三属抚恤跨省迁入</option>
								   		<option value="42">添加在乡复员抚恤跨省迁入</option>
								   		<option value="46">添加带病回乡抚恤跨省迁入</option>
								   		<option value="52">添加参战抚恤跨省迁入</option>
								   		<option value="62">添加参试抚恤跨省迁入</option>
								   		<option value="82">年满60周岁农村籍退役士兵定补关系跨省迁入</option>
								   		<option value="B2">添加部分烈士（错杀被平反人员）子女定补关系跨省迁入</option>
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
				frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="yes" allowtransparency="yes" width="100%" height="100%">
	 	   </iframe>
	 </next:Html>
</next:Panel>   
</body>
</html>
