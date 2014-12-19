package com.inspur.cams.cdc.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.cdc.base.dao.ICdcNoticeInfoDao;
import com.inspur.cams.cdc.base.data.CdcNoticeInfo;

public class CdcNoticeInfoDao extends EntityDao<CdcNoticeInfo> implements ICdcNoticeInfoDao {

	@Override
	protected Class<CdcNoticeInfo> getEntityClass() {
		// TODO Auto-generated method stub
		return CdcNoticeInfo.class;
	}
	
	/**
	 * 查询上司的通知
	 * @param pset
	 * @return DataSet
	 */
	public DataSet queryNotice(ParameterSet pset){
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT U.* FROM CDC_NOTICE_INFO U WHERE 1 = 1 ");
		sql.append(" AND U.NOTICE_TYPE = '1' AND U.FLAG = '1' ");
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		
		String level = (String) pset.getParameter("level");
		if (level != null && !"".equals(level)) {
			if("JD".equals(level)){
				sql.append(" AND U.TARGETTO >=? ");
				typeList.add(Types.VARCHAR);
				argsList.add("14");
				sql.append(" AND U.ORGAN_LEVEL<? ");
				typeList.add(Types.VARCHAR);
				argsList.add("14");
			}else if("SQ".equals(level)){
				sql.append(" AND U.TARGETTO >=? ");
				typeList.add(Types.VARCHAR);
				argsList.add("15");
				sql.append(" AND U.ORGAN_LEVEL<? ");
				typeList.add(Types.VARCHAR);
				argsList.add("15");
			}else{
				sql.append(" AND U.TARGETTO >=? ");
				typeList.add(Types.VARCHAR);
				argsList.add(level);
				sql.append(" AND U.ORGAN_LEVEL<? ");
				typeList.add(Types.VARCHAR);
				argsList.add(level);
			}
		}
		
		String organCode = (String) pset.getParameter("organCode");
		if (organCode != null && !organCode.equals("")) {
			sql.append(" AND U.ORGAN_AREA LIKE (CASE WHEN U.ORGAN_LEVEL = '11' THEN SUBSTR(?,1,2)||'%' ");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode);
			sql.append(" WHEN U.ORGAN_LEVEL = '12' THEN SUBSTR(?,1,4)||'%' ");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode);
			sql.append(" WHEN U.ORGAN_LEVEL = '13' THEN SUBSTR(?,1,6)||'%' ");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode);
			sql.append(" WHEN U.ORGAN_LEVEL = '14' THEN SUBSTR(?,1,9)||'%' END )");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode);
		}
		String createTime = (String) pset.getParameter("createTime");
		if (createTime != null && !createTime.equals("")) {
			sql.append(" AND U.CREATE_TIME=?");
			typeList.add(Types.VARCHAR);
			argsList.add(createTime);
		}
		String name = (String) pset.getParameter("name");
		if (name != null && !name.equals("")) {
			sql.append(" AND U.NAME LIKE ?");
			typeList.add(Types.VARCHAR);
			argsList.add("%"+name+"%");
		}
		String organName = (String) pset.getParameter("organName");
		if (organName != null && !organName.equals("")) {
			sql.append(" AND U.ORGAN_NAME LIKE ?");
			typeList.add(Types.VARCHAR);
			argsList.add("%"+organName+"%");
		}
		sql.append(" ORDER BY U.CREATE_TIME DESC ");
		DataSet ds = new DataSet();
		if (typeList.size() != 0 && argsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = (Integer) (typeList.get(i));
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			ds = this.executeDataset(sql.toString(), types, args, pset
						.getPageStart(), pset.getPageLimit(), true);
		}
		return ds;
	}
	/**
	 * 查询自己的通知
	 * @param pset
	 * @return DataSet
	 */
	public DataSet queryMyNotice(ParameterSet pset){
		
		StringBuffer sql = new StringBuffer();
		String organCode = (String) pset.getParameter("organCode");
		String createTime = (String) pset.getParameter("createTime");
		String name = (String) pset.getParameter("name");
		String flag = (String) pset.getParameter("flag");
		sql.append(" SELECT U.* FROM CDC_NOTICE_INFO U WHERE 1=1 AND U.NOTICE_TYPE='1' ");
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		if (organCode != null && !organCode.equals("")) {
			sql.append(" AND U.ORGAN_AREA=? ");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode);
		}
		if (createTime != null && !createTime.equals("")) {
			sql.append(" AND U.CREATE_TIME=?");
			typeList.add(Types.VARCHAR);
			argsList.add(createTime);
		}
		if (name != null && !name.equals("")) {
			sql.append(" AND U.NAME LIKE ?");
			typeList.add(Types.VARCHAR);
			argsList.add("%"+name+"%");
		}
		if (flag != null && !flag.equals("")) {
			sql.append(" AND U.FLAG = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(flag);
		}
		DataSet ds = new DataSet();
		if (typeList.size() != 0 && argsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = (Integer) (typeList.get(i));
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			ds = this.executeDataset(sql.toString(), types, args, pset
						.getPageStart(), pset.getPageLimit(), true);
		}
		return ds;
	}
	/**
	 * 查询下属的申报
	 * @param pset
	 * @return DataSet
	 */
	public DataSet queryReport(ParameterSet pset){
		StringBuffer sql = new StringBuffer();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		sql.append("SELECT U.* FROM CDC_NOTICE_INFO U WHERE 1 = 1 ");
		sql.append("AND U.NOTICE_TYPE='2' AND U.FLAG='1'");
		String organCode = (String) pset.getParameter("organCode");
		if (organCode != null && !organCode.equals("")) {
			sql.append(" AND U.ORGAN_AREA IN (SELECT A.USER_ID FROM COM_EXT_USER A WHERE A.ORGAN_ID = ? )");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode);
		}
		String createTime = (String) pset.getParameter("createTime");
		if (createTime != null && !createTime.equals("")) {
			sql.append(" AND U.CREATE_TIME=?");
			typeList.add(Types.VARCHAR);
			argsList.add(createTime);
		}
		String name = (String) pset.getParameter("name");
		if (name != null && !name.equals("")) {
			sql.append(" AND U.NAME LIKE ?");
			typeList.add(Types.VARCHAR);
			argsList.add("%"+name+"%");
		}
		String organName = (String) pset.getParameter("organArea");
		if (organName != null && !organName.equals("")) {
			sql.append(" AND U.ORGAN_NAME LIKE ?");
			typeList.add(Types.VARCHAR);
			argsList.add("%"+organName+"%");
		}
		DataSet ds = new DataSet();
		if (typeList.size() != 0 && argsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = (Integer) (typeList.get(i));
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			ds = this.executeDataset(sql.toString(), types, args, pset
						.getPageStart(), pset.getPageLimit(), true);
		}
		return ds;
	}
	/**
	 * 查询自己的申报
	 * @param pset
	 * @return DataSet
	 */
	public DataSet queryMyReport(ParameterSet pset){
		StringBuffer sql = new StringBuffer();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		String organCode = (String) pset.getParameter("organCode");
		String createTime = (String) pset.getParameter("createTime");
		String name = (String) pset.getParameter("name");
		String flag = (String) pset.getParameter("flag");
		sql.append(" SELECT U.* FROM CDC_NOTICE_INFO U WHERE  U.ORGAN_AREA=? AND U.NOTICE_TYPE='2' ");
		
		if (organCode != null && !organCode.equals("")) {
			typeList.add(Types.VARCHAR);
			argsList.add(organCode);
		}
		if (createTime != null && !createTime.equals("")) {
			sql.append(" AND U.CREATE_TIME=?");
			typeList.add(Types.VARCHAR);
			argsList.add(createTime);
		}
		if (name != null && !name.equals("")) {
			sql.append(" AND U.NAME LIKE ?");
			typeList.add(Types.VARCHAR);
			argsList.add("%"+name+"%");
		}
		if (flag != null && !flag.equals("")) {
			sql.append(" AND U.FLAG = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(flag);
		}
		DataSet ds = new DataSet();
		if (typeList.size() != 0 && argsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = (Integer) (typeList.get(i));
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			ds = this.executeDataset(sql.toString(), types, args, pset
						.getPageStart(), pset.getPageLimit(), true);
		}
		return ds;
	}
}
