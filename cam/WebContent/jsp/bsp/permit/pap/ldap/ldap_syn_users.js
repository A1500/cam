//初始化方法
function init(){
	window.command=new L5.Command("org.loushang.bsp.permit.pap.ldap.cmd.PubLdapSysUsersQueryCmd");
	 var pubLdapSynUsersDs=L5.DatasetMgr.lookup("pubLdapSynUsersDs");
	 //command.execute("query");
	 pubLdapSynUsersDs.load();
	}
function getParam(ElementId){
	var val=document.getElementById(ElementId).value;
	if(val=="") val=undefined;
	return val;
}

//查询
function query(){
    pubLdapSynUsersDs.setParameter("PUB_LDAP_SYN_USERS.USER_ID@like",getParam("userId0"));
	pubLdapSynUsersDs.setParameter("PUB_LDAP_SYN_USERS.USER_NAME@like",getParam("userName0"));
	pubLdapSynUsersDs.load();
}

function reset(){
	document.getElementById("userId0").value="";
	document.getElementById("userName0").value="";
}
//数据同步
function Evt_butSyn_click(){
			//在前台创建PubLdapSynUsersQueryCmd对象
	         window.command=new L5.Command("org.loushang.bsp.permit.pap.ldap.cmd.PubLdapSynUsersQueryCmd");
	         //通过对象调用PubLdapSynUsersQueryCmd中的SynPubLdap方法实现数据同步
				command.execute("SynPubLdap");
				if (!command.error){
					L5.MessageBox.alert("提示","同步完成!");
				}
				//else{
					//L5.MessageBox.alert("错误",command.error);
					//return;
				    // }
				 //刷新页面
				 pubLdapSynUsersDs.load();
				}

 //添加用户
 function Evt_butadd_click(){
    // var pubLdapSynUsersDs=L5.DatasetMgr.lookup("pubLdapSynUsersDs");
 	 if(pubLdapSynUsersDs.getCount()==0){
		L5.MessageBox.alert("提示","没有可以添加的用户记录！");
		return;
		}
   //获取jsp中定义的ID为Syngrid的EditGridPanel
	var grid = L5.getCmp("Syngrid");
	//停止grid的编辑状态
	grid.stopEditing();
	//获取被选中的记录行
	var sm=grid.getSelectionModel();
	var cell=sm.getSelections();
	if(cell.length<1){
		L5.MessageBox.alert("提示","请选择要添加的记录");
		return;
	}else{
		  var revalue=window.showModalDialog("../../../organization/getselect.jsp?rootId=rootId&showOrganType=1,2&organType=1,2&isExact=0&isCheckBox=0&isTree=1","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;status:no;dialogLeft:"+(window.screen.width-300)/2+";dialogTop:"+(window.screen.height-400)/2);
		  var returnclear=""+";"+""+";"+""+";"+""+";"+""+";"+""+";"+"";
		  if(revalue!=""&&revalue!=returnclear){
	      var list=revalue.split(";");
		  var ids=[];
		  for(var i=0; i<cell.length; i++){
			ids[i]=cell[i].get("userId");
			}
		 //将所选择的用户都添加到选择的单位下面
		  var command = new L5.Command("org.loushang.bsp.permit.pap.ldap.cmd.PubLdapSynUsersSaveCmd");
		  command.setParameter("userIds",ids);
		  command.setParameter("deptId",list[5]);
		  command.setParameter("corpId",list[0]);
		  command.execute("insertUser");
		    if (!command.error){
			   L5.MessageBox.alert("提示","添加成功!");
			   }else{
			     L5.MessageBox.alert("提示",command.error);
			     return;
			   }
		 }else{
			  return;
			}
	}
	//刷新页面
	  pubLdapSynUsersDs.load();
}
