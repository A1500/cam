package com.inspur.cams.comm.subsys.util;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.loushang.bsp.share.permit.bean.RoleView;
import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.comm.subsys.data.ComSubsysConfig;
import com.inspur.cams.comm.subsys.data.ComSubsysRoles;

/**
 * @title:ComSubsysConfigQueryCommand
 * @description:
 * @author:
 * @since:2012-01-17
 * @version:1.0
*/
public class SubsysConfigUtil {
	
	private static List<ComSubsysConfig> sysList=null;
	
	@SuppressWarnings("unchecked")
	public static void querySysConfig() {
		EntityDao<ComSubsysConfig> dao = (EntityDao<ComSubsysConfig>) DaoFactory
				.getDao("com.inspur.cams.comm.subsys.dao.jdbc.ComSubsysConfigDao");

		EntityDao<ComSubsysRoles> rolesDao = (EntityDao<ComSubsysRoles>) DaoFactory
				.getDao("com.inspur.cams.comm.subsys.dao.jdbc.ComSubsysRolesDao");
		Map<Object,Object> queryMap = new HashMap<Object,Object>();
		queryMap.put("sort", "ORDER_NUM");
		queryMap.put("dir", "asc");
		queryMap.put("SHOW_FLG", "1");
		sysList = dao.queryNoPage(queryMap);
		for(int i=0;i<sysList.size();i++){
			Map<Object,Object> map = new HashMap<Object,Object>();
			map.put("SYS_ID", sysList.get(i).getSysId());
			List<ComSubsysRoles> rolesList = rolesDao.queryNoPage(map);
			String grantedRoles="";
			for(int j=0;j<rolesList.size();j++){
				if("".equals(grantedRoles)){
					grantedRoles=grantedRoles+rolesList.get(j).getRoleId();
				}else{
					grantedRoles=grantedRoles+","+rolesList.get(j).getRoleId();
				}
			}
			sysList.get(i).setGrantedRoles(grantedRoles);
		}

	}
	
	public static boolean hasPriv(RoleView[] roleViews,String assingedRole) {
		for(int i=0;i<roleViews.length;i++){
			if(assingedRole.indexOf(roleViews[i].getRoleId())>=0){
				return true;
			}
		}
		return false;
	}
	
	public static List<ComSubsysConfig> getSysList() {
		if(sysList==null){
			querySysConfig();
		}
		return sysList;
	}

}