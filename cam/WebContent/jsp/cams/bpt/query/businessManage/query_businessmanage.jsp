<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<html>
<head>
<script>
	var xzqu = '<%=request.getParameter("xzqu")%>';
	var cxsjq = '<%=request.getParameter("cxsjq")%>';
	var cxsjz = '<%=request.getParameter("cxsjz")%>';
	var pageflag ='<%=request.getParameter("pageflag")%>';
	var organCode = '<%=BspUtil.getOrganCode()%>';
	var organName = '<%=BspUtil.getOrganName()%>';
	var currentUserName = '<%= GetBspInfo.getBspInfo().getUserName()%>';
</script>
<next:ScriptManager />
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "ISPrint.js") %>"></script>
<script type="text/javascript" src="query_businessmanage.js"></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
	<script type="text/javascript" src="../../comm/bptComm.js"></script>
<style>

body {
	background-color: #EAF4FD;
}

table {
	border-collapse: collapse;
}

input {
	background-color: #EAF4FD;
	border-style: none;
	text-align: right;
}
td {
	border-style: solid;
	border-color: #000000;
	border-width: 1px;
}
.tdTitle {
	border-style: solid;
	border-color: #000000;
	border-width: 1.5px;
	font-weight: bold;
}

.tdIma {
	background-image: url(line.bpm);
	background-repeat: no-repeat;
}
</style>
<script language="javascript">
 	 //查询条件打开合并函数
	 function collapse(element){
		var fieldsetParent=L5.get(element).findParent("fieldset");
		if(element.expand==null||element.expand==true){
			fieldsetParent.getElementsByTagName("div")[0].style.display="none";
			element.src = '<%=SkinUtils.getImage(request, "groupbox_expand.gif")%>';
			element.expand=false;
		}else{
			fieldsetParent.getElementsByTagName("div")[0].style.display="";
			element.src = "<%=SkinUtils.getImage(request, "groupbox_collapse.gif")%>";
			element.expand =true;
		}
	}
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="ds"
		cmd="com.inspur.cams.bpt.query.cmd.BptBusinessManageQueryCmd"
		global="true" autoLoad="false">
		<model:record>
			<model:field name="organ_code" type="string" />
			<model:field name="organ_name" type="string" />
			<model:field name="disability_assess" type="string" />
			<model:field name="disability_adjust" type="string" />
			<model:field name="disability_exchace" type="string" />
			<model:field name="disability_migrate" type="string" />
			<model:field name="dependant_assess" type="string" />
			<model:field name="dependant_migrate" type="string" />
			<model:field name="demobilize_assess" type="string" />
			<model:field name="demobilize_migrate" type="string" />
			<model:field name="demobilizeill_assess" type="string" />
			<model:field name="demobilizeill_migrate" type="string" />
			<model:field name="war_assess" type="string" />
			<model:field name="war_migrate" type="string" />
			<model:field name="tested_assess" type="string" />
			<model:field name="tested_migrate" type="string" />
			<model:field name="mon_count" type="string" />
			<model:field name="disability_count" type="string" />
			<model:field name="dependant_count" type="string" />
			<model:field name="demobilize_count" type="string" />
			<model:field name="demobilizeill_count" type="string" />
			<model:field name="war_count" type="string" />
			<model:field name="tested_count" type="string" />
			
			<model:field name="soldier_assess" type="string" />
			<model:field name="soldier_migrate" type="string" />
			<model:field name="soldier_count" type="string" />
			<model:field name="martyr_assess" type="string" />
			<model:field name="martyr_migrate" type="string" />
			<model:field name="martyr_count" type="string" />
		</model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>

	<next:Panel  width="100%" border="0"
		bodyStyle="background-color:#EAF4FD;padding-bottom:10px;padding-top:12px;"
		height="100%" autoScroll="true">
		<next:Html>
			<div align="center" id="reDiv" style="display: none;" >
			
				<div align="center" style="width: 80%;">
					<div align="center"><span id="reportTitle"
						style="font-size: large;">优抚业务办理情况统计</span></div>
					<div align="right" class="L5form" ><button    onclick="printBill()">打印</button></div>
					<br />
					<div align="right"><span style="font-size: small;">编制单位：<%=BspUtil.getOrganName()%></span></div>
				</div>
				<table width="1380" dataset="ds" align="center" style="margin-left:40px;margin-right:40px;">
				<tr>
					<td class="tdTitle" width="120" rowspan="2">单位</td>
					<td class="tdTitle" width="60"  rowspan="2">总计</td>
					<td class="tdTitle" align="center" colspan="5">伤残人员</td>
					<td class="tdTitle" align="center" colspan="3">三属人员</td>
					<td class="tdTitle" align="center" colspan="3">复员军人</td>
					<td class="tdTitle" align="center" colspan="3">带病回乡退役人员</td>
					<td class="tdTitle" align="center" colspan="3">参战人员</td>
					<td class="tdTitle" align="center" colspan="3">参试人员</td>
					<td class="tdTitle" align="center" colspan="3">60岁退役士兵</td>
					<td class="tdTitle" align="center" colspan="3">烈士子女</td>
				</tr>
				<tr>
					<td class="tdTitle" width="60" align="center">评残</td>
					<td class="tdTitle" width="60" align="center">调残</td>
					<td class="tdTitle" width="60" align="center">换证<br/>补证</td>
					<td class="tdTitle" width="60" align="center">迁移</td>
					<td class="tdTitle" width="60" align="center">小计</td>
					
					<td class="tdTitle" width="60" align="center">评定</td>
					<td class="tdTitle" width="60" align="center">迁移</td>
					<td class="tdTitle" width="60" align="center">小计</td>

					<td class="tdTitle" width="60" align="center">评定</td>
					<td class="tdTitle" width="60" align="center">迁移</td>
					<td class="tdTitle" width="60" align="center">小计</td>
					
					<td class="tdTitle" width="60" align="center">评定</td>
					<td class="tdTitle" width="60" align="center">迁移</td>
					<td class="tdTitle" width="60" align="center">小计</td>
					
					<td class="tdTitle" width="60" align="center">评定</td>
					<td class="tdTitle" width="60" align="center">迁移</td>
					<td class="tdTitle" width="60" align="center">小计</td>
					
					<td class="tdTitle" width="60" align="center">评定</td>
					<td class="tdTitle" width="60" align="center">迁移</td>
					<td class="tdTitle" width="60" align="center">小计</td>
					
					<td class="tdTitle" width="60" align="center">评定</td>
					<td class="tdTitle" width="60" align="center">迁移</td>
					<td class="tdTitle" width="60" align="center">小计</td>
					
					<td class="tdTitle" width="60" align="center">评定</td>
					<td class="tdTitle" width="60" align="center">迁移</td>
					<td class="tdTitle" width="60" align="center">小计</td>
				</tr>
				<tr repeat="true">
					<td style="display: none">
								<label readonly="true" field="organ_code" /></label>
							</td>
					<td nowrap align="left" class="td"><a href="#"><label id="test" field="organ_name"  onclick="test(this)" readonly="true"  style="line-height:20px;"/></label>
						<label id="code" field="organ_code"  style="display:none" readonly="true" /></label></a></td>
					<td nowrap align="right" class="td"><a href="#" style="cursor:hand"><label  
						onclick="redirect(this,'')" field="mon_count" ></label></a></td>
					<td nowrap align="right" class="td"><a href="#" style="cursor:hand"><label  
						onclick="redirect(this,'11,14')" field="disability_assess" ></label></a></td>
					<td nowrap align="right" class="td"><a href="#" style="cursor:hand"><label  
						onclick="redirect(this,'12')" field="disability_adjust"  ></label></a></td>
					<td nowrap align="right" class="td"><a href="#" style="cursor:hand"><label
						onclick="redirect(this,'13')" field="disability_exchace" ></label></a></td>
					<td nowrap align="right" class="td"><a href="#" style="cursor:hand"><label  
						onclick="redirect(this,'15,16,19')" field="disability_migrate" ></label></a></td>
					<td nowrap align="right" class="td"><a href="#" style="cursor:hand"><label  
						onclick="redirect(this,'11,12,13,14,15,16,19')" field="disability_count" ></label></a></td>
					<td nowrap align="right" class="td"><a href="#" style="cursor:hand"><label
						onclick="redirect(this,'2')" field="dependant_assess"></label></a></td>
					<td nowrap align="right" class="td"><a href="#" style="cursor:hand"><label
						onclick="redirect(this,'22,23,25')" field="dependant_migrate" ></label></a></td>
					<td nowrap align="right" class="td"><a href="#" style="cursor:hand"><label  
						onclick="redirect(this,'2,22,23,25')" field="dependant_count" ></label></a></td>
					<td nowrap align="right" class="td"><a href="#" style="cursor:hand"><label 
						onclick="redirect(this,'41')" field="demobilize_assess"></label></a></td>
					<td nowrap align="right" class="td"><a href="#" style="cursor:hand"><label
						onclick="redirect(this,'42,43,4A')" field="demobilize_migrate" ></label></a></td>
					<td nowrap align="right" class="td"><a href="#" style="cursor:hand"><label  
						onclick="redirect(this,'41,42,43,4A')" field="demobilize_count" ></label></a></td>
					<td nowrap align="right" class="td"><a href="#" style="cursor:hand"><label
						onclick="redirect(this,'45')" field="demobilizeill_assess" ></label></a></td>
					<td nowrap align="right" class="td"><a href="#" style="cursor:hand"><label  
						onclick="redirect(this,'46,47,4B')" field="demobilizeill_migrate"></label></a></td>
					<td nowrap align="right" class="td"><a href="#" style="cursor:hand"><label  
						onclick="redirect(this,'45,46,47,4B')" field="demobilizeill_count" ></label></a></td>
					<td nowrap align="right" class="td"><a href="#" style="cursor:hand"><label
						onclick="redirect(this,'5')" field="war_assess" ></label></a></td>
					<td nowrap align="right" class="td"><a href="#" style="cursor:hand"><label
						onclick="redirect(this,'52,53,55')" field="war_migrate" ></label></a></td>
					<td nowrap align="right" class="td"><a href="#" style="cursor:hand"><label  
						onclick="redirect(this,'5,52,53,55')" field="war_count" ></label></a></td>
					<td nowrap align="right" class="td"><a href="#" style="cursor:hand"><label
						onclick="redirect(this,'6')" field="tested_assess" ></label></a></td>
					<td nowrap align="right" class="td"><a href="#" style="cursor:hand"><label
						onclick="redirect(this,'62,63,65')" field="tested_migrate" ></label></a></td>
					<td nowrap align="right" class="td"><a href="#" style="cursor:hand"><label  
						onclick="redirect(this,'6,62,63,65')" field="tested_count" ></label></a></td>
						
					<td nowrap align="right" class="td"><a href="#" style="cursor:hand"><label
						onclick="redirect(this,'81')" field="soldier_assess" ></label></a></td>
					<td nowrap align="right" class="td"><a href="#" style="cursor:hand"><label
						onclick="redirect(this,'82,83,85')" field="soldier_migrate" ></label></a></td>
					<td nowrap align="right" class="td"><a href="#" style="cursor:hand"><label  
						onclick="redirect(this,'81,82,83,84')" field="soldier_count" ></label></a></td>
						
					<td nowrap align="right" class="td"><a href="#" style="cursor:hand"><label
						onclick="redirect(this,'B1')" field="martyr_assess" ></label></a></td>
					<td nowrap align="right" class="td"><a href="#" style="cursor:hand"><label
						onclick="redirect(this,'B2,B3,B5')" field="martyr_migrate" ></label></a></td>
					<td nowrap align="right" class="td"><a href="#" style="cursor:hand"><label  
						onclick="redirect(this,'B1,B2,B3,B4')" field="martyr_count" ></label></a></td>
				</tr>
			</table>
			</div>
		</next:Html>
	</next:Panel>
</next:ViewPort>
</body>
</html>