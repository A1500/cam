 var row_index=0;
 var valueCheckBoxEnd;

/*
 * 实现HtmlEdit
 */
function init(){
	if(method=="add"){
		var fisMattersAttention=L5.DatasetMgr.lookup("fisMattersAttention");
		fisMattersAttention.newRecord();
	}
			 	 new L5.FormPanel({
			        labelAlign: 'top',
			        renderTo:"htmledit",
			        //title: '通知内容',
			        //bodyStyle:'padding:5px 5px 0',
			        width: 850,
			        height:400,
			        border:false,
			        frame:true,
			        items: [{
			            xtype:'htmleditor',
			            id:'bio',
			           fieldLabel:'通知正文',
			            height:330,
			            anchor:'100%',
			            fontFamilies:['宋体','隶书','黑体','楷体_GB2312','华文行楷','arial','courier','verdana'],
			            sourceEdit:true
			        }]
			    });
	
		if(method=="update"){
			var   fisMattersAttention=L5.DatasetMgr.lookup("fisMattersAttention");
					fisMattersAttention.setParameter("ATTENTION_ID@=",attentionId);
					fisMattersAttention.load(true);
					var record = fisMattersAttention.getCurrent();
					var toOrganFisU=record.get("toOrganFis");
					if(toOrganFisU.indexOf("B") !=-1){
						document.getElementById("funeralHome").checked=true;
					}
					if(toOrganFisU.indexOf("G") !=-1){
						document.getElementById("cemetery").checked=true;
					}
					if(toOrganFisU.indexOf("Y") !=-1){
						document.getElementById("funeralHomeCemetery").checked=true;
					}
					
					document.getElementById("title").value=record.get("attentionTitle");
					document.getElementsByName("toOrganFis").value=record.get("toOrganFis");
					document.getElementById("attentionType").value=record.get("attentionType");
					document.getElementById("emergencyDegree").value=record.get("emergencyDegree");
					document.getElementById("bio").value=record.get("attentionContents");
				}
		if(method=="detail"){
			fisMattersAttentionDataSet.setParameter("ATTENTION_ID@=",attentionId);
			fisMattersAttentionDataSet.load(true);
		}
}

/*
 * 删除左右两端空格
 */
function trim(str){

	return str.replace(/(^\s*)|(\s*$)/g, '');
}
//获取复选框的值
function selectAll() {       
    var ids = document.getElementsByName("toOrganFis"); 
    var valueCheckBox="";
    for (var i = 0; i < ids.length; i++)        
    {        
    	if(ids[i].checked){
    		valueCheckBox += ids[i].value+" ,";
    	}
    }   
    var reg=/,$/gi; 
    valueCheckBox=valueCheckBox.replace(reg,""); 
    valueCheckBoxEnd = valueCheckBox ;
} 

/*
 * 执行保存前的校验
 */
function click_check(){
    var editor=L5.getCmp('bio');
	var temp=undefined;
	selectAll();
	//if(getParam("content").length>=2000){
	//L5.Msg.alert("提示","正文不得大于2000个字符!");
	//return false;
	//}
	if(getParam("title")==temp||trim(getParam("title"))==""){
		L5.Msg.alert("提示","通知标题不能为空!");
		return false;
	}else if(getParam("attentionType")==temp){
		L5.Msg.alert("提示","请选择通知类型!");
		return false;
	}else if(getParam("emergencyDegree")==temp){
		L5.Msg.alert("提示","请选择紧急程度!");
		return false;
	}else	if(valueCheckBoxEnd==""){
		L5.Msg.alert("提示","请选择面向单位!");
		return false;
	}else if(trim(L5.getCmp('bio').getValue())==""){
		L5.Msg.alert("提示","请填写通知正文!");
		return false;
	}else if((editor.getValue()).length>=4000){
		L5.Msg.alert("提示","正文不能超过4000字!");
	    return false;
	}else{
		return true ;
	}

	if(getParam("title").length>=200){
	L5.Msg.alert("提示","标题不得大于200个字符!");
	return false;
	}

}

//根据ID获取界面控件的值
function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
/*
 * 发布通知
 */
function click_save(){

	if(click_check()){
		if(method=="add"){
				var editor=L5.getCmp('bio');
				var command=new L5.Command("com.inspur.cams.fis.base.cmd.FisMattersAttentionCmd");
				command.setParameter("title",document.getElementById("title").value);//通知标题
				command.setParameter("attentionType",document.getElementById("attentionType").value);//通知类型
				command.setParameter("content",editor.getValue());//通知内容
				command.setParameter("emergencyDegree",document.getElementById("emergencyDegree").value);//通知紧急程度
				command.setParameter("toOrganFis",valueCheckBoxEnd);//面向馆/墓/馆墓一体
				command.execute("insertFisAttention");
				if(!command.error){
					L5.Msg.alert("提示","通知发布成功!");
					 var url='jsp/cams/fis/annocement/fisMattersAttentionList.jsp';
					 L5.forward(url,"","");
					}else{
				        L5.Msg.alert("提示",(command.error+'').replace("出现系统异常",""),{});
			        }
		}
		if(method=="update"){
			var editor=L5.getCmp('bio');
			var command=new L5.Command("com.inspur.cams.fis.base.cmd.FisMattersAttentionCmd");
			command.setParameter("attentionId",attentionId);//通知ID
			command.setParameter("title",document.getElementById("title").value);//通知标题
			command.setParameter("attentionType",document.getElementById("attentionType").value);//通知类型
			command.setParameter("content",editor.getValue());//通知内容
			command.setParameter("emergencyDegree",document.getElementById("emergencyDegree").value);//通知紧急程度
			command.setParameter("toOrganFis",valueCheckBoxEnd);//面向馆/墓/馆墓一体
			command.execute("updateFisAttention");
			if(!command.error){
				L5.Msg.alert("提示","通知发布成功!");
				 var url='jsp/cams/fis/annocement/fisMattersAttentionList.jsp';
				 L5.forward(url,"","");
				}else{
			        L5.Msg.alert("提示",(command.error+'').replace("出现系统异常",""),{});
		        }
		}
	}
}

/*
 * 点击【返回】
 */
function returnBack(){
		window.location="fisMattersAttentionList.jsp";
}