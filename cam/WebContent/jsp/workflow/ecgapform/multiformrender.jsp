<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<%
	String actDefUniqueId=request.getParameter("actDefUniqueId");
	String assignmentId=request.getParameter("assignmentId");	
	String procDefUniqueId=request.getParameter("procDefUniqueId");
	if(actDefUniqueId==null||"".equals(actDefUniqueId))
	{
		actDefUniqueId=request.getParameter("startActDefUniqueId");
	}
%>
<next:ScriptManager />
<script type="text/javascript">
var assignmentId="<%=assignmentId%>";
var procDefUniqueId="<%=procDefUniqueId%>";
var actDefUniqueId="<%=actDefUniqueId%>";
var formId='<%=request.getParameter("formId")%>';
var basePath='<%=request.getContextPath()%>';
var queryStr="<%=request.getQueryString()%>";
var primalPath=document.URL.split('?');
if(primalPath.length>1){
	if(queryStr!=primalPath[1]){
		queryStr+="&";
		queryStr+=primalPath[1];
	}
}
var readonlyQueryStr=queryStr.replace(/type=\d/,'type=1');

var rootdata = {
    id : 'rootId',//唯一标志record,如果是前台配置生成record,需要指定id
	parentId:'-1',
	isLeaf:'0',
	formId:'rootId',
	dataId:'000',
	formName:'表单树',
	recordType : 'formInfo'
};

function  getFormId(record){
	if(record.get('formId')=='rootId')
	{
		return formId;
	}
	return record.get('formId');
}

function getIcon(record)
{
	if(record.get('formId')!='rootId')
	{
		return "images/view.png";
	}
}
function getIsLeaf(record)
{
	return record.get('formId')!='rootId';
}

function getProcDefUniqueId()
{
	return procDefUniqueId;
}
function getActDefUniqueId()
{
	return actDefUniqueId;
}
function getAssignmentId()
{
	return assignmentId;
}
function selectedForm(record)
{
	if(record.get('formId')=="rootId")return;
	if(record.get("formId")==formId){
		L5.getDom("mainFormFrame").style.display="";
		L5.getDom("subFormFrame").style.display="none";
	}else{
		L5.getDom("subFormFrame").style.display="";
		L5.getDom("mainFormFrame").style.display="none";
		var src=basePath+'/jsp/workflow/ecgapform/jsp/'+record.get('formId')+'.jsp?'+readonlyQueryStr;
		src=src.replace(/dataId=\w*&/,'dataId='+record.get('dataId')+"&");
		src=src.replace(/formId=\w*&/,'formId='+record.get('formId')+"&");
		L5.getDom("subFormFrame").src=src;
	}
}

function init()
{
	L5.getDom("mainFormFrame").src=basePath+'/jsp/workflow/ecgapform/jsp/'+formId+'.jsp?'+queryStr;
}


</script>
</head>
<body>
<next:ViewPort id="viewport">
	<next:BorderLayout>
		<next:Left split="true">
				<next:Tree width="200" name="multiform" id="multiform" title="表单信息"  rootVisible="true" rootExpanded="true"
				collapsible="true" border="false" autoScroll="true" lines="true" >
				<next:TreeDataSet dataset="formdataset" root="rootdata">
					<next:TreeLoader cmd="org.loushang.workflow.ecgapform.formrender.cmd.FormQueryCommand" method="getReadonlyForms">
						<next:treeRecord name="formInfo" idField="formId">
							<model:field name="formName" type="string"/>
							<model:field name="formId" type="string"/>
							<model:field name="dataId" type="string"/>
						</next:treeRecord>
						<next:TreeBaseparam name="formId"    value="getFormId" />
						<next:TreeBaseparam name="procDefUniqueId"    value="getProcDefUniqueId" />
						<next:TreeBaseparam name="actDefUniqueId"    value="getActDefUniqueId" />
						<next:TreeBaseparam name="assignmentId"    value="getAssignmentId" />
					</next:TreeLoader>
				</next:TreeDataSet>
				<next:TreeNodemodel recordType="formInfo">
					<next:TreeNodeAttribute name="text" mapping="formName"></next:TreeNodeAttribute>
					<next:TreeNodeAttribute name="icon" handler="getIcon"></next:TreeNodeAttribute>
					<next:TreeNodeAttribute name="leaf" handler="getIsLeaf"></next:TreeNodeAttribute>
					<next:Listeners>
							<next:Listener eventName="selected" handler="selectedForm"></next:Listener>
					</next:Listeners>
				</next:TreeNodemodel>
			</next:Tree>
		</next:Left>
		<next:Center>
			<next:Panel id="headpage" closable="false" autoScroll="false" >
				<next:Html>
					<iframe id="mainFormFrame" frameborder="no" border="0" marginwidth="0"
						marginheight="0" allowtransparency="yes" width="100%"
						style="overflow: auto" height="100%"
						src=""></iframe>
					<iframe id="subFormFrame" frameborder="no" border="0" marginwidth="0"
						marginheight="0" allowtransparency="yes" width="100%"
						style="overflow: auto;display:none" height="100%"
						src=""></iframe>
				</next:Html>
			</next:Panel>
		</next:Center>
	</next:BorderLayout>
</next:ViewPort>
</body>
</html>