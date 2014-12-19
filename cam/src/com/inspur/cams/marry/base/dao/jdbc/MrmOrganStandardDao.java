package com.inspur.cams.marry.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.util.StrUtil;
import com.inspur.cams.marry.base.dao.IMrmOrganStandardDao;
import com.inspur.cams.marry.base.data.MrmOrganStandard;

/**
 * @title:等级评定标准dao
 * @description:
 * @author:
 * @since:2012-11-21
 * @version:1.0
 */
public class MrmOrganStandardDao extends EntityDao<MrmOrganStandard> implements
		IMrmOrganStandardDao {
	public Class<MrmOrganStandard> getEntityClass() {
		return MrmOrganStandard.class;
	}

	public DataSet getMrmOrganStandard(ParameterSet pset) {
		DataSet ds=new DataSet();
		StringBuffer sql = new StringBuffer();
		List<Object> typeList = new ArrayList<Object>();
		List<Object> argsList = new ArrayList<Object>();
		sql.append("SELECT T.* FROM MRM_ORGAN_STANDARD T WHERE 1=1 ");
		String type=StrUtil.n2b((String)pset.getParameter("TYPE@="));
		if(StringUtils.isNotEmpty(type)){
			sql.append(" AND T.TYPE = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(type);
		}
		String standardLevel=StrUtil.n2b((String)pset.getParameter("STANDARD_LEVEL@="));
		if(StringUtils.isNotEmpty(standardLevel)){
			sql.append(" AND T.STANDARD_LEVEL = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(standardLevel);
		}
		String con1=StrUtil.n2b((String)pset.getParameter("CON1@="));
		if(StringUtils.isNotEmpty(con1)){
			sql.append(" AND T.CON1 = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(con1);
		}
		String con2=StrUtil.n2b((String)pset.getParameter("CON2@="));
		if(StringUtils.isNotEmpty(con2)){
			sql.append(" AND T.CON2 = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(con2);
		}
		String con3=StrUtil.n2b((String)pset.getParameter("CON3@="));
		if(StringUtils.isNotEmpty(con3)){
			sql.append(" AND T.CON3 = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(con3);
		}
		sql.append(" ORDER BY T.STANDARD_LEVEL, T.SEQ ");
		if (typeList.size() != 0 && argsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = (Integer) typeList.get(i);
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			ds = this.executeDataset(sql.toString(), types, args, true);
		} else {
			ds = this.executeDataset(sql.toString(), true);
		}
		return ds;
	}
}
