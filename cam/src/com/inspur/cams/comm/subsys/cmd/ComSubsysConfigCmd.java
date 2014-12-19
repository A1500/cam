package com.inspur.cams.comm.subsys.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import org.loushang.sca.*;

import com.inspur.cams.comm.subsys.dao.*;
import  com.inspur.cams.comm.subsys.dao.*;
import com.inspur.cams.comm.subsys.dao.jdbc.ComSubsysRolesDao;
import com.inspur.cams.comm.subsys.data.ComSubsysConfig;
import com.inspur.cams.comm.subsys.data.ComSubsysRoles;
import com.inspur.cams.comm.subsys.domain.IComSubsysConfigDomain;
import com.inspur.cams.comm.subsys.util.SubsysConfigUtil;
import com.inspur.cams.comm.util.StrUtil;

/**
 * @title:ComSubsysConfigSaveCommand
 * @description:
 * @author:
 * @since:2012-01-17
 * @version:1.0
*/
public class ComSubsysConfigCmd extends BaseAjaxCommand {

	public void save() {
		IComSubsysConfigDomain service = ScaComponentFactory.getService(IComSubsysConfigDomain.class,
				"ComSubsysConfigDomain/ComSubsysConfigDomain");
		ComSubsysConfig comsubsysconfig = getComSubsysConfig();
		List ComSubsysRolesList = null;
		if(!"".equals(StrUtil.n2b(comsubsysconfig.getGrantedRoles()))){
			ComSubsysRolesList = getComSubsysRolesList(comsubsysconfig);
		}
		
		service.saveComSubsysRolesList(comsubsysconfig, ComSubsysRolesList);
		
	}

	public void delete() {
		IComSubsysConfigDomain service = ScaComponentFactory.getService(IComSubsysConfigDomain.class,
				"ComSubsysConfigDomain/ComSubsysConfigDomain");
		String[] delId = (String[]) getParameter("delIds");
		List list = new ArrayList();
		for(int i=0;i<delId.length;i++){
			list.add(delId[i]);
		}
		
		
		
		service.delete(list);
	}

	private ComSubsysConfig getComSubsysConfig() {
		Record comsubsysconfigRecord = (Record) getParameter("ComSubsysConfigRecord");
		return (ComSubsysConfig) comsubsysconfigRecord.toBean(ComSubsysConfig.class);
	}
	
	private List<ComSubsysRoles> getComSubsysRolesList(ComSubsysConfig comsubsysconfig) {
		String[] rolesArrStrings = comsubsysconfig.getGrantedRoles().split(",");
		List<ComSubsysRoles> list = new ArrayList<ComSubsysRoles>();
		for (int i = 0; i < rolesArrStrings.length; i++) {
			ComSubsysRoles comsubsysroles = new ComSubsysRoles();
			comsubsysroles.setRoleId(rolesArrStrings[i]);
			comsubsysroles.setState(Record.STATE_NEW);
			comsubsysroles.setSysId(comsubsysconfig.getSysId());
			list.add(comsubsysroles);
		}

		return list;
	}
	
	public void apply(){
		SubsysConfigUtil.querySysConfig();
	}
	
}