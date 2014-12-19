package com.inspur.cams.marry.base.dao.jdbc;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.marry.base.dao.IMrmRegisOrganInfoDao;
import com.inspur.cams.marry.base.data.MrmRegisOrganInfo;

/**
 * @title:MrmRegisOrganInfoDao
 * @description:
 * @author:
 * @since:2011-11-28
 * @version:1.0
 */
public class MrmRegisOrganInfoDao extends EntityDao<MrmRegisOrganInfo>
		implements IMrmRegisOrganInfoDao {
	 private static final String  SHENG_VALUE="000001";
	 private static final String  SHI_VALUE="0001";

	public MrmRegisOrganInfoDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class getEntityClass() {
		return MrmRegisOrganInfo.class;
	}

	/**
	 * 根据organCode获取organId
	 * 
	 * @param idCard
	 * @return
	 */
	public String checkOrganId(String organCode) {
		StringBuffer sql = new StringBuffer();
		@SuppressWarnings("unused")
		List typeList = new ArrayList();
		@SuppressWarnings("unused")
		List<Object> argsList = new ArrayList();
		sql
				.append("SELECT p.organ_id ORGAN_ID FROM PUB_ORGAN p  WHERE p.organ_code= ? ");
		List list = this.executeQuery(sql.toString(),
				new int[] { Types.VARCHAR }, new Object[] { organCode });
		int num = list.size();
		if (num == 0 || list == null) {
			return "0";
		} else {
			String organId = (String) ((Map) list.get(0)).get("ORGAN_ID");
			StringBuffer strBuf = new StringBuffer();
			strBuf.append(organId);
			return strBuf.toString();
		}
	}

	/**
	 * 查询婚姻登记处列表
	 * 
	 * @param pset
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public DataSet queryOrganInfoList(ParameterSet pset) {
		DataSet ds = new DataSet();
		String regionCode = (String) pset.getParameter("regionCode");
		String deptId = (String) pset.getParameter("deptId");//济南市级本机处理
		List typeList = new ArrayList();
		List<Object> argsList = new ArrayList();
		StringBuffer sql = new StringBuffer("select m.name, m.organ_id, "
				+ " m.region_code," + " m.dept_code," + " m.dept_address, "
				+ " m.modify_id," + " m.complain_tel," + " m.office_email, "
				+ " m.types, m.valid_flag , m.dept_tel " 
				+ " from mrm_regis_organ_info m where 1=1");

		if ("0000000000".equals(regionCode.substring(2))) { // 省级用户查询婚姻管理处
			sql
					.append(" and substr(m.dept_code,5,4)="+SHI_VALUE+" and substr(m.dept_code,3,6) <> "+SHENG_VALUE+" ");
		} else if ("00000000".equals(regionCode.substring(4))) { // 市级用户
			if(deptId!=null&&!deptId.equals("")){
			if(deptId.substring(6, 8)=="99"||deptId.substring(6, 8).equals("99")){
			    sql.append(" and substr(m.dept_code,1,6) = ? and substr(m.dept_code,5,4) <> "+SHI_VALUE+"");
				typeList.add(Types.VARCHAR);
				argsList.add(regionCode.substring(0, 6));
			  
			}else{
			    sql.append(" and substr(m.dept_code,1,4) = ?");
				typeList.add(Types.VARCHAR);
				argsList.add(regionCode.substring(0, 4));
			 }
			}else{
				 sql.append(" and substr(m.dept_code,1,4) = ?");
					typeList.add(Types.VARCHAR);
					argsList.add(regionCode.substring(0, 4));
			 }
		
		
		} else if ("000000".equals(regionCode.substring(6))) { // 县级用户
			sql.append(" and substr(m.dept_code,1,6)=?");
			typeList.add(Types.VARCHAR);
			argsList.add(regionCode.substring(0, 6));
		}

		sql.append("  order by m.region_code,m.dept_code,m.organ_id asc ");
		if (typeList.size() != 0 && argsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = (Integer) (typeList.get(i));
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			ds = this.executeDataset(sql.toString(), types, args, true);
		} else {
			ds = this.executeDataset(sql.toString(), true);
		}
		return ds;
	}
	/**
	 * 查询所有带等级的登记处
	 * @return 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public DataSet queryLevelOrgan(ParameterSet pset){
		String regionCode = (String) pset.getParameter("regionCode");
		String deptId = (String) pset.getParameter("deptId");// 济南市级本机处理
		DataSet ds = new DataSet();
		List typeList = new ArrayList();
		List<Object> argsList = new ArrayList();
		StringBuffer sql = new StringBuffer(
				"select * from mrm_regis_organ_info m where 1=1");

		if ("0000000000".equals(regionCode.substring(2))) { // 省级用户查询婚姻管理处
			sql.append(" and substr(m.dept_code,5,3)=" + "000"
					+ " and substr(m.dept_code,3,6) <> " + SHENG_VALUE + " ");
		} else{ // 市级用户
			sql.append(" and m.dept_code  like ?");
			typeList.add(Types.VARCHAR);
			argsList.add(getAreaCodeLikePrefix(regionCode) + "%");

		}
		sql.append("  order by m.region_code,m.dept_code,m.organ_id asc ");
		if (typeList.size() != 0 && argsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = (Integer) (typeList.get(i));
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			ds = this.executeDataset(sql.toString(), types, args, pset.getPageStart(), pset.getPageLimit(), true);
		} else {
			ds= executeDataset(sql.toString(), pset.getPageStart(),pset.getPageLimit(), true);
		}
		return ds;
		
	}
	private String getAreaCodeLikePrefix(String areaCode) {
        if(areaCode.endsWith("0000000000")){//省370000000000
			return areaCode.substring(0,2);
		} else if (areaCode.endsWith("00000000")){//市370100000000
			return areaCode.substring(0,4);
		} else if (areaCode.endsWith("000000")){//县370104000000
			return areaCode.substring(0,6);
		} else if (areaCode.endsWith("000")){//乡370104003000
			return areaCode.substring(0,9);
		}
        return areaCode;
	}
	/**
	 * 修改状态
	 * @param mOrganInfo
	 */
	public void updateValid(MrmRegisOrganInfo mOrganInfo){
		String organId = mOrganInfo.getOrganId();
		String validFlag = mOrganInfo.getValidFlag().toString();
		StringBuffer sBuffer = new StringBuffer(
				"update mrm_regis_organ_info "
		);
		List typeList = new ArrayList();
		List<Object> argsList = new ArrayList();
		if (validFlag != null && !"".equals(validFlag)) {
			sBuffer.append(" set valid_flag = ? ");
			typeList.add(Types.NUMERIC);
			argsList.add(validFlag);
		}
		
		if (organId != null && !"".equals(organId)) {
			sBuffer.append(" where organ_id = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(organId);
		}
		DataSet ds = new DataSet();
		if (typeList.size() != 0 && argsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = (Integer) (typeList.get(i));
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			this.executeUpdate(sBuffer.toString(), types, args);
		}
	}

	public void setLevel(String applyLevel, String organCode) {
		StringBuffer sBuffer = new StringBuffer(
				"update mrm_regis_organ_info "
		);
		List<Object> typeList = new ArrayList<Object>();
		List<Object> argsList = new ArrayList<Object>();
		if (applyLevel != null && !"".equals(applyLevel)) {
			sBuffer.append(" set skin_value = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(applyLevel);
		}
		
		if (organCode != null && !"".equals(organCode)) {
			sBuffer.append(" where dept_code = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode);
		}
		//DataSet ds = new DataSet();
		if (typeList.size() != 0 && argsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = (Integer) (typeList.get(i));
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			this.executeUpdate(sBuffer.toString(), types, args);
		}
	}

}
