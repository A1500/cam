package com.inspur.comm.cqm.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.bsp.share.permit.bean.RoleView;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.comm.cqm.base.dao.ICqmModuleDao;
import com.inspur.comm.cqm.base.data.CqmModule;

/**
 * 自定义统计报表模型表dao
 * @author shgtch
 * @date 2012-03-16
 */
public class CqmModuleDao extends EntityDao<CqmModule> implements ICqmModuleDao {
	
	@Override
	public Class<CqmModule> getEntityClass() {
		return CqmModule.class;
	}

	public DataSet queryModule(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		List<Integer> typesList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		sql.append("SELECT M.MODULE_ID,M.MODULE_NAME,");
		sql.append("M.MODULE_ROLE FROM CQM_MODULE M WHERE 1 = 1 ");
		RoleView [] roles =(RoleView[]) pset.getParameter("roles");
		if(roles!=null&&roles.length>0){
			sql.append(" AND　M.MODULE_ROLE IN (");
			for(int i = 0;i<roles.length;i++){
				if(i!=0)sql.append(",");
				sql.append("?");
				typesList.add(Types.VARCHAR);
				argsList.add(roles[i].getRoleId());
			}
			sql.append(")");
		}
		int[] types = new int[typesList.size()];
		for(int i = 0;i<types.length;i++ ){
			types[i] = typesList.get(i);
		}
		Object[] args = argsList.toArray();
		return this.executeDataset(sql.toString(),types,args,true);
	}

}