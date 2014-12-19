package com.inspur.cams.prs.prsretiredsoldiers.dao;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.loushang.bsp.util.StringUtil;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.prs.util.PrsSQL;

/**
 * @title:PrsRetiredSoldiersDao
 * @description:
 * @author:
 * @since:2011-08-18
 * @version:1.0
 */
public class PrsRetiredSoldiersDao extends EntityDao<PrsRetiredSoldiers>
		implements IPrsRetiredSoldiersDao {

	public PrsRetiredSoldiersDao() throws Exception {
		 this.setDataSource(DataSourceFactory.defaultFactory.getDataSource("dataSource"));
	}

	@SuppressWarnings("unchecked")
	@Override
	public Class getEntityClass() {
		return PrsRetiredSoldiers.class;
	}

	public void updateTrainFlag(String soldierId) {
		executeUpdate(PrsSQL.UPDATE_TRAINFLAG_BY_SOLDIERS_ID, new int[] { Types.VARCHAR },
				new Object[] { soldierId });
	}

	public void updatePlacementFlag(String soldierId) {
		executeUpdate(PrsSQL.UPDATE_PLACEMENTFLAG_BY_SOLDIERS_ID, new int[] { Types.VARCHAR },
				new Object[] { soldierId });
	}
	/**
	 * 查询人数
	 */
	public DataSet queryBySql(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		sql.append(PrsSQL.SELECT_PEOPLENUMBER);
		String time_q = (String) pset.getParameter("time_q");
		String time_z = (String) pset.getParameter("time_z");
		sql.append(" AND ALLOT_FLAG = '1' ");
		if(StringUtils.isNotEmpty(time_q)){
			sql.append(" AND RETIRED_TIME>= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(time_q);
		}
		if(StringUtils.isNotEmpty(time_z)){
			sql.append(" AND RETIRED_TIME <= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(time_z);
		}
		
		String wherePlacement = (String) pset.getParameter("wherePlacement");
		if(StringUtils.isNotEmpty(wherePlacement)){
			sql.append(" AND WHERE_PLACEMEN LIKE ?||'%' ");
			typeList.add(Types.VARCHAR);
			argsList.add(wherePlacement);
		}
		String organCode =  (String) pset.getParameter("organCode");
		if(StringUtils.isNotEmpty(organCode)){
			if (organCode.endsWith("0000000000")){
				sql.append("AND WHERE_PLACEMEN LIKE ?||'%'");
				typeList.add(Types.VARCHAR);
				argsList.add(organCode.substring(0, 2));
			}else if(organCode.endsWith("00000000")){
				sql.append("AND WHERE_PLACEMEN LIKE ?||'%'");
				typeList.add(Types.VARCHAR);
				argsList.add(organCode.substring(0, 4));
			}else {
				sql.append("AND WHERE_PLACEMEN =? ");
				typeList.add(Types.VARCHAR);
				argsList.add(organCode);
			}
		}
		String flag =  (String) pset.getParameter("flag");
		if(StringUtils.isNotEmpty(flag)){
			sql.append(" AND FLAG = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(flag);
		}
		String servedMilitaryRegion =  (String) pset.getParameter("servedMilitaryRegion");
		if(StringUtils.isNotEmpty(servedMilitaryRegion)){
			sql.append(" AND SERVED_MILITARY_REGION = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(servedMilitaryRegion);
		}
		String zhizhao =  (String) pset.getParameter("zhizhao");
		if(StringUtils.isNotEmpty(zhizhao)){
			sql.append(" AND DIRECTSERGEANT = '2' ");
		}
		int[] types = new int[typeList.size()];
		for(int i = 0;i<types.length;i++){
			types[i]= typeList.get(i);
		}
		return executeDataset(sql.toString(), types, argsList.toArray(),
				pset.getPageStart(), pset.getPageLimit(), true);
	}

	public void updateAllotFlag(String[] soldierIds) {

		for (String id : soldierIds) {
			this.executeUpdate(PrsSQL.UPDATE_ALLOTFLAG_BY_SOLDIERS_ID,new int[] { Types.VARCHAR }, new Object[] { id });
		}
	}

	
	public DataSet querySoldierById(ParameterSet pset) {
		String solidersId =  (String) pset.getParameter("SOLDIERSID");
		DataSet ds = new DataSet();
		PrsRetiredSoldiers soldier =this.get(solidersId);
		if(soldier!=null){
			ds.addRecord(soldier);
		}
		return ds;

	}

	/**
	 * 查询。。。 。。。
	 */
	public DataSet querySoldiers(ParameterSet pset){
		StringBuffer sql = new StringBuffer();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		sql.append(PrsSQL.SELECT_SOLDIERS_INFO_WITHOUT_FROM);
		sql.append("FROM PRS_RETIRED_SOLDIERS T WHERE 1 = 1");
		sql.append(" AND T.RETIRED_SOLDIER_TYPE in (4,5) ");
		String orgCode=(String) pset.getParameter("orgCode");
		if(!StringUtil.isEmptyString(orgCode)){
			if (orgCode.endsWith("0000000000")){
				sql.append("AND T.WHERE_PLACEMEN LIKE ? ");
				typeList.add(Types.VARCHAR);
				argsList.add(orgCode.substring(0, 2)+"%");
			}else if(orgCode.endsWith("00000000")){
				sql.append("AND T.WHERE_PLACEMEN LIKE ? ");
				typeList.add(Types.VARCHAR);
				argsList.add(orgCode.substring(0, 4)+"%");
			}else {
				sql.append("AND T.WHERE_PLACEMEN =? ");
				typeList.add(Types.VARCHAR);
				argsList.add(orgCode);
			}
		}
		
		String cYear = (String) pset.getParameter("cYear");
		if (!StringUtil.isEmptyString(cYear)) {
			sql.append("AND SUBSTR(T.RETIRED_TIME, 1, 4) = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(cYear);
		}
		String planYear = (String) pset.getParameter("planYear");
		if (!StringUtil.isEmptyString(planYear)) {
			sql.append("AND T.PLAN_YEAR = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(planYear);
		}
		String type =(String) pset.getParameter("type");
		if(!StringUtil.isEmptyString(type)){
			sql.append("AND T.RETIRED_SOLDIER_TYPE=? ");
			typeList.add(Types.VARCHAR);
			argsList.add(type);
		}
		String sendback=(String) pset.getParameter("sendback");
		if(!StringUtil.isEmptyString(sendback)){
			sql.append("AND T.FLAG=? ");
			typeList.add(Types.VARCHAR);
			argsList.add(sendback);
		}
		String name = (String) pset.getParameter("name");
		if (!StringUtil.isEmptyString(name)) {
			sql.append("AND T.NAME LIKE ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(name+"%");
		}
		String soldiersId = (String) pset.getParameter("soldiersId");
		if (!StringUtil.isEmptyString(soldiersId)) {
			sql.append("AND T.SOLDIERS_ID = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(soldiersId);
		}
		String servedMilitaryRegion = (String) pset
				.getParameter("servedMilitaryRegion");
		if (!StringUtil.isEmptyString(servedMilitaryRegion)) {
			sql.append("AND T.SERVED_MILITARY_REGION  = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(servedMilitaryRegion);
		}
		String domicileCode = (String) pset.getParameter("domicileCode");
		if (!StringUtil.isEmptyString(domicileCode)) {
			if("00".equals(domicileCode.substring(4, 6))){
				if(domicileCode.endsWith("999000")){
					sql.append("AND T.WHERE_PLACEMEN = ? ");
					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode.substring(0, 4)+"00000000");
				}else{
					sql.append("AND T.WHERE_PLACEMEN LIKE ? ");
					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode.substring(0, 4)+"%");
				}
			}else {
				sql.append("AND T.WHERE_PLACEMEN LIKE ? ");
				typeList.add(Types.VARCHAR);
				argsList.add(domicileCode.substring(0, 6)+"%");
			}
		}
		String enlistPlace = (String) pset.getParameter("enlistPlace");
		if (!StringUtil.isEmptyString(enlistPlace)) {
			sql.append("AND T.ENLIST_PLACE LIKE ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(enlistPlace+"%");
		}
		String servicedTime =(String) pset.getParameter("servicedTime");
		if (!StringUtil.isEmptyString(servicedTime)) {
			sql.append("AND T.SERVICED_TIME  = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(servicedTime);
		}
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = typeList.get(i);
		}
		Object[] args = argsList.toArray();
		String ifAll = (String) pset.getParameter("ifAll");
		if(StringUtils.isNotEmpty(ifAll)){
			DataSet dSet = executeDataset(sql.toString(), types, args, false);
			return dSet;
		}else{
			DataSet dSet = executeDataset(sql.toString(), types, args,pset.getPageStart(),pset.getPageLimit(), false);
			return dSet;
		}
	}
	public DataSet queryBatchSoldiers(ParameterSet pset) {

		StringBuffer sql = new StringBuffer();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();

		sql.append(PrsSQL.SELECT_SOLDIERS_INFO_WITHOUT_FROM);
		sql.append("FROM PRS_RETIRED_SOLDIERS T WHERE 1 = 1");
		sql.append(" AND T.RETIRED_SOLDIER_TYPE IN ( 1,3 ) ");
		sql.append(" AND T.FLAG IN (1,2) AND T.ALLOT_FLAG = '0' ");
		String cYear = (String) pset.getParameter("cYear");
		if (!StringUtil.isEmptyString(cYear)) {
			sql.append("AND SUBSTR(T.RETIRED_TIME, 1, 4) = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(cYear);
		}

		String name = (String) pset.getParameter("name");
		if (!StringUtil.isEmptyString(name)) {
			sql.append("AND T.NAME LIKE ?||'%' ");
			typeList.add(Types.VARCHAR);
			argsList.add(name);
		}

		String servedMilitaryRegion = (String) pset
				.getParameter("servedMilitaryRegion");
		if (!StringUtil.isEmptyString(servedMilitaryRegion)) {
			sql.append("AND T.SERVED_MILITARY_REGION  = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(servedMilitaryRegion);
		}
		String orgCode=(String) pset.getParameter("orgCode");
		if (!StringUtil.isEmptyString(orgCode)) {
		if (orgCode.endsWith("0000000000")){
			sql.append("AND T.WHERE_PLACEMEN LIKE ?||'%'");
			typeList.add(Types.VARCHAR);
			argsList.add(orgCode.substring(0, 2));
		}else if(orgCode.endsWith("00000000")){
			sql.append("AND T.WHERE_PLACEMEN LIKE ?||'%'");
			typeList.add(Types.VARCHAR);
			argsList.add(orgCode.substring(0, 4));
		}else {
			sql.append("AND T.WHERE_PLACEMEN =? ");
			typeList.add(Types.VARCHAR);
			argsList.add(orgCode);
		}
	}	
		String domicileCode = (String) pset.getParameter("domicileCode");
		if (!StringUtil.isEmptyString(domicileCode)) {
			if("00".equals(domicileCode.substring(4, 6))){
				if(domicileCode.endsWith("999000")){
					sql.append("AND T.WHERE_PLACEMEN = ? ");
					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode.substring(0, 4)+"00000000");
				}else{
					sql.append("AND T.WHERE_PLACEMEN LIKE ?||'%'");
					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode.substring(0, 4));
				}
			}else {
				sql.append("AND T.WHERE_PLACEMEN LIKE ?||'%'");
				typeList.add(Types.VARCHAR);
				argsList.add(domicileCode.substring(0, 6));
			}
		}
		String enlistPlace = (String) pset.getParameter("enlistPlace");
		if (!StringUtil.isEmptyString(enlistPlace)) {
			sql.append("AND T.ENLIST_PLACE = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(enlistPlace);
		}
		String sendback=(String) pset.getParameter("sendback");
		if(!StringUtil.isEmptyString(sendback)){
			sql.append("AND T.FLAG=? ");
			typeList.add(Types.VARCHAR);
			argsList.add(sendback);
		}
		String uploadFlag = (String) pset.getParameter("uploadFlag");
		if(!StringUtil.isEmptyString(uploadFlag)){
			sql.append("AND T.UPLOADFLAG=? ");
			typeList.add(Types.VARCHAR);
			argsList.add(uploadFlag);
		}
		sql.append("  ORDER BY T.SERVED_MILITARY_REGION,T.FILE_NUM ");
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = typeList.get(i);
		}
		Object[] args = argsList.toArray();
		String flag = (String) pset.getParameter("flag");
		if("1".equals(flag)){
			return this.executeDataset(sql.toString(), types, args, true);
		}
		return this.executeDataset(sql.toString(), types, args, pset
				.getPageStart(), pset.getPageLimit(), true);
	}
	public DataSet querySoldierss(ParameterSet pset) {

		StringBuffer sql = new StringBuffer();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		sql.append(PrsSQL.SELECT_SOLDIERS_INFO);
		sql.append("FROM PRS_RETIRED_SOLDIERS T,PRS_SOLDIERS_TRAIN S WHERE T.SOLDIERS_ID=S.SOLDIERS_ID");
		sql.append(" AND T.RETIRED_SOLDIER_TYPE IN ( '0','1','3' ) ");
		sql.append(" AND T.FLAG IN (1,2) AND T.ALLOT_FLAG = '1' ");
		String cYear = (String) pset.getParameter("cYear");
		if (!StringUtil.isEmptyString(cYear)) {
			sql.append("AND SUBSTR(T.RETIRED_TIME, 1, 4) = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(cYear);
		}

		String name = (String) pset.getParameter("name");
		if (!StringUtil.isEmptyString(name)) {
			sql.append("AND T.NAME LIKE ?||'%' ");
			typeList.add(Types.VARCHAR);
			argsList.add(name);
		}

		String servedMilitaryRegion = (String) pset
				.getParameter("servedMilitaryRegion");
		if (!StringUtil.isEmptyString(servedMilitaryRegion)) {
			sql.append("AND T.SERVED_MILITARY_REGION  = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(servedMilitaryRegion);
		}
		String orgCode=(String) pset.getParameter("orgCode");
		if (orgCode.endsWith("0000000000")){
			sql.append("AND T.WHERE_PLACEMEN LIKE ?||'%' ");
			typeList.add(Types.VARCHAR);
			argsList.add(orgCode.substring(0, 2));
		}else if(orgCode.endsWith("00000000")){
			sql.append("AND T.WHERE_PLACEMEN LIKE ?||'%' ");
			typeList.add(Types.VARCHAR);
			argsList.add(orgCode.substring(0, 4));
		}else {
			sql.append("AND T.WHERE_PLACEMEN = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(orgCode);
		}
		String domicileCode = (String) pset.getParameter("domicileCode");
		if (!StringUtil.isEmptyString(domicileCode)) {
			if("00".equals(domicileCode.substring(4, 6))){
				if(domicileCode.endsWith("999000")){
					sql.append("AND T.WHERE_PLACEMEN = ? ");
					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode.substring(0, 4)+"00000000");
				}else{
					sql.append("AND T.WHERE_PLACEMEN LIKE ?||'%'");
					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode.substring(0, 4));
				}
			}else {
				sql.append("AND T.WHERE_PLACEMEN LIKE ?||'%'");
				typeList.add(Types.VARCHAR);
				argsList.add(domicileCode.substring(0, 6));
			}
		}

		String retiredSoldierType = (String) pset.getParameter("retiredSoldierType");
		if (!StringUtil.isEmptyString(retiredSoldierType)) {
			sql.append("AND T.RETIRED_SOLDIER_TYPE = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(retiredSoldierType);
		}
		String veteransCertificateNo = (String) pset.getParameter("veteransCertificateNo");
		if(!StringUtil.isEmptyString(veteransCertificateNo)){
			sql.append("AND T.VETERANS_CERTIFICATE_NO LIKE ?||'%' ");
			typeList.add(Types.VARCHAR);
			argsList.add(veteransCertificateNo);
		}
		String sendback=(String) pset.getParameter("sendback");
		if(!StringUtil.isEmptyString(sendback)){
			sql.append("AND T.FLAG=? ");
			typeList.add(Types.VARCHAR);
			argsList.add(sendback);
		}
		String uploadFlag = (String) pset.getParameter("uploadFlag");
		if(!StringUtil.isEmptyString(uploadFlag)){
			sql.append("AND T.UPLOADFLAG=? ");
			typeList.add(Types.VARCHAR);
			argsList.add(uploadFlag);
		}
		sql.append("  ORDER BY T.SERVED_ARMY,T.FILE_NUM ");
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = typeList.get(i);
		}
		Object[] args = argsList.toArray();
		String flag = (String) pset.getParameter("flag");
		if("2".equals(flag)){
			return this.executeDataset(sql.toString(), types, args, true);
		}
		return this.executeDataset(sql.toString(), types, args,getDsStart(pset), getDsLimit(pset), true);
	}

	/**
	 *
	 * @param pset
	 * @return
	 */
	private int getDsStart(ParameterSet pset) {
		String excelType = (String)pset.getParameter("excelType");
		if(null==excelType||"0,1".indexOf(excelType)==-1) {
			return pset.getPageStart();
		}
		int start = 0;
		if("0".equals(excelType)) {  //导出当前页
			Integer startExcel = (java.lang.Integer) pset.getParameter("startExcel");
			if(startExcel!=null) {
				start = startExcel.intValue();
			}
		}
		return start;
	}
	private int getDsLimit(ParameterSet pset) {
		String excelType = (String)pset.getParameter("excelType");
		if(null==excelType||"0,1".indexOf(excelType)==-1) {
			return pset.getPageLimit();
		}
		int limit = ((java.lang.Integer) pset.getParameter("limitExcel")).intValue();
		return limit>1000?1000:limit;
	}
	public DataSet queryDisabilitySoldiers(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		
		sql.append(PrsSQL.SELECT_SOLDIERS_INFO_WITHOUT_FROM);
		sql.append(" FROM PRS_RETIRED_SOLDIERS T ,PRS_SOLDIERS_ARMY ARMY WHERE 1 = 1 ");
		sql.append(" AND ARMY.SOLDIERS_ID = T.SOLDIERS_ID ");
		sql.append(" AND T.RETIRED_SOLDIER_TYPE IN ('0','3' ) ");
		sql.append(" AND T.ALLOT_FLAG = '1' ");
		String xzqh = (String) pset.getParameter("xzqh");
		if (!xzqh.substring(0, 2).equals("00")
				&& xzqh.substring(2, 4).equals("00")) {
			sql.append(" AND RPAD(SUBSTR(T.WHERE_PLACEMEN, 1, 2), 12, 0) = ?");
		} else if (!xzqh.substring(2, 4).equals("00")
				&& xzqh.substring(4, 6).equals("00")) {
			sql.append(" AND RPAD(SUBSTR(T.WHERE_PLACEMEN, 1, 4), 12, 0) = ?");
		} else {
			sql.append(" AND RPAD(SUBSTR(T.WHERE_PLACEMEN, 1, 6), 12, 0) = ?");
		}
		typeList.add(Types.VARCHAR);
		argsList.add(xzqh);
		String cxsj_q = (String) pset.getParameter("cxsjq");
		String cxsj_z = (String) pset.getParameter("cxsjz");
		if (!("null".equals(cxsj_q)) && !("null".equals(cxsj_z))) {
			sql.append(" AND TO_DATE(T.RETIRED_TIME, 'YYYY-MM-DD') BETWEEN ");
			sql.append("TO_DATE(?, 'YYYY-MM-DD') AND TO_DATE(?, 'YYYY-MM-DD')");
			typeList.add(Types.VARCHAR);
			argsList.add(cxsj_q);
			typeList.add(Types.VARCHAR);
			argsList.add(cxsj_z);
		}
		String disable = (String) pset.getParameter("disable");
		if (!("null".equals(disable))) {
			sql.append(" AND T.DISABILITY_FLAG = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(disable);
		}
		String propertie = (String) pset.getParameter("propertie");
		if (!("null".equals(propertie))) {
			sql.append(" AND ARMY.DISABILITY_PROPERTIES = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(propertie);
		}
		String grade = (String) pset.getParameter("grade");
		if (!("null".equals(grade))) {
			sql.append(" AND ARMY.INJURING_GRADE = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(grade);
		}

		sql.append(" ORDER BY  T.SERVED_MILITARY_REGION,T.FILE_NUM ");
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = typeList.get(i);
		}
		Object[] args = argsList.toArray();

		String ifAll = (String) pset.getParameter("ifAll");
		if(StringUtils.isNotEmpty(ifAll)){
			DataSet dSet = executeDataset(sql.toString(), types, args, false);
			return dSet;
		}else{
			DataSet dSet = executeDataset(sql.toString(), types, args,pset.getPageStart(),pset.getPageLimit(), false);
			return dSet;
		}
	}

	public DataSet queryMilitarySoldiers(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		sql.append(PrsSQL.SELECT_SOLDIERS_INFO_WITHOUT_FROM);
		sql.append(" FROM PRS_RETIRED_SOLDIERS T WHERE 1 = 1");
		sql.append(" AND T.ALLOT_FLAG = '1' ");
		String xzqh = (String) pset.getParameter("xzqh");
		if (StringUtils.isNotEmpty(xzqh)) {
			if(xzqh.endsWith("0000000000")){
				sql.append(" AND RPAD(SUBSTR(T.WHERE_PLACEMEN, 1, 2), 12, 0) = ?");
				typeList.add(Types.VARCHAR);
				argsList.add(xzqh);
			}else if(xzqh.endsWith("00000000")){
				sql.append(" AND RPAD(SUBSTR(T.WHERE_PLACEMEN, 1, 4), 12, 0) = ?");
				typeList.add(Types.VARCHAR);
				argsList.add(xzqh);
			}else if(xzqh.endsWith("999000")){
				sql.append(" AND T.WHERE_PLACEMEN = ? ");
				typeList.add(Types.VARCHAR);
				argsList.add(xzqh.substring(0, 4)+"00000000");
			}else if(xzqh.endsWith("000000")){
				sql.append(" AND RPAD(SUBSTR(T.WHERE_PLACEMEN, 1, 6), 12, 0) = ?");
				typeList.add(Types.VARCHAR);
				argsList.add(xzqh);
			}
		}
		String cxsj_q = (String) pset.getParameter("cxsjq");
		String cxsj_z = (String) pset.getParameter("cxsjz");
		if (!("null".equals(cxsj_q)) && !("null".equals(cxsj_z))) {
			sql.append(" AND TO_DATE(T.RETIRED_TIME, 'YYYY-MM-DD') BETWEEN ");
			sql.append("TO_DATE(?, 'YYYY-MM-DD') AND TO_DATE(?, 'YYYY-MM-DD')");
			typeList.add(Types.VARCHAR);
			argsList.add(cxsj_q);
			typeList.add(Types.VARCHAR);
			argsList.add(cxsj_z);
		}
		String type = (String) pset.getParameter("type");
		if (!("null".equals(type))) {
			if ("5".equals(type)) {

			} else {
				sql.append(" AND T.RETIRED_SOLDIER_TYPE = ? ");
				typeList.add(Types.VARCHAR);
				argsList.add(type);
			}
		}

		String region = (String) pset.getParameter("region");
		if (!("null".equals(region))) {
			sql.append(" AND T.SERVED_MILITARY_REGION = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(region);
		}
		sql.append(" ORDER BY  T.SERVED_MILITARY_REGION,T.FILE_NUM ");
		int[] types = new int[typeList.size()];
		Object[] args = argsList.toArray();
		String ifAll = (String) pset.getParameter("ifAll");
		if(StringUtils.isNotEmpty(ifAll)){
			DataSet dSet = executeDataset(sql.toString(), types, args, false);
			return dSet;
		}else{
			DataSet dSet = executeDataset(sql.toString(), types, args,pset.getPageStart(),pset.getPageLimit(), false);
			return dSet;
		}
	}

	public DataSet queryPlacementSoldiers(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		
		sql.append(PrsSQL.SELECT_SOLDIERS_INFO_WITHOUT_FROM);
		sql.append(" FROM PRS_RETIRED_SOLDIERS T , PRS_SOLDIERS_PLACEMENT PLACEMENT WHERE 1 = 1 ");
		sql.append(" AND PLACEMENT.SOLDIERS_ID = T.SOLDIERS_ID  ");
		sql.append(" AND T.ALLOT_FLAG = '1' ");
		String xzqh = (String) pset.getParameter("xzqh");
		if (StringUtils.isNotEmpty(xzqh)) {
			if(xzqh.endsWith("0000000000")){
				sql.append(" AND RPAD(SUBSTR(T.WHERE_PLACEMEN, 1, 2), 12, 0) = ?");
				typeList.add(Types.VARCHAR);
				argsList.add(xzqh);
			}else if(xzqh.endsWith("00000000")){
				sql.append(" AND RPAD(SUBSTR(T.WHERE_PLACEMEN, 1, 4), 12, 0) = ?");
				typeList.add(Types.VARCHAR);
				argsList.add(xzqh);
			}else if(xzqh.endsWith("999000")){
				sql.append(" AND T.WHERE_PLACEMEN = ? ");
				typeList.add(Types.VARCHAR);
				argsList.add(xzqh.substring(0, 4)+"00000000");
			}else if(xzqh.endsWith("000000")){
				sql.append(" AND RPAD(SUBSTR(T.WHERE_PLACEMEN, 1, 6), 12, 0) = ?");
				typeList.add(Types.VARCHAR);
				argsList.add(xzqh);
			}
		}
		String cxsj_q = (String) pset.getParameter("cxsjq");
		String cxsj_z = (String) pset.getParameter("cxsjz");

		String flag = (String) pset.getParameter("flag");
		if (!("null".equals(flag))) {
			sql.append(" AND T.EMPLACEMENTFLAG = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(flag);

			if ("1".equals(flag)) {//安置
				if (!("null".equals(cxsj_q)) && !("null".equals(cxsj_z))) {
					sql.append(" AND TO_DATE( PLACEMENT.EMPLOYMENT_TIME, 'YYYY-MM-DD') BETWEEN ");
					sql.append("TO_DATE(?, 'YYYY-MM-DD') AND TO_DATE(?, 'YYYY-MM-DD')");
					typeList.add(Types.VARCHAR);
					argsList.add(cxsj_q);
					typeList.add(Types.VARCHAR);
					argsList.add(cxsj_z);
				}

				String employment = (String) pset.getParameter("employment");
				if (!("null".equals(employment))) {
					sql.append(" AND PLACEMENT.EMPLOYMENT_TYPE = ? ");
					typeList.add(Types.VARCHAR);
					argsList.add(employment);
				}

				String placement = (String) pset.getParameter("placement");
				if (!("null".equals(placement))) {
					sql.append("AND PLACEMENT.RESETTLEMENT_SITUATION =  ? ");
					typeList.add(Types.VARCHAR);
					argsList.add(placement);
				}

			}else{//未安置
				if (!("null".equals(cxsj_q)) && !("null".equals(cxsj_z))) {
					sql.append(" AND TO_DATE(T.RETIRED_TIME, 'YYYY-MM-DD') BETWEEN ");
					sql.append("TO_DATE(?, 'YYYY-MM-DD') AND TO_DATE(?, 'YYYY-MM-DD')");
					typeList.add(Types.VARCHAR);
					argsList.add(cxsj_q);
					typeList.add(Types.VARCHAR);
					argsList.add(cxsj_z);
				}
			}

		}
		sql.append(" ORDER BY  T.SERVED_MILITARY_REGION,T.FILE_NUM ");
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = typeList.get(i);
		}
		Object[] args = argsList.toArray();
		String ifAll = (String) pset.getParameter("ifAll");
		if(StringUtils.isNotEmpty(ifAll)){
			DataSet dSet = executeDataset(sql.toString(), types, args, false);
			return dSet;
		}else{
			DataSet dSet = executeDataset(sql.toString(), types, args,pset.getPageStart(),pset.getPageLimit(), false);
			return dSet;
		}
	}

	public DataSet queryTrainingSoldiers(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		sql.append(PrsSQL.SELECT_SOLDIERS_INFO_WITHOUT_FROM);
		sql.append(" FROM  PRS_RETIRED_SOLDIERS T, PRS_SOLDIERS_TRAIN TRAIN  WHERE  1 = 1 ");
		sql.append(" AND TRAIN.SOLDIERS_ID = T.SOLDIERS_ID ");
		sql.append(" AND T.ALLOT_FLAG = '1' ");
		String xzqh = (String) pset.getParameter("xzqh");
		if (StringUtils.isNotEmpty(xzqh)) {
			if(xzqh.endsWith("0000000000")){
				sql.append(" AND RPAD(SUBSTR(T.WHERE_PLACEMEN, 1, 2), 12, 0) = ?");
				typeList.add(Types.VARCHAR);
				argsList.add(xzqh);
			}else if(xzqh.endsWith("00000000")){
				sql.append(" AND RPAD(SUBSTR(T.WHERE_PLACEMEN, 1, 4), 12, 0) = ?");
				typeList.add(Types.VARCHAR);
				argsList.add(xzqh);
			}else if(xzqh.endsWith("999000")){
				sql.append(" AND T.WHERE_PLACEMEN = ? ");
				typeList.add(Types.VARCHAR);
				argsList.add(xzqh.substring(0, 4)+"00000000");
			}else if(xzqh.endsWith("000000")){
				sql.append(" AND RPAD(SUBSTR(T.WHERE_PLACEMEN, 1, 6), 12, 0) = ?");
				typeList.add(Types.VARCHAR);
				argsList.add(xzqh);
			}
		}
		String cxsj_q = (String) pset.getParameter("cxsjq");
		String cxsj_z = (String) pset.getParameter("cxsjz");
		String flag = (String) pset.getParameter("flag");
		if (!("null".equals(flag))) {
			sql.append(" AND T.TRAININGFLAG =  ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(flag);

			if ("1".equals(flag)) {//参加培训
				if (!("null".equals(cxsj_q)) && !("null".equals(cxsj_z))) {
					sql.append(" AND TO_DATE(TRAIN.TRAINING_START_TIME, 'YYYY-MM-DD') BETWEEN ");
					sql.append("TO_DATE(?, 'YYYY-MM-DD') AND TO_DATE(?, 'YYYY-MM-DD')");
					typeList.add(Types.VARCHAR);
					argsList.add(cxsj_q);
					typeList.add(Types.VARCHAR);
					argsList.add(cxsj_z);
					sql.append(" AND TO_DATE(TRAIN.TRAINING_END_TIME, 'YYYY-MM-DD') BETWEEN ");
					sql.append("TO_DATE(?, 'YYYY-MM-DD') AND TO_DATE(?, 'YYYY-MM-DD')");
					typeList.add(Types.VARCHAR);
					argsList.add(cxsj_q);
					typeList.add(Types.VARCHAR);
					argsList.add(cxsj_z);
				}

				String type = (String) pset.getParameter("type");
				if (!("null".equals(type))) {
					sql.append(" AND TRAIN.TRAINING_TYPE = ? ");
					typeList.add(Types.VARCHAR);
					argsList.add(type);
				}

			}else{
				if (!("null".equals(cxsj_q)) && !("null".equals(cxsj_z))) {
					sql.append(" AND TO_DATE(T.RETIRED_TIME, 'YYYY-MM-DD') BETWEEN ");
					sql.append("TO_DATE(?, 'YYYY-MM-DD') AND TO_DATE(?, 'YYYY-MM-DD')");
					typeList.add(Types.VARCHAR);
					argsList.add(cxsj_q);
					typeList.add(Types.VARCHAR);
					argsList.add(cxsj_z);
				}
			}
		}
		sql.append(" ORDER BY  T.SERVED_MILITARY_REGION,T.FILE_NUM ");
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = typeList.get(i);
		}
		Object[] args = argsList.toArray();
		String ifAll = (String) pset.getParameter("ifAll");
		if(StringUtils.isNotEmpty(ifAll)){
			DataSet dSet = executeDataset(sql.toString(), types, args, false);
			return dSet;
		}else{
			DataSet dSet = executeDataset(sql.toString(), types, args,pset.getPageStart(),pset.getPageLimit(), false);
			return dSet;
		}
	}

	public DataSet querySoldier(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		sql.append(PrsSQL.SELECT_SOLDIERS_INFO_WITHOUT_FROM);
		sql.append("FROM PRS_RETIRED_SOLDIERS T WHERE 1 = 1");
		String time_q = (String) pset.getParameter("time_q");
		String time_z = (String) pset.getParameter("time_z");
		sql.append(" AND T.ALLOT_FLAG = '1' ");
		if(StringUtils.isNotEmpty(time_q)){
			sql.append(" AND T.RETIRED_TIME>= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(time_q);
		}
		if(StringUtils.isNotEmpty(time_z)){
			sql.append(" AND T.RETIRED_TIME <= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(time_z);
		}
		
		String wherePlacement = (String) pset.getParameter("wherePlacement");
		if(StringUtils.isNotEmpty(wherePlacement)){
			sql.append(" AND T.WHERE_PLACEMEN LIKE ?||'%' ");
			typeList.add(Types.VARCHAR);
			argsList.add(wherePlacement);
		}
		
		String flag =  (String) pset.getParameter("flag");
		if(StringUtils.isNotEmpty(flag)){
			sql.append(" AND T.FLAG = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(flag);
		}
		
		String servedMilitaryRegion =  (String) pset.getParameter("servedMilitaryRegion");
		if(StringUtils.isNotEmpty(servedMilitaryRegion)){
			sql.append(" AND T.SERVED_MILITARY_REGION = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(servedMilitaryRegion);
		}
		String organCode =  (String) pset.getParameter("organCode");
		if(StringUtils.isNotEmpty(organCode)){
			if (organCode.endsWith("0000000000")){
				sql.append("AND T.WHERE_PLACEMEN LIKE ?||'%'");
				typeList.add(Types.VARCHAR);
				argsList.add(organCode.substring(0, 2));
			}else if(organCode.endsWith("00000000")){
				sql.append("AND T.WHERE_PLACEMEN LIKE ?||'%'");
				typeList.add(Types.VARCHAR);
				argsList.add(organCode.substring(0, 4));
			}else {
				sql.append("AND T.WHERE_PLACEMEN =? ");
				typeList.add(Types.VARCHAR);
				argsList.add(organCode);
			}
		}
		String zhizhao =  (String) pset.getParameter("zhizhao");
		if(StringUtils.isNotEmpty(zhizhao)){
			sql.append(" AND ENLIST_TYPE = '2' ");
		}
		String sort = (String) pset.getParameter("sort");
		if(StringUtils.isNotEmpty(sort)){
			sql.append(" ORDER BY "+sort+",FILE_NUM ");
		}else{
			sql.append(" ORDER BY FILE_NUM ");
		}
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = typeList.get(i);
		}
		Object[] args = argsList.toArray();
		String ifAll = (String) pset.getParameter("ifAll");
		if(StringUtils.isNotEmpty(ifAll)){
			DataSet dSet = executeDataset(sql.toString(), types, args, false);
			return dSet;
		}else{
			DataSet dSet = executeDataset(sql.toString(), types, args,pset.getPageStart(),pset.getPageLimit(), false);
			return dSet;
		}
	}
	public DataSet queryDisabilityPlacement(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		sql.append(PrsSQL.SELECT_SOLDIERS_INFO_WITHOUT_FROM);
		sql.append("FROM PRS_RETIRED_SOLDIERS T WHERE 1 = 1");
		String xzqh = (String) pset.getParameter("xzqh");
		String planYear = (String) pset.getParameter("planYear");
		String type = (String) pset.getParameter("type");
		if(StringUtils.isNotEmpty(type)){
			sql.append(" AND T.IF_RECEIVE = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(type);
		}
		if (StringUtils.isNotEmpty(xzqh)) {
			if(xzqh.endsWith("0000000000")){
				sql.append(" AND RPAD(SUBSTR(T.WHERE_PLACEMEN, 1, 2), 12, 0) = ?");
				typeList.add(Types.VARCHAR);
				argsList.add(xzqh);
			}else if(xzqh.endsWith("00000000")){
				sql.append(" AND RPAD(SUBSTR(T.WHERE_PLACEMEN, 1, 4), 12, 0) = ?");
				typeList.add(Types.VARCHAR);
				argsList.add(xzqh);
			}else if(xzqh.endsWith("999000")){
				sql.append(" AND T.WHERE_PLACEMEN = ? ");
				typeList.add(Types.VARCHAR);
				argsList.add(xzqh.substring(0, 4)+"00000000");
			}else if(xzqh.endsWith("000000")){
				sql.append(" AND RPAD(SUBSTR(T.WHERE_PLACEMEN, 1, 6), 12, 0) = ?");
				typeList.add(Types.VARCHAR);
				argsList.add(xzqh);
			}
		}
		if(StringUtils.isNotEmpty(planYear)){
			sql.append(" AND T.PLAN_YEAR = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(planYear);
		}
		sql.append(" ORDER BY FILE_NUM ");
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = typeList.get(i);
		}
		Object[] args = argsList.toArray();
		String ifAll = (String) pset.getParameter("ifAll");
		if(StringUtils.isNotEmpty(ifAll)){
			DataSet dSet = executeDataset(sql.toString(), types, args, false);
			return dSet;
		}else{
			DataSet dSet = executeDataset(sql.toString(), types, args,pset.getPageStart(),pset.getPageLimit(), false);
			return dSet;
		}
	}
	/**
	 * 退役士兵安置地明细表查询
	 * @author linyy
	 * @param pset
	 * @return
	 */
	public DataSet querySoldiersPlacement(ParameterSet pset){
		StringBuffer sql = new StringBuffer();//新建sql查询语句
		List<Integer> typeList = new ArrayList<Integer>();//executeDataset参数
		List<Object> argsList = new ArrayList<Object>();//executeDataset参数
        sql.append(" SELECT A.*, ");
		sql.append(" B.RESETTLEMENT_SITUATION, B.EMPLOYMENT_TIME, B.EMPLOYMENT_COMPANY, B.GRANT_GRANT, B.APPLICATION_DATE, B.GRANT_DATE, B.EMPLOYMENT_TYPE ");
        sql.append(" FROM PRS_RETIRED_SOLDIERS A, PRS_SOLDIERS_PLACEMENT B");
        sql.append(" WHERE A.SOLDIERS_ID=B.SOLDIERS_ID ");
        sql.append(" AND A.ALLOT_FLAG = '1' ");
        String cxsj_year = (String) pset.getParameter("cxsj_year");//查询条件：退役年度
        if(StringUtils.isNotEmpty(cxsj_year)){
			sql.append(" AND SUBSTR(A.RETIRED_TIME,1,4)=? ");
			typeList.add(Types.VARCHAR);
			argsList.add(cxsj_year);
		}
        String cx_servedMilitaryRegion= (String) pset.getParameter("cx_servedMilitaryRegion");//查询条件：军区大单位
        if(StringUtils.isNotEmpty(cx_servedMilitaryRegion)){
			sql.append(" AND A.SERVED_MILITARY_REGION=? ");
			typeList.add(Types.VARCHAR);
			argsList.add(cx_servedMilitaryRegion);
		}
        String cxsjq =(String)pset.getParameter("cxsjq");//查询条件：退役时间（起、止）
        String cxsjz = (String)pset.getParameter("cxsjz");
        String emplacementflag = (String)pset.getParameter("emplacementflag");//查询条件：安置标记  0:未安置   1:已安置
        if("1".equals(emplacementflag)){
        	if(StringUtils.isNotEmpty(cxsjq)){
	        	sql.append(" AND B.EMPLOYMENT_TIME>=? ");
	        	typeList.add(Types.VARCHAR);
	        	argsList.add(cxsjq);
	        }
	        if(StringUtils.isNotEmpty(cxsjz)){
	        	sql.append(" AND B.EMPLOYMENT_TIME<=? ");
	        	typeList.add(Types.VARCHAR);
	        	argsList.add(cxsjz);
	        }
        }else if("0".equals(emplacementflag)){
	        if(StringUtils.isNotEmpty(cxsjq)){
	        	sql.append(" AND A.RETIRED_TIME>=? ");
	        	typeList.add(Types.VARCHAR);
	        	argsList.add(cxsjq);
	        }
	        if(StringUtils.isNotEmpty(cxsjz)){
	        	sql.append(" AND A.RETIRED_TIME<=? ");
	        	typeList.add(Types.VARCHAR);
	        	argsList.add(cxsjz);
	        }
        }
        if(StringUtils.isNotEmpty(emplacementflag)){
        	sql.append(" AND A.EMPLACEMENTFLAG=? ");
        	typeList.add(Types.VARCHAR);
        	argsList.add(emplacementflag);
        }
        String employment_type = (String)pset.getParameter("employment_type");//查询条件：就业方式 1:自主就业   0：政府指导
        if(StringUtils.isNotEmpty(employment_type)){
        	sql.append(" AND B.EMPLOYMENT_TYPE=? ");
        	typeList.add(Types.VARCHAR);
        	argsList.add(employment_type);
        }
        String resettlement_situation = (String) pset.getParameter("resettlement_situation");//查询条件：安置形式  10,20,30,40
        if(StringUtils.isNotEmpty(resettlement_situation)){
        	sql.append(" AND B.RESETTLEMENT_SITUATION=? ");
        	typeList.add(Types.VARCHAR);
        	argsList.add(resettlement_situation);
        }
        String where_placemen = (String)pset.getParameter("xzqh");//查询条件：安置地
        if(StringUtils.isNotEmpty(where_placemen)){
        	
        	if(where_placemen.endsWith("0000000000")){
        		sql.append(" AND A.WHERE_PLACEMEN LIKE ? ");
        		typeList.add(Types.VARCHAR);
        		argsList.add(where_placemen.substring(0, 2)+"%");
        	}else if(where_placemen.endsWith("00000000")){
        		sql.append(" AND A.WHERE_PLACEMEN LIKE ? ");
        		typeList.add(Types.VARCHAR);
        		argsList.add(where_placemen.substring(0, 4)+"%");
        	}else if(where_placemen.endsWith("000000")){
        		sql.append(" AND A.WHERE_PLACEMEN LIKE ? ");
        		typeList.add(Types.VARCHAR);
        		argsList.add(where_placemen.substring(0, 6)+"%");
        	}else if(where_placemen.endsWith("999000")){
        		sql.append(" AND WHERE_PLACEMEN= ? ");
        		typeList.add(Types.VARCHAR);
        		argsList.add(where_placemen.substring(0,6)+"000000");
        	}
        }
        sql.append(" ORDER BY A.FILE_NUM ");
        int[] types = new int[typeList.size()];//参数设置
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = typeList.get(i);
		}
		Object[] args = argsList.toArray();//参数设置
		String ifAll = (String) pset.getParameter("ifAll");
		DataSet dSet = new DataSet();
		if(StringUtils.isNotEmpty(ifAll)){
			dSet = executeDataset(sql.toString(), types, args, false);
		}else{
			dSet = executeDataset(sql.toString(), types, args,pset.getPageStart(),pset.getPageLimit(), false);
		}
		return dSet;
	}
	/**
	 * 退役士兵培训统计表查询
	 */
	public DataSet querySoldiersTraining(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		sql.append(" select t.*, train.training_type, train.training_institutions, train.training_start_time, train.training_end_time, train.training_major, train.training_skill_level ");
		sql.append(" FROM  PRS_RETIRED_SOLDIERS T, PRS_SOLDIERS_TRAIN TRAIN  WHERE  1 = 1 ");
		sql.append(" AND TRAIN.SOLDIERS_ID = T.SOLDIERS_ID and allot_flag = '1' ");
		String xzqh = (String) pset.getParameter("xzqh");
		if (StringUtils.isNotEmpty(xzqh)) {
			if(xzqh.endsWith("0000000000")){
				sql.append(" AND RPAD(SUBSTR(T.WHERE_PLACEMEN, 1, 2), 12, 0) = ?");
				typeList.add(Types.VARCHAR);
				argsList.add(xzqh);
			}else if(xzqh.endsWith("00000000")){
				sql.append(" AND RPAD(SUBSTR(T.WHERE_PLACEMEN, 1, 4), 12, 0) = ?");
				typeList.add(Types.VARCHAR);
				argsList.add(xzqh);
			}else if(xzqh.endsWith("999000")){
				sql.append(" AND T.WHERE_PLACEMEN = ? ");
				typeList.add(Types.VARCHAR);
				argsList.add(xzqh.substring(0, 4)+"00000000");
			}else if(xzqh.endsWith("000000")){
				sql.append(" AND RPAD(SUBSTR(T.WHERE_PLACEMEN, 1, 6), 12, 0) = ?");
				typeList.add(Types.VARCHAR);
				argsList.add(xzqh);
			}
		}
		String cxsj_q = (String) pset.getParameter("cxsjq");
		String cxsj_z = (String) pset.getParameter("cxsjz");
		String trainingflag = (String)pset.getParameter("trainingflag");
		String training_type = (String)pset.getParameter("training_type");
		if("1".equals(trainingflag)){
			if (StringUtils.isNotEmpty(cxsj_q)&&StringUtils.isNotEmpty(cxsj_z)) {
				sql.append(" AND TRAIN.TRAINING_START_TIME>? AND TRAIN.TRAINING_START_TIME<? ");
				typeList.add(Types.VARCHAR);
				argsList.add(cxsj_q);
				typeList.add(Types.VARCHAR);
				argsList.add(cxsj_z);
			}
			if(StringUtils.isNotEmpty(cxsj_q)&&StringUtils.isNotEmpty(cxsj_z)){
				sql.append(" AND TRAIN.TRAINING_END_TIME>? AND TRAIN.TRAINING_END_TIME<? ");
				typeList.add(Types.VARCHAR);
				argsList.add(cxsj_q);
				typeList.add(Types.VARCHAR);
				argsList.add(cxsj_z);
			}
		}else {//if("0".equals(trainingflag))
			if (StringUtils.isNotEmpty(cxsj_q)&&StringUtils.isNotEmpty(cxsj_z)) {
				sql.append(" AND T.RETIRED_TIME>? AND T.RETIRED_TIME<? ");
				typeList.add(Types.VARCHAR);
				argsList.add(cxsj_q);
				typeList.add(Types.VARCHAR);
				argsList.add(cxsj_z);
			}
		}
		if(StringUtils.isNotEmpty(trainingflag)){
			sql.append(" and t.trainingflag=? ");
			typeList.add(Types.VARCHAR);
			argsList.add(trainingflag);
		}
		if(StringUtils.isNotEmpty(training_type)){
			sql.append(" and train.training_type=? ");
			typeList.add(Types.VARCHAR);
			argsList.add(training_type);
		}
		sql.append(" ORDER BY  T.SERVED_MILITARY_REGION,T.FILE_NUM ");
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = typeList.get(i);
		}
		Object[] args = argsList.toArray();
		String ifAll = (String) pset.getParameter("ifAll");
		if(StringUtils.isNotEmpty(ifAll)){
			DataSet dSet = executeDataset(sql.toString(), types, args, false);
			return dSet;
		}else{
			DataSet dSet = executeDataset(sql.toString(), types, args,pset.getPageStart(),pset.getPageLimit(), false);
			return dSet;
		}
	}

}

