package com.inspur.cams.cdc.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.cdc.base.dao.ICdcWorkInfoDao;
import com.inspur.cams.cdc.base.data.CdcWorkInfo;

/**
 * 基层民主与社区建设工作交流dao
 * @author shgtch
 * @date 2012-3-1
 */
public class CdcWorkInfoDao extends EntityDao<CdcWorkInfo> implements ICdcWorkInfoDao {
	
	@Override
	public Class<CdcWorkInfo> getEntityClass() {
		return CdcWorkInfo.class;
	}
	
	public DataSet queryList(ParameterSet pset){
		String organCode = (String) pset.getParameter("organCode");
		String reportDate = (String) pset.getParameter("reportDate");
		String code = (String) pset.getParameter("code");
		String type = (String) pset.getParameter("type");
		String name = (String) pset.getParameter("name");
		String kind = (String) pset.getParameter("kind");
		StringBuffer sql = new StringBuffer("SELECT  T.WORK_ID WORKID,T.FILE_ID FILEID, T.NAME NAME,T.KIND KIND,");
		sql.append("T.REPORT_DATE REPORTDATE,T.ORGAN_NAME ORGANNAME,");
		sql.append("T.ORGAN_CODE ORGANCODE,T.REPORT_PEOPLE REPORTPEOPLE");
		sql.append(" FROM CDC_WORK_INFO T WHERE 1 = 1 ");
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
		if (kind != null && !("".equals(kind))) {
			sql.append(" AND T.KIND = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(kind);
		}
		if (name != null && !("".equals(name))) {
			sql.append(" AND T.NAME LIKE '%'||?||'%' ");
			typeList.add(Types.VARCHAR);
			argsList.add(name);
		}
		if (reportDate != null && !"".equals(reportDate)) {
			sql.append(" AND T.REPORT_DATE = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(reportDate);
		}
		if (type != null && !"".equals(type)) {
			sql.append(" AND T.WORK_TYPE = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(type);
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