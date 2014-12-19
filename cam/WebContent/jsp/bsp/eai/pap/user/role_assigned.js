function getParam(ElementId){
	var val=document.getElementById(ElementId).value;
	if(val=="") val=undefined;
	return val;
}

function init(){
	userDs.setParameter("APP_USER_ID",userId);
	userDs.load();
    initGrantRole();
}

function query(){
	var ableRolesDs=L5.DatasetMgr.lookup("ableRolesDs");
	var queryRoleName=getParam("roleName");
	if(queryRoleName!=null&&queryRoleName!=undefined){
		ableRolesDs.filter("roleInfo",getParam("roleName"),true,false);
	}else{
		ableRolesDs.clearFilter();
	}
}

function undo(){
	document.getElementById("roleName").value="";
}


//初始化双边栏
function initGrantRole(){
	var ableRolesDs=L5.DatasetMgr.lookup("ableRolesDs");
    ableRolesDs.setParameter("TARGET",userId);
    ableRolesDs.load(true);
    var assignedRoleDs=L5.DatasetMgr.lookup("assignedRoleDs");
   assignedRoleDs.setParameter("TARGET",userId);
    assignedRoleDs.load();
	 new L5.ux.ItemSelector({
		field:"grantedRoles",
		applyTo:"grantRoleDiv",
		id:"grantRolecmp",
		name:"grantedRoles",
		fromDataset:ableRolesDs,
		toDataset:assignedRoleDs,
		valueField:"roleId",
		displayField:"roleInfo",
	    msWidth:350,
	    msHeight:350,
	    toLegend:"已授予角色",
	    fromLegend:"未授予角色",
	    drawUpIcon:false,
	    drawDownIcon:false,
	    drawTopIcon:false,
	    drawBotIcon:false
	});
}

//返回按钮
function back2list(){
  L5.forward("jsp/bsp/eai/pap/user/user_role.jsp");
}


function save(){
    var command = new L5.Command("org.loushang.bsp.eai.pap.user.cmd.UserCmd");
    var ds = L5.DatasetMgr.lookup("assignedRoleDs");
    var recs = ds.getAllChangedRecords();
    var addRcds=new Array();
    var delRcds=new Array();
    var count=recs.length;
    if(count>0){
      for(var i=0;i<count;i++){
    	  var rec=recs[i];
    	  if(rec.state=="1"){//新增的
            	addRcds.push(rec);
            }
            if(rec.state=="2"){//新增的
              	delRcds.push(rec);
          }	
      }
    }
    
    command.setParameter("addRcds",addRcds);
    command.setParameter("delRcds",delRcds);
       
	command.setParameter("userId",userId);
	command.execute("updateUserRole");
	if (!command.error) {
		L5.MessageBox.alert("提示","保存成功!");
		ds.commitChanges();
		return;
		}
     else{
      L5.MessageBox.alert("提示",command.error);
      return false;
     }
}