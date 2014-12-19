package com.inspur.cams.cdc.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.cdc.base.dao.ICdcMailListDao;
import com.inspur.cams.cdc.base.data.CdcMailList;

/**
 * 基层民主与社区建设通讯录dao
 * @author shgtch
 * @date 2012-3-1
 */
public class CdcMailListDao extends EntityDao<CdcMailList> implements ICdcMailListDao {
	
	@Override
	public Class<CdcMailList> getEntityClass() {
		return CdcMailList.class;
	}

	public DataSet queryList(ParameterSet pset) {
		String organCode = (String) pset.getParameter("organCode");
		String organ = (String) pset.getParameter("organ");
		String code = (String) pset.getParameter("code");
		String dept = (String) pset.getParameter("dept");
		String name = (String) pset.getParameter("name");
		StringBuffer sql = new StringBuffer("SELECT T.LIST_ID LISTID,T.NAME NAME,");
        sql.append("T.SEX SEX,T.ORGAN ORGAN,T.DEPT DEPT,T.DUTY DUTY,T.MOBLE_PHONE MOBLEPHONE,");
        sql.append("T.PHONE PHONE,T.ORGAN_CODE ORGANCODE,T.ORGAN_NAME ORGANNAME,T.POST_ADDS POSTADDS ");
        sql.append("FROM CDC_MAIL_LIST T WHERE 1 = 1 ");
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		if (organCode != null && !"".equals(organCode)) {
			sql.append(" AND T.ORGAN_CODE  LIKE ''||?||'%' ");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode);
		}
		if (code != null && !("".equals(code))) {
			sql.append(" AND T.ORGAN_CODE = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(code);
		}
		if (name != null && !("".equals(name))) {
			sql.append(" AND T.NAME LIKE '%'||?||'%' ");
			typeList.add(Types.VARCHAR);
			argsList.add(name);
		}
		if (organ != null && !"".equals(organ)) {
			sql.append(" AND T.ORGAN LIKE '%'||?||'%' ");
			typeList.add(Types.VARCHAR);
			argsList.add(organ);
		}
		if (dept != null && !"".equals(dept)) {
			sql.append(" AND T.DEPT LIKE '%'||?||'%' ");
			typeList.add(Types.VARCHAR);
			argsList.add(dept);
		}
		sql.append(" ORDER BY T.CREATE_TIME DESC");
		DataSet ds = new DataSet();
		if (typeList.size() != 0 && argsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = (Integer) (typeList.get(i));
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			ds = this.executeDataset(sql.toString(), types, args, pset
						.getPageStart(), pset.getPageLimit(), true);
		}else {
			ds = this.executeDataset(sql.toString(), pset.getPageStart(), pset.getPageLimit(), true);
		}
		return ds;
	}
}