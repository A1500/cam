package com.inspur.cams.comm.subsys.cmd;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.loushang.bsp.permit.pap.user.domain.IUserDomain;
import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.subsys.data.ComSubsysConfig;
import com.inspur.cams.comm.subsys.data.ComSubsysRoles;
import com.inspur.cams.comm.util.StrUtil;

/**
 * @title:ComSubsysConfigQueryCommand
 * @description:
 * @author:
 * @since:2012-01-17
 * @version:1.0
*/
public class ComSubsysConfigQueryCmd extends BaseQueryCommand{
	@SuppressWarnings("unchecked")
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<ComSubsysConfig> dao = (EntityDao<ComSubsysConfig>) DaoFactory
				.getDao("com.inspur.cams.comm.subsys.dao.jdbc.ComSubsysConfigDao");
		
		EntityDao<ComSubsysRoles> rolesDao = (EntityDao<ComSubsysRoles>) DaoFactory
				.getDao("com.inspur.cams.comm.subsys.dao.jdbc.ComSubsysRolesDao");
		
		DataSet dSet = dao.query(pset);
		if(dSet.getCount()==-1){
			Map<Object,Object> map = new HashMap<Object,Object>();
			map.put("SYS_ID",dSet.getRecord(0).get("sysId"));
			List<ComSubsysRoles> rolesList = rolesDao.queryNoPage(map);		
			String grantedRoles="";
			for(int j=0;j<rolesList.size();j++){
			    if("".equals(grantedRoles)){
				grantedRoles=grantedRoles+rolesList.get(j).getRoleId();
			    }else{
			    	grantedRoles=grantedRoles+","+rolesList.get(j).getRoleId();
			    }
			}
			dSet.getRecord(0).set("grantedRoles", grantedRoles);
		}
		return dSet;
	}
	
	
	

}