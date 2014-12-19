package com.inspur.cams.fis.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.fis.base.dao.IFisCremationInfoSumDao;
import com.inspur.cams.fis.base.data.FisCremationInfoSum;
import com.inspur.cams.fis.util.ProceduresUtil;
import com.inspur.cams.fis.util.ProceduresUtil.Proc;

/**
 * @title:FisCremationInfoSumDao
 * @description:
 * @author:
 * @since:2012-11-13
 * @version:1.0
 */
public class FisCremationInfoSumDao extends EntityDao<FisCremationInfoSum>
		implements IFisCremationInfoSumDao {

	public FisCremationInfoSumDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class<FisCremationInfoSum> getEntityClass() {
		return FisCremationInfoSum.class;
	}

	public DataSet queyDeadInfo(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		sql.append("SELECT * FROM FIS_CREMATION_INFO_SUM T WHERE 1=1 ");
		String populace = (String) pset.getParameter("populace");
		if (StringUtils.isNotEmpty(populace)) {
			String subPopulace = "";
			if (populace.substring(2, 12).equals("0000000000")) {
				subPopulace = populace.substring(0, 2);
			} else if (populace.substring(4, 12).equals("00000000")) {
				subPopulace = populace.substring(0, 4);
			} else if (populace.substring(6, 12).equals("000000")) {
				subPopulace = populace.substring(0, 6);
			} else if (populace.substring(9, 12).equals("000")) {
				subPopulace = populace.substring(0, 9);
			} else {
				subPopulace = populace;
			}
			sql.append(" AND T.POPULACE LIKE ?||'%' ");
			typeList.add(Types.VARCHAR);
			argsList.add(subPopulace);
		}
		String name = (String) pset.getParameter("name");
		if (StringUtils.isNotEmpty(name)) {
			sql.append(" AND T.NAME = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(name);
		}
		String idCard = (String) pset.getParameter("idCard");
		if (StringUtils.isNotEmpty(idCard)) {
			sql.append(" AND T.ID_CARD = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(idCard);
		}
		String organId = (String) pset.getParameter("organId");
		if (StringUtils.isNotEmpty(organId)) {
			sql.append(" AND  (");
			String[] ary = organId.split(",");
			for (int i = 0; i < ary.length; i++) {
				sql.append(" T.CREATE_ORGAN=? ");
				if (i != ary.length - 1) {
					sql.append(" OR ");
				}
				typeList.add(Types.VARCHAR);
				argsList.add(ary[i]);
			}
			sql.append(" ) ");
		}
		String organCode = (String) pset.getParameter("organCode");
		if (StringUtils.isNotEmpty(organCode)) {
			sql.append(" AND T.CREATE_ORGAN like ?||'%' ");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode);
		}
		String qreferentialTypeName = (String) pset
				.getParameter("qreferentialTypeName");
		// 优惠类型
		if (StringUtils.isNotEmpty(qreferentialTypeName)) {
			sql.append(" AND T.PREFERENTIAL_TYPE = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(qreferentialTypeName);
		}
		String ageBegin = (String) pset.getParameter("ageBegin");
		String ageEnd = (String) pset.getParameter("ageEnd");
		if (StringUtils.isNotEmpty(ageBegin)) {
			sql.append(" AND  T.AGE>=? ");
			typeList.add(Types.INTEGER);
			argsList.add(ageBegin);
		}
		if (StringUtils.isNotEmpty(ageEnd)) {
			sql.append(" AND  T.AGE<=? ");
			typeList.add(Types.INTEGER);
			argsList.add(ageEnd);
		}
		String deathCaseValue = (String) pset.getParameter("deathCaseValue");
		if (StringUtils.isNotEmpty(deathCaseValue)) {
			sql.append(" AND  (");
			String[] ary = deathCaseValue.split(",");
			for (int i = 0; i < ary.length; i++) {
				sql.append(" T.DEATH_CAUSE=? ");
				if (i != ary.length - 1) {
					sql.append(" OR ");
				}
				typeList.add(Types.VARCHAR);
				argsList.add(ary[i]);
			}
			sql.append(" ) ");
		}
		String SRecieveTime = (String) pset.getParameter("SRecieveTime");
		if (StringUtils.isNotEmpty(SRecieveTime)) {
			sql.append(" AND  T.RECEIVE_TIME>=? ");
			typeList.add(Types.VARCHAR);
			argsList.add(SRecieveTime);
		}
		String ERecieveTime = (String) pset.getParameter("ERecieveTime");
		if (StringUtils.isNotEmpty(ERecieveTime)) {
			sql.append(" AND  T.RECEIVE_TIME<=? ");
			typeList.add(Types.VARCHAR);
			argsList.add(ERecieveTime);
		}
		String SCremationTime = (String) pset.getParameter("SCremationTime");
		if (StringUtils.isNotEmpty(SCremationTime)) {
			sql.append(" AND  T.START_TIME>=? ");
			typeList.add(Types.VARCHAR);
			argsList.add(SCremationTime);
		}
		String ECremationTime = (String) pset.getParameter("ECremationTime");
		if (StringUtils.isNotEmpty(ECremationTime)) {
			sql.append(" AND  T.START_TIME<=? ");
			typeList.add(Types.VARCHAR);
			argsList.add(ECremationTime);
		}
		String fisAshesGo = (String) pset.getParameter("fisAshesGo");
		if (StringUtils.isNotEmpty(fisAshesGo)) {
			sql.append(" AND T.ASHES_GO = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(fisAshesGo);
		}
		String deadId = (String) pset.getParameter("deadId");
		if (StringUtils.isNotEmpty(deadId)) {
			sql.append(" AND T.DEAD_ID = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(deadId);
		}
		String ifFinish = (String) pset.getParameter("ifFinish");
		if (StringUtils.isNotEmpty(ifFinish)) {
			sql.append(" AND T.IF_FINISH = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(ifFinish);
		}
		//数据传输用
		if( pset.getParameter("isExChange") != null && "true".equals(pset.getParameter("isExChange"))){
			
			sql.append(" AND T.CREATE_TIME <= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add((String)pset.getParameter("queryDate"));
		}
		String idCards = (String) pset.getParameter("idCards");
		if (StringUtils.isNotEmpty(idCards)) {
			sql.append(" AND T.ID_CARD in ( ");
			String[] sss= idCards.split(",");
			StringBuffer idCardSQL = new StringBuffer("");
			for (int i = 0; i < sss.length; i++) {
				idCardSQL.append("'");
				idCardSQL.append(sss[i]);
				idCardSQL.append("'");
				idCardSQL.append(",");
			}
			sql.append(idCardSQL.toString().substring(0, idCardSQL.length()-1)+"  )  ");
		}
		
		sql.append(" ORDER BY T.CREATE_ORGAN ASC,T.POPULACE ASC,T.START_TIME ASC,T.DEAD_ID,T.RECORD_ID ");
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = typeList.get(i);
		}
		Object[] args = argsList.toArray();
		DataSet ds = this.executeDataset(sql.toString(), types, args,pset.getPageStart(),pset.getPageLimit(), false);
		return ds;
	}

	/**
	 * @Description: 查询统计信息
	 * @author xuexzh
	 */
	public DataSet queyAllSum(ParameterSet pset) {
		DataSet ds = this.executeDataset("SELECT * FROM FIS_ALL_SUM ORDER BY ORGAN_CODE", false);
		ProceduresUtil.fixDataSet(ds);
		return ds;
	}
}
